#!/usr/bin/env python3
"""Run the actual vendored ImageResizer against small Android API test doubles.

This checks the options passed to the decoder and bitmap recycling, not Android
pixel decoding or a physical device's memory. Requires JDK 17; --ecj can use an
already-downloaded Eclipse compiler with a Java 17 runtime instead.
"""
import argparse
import pathlib
import shutil
import subprocess
import tempfile

ROOT = pathlib.Path(__file__).resolve().parents[1]
PACKAGE = "io/flutter/plugins/imagepicker"
DEFAULT_SOURCE = ROOT / "third_party/image_picker_android/android/src/main/java" / PACKAGE / "ImageResizer.java"

STUBS = {
    "android/content/Context.java": """package android.content;
import java.io.File;
public class Context { public File getCacheDir() { return new File(System.getProperty("java.io.tmpdir")); } }
""",
    "android/util/Log.java": """package android.util;
public class Log { public static int d(String a,String b){return 0;} public static int e(String a,String b){return 0;} }
""",
    "androidx/core/util/SizeFCompat.java": """package androidx.core.util;
public class SizeFCompat {
  private final float width,height;
  public SizeFCompat(float w,float h){width=w;height=h;}
  public float getWidth(){return width;} public float getHeight(){return height;}
}
""",
    "androidx/exifinterface/media/ExifInterface.java": """package androidx.exifinterface.media;
public class ExifInterface { public ExifInterface(String path){} }
""",
    PACKAGE + "/ExifDataCopier.java": """package io.flutter.plugins.imagepicker;
import androidx.exifinterface.media.ExifInterface;
class ExifDataCopier { void copyExif(ExifInterface from,ExifInterface to){} }
""",
    "android/graphics/Bitmap.java": """package android.graphics;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
public class Bitmap {
  public enum CompressFormat { PNG, JPEG }
  public static final List<Bitmap> created = new ArrayList<>();
  public static boolean failCompression;
  public final int width,height;
  public boolean recycled;
  public Bitmap(int w,int h){width=w;height=h;created.add(this);}
  public static Bitmap createScaledBitmap(Bitmap b,int w,int h,boolean filter){
    if(w<1||h<1)throw new IllegalArgumentException("invalid dimensions");
    return b.width==w&&b.height==h?b:new Bitmap(w,h);
  }
  public boolean hasAlpha(){return false;}
  public boolean compress(CompressFormat f,int q,OutputStream s){
    if(failCompression)throw new IllegalStateException("compression failed");
    return true;
  }
  public void recycle(){if(recycled)throw new AssertionError("double recycle");recycled=true;}
}
""",
    "android/graphics/BitmapFactory.java": """package android.graphics;
public class BitmapFactory {
  public static int width,height,sample,pixelDecodes;
  public static class Options { public boolean inJustDecodeBounds; public int outWidth,outHeight,inSampleSize=1; }
  public static Bitmap decodeFile(String path,Options o){
    if(o.inJustDecodeBounds){o.outWidth=width;o.outHeight=height;return null;}
    sample=o.inSampleSize;pixelDecodes++;
    // Model a bounded decoder: no large real bitmap is allocated in this test.
    long pixels=(long)(width/sample)*(height/sample);
    if(pixels*4>16*1024*1024)throw new AssertionError("full-resolution decode: sample="+sample+", bytes="+pixels*4);
    return new Bitmap(Math.max(1,width/sample),Math.max(1,height/sample));
  }
}
""",
    PACKAGE + "/SamplingRegression.java": """package io.flutter.plugins.imagepicker;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
public class SamplingRegression {
  static void check(int w,int h,int expected){
    Bitmap.created.clear();Bitmap.failCompression=false;
    BitmapFactory.width=w;BitmapFactory.height=h;BitmapFactory.sample=0;
    new ImageResizer(new Context(),new ExifDataCopier()).resizeImageIfNeeded("photo.jpg",1024.0,1024.0,85);
    if(BitmapFactory.sample!=expected)throw new AssertionError(w+"x"+h+": expected "+expected+", got "+BitmapFactory.sample);
    for(Bitmap b:Bitmap.created)if(!b.recycled)throw new AssertionError("bitmap leaked");
    System.out.println("PASS "+w+"x"+h+": decoder sample="+expected+", bitmaps released");
  }
  public static void main(String[] args){
    check(12000,9000,8);check(8000,6000,4);check(6000,8000,4);
    check(4000,3000,2);check(1024,768,1);check(800,600,1);check(100000,1,1);
    BitmapFactory.width=0;BitmapFactory.height=0;BitmapFactory.pixelDecodes=0;
    new ImageResizer(new Context(),new ExifDataCopier()).resizeImageIfNeeded("bad.jpg",1024.0,1024.0,85);
    if(BitmapFactory.pixelDecodes!=0)throw new AssertionError("invalid dimensions decoded");
    System.out.println("PASS invalid dimensions rejected before pixel decoding");
    Bitmap.created.clear();Bitmap.failCompression=true;BitmapFactory.width=4000;BitmapFactory.height=3000;
    try{
      new ImageResizer(new Context(),new ExifDataCopier()).resizeImageIfNeeded("photo.jpg",1024.0,1024.0,85);
      throw new AssertionError("compression failure swallowed");
    }catch(IllegalStateException expected){}
    for(Bitmap b:Bitmap.created)if(!b.recycled)throw new AssertionError("bitmap leaked on compression error");
    System.out.println("PASS compression failure releases both bitmaps");
  }
}
""",
}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source", type=pathlib.Path, default=DEFAULT_SOURCE)
    parser.add_argument("--ecj", type=pathlib.Path)
    parser.add_argument("--java", default=shutil.which("java") or "java")
    args = parser.parse_args()
    with tempfile.TemporaryDirectory(prefix="picker-regression-") as temp:
        root = pathlib.Path(temp)
        files = dict(STUBS)
        for annotation in ("NonNull", "Nullable", "VisibleForTesting"):
            files[f"androidx/annotation/{annotation}.java"] = f"package androidx.annotation; public @interface {annotation} {{}}"
        files[PACKAGE + "/ImageResizer.java"] = args.source.read_text()
        for name, content in files.items():
            path = root / name
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text(content)
        out = root / "classes"
        out.mkdir()
        compiler = [args.java, "-jar", str(args.ecj), "-17", "-proc:none"] if args.ecj else ["javac", "--release", "17"]
        subprocess.run(compiler + ["-d", str(out)] + [str(root / p) for p in files], check=True)
        subprocess.run([args.java, "-Djava.io.tmpdir=" + temp, "-cp", str(out), "io.flutter.plugins.imagepicker.SamplingRegression"], check=True)


if __name__ == "__main__":
    main()

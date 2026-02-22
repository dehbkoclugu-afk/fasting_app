// ignore_for_file: depend_on_referenced_packages, avoid_print
import 'dart:io';
import 'dart:math';
import 'package:image/image.dart' as img;

void main() {
  print('Generating app icons...');

  // App Icon (1024x1024)
  final appIcon = _generateAppIcon(1024);
  final appIconBytes = img.encodePng(appIcon);
  File('assets/icons/app_icon.png').writeAsBytesSync(appIconBytes);
  print('  ✓ app_icon.png (1024x1024)');

  // Foreground for adaptive icon (1024x1024)
  final foreground = _generateForeground(1024);
  final fgBytes = img.encodePng(foreground);
  File('assets/icons/app_icon_foreground.png').writeAsBytesSync(fgBytes);
  print('  ✓ app_icon_foreground.png (1024x1024)');

  // Splash logo (512x512)
  final splash = _generateAppIcon(512);
  final splashBytes = img.encodePng(splash);
  File('assets/icons/splash_logo.png').writeAsBytesSync(splashBytes);
  print('  ✓ splash_logo.png (512x512)');

  print('Done! Now run:');
  print('  flutter pub run flutter_launcher_icons');
  print('  flutter pub run flutter_native_splash:create');
}

img.Image _generateAppIcon(int size) {
  final image = img.Image(width: size, height: size);
  final center = size / 2;

  // Background gradient (dark indigo to deep blue)
  for (int y = 0; y < size; y++) {
    for (int x = 0; x < size; x++) {
      final t = y / size;
      final r = (15 + (20 - 15) * t).round();
      final g = (15 + (15 - 15) * t).round();
      final b = (26 + (46 - 26) * t).round();
      image.setPixelRgba(x, y, r, g, b, 255);
    }
  }

  // Draw circular ring (the fasting timer ring)
  final ringRadius = size * 0.35;
  final ringWidth = size * 0.045;

  for (int y = 0; y < size; y++) {
    for (int x = 0; x < size; x++) {
      final dx = x - center;
      final dy = y - center;
      final dist = sqrt(dx * dx + dy * dy);

      // Ring area
      if ((dist - ringRadius).abs() < ringWidth) {
        // Calculate angle for gradient color
        final angle = atan2(dy, dx) + pi; // 0 to 2*pi
        final t = angle / (2 * pi);

        // Gradient: primary (indigo) -> secondary (coral) -> tertiary (cyan)
        int r, g, b;
        if (t < 0.33) {
          final lt = t / 0.33;
          r = (108 + (255 - 108) * lt).round();
          g = (99 + (101 - 99) * lt).round();
          b = (255 + (132 - 255) * lt).round();
        } else if (t < 0.66) {
          final lt = (t - 0.33) / 0.33;
          r = (255 + (0 - 255) * lt).round();
          g = (101 + (210 - 101) * lt).round();
          b = (132 + (255 - 132) * lt).round();
        } else {
          final lt = (t - 0.66) / 0.34;
          r = (0 + (108 - 0) * lt).round();
          g = (210 + (99 - 210) * lt).round();
          b = (255 + (255 - 255) * lt).round();
        }

        // Anti-aliasing
        final edgeDist = (dist - ringRadius).abs();
        final alpha = edgeDist > ringWidth - 2
            ? ((ringWidth - edgeDist) / 2 * 255).round().clamp(0, 255)
            : 255;

        if (alpha > 0) {
          image.setPixelRgba(x, y, r.clamp(0, 255), g.clamp(0, 255), b.clamp(0, 255), alpha);
        }
      }
    }
  }

  // Draw timer icon (hourglass/clock-like symbol) in center
  _drawTimerSymbol(image, center, center, size * 0.15);

  // Draw progress dot at the top of the ring
  final dotRadius = size * 0.03;
  final dotX = center;
  final dotY = center - ringRadius;
  _drawFilledCircle(image, dotX, dotY, dotRadius, 108, 99, 255);

  return image;
}

img.Image _generateForeground(int size) {
  // Transparent background with just the icon elements
  final image = img.Image(width: size, height: size);

  // Fill transparent
  for (int y = 0; y < size; y++) {
    for (int x = 0; x < size; x++) {
      image.setPixelRgba(x, y, 0, 0, 0, 0);
    }
  }

  final center = size / 2;
  final ringRadius = size * 0.28; // Smaller for adaptive safe zone
  final ringWidth = size * 0.04;

  for (int y = 0; y < size; y++) {
    for (int x = 0; x < size; x++) {
      final dx = x - center;
      final dy = y - center;
      final dist = sqrt(dx * dx + dy * dy);

      if ((dist - ringRadius).abs() < ringWidth) {
        final angle = atan2(dy, dx) + pi;
        final t = angle / (2 * pi);

        int r, g, b;
        if (t < 0.33) {
          final lt = t / 0.33;
          r = (108 + (255 - 108) * lt).round();
          g = (99 + (101 - 99) * lt).round();
          b = (255 + (132 - 255) * lt).round();
        } else if (t < 0.66) {
          final lt = (t - 0.33) / 0.33;
          r = (255 + (0 - 255) * lt).round();
          g = (101 + (210 - 101) * lt).round();
          b = (132 + (255 - 132) * lt).round();
        } else {
          final lt = (t - 0.66) / 0.34;
          r = (0 + (108 - 0) * lt).round();
          g = (210 + (99 - 210) * lt).round();
          b = (255 + (255 - 255) * lt).round();
        }

        final edgeDist = (dist - ringRadius).abs();
        final alpha = edgeDist > ringWidth - 2
            ? ((ringWidth - edgeDist) / 2 * 255).round().clamp(0, 255)
            : 255;

        if (alpha > 0) {
          image.setPixelRgba(x, y, r.clamp(0, 255), g.clamp(0, 255), b.clamp(0, 255), alpha);
        }
      }
    }
  }

  _drawTimerSymbol(image, center, center, size * 0.12);
  _drawFilledCircle(image, center, center - ringRadius, size * 0.025, 108, 99, 255);

  return image;
}

void _drawTimerSymbol(img.Image image, double cx, double cy, double symbolSize) {
  // Draw a simple lightning bolt / timer symbol
  // Using a clock-like circle with hands
  final innerRadius = symbolSize * 0.7;

  // Small inner circle
  for (int y = 0; y < image.height; y++) {
    for (int x = 0; x < image.width; x++) {
      final dx = x - cx;
      final dy = y - cy;
      final dist = sqrt(dx * dx + dy * dy);

      // Inner circle outline
      if ((dist - innerRadius).abs() < 2) {
        image.setPixelRgba(x, y, 255, 255, 255, 180);
      }
    }
  }

  // Draw hour hand (pointing up-right)
  final handLength = symbolSize * 0.5;
  final handAngle = -pi / 4; // 45 degrees
  for (double t = 0; t < 1; t += 0.001) {
    final hx = cx + cos(handAngle) * handLength * t;
    final hy = cy + sin(handAngle) * handLength * t;
    for (int dy = -1; dy <= 1; dy++) {
      for (int dx = -1; dx <= 1; dx++) {
        final px = (hx + dx).round();
        final py = (hy + dy).round();
        if (px >= 0 && px < image.width && py >= 0 && py < image.height) {
          image.setPixelRgba(px, py, 255, 255, 255, 220);
        }
      }
    }
  }

  // Draw minute hand (pointing up)
  final minLength = symbolSize * 0.65;
  for (double t = 0; t < 1; t += 0.001) {
    final hx = cx;
    final hy = cy - minLength * t;
    for (int dx = -1; dx <= 1; dx++) {
      final px = (hx + dx).round();
      final py = hy.round();
      if (px >= 0 && px < image.width && py >= 0 && py < image.height) {
        image.setPixelRgba(px, py, 255, 255, 255, 220);
      }
    }
  }

  // Center dot
  _drawFilledCircle(image, cx, cy, 3, 255, 255, 255);
}

void _drawFilledCircle(img.Image image, double cx, double cy, double radius, int r, int g, int b) {
  for (int y = (cy - radius - 1).round(); y <= (cy + radius + 1).round(); y++) {
    for (int x = (cx - radius - 1).round(); x <= (cx + radius + 1).round(); x++) {
      if (x < 0 || x >= image.width || y < 0 || y >= image.height) continue;
      final dx = x - cx;
      final dy = y - cy;
      final dist = sqrt(dx * dx + dy * dy);
      if (dist <= radius) {
        final alpha = dist > radius - 1
            ? ((radius - dist) * 255).round().clamp(0, 255)
            : 255;
        image.setPixelRgba(x, y, r, g, b, alpha);
      }
    }
  }
}

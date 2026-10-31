# flutter_local_notifications stores scheduled notifications with Gson and
# reads them back through a TypeToken subclass. R8 strips the generic
# signature, so loadScheduledNotifications throws "TypeToken must be created
# with a type argument" (Play vitals: boot receiver and scheduling crashes).
-keepattributes Signature
-keepattributes *Annotation*
-keep class com.google.gson.reflect.TypeToken { *; }
-keep class * extends com.google.gson.reflect.TypeToken
-keep public class * implements java.lang.reflect.Type
-keep class com.dexterous.** { *; }

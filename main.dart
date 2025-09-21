import 'package:flutter/material.dart';
import 'package:shop_app/route/route_constants.dart';
import 'package:shop_app/route/router.dart' as router;
import 'package:shop_app/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shop_app/services/auth_service.dart'; // استدعاء خدمة Firebase Authentication
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // للتأكد من تهيئة Flutter قبل أي شيء
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // تهيئة Firebase قبل تشغيل التطبيق

  // ======= فحص المستخدم الحالي =======
  final AuthService _authService = AuthService(); // إنشاء كائن من AuthService
  String initialRoute; // المتغير لتحديد الصفحة الأولية للتطبيق

  if (_authService.currentUser != null) {
    // إذا كان المستخدم مسجل الدخول مسبقًا
    initialRoute = entryPointScreenRoute; // اذهب مباشرة إلى الصفحة الرئيسية
  } else {
    // إذا كان المستخدم جديد أو لم يسجل الدخول
    initialRoute = onbordingScreenRoute; // ابدأ بصفحة الـ Onboarding
  }

  runApp(MyApp(initialRoute: initialRoute)); // تمرير الصفحة الأولية للتطبيق
}

class MyApp extends StatelessWidget {
  final String initialRoute; // استلام الصفحة الأولية من main

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    print("Initial route: $initialRoute");
    return MaterialApp(
      debugShowCheckedModeBanner: false, // إزالة شعار Debug من أعلى الشاشة
      title: 'E-Shop', // عنوان التطبيق
      theme: AppTheme.lightTheme(context), // تعيين الثيم الفاتح
      themeMode: ThemeMode.light, // وضع الثيم الافتراضي عند التشغيل
      onGenerateRoute:
          router.generateRoute, // إدارة التنقل بين الصفحات باستخدام الـ Router
      initialRoute:
          initialRoute, // الصفحة الأولى التي يراها المستخدم عند فتح التطبيق
    );
  }
}

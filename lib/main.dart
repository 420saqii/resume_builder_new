import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bindings/getx_bindings.dart';
import 'constants/routes.dart';
import 'constants/colors.dart';
import 'firebase_options.dart';
import 'home_page.dart';
import 'services/storage_service.dart';
import 'modules/auth_module/ui/auth_screen.dart';
import 'modules/auth_module/controller/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await StorageService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Check if user is already logged in
    final isLoggedIn = StorageService.isLoggedIn();
    final initialRoute = isLoggedIn ? Routes.home : Routes.auth;
    return ScreenUtilInit(
      // designSize: const Size(375, 812), // iPhone X design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Resume Builder',
          initialBinding: GetxBindings(),
          theme: ThemeData(
            primarySwatch: AppColors.primarySwatch,
            primaryColor: AppColors.primaryBlue,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primaryBlue,
              primary: AppColors.primaryBlue,
              secondary: AppColors.secondaryBlue,
              surface: AppColors.cardBackground,
              background: AppColors.primaryBackground,
              error: AppColors.error,
              onPrimary: AppColors.white,
              onSecondary: AppColors.white,
              onSurface: AppColors.primaryText,
              onBackground: AppColors.primaryText,
              onError: AppColors.white,
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: AppColors.white,
              elevation: 0,
              centerTitle: true,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: AppColors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: AppColors.secondaryBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColors.primaryBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColors.primaryBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColors.primaryBlue, width: 2),
              ),
            ),
            scaffoldBackgroundColor: AppColors.primaryBackground,
          ),
          initialRoute: initialRoute,
          getPages: [
            GetPage(name: Routes.auth, page: () => const AuthScreen()),
            GetPage(name: Routes.home, page: () => const HomePage()),
          ],
        );
      },
    );
  }
}

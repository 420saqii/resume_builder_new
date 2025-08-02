import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'constants/colors.dart';
import 'modules/auth_module/controller/auth_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Resume Builder',
          style: TextStyle(
            fontSize: 18.sp, // Responsive font size
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, size: 20.sp),
            onPressed: () => authController.signOut(),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w), // Responsive padding
        child: Column(
          children: [
            // User profile section
            Obx(() {
              final user = authController.user;
              return Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.secondaryBackground,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: AppColors.primaryBorder,
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    if (user?.photoURL != null)
                      CircleAvatar(
                        radius: 40.r,
                        backgroundImage: NetworkImage(user!.photoURL!),
                      )
                    else
                      CircleAvatar(
                        radius: 40.r,
                        backgroundColor: AppColors.primaryBlue,
                        child: Icon(
                          Icons.person,
                          size: 40.sp,
                          color: AppColors.white,
                        ),
                      ),
                    SizedBox(height: 12.h),
                    Text(
                      'Welcome, ${user?.displayName ?? 'User'}!',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (user?.email != null) ...[
                      SizedBox(height: 4.h),
                      Text(
                        user!.email!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ],
                ),
              );
            }),
            // Spacer to push the button to the bottom
            Expanded(
              child: SizedBox.shrink(),
            ),
            // Create Resume Button - now at the bottom
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to template selection screen
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 16.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Create Resume',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(
              height:12.h,
            ),
          ],
        ),
      ),
    );
  }
}

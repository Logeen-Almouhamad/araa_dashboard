import 'package:archiarena/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../../core/class/status_request.dart';
import '../../../core/constant/assets.dart';
import '../../../core/constant/color.dart';
import '../../../widget/gradient_button.dart';
import '../login_controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: 1.sw,
          height: 1.sh,
          color: AppColors.white,
          child: Row(
            children: [

              /// ================= RIGHT SIDE (LOGO) =================
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 190.w),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Center(child: Image.asset(Assets.araa)),
                        SizedBox(
                          height: 15.h,
                        ),
                        Center(child: Text('لوحة التحكم في منصة أريس')),
                        SizedBox(
                          height: 20.h,
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: TextFormField(
                            controller: controller.phoneOrEmailController,
                            decoration: InputDecoration(
                              hintText: 'phone or email',
                              hintStyle: TextStyle(
                                color: AppColors.grey400,
                              ),

                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.grey400,
                                  width: 1.5,
                                ),
                              ),

                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.grey400,
                                  width: 1,
                                ),
                              ),

                              border: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: TextFormField(
                            controller: controller.passwordController,
                            obscureText: controller.obscurePassword.value,
                            //obscureText: false,
                            keyboardType: TextInputType.visiblePassword,

                            decoration: InputDecoration(
                              hintText: 'password',
                              hintStyle: TextStyle(
                                color: AppColors.grey400,
                              ),

                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.grey400,
                                  width: 1.5,
                                ),
                              ),

                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.grey400,
                                  width: 1,
                                ),
                              ),

                              border: UnderlineInputBorder(),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 80.h,
                        ),

                        GetBuilder<LoginController>(
                          builder: (controller) {
                            return ArchiButton(
                              height: 55.h,
                              onPressed: controller.statusRequest == StatusRequest.loading
                                  ? null
                                  : () {
                                controller.login();
                              },

                              child: controller.statusRequest == StatusRequest.loading
                                  ? SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  color: Colors.white,
                                ),
                              )
                                  : Text("Log in"),
                            );
                          },
                        ),
                        SizedBox(
                          height: 30.h,
                        ),

                        SizedBox(
                          height: 30.h,
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Center(child: TextButton(
                            onPressed: () {  },
                            child: Text('Forgot Password?',
                              style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.primaryDark),),
                          ),),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              /// ================= DIVIDER =================
              Container(
                width: 1.5.w,
                height: 760.h,
                color: AppColors.primaryDark,
              ),

              /// ================= RIGHT SIDE (FORM) =================

              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80.w),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// 🔶 اللوجو هنا
                        Image.asset(Assets.appLogo,width: 545.w,height: 545.h,)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:archiarena/view/side_bar/professional_sidebar/sidebar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constant/assets.dart';
import '../../../core/constant/color.dart';


class ProfessionalSideBar extends StatelessWidget {
  ProfessionalSideBar({super.key});

  final SideBarController controller = Get.find();

  final List<String> icons = [
    Assets.dashboard_icon,
    Assets.check_box_icon_outlined,
    Assets.bar_chart_icon,
    Assets.add_box_icon,
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        width: screenWidth * 0.10,
        height: screenHeight,
        child: Row(
          children: [
            Column(
              children: [
                /// 🔵 LOGO
                SizedBox(height: 40.h),
                Image.asset(
                  Assets.appLogo,
                  width: 120.w,
                  height: 120.w,
                ),
                SizedBox(height: 40.h),

                /// 🔵 Sidebar Body
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {

                      double capsuleHeight =
                          constraints.maxHeight * 0.9;

                      double itemHeight =
                          capsuleHeight / icons.length;

                      double circleSize = 90.w;

                      return Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topCenter,
                        children: [

                          /// Background Capsule
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: 70.w,
                              height: capsuleHeight,
                              decoration: BoxDecoration(
                                color:
                                const Color(0xff2C8C94),
                                borderRadius:
                                BorderRadius.circular(50),
                              ),
                            ),
                          ),

                          /// Animated Blue Circle
                          Obx(() => AnimatedPositioned(
                            duration: const Duration(
                                milliseconds: 300),
                            curve: Curves.easeInOut,
                            top: (controller
                                .selectedIndex
                                .value *
                                itemHeight) +
                                (itemHeight / 2) -
                                (circleSize / 2),
                            child: _buildActiveCircle(
                              icons[controller
                                  .selectedIndex.value],
                              circleSize,
                            ),
                          )),

                          /// Icons
                          SizedBox(
                            height: capsuleHeight,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceEvenly,
                              children: List.generate(
                                icons.length,
                                    (index) =>
                                    GestureDetector(
                                      onTap: () =>
                                          controller
                                              .changeIndex(
                                              index),
                                      child: SizedBox(
                                        height: itemHeight,
                                        child: Center(
                                          child:
                                          Image.asset(
                                            icons[index],
                                            width: 32.w,
                                            height: 32.w,
                                            color: Colors
                                                .white,
                                          ),
                                        ),
                                      ),
                                    ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),

            SizedBox(width: 20.w),

            /// Divider
            Container(
              width: 1.5.w,
              height: screenHeight,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveCircle(
      String icon, double circleSize) {
    return Container(
      width: circleSize,
      height: circleSize,
      decoration: BoxDecoration(
        color: AppColors.darkBlue,
        shape: BoxShape.circle,
        border:
        Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.25),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Center(
        child: Image.asset(
          icon,
          width: 35.w,
          height: 35.w,
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constant/color.dart';

class DatePickerColumn extends StatelessWidget {
  final List items;
  final double width;
  final RxInt selectedIndex;

  const DatePickerColumn({
    super.key,
    required this.items,
    required this.width,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final FixedExtentScrollController scrollController =
    FixedExtentScrollController(initialItem: selectedIndex.value);

    final FocusNode focusNode = FocusNode();

    return GestureDetector(
      onTap: () {
        focusNode.requestFocus(); // يأخذ فوكس فقط عند الضغط عليه
      },
      child: RawKeyboardListener(
        focusNode: focusNode,
        onKey: (event) {
          if (event is RawKeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
              if (selectedIndex.value < items.length - 1) {
                selectedIndex.value++;
                scrollController.animateToItem(
                  selectedIndex.value,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                );
              }
            }

            if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
              if (selectedIndex.value > 0) {
                selectedIndex.value--;
                scrollController.animateToItem(
                  selectedIndex.value,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                );
              }
            }
          }
        },
        child: Container(
          width: width,
          height: 150.h,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: AppColors.primaryDark, width: 1),
              bottom: BorderSide(color: AppColors.primaryDark, width: 1),
            ),
          ),
          child: ListWheelScrollView.useDelegate(
            controller: scrollController,
            physics: const FixedExtentScrollPhysics(),
            itemExtent: 45.h,
            onSelectedItemChanged: (index) {
              selectedIndex.value = index;
            },
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: items.length,
              builder: (context, index) {
                return Obx(() {
                  final int diff =
                  (index - selectedIndex.value).abs();

                  Color color;
                  double fontSize;
                  FontWeight weight;

                  if (diff == 0) {
                    color = AppColors.primaryDark;
                    fontSize = 22.sp;
                    weight = FontWeight.bold;
                  } else if (diff == 1) {
                    color =
                        AppColors.primaryDark.withOpacity(0.6);
                    fontSize = 18.sp;
                    weight = FontWeight.w500;
                  } else {
                    color = Colors.grey.withOpacity(0.5);
                    fontSize = 16.sp;
                    weight = FontWeight.normal;
                  }

                  return Center(
                    child: Text(
                      items[index].toString(),
                      style: TextStyle(
                        color: color,
                        fontSize: fontSize,
                        fontWeight: weight,
                      ),
                    ),
                  );
                });
              },
            ),
          ),
        ),
      ),
    );
  }

}

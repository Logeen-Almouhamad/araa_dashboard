import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        child: TextField(
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: "قم بالبحث عن التصميم؟",
            filled: true,
            fillColor: Colors.grey[200],
             prefixIcon: const Icon(Icons.photo_library_outlined),
            //suffixIcon: const Icon(Icons.photo_library_rounded),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}

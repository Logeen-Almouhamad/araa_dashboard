import 'package:flutter/material.dart';
import '../core/constant/color.dart';

enum IconPosition { start, end }

class ArchiButton extends StatelessWidget {
  const ArchiButton({
    super.key,
    this.child,
    this.label,
    required this.onPressed,
    this.height = 52,
    this.width,
    this.fontSize = 17,
    this.icon,
    this.iconSize = 22,
    this.borderRadius = 12,
    this.iconPosition = IconPosition.start,
    this.backgroundColor,
  });

  final String? label;
  final Widget? child;
  final VoidCallback? onPressed;
  final double height;
  final double? width;
  final double fontSize;
  final IconData? icon;
  final double iconSize;
  final double borderRadius;
  final IconPosition iconPosition;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Ink(
            decoration: BoxDecoration(
              gradient: backgroundColor == null
                  ? const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
                  : null,
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Center(
              child: child ?? _buildContent(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: iconPosition == IconPosition.start
            ? [
          Icon(icon, color: AppColors.onPrimary, size: iconSize),
          const SizedBox(width: 8),
          _buildText(),
        ]
            : [
          _buildText(),
          const SizedBox(width: 8),
          Icon(icon, color: AppColors.onPrimary, size: iconSize),
        ],
      );
    }

    return _buildText();
  }

  Widget _buildText() {
    return Text(
      label ?? "",
      style: TextStyle(
        color: AppColors.onPrimary,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
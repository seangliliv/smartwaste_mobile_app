import 'package:flutter/material.dart';
import '../utils/app_color.dart';
import '../utils/constants.dart';

class LogoWidget extends StatelessWidget {
  final double size;
  final double fontSize;

  const LogoWidget({
    Key? key,
    this.size = 80,
    this.fontSize = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            Icons.recycling,
            color: AppColors.white,
            size: size * 0.625, // 50/80 ratio
          ),
        ),
        SizedBox(height: size * 0.25), // 20/80 ratio
        Text(
          AppConstants.appName,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: fontSize * 0.33), // 8/24 ratio
        Text(
          AppConstants.subtitle,
          style: TextStyle(
            fontSize: fontSize * 0.67, // 16/24 ratio
            color: AppColors.grey600,
          ),
        ),
      ],
    );
  }
}
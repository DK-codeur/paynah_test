import 'package:flutter/material.dart';
import 'package:paynah_test/utils/app_colors.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Widget? icon;
  final bool isElevated;
  final Color bgColor;
  final Color textColor;
  final bool? useBorder;
  const AppButton({
    super.key, 
    required this.title, 
    this.onTap, 
    this.icon, 
    this.isElevated = false, 
    this.bgColor = AppColors.black,
    this.textColor = Colors.white,
    this.useBorder = true
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      height: 55.0,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: isElevated ? 10 : 0,
          backgroundColor: bgColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: useBorder== true ? const BorderSide(color: Colors.black, ) : BorderSide.none
          )
        ),
        // iconAlignment: IconAlignment.end,
        icon: icon,
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
          child: Text(title, style: const TextStyle(fontSize: 15),),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class UiHelper {

   static void showSnackbar(BuildContext context, String msg, {Color backgroundColor = Colors.black}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg, maxLines: 2, overflow: TextOverflow.ellipsis), backgroundColor: backgroundColor,)
    );
  }
}

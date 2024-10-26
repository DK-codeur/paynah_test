import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Utils {

  static OutlineInputBorder outlineInputBorderStyle({bool isFucosed = false}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(width: isFucosed ? 2 : 1.3, color: isFucosed ? Colors.black : Colors.grey.withOpacity(0.3))
    );
  }

  static dPrint(Object? object, {String? t = "request"}) {
    if (kDebugMode) {
      log("=========> $t <======== \n# $object");
    }
  }
}

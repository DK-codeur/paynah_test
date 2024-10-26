import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paynah_test/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';


class AppInput extends StatelessWidget {
  final String? labelText;
  final Color? labelColor;
  final TextEditingController? controller;
  // final IconData? prefixIcon;
  final TextInputType? textInputType;
  final String? hintText;
  final bool? isPhoneNumber;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon; 
  final bool? isNullable;
  final bool obscureText;
  final bool autoFocus;
  final double mx;
  final bool? isNumeric;
  final int? maxLine;

  const AppInput({super.key, 
    this.controller, 
    this.textInputType,
    this.isNullable = false,
    this.hintText,
    this.inputFormatters,
    this.isPhoneNumber,
    this.labelText, 
    this.suffixIcon,
    this.obscureText = false, 
    this.autoFocus = false, 
    this.mx = 0.0, 
    this.labelColor = Colors.grey, 
    this.maxLine = 1, 
    this.isNumeric
  });
  

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: mx, vertical: 6),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$labelText"),
          10.heightBox,
          TextFormField(
            maxLines: maxLine,
            controller: controller,
            autofocus: autoFocus,
            obscureText: obscureText,
            maxLength: (isPhoneNumber == true) ? 10 : (isNumeric == true) ? 2 : null,
            autocorrect: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: isNumeric == true ? TextInputType.number : textInputType,
            textInputAction: TextInputAction.next,
            style: const TextStyle(fontSize: 16),
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              counter: const SizedBox(),
              suffixIcon: suffixIcon,
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              filled: true,
              fillColor: Colors.white,
              // labelText: labelText,
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
              labelStyle: TextStyle(color: labelColor, fontSize: 16),
              enabledBorder: Utils.outlineInputBorderStyle(),
              focusedBorder: Utils.outlineInputBorderStyle(isFucosed: true),
              border: Utils.outlineInputBorderStyle()
            ),
          
            validator: (value) {
              if (!(isNullable!)) {
                if (value!.isEmpty) {
                  return "Ce champ est requis";
                }
          
                if (textInputType == TextInputType.emailAddress) { 
                  if (!value.contains("@")) {
                    return "email invalide";
                  }
                }
          
                if (isPhoneNumber == true) {
                  if (value.length< 10){
                    return "Numéro invalide";
                  }
                }
              }
              return null;
            },
          
            onSaved: (value) {
              controller!.text = value!;
            },
          ),
        ],
      ),
    );
  }

  
}

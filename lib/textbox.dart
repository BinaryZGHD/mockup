
import 'package:flutter/material.dart';
import 'package:mockup/theme.dart';
import 'package:sizer/sizer.dart';

class TextBox extends StatelessWidget{
  final double? fontSize;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;
  final Function? suffixIconCallBack;
  final bool? autoFocus;
  const TextBox(this.controller, {this.autoFocus, this.fontSize = 16, this.hintText, this.prefixIcon, this.suffixIcon, this.obscureText, this.onChanged, this.suffixIconCallBack, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
              primary: MyColors.eZMockUpMyrtleYellow)
      ),
      child: TextField(
        obscuringCharacter: '●',
        // style: TextStyle(fontSize: controller == null ? fontSize : controller!.text.length == 0 ? fontSize : obscureText == null
        //                            ? fontSize : obscureText!
        //                            ? 18 : fontSize),
        style: TextStyle(fontSize: 13.sp),
        obscureText: obscureText ?? false,
        onChanged: onChanged,
        controller: controller,
        cursorColor: MyColors.eZMockUpMyrtleYellow,
        autofocus: autoFocus ?? false,
        decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.grey.shade400),
            //focusColor: Colors.grey,
            //iconColor: Colors.black ,
            //suffixIconColor: Colors.grey.shade200,
            hintText: hintText,
            //filled: true,
            contentPadding: const EdgeInsets.only(bottom: 0, top: 0),
            //fillColor: Colors.grey.withOpacity(0.5),
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.eZMockUpMyrtleYellow),
              borderRadius: BorderRadius.circular(12.sp),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.all(Radius.circular(12.sp))),
            suffixIcon: suffixIcon
            /*suffixIcon: IconButton(
              onPressed: () {
                suffixIconCallBack!();
              },
              icon: Icon(Icons.close_rounded),
              color: Colors.black,
            )*/,
            prefixIcon: prefixIcon
        ),
      ),
    );
  }
}
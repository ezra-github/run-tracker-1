import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:run_tracker/constants/constants.dart';

class AppTextField extends StatelessWidget {
  AppTextField({
    Key key,
    this.hintText,
    this.hintStyle,
    this.bgColor,
    this.onChange,
    this.textInputType = TextInputType.name,
    this.inputFormat,
    this.controller,
    this.onTap,
    this.enabled = true,
    this.textCapitalization = TextCapitalization.words,
    this.borderColor = CustomTheme.colorPrimary,
    this.fieldWidth,
  }) : super(key: key);

  final String hintText;
  final TextStyle hintStyle;
  final Color bgColor;
  final Function(String) onChange;
  final Function onTap;
  final TextInputType textInputType;
  final List<TextInputFormatter> inputFormat;
  final TextEditingController controller;
  final TextCapitalization textCapitalization;
  final enabled;
  final Color borderColor;
  final double fieldWidth;

  final TextEditingController _inTernalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fieldWidth ?? double.infinity,
      height: 40,
      child: TextFormField(
        onTap: onTap,
        enabled: enabled,
        inputFormatters: inputFormat,
        autocorrect: false,
        onChanged: onChange,
        style: CustomTextStyle.primary(),
        controller: controller ?? _inTernalController,
        keyboardType: textInputType,
        textCapitalization: textCapitalization,
        decoration: InputDecoration(
          hintStyle: hintStyle ?? CustomTextStyle.subHeader(textcolor: CustomTheme.colorDisabled),
          fillColor: bgColor ?? CustomTheme.colorWhite,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0), borderSide: BorderSide(color: borderColor)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0), borderSide: BorderSide(color: borderColor)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0), borderSide: BorderSide(color: borderColor)),
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: hintText ?? '',
          contentPadding: EdgeInsets.only(left: 10, right: 10),
        ),
      ),
    );
  }
}

class AppTextField2 extends StatelessWidget {
  AppTextField2({
    Key key,
    this.hintText,
    this.hintStyle,
    this.bgColor,
    this.onChange,
    this.textInputType = TextInputType.name,
    this.controller,
    this.onTap,
    this.enabled = true,
    this.textCapitalization = TextCapitalization.words,
    this.icon,
  }) : super(key: key);

  final String hintText;
  final TextStyle hintStyle;
  final Color bgColor;
  final Function(String) onChange;
  final Function onTap;
  final TextInputType textInputType;
  final TextEditingController controller;
  final TextCapitalization textCapitalization;
  final enabled;
  final Widget icon;

  final TextEditingController _inTernalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        onTap: onTap,
        enabled: enabled,
        autocorrect: false,
        onChanged: onChange,
        controller: controller ?? _inTernalController,
        keyboardType: textInputType,
        textCapitalization: textCapitalization,
        decoration: InputDecoration(
          prefixIcon: icon,
          hintStyle: hintStyle,
          fillColor: bgColor,
          border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.teal)
          ),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: hintText ?? '',
          contentPadding: EdgeInsets.only(left: 10, right: 10, top: 15,),
        ),
      ),
    );
  }
}

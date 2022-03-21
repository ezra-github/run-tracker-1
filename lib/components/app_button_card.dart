import 'package:flutter/material.dart';
import 'package:run_tracker/constants/constants.dart';

class AppButtonCard extends StatelessWidget {
  AppButtonCard({ 
    Key key,
    this.onTap,
    this.elevation,
    this.borderRadius = 30.0,
    this.buttonColor = CustomTheme.colorPrimary,
    this.title,
    this.titleFontSize,
    this.titleColor = Colors.white,
  }) : super(key: key);

  final VoidCallback onTap;
  final double elevation;
  final double borderRadius;
  final Color buttonColor;
  final String title;
  final double titleFontSize;
  final Color titleColor;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
        width: double.infinity,
        child: TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            elevation: elevation ?? 0,
            padding: EdgeInsets.only(top: 15, bottom: 15, right: 15, left: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            backgroundColor: buttonColor ?? Colors.black,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: titleFontSize ?? 14, color: titleColor ?? Colors.white),
            ),
          ),
        ),
      );
  }
}
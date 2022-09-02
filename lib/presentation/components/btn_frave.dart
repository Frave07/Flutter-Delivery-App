import 'package:flutter/material.dart';
import 'package:restaurant/presentation/components/components.dart';

class BtnFrave extends StatelessWidget {

  final String text;
  final Color color;
  final double height;
  final double width;
  final double borderRadius;
  final Color textColor;
  final FontWeight fontWeight;
  final double fontSize;
  final VoidCallback? onPressed;

  const BtnFrave({
    required this.text, 
    this.color  = const Color(0xff0C6CF2), 
    this.height = 50, 
    this.width  = double.infinity, 
    this.borderRadius = 8.0, 
    this.textColor = Colors.white, 
    this.fontWeight = FontWeight.normal,
    this.fontSize = 18,
    this.onPressed
  });

  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius))
        ),
        child: TextCustom(text: text, fontSize: fontSize, color: textColor, fontWeight: fontWeight,),
        onPressed: onPressed,
      ),
    );
  }
}
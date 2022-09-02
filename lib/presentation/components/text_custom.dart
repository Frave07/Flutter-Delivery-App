import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextCustom extends StatelessWidget{
  
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextOverflow textOverflow;
  final int? maxLine;
  final TextAlign textAlign;

  const TextCustom({
    required this.text, 
    this.fontSize = 18, 
    this.color = Colors.black, 
    this.fontWeight = FontWeight.normal,
    this.textOverflow = TextOverflow.visible,
    this.maxLine,
    this.textAlign = TextAlign.left
  });

  @override
  Widget build(BuildContext context){
    return Text(
      text,
      overflow: textOverflow,
      maxLines: maxLine,
      textAlign: textAlign,
      style: GoogleFonts.getFont('Roboto', fontSize: fontSize, color: color, fontWeight: fontWeight)
    );
  }
}
import 'package:flutter/material.dart';
import 'package:restaurant/presentation/components/components.dart';

class ItemAccount extends StatelessWidget {
  
  final double borderRadius;
  final String text;
  final IconData icon;
  final int colorIcon;
  final VoidCallback? onPressed;

  const ItemAccount({
    this.borderRadius = 10.0, 
    required this.text, 
    required this.icon, 
    required this.colorIcon, 
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      height: 50,
      width: size.width,
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius)
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
        elevation: 0,
        color: Colors.grey[100],
        margin: EdgeInsets.all(0),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(colorIcon)
                      ),
                      child: Icon(icon, color: Colors.white ),
                    ),
                    const SizedBox(width: 8.0),
                    TextCustom(text: text),
                  ],
                ),
                const Icon(Icons.navigate_next_rounded)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
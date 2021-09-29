import 'package:flutter/material.dart';
import 'package:restaurant/Screen/Client/CartClientPage.dart';
import 'package:restaurant/Screen/Client/ClientHomePage.dart';
import 'package:restaurant/Screen/Client/ProfileClientPage.dart';
import 'package:restaurant/Screen/Client/SearchClientPage.dart';
import 'package:restaurant/Themes/ColorsFrave.dart';
import 'package:restaurant/Widgets/AnimationRoute.dart';
import 'package:restaurant/Widgets/Widgets.dart';

class BottomNavigationFrave extends StatelessWidget {

  final int index;

  BottomNavigationFrave(this.index);

  @override
  Widget build(BuildContext context)
  {
    return Container(
      height: 55,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 10, spreadRadius: -5)
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ItemButton(
            i: 0, 
            index: index, 
            iconData: Icons.home_outlined, 
            text: 'Home',
            onPressed: () => Navigator.pushReplacement(context, routeFrave(page: ClientHomePage())),
            ),
          _ItemButton(
            i: 1, 
            index: index, 
            iconData: Icons.search, 
            text: 'Search',
            onPressed: () => Navigator.pushReplacement(context, routeFrave(page: SearchClientPage())),
            ),
          _ItemButton(
            i: 2, 
            index: index, 
            iconData: Icons.local_mall_outlined, 
            text: 'Cart',
            onPressed: () => Navigator.pushReplacement(context, routeFrave(page: CartClientPage())),
          ),
          _ItemButton(
            i: 3, 
            index: index, 
            iconData: Icons.person_outline_outlined, 
            text: 'Profile',
            onPressed: () => Navigator.pushReplacement(context, routeFrave(page: ProfileClientPage())),
            ),
        ],
      )
    );
  }
}

class _ItemButton extends StatelessWidget {
  
  final int i;
  final int index;
  final IconData iconData;
  final String text;
  final VoidCallback? onPressed;

  const _ItemButton({ required this.i, required this.index, required this.iconData, required this.text, this.onPressed });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
        decoration: BoxDecoration(
          color: ( i == index ) ? ColorsFrave.primaryColor.withOpacity(.9) : Colors.transparent,
          borderRadius: BorderRadius.circular(15.0)
        ),
        child: ( i == index ) 
          ? Row(
            children: [
                Icon(iconData, color: Colors.white, size: 25),
                SizedBox(width: 6.0),
                TextFrave(text: text, fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500 )
              ],
            )
          :  Icon(iconData, size: 28),
      ),
    );
  }
}
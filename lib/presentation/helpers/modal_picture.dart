import 'package:flutter/material.dart';
import 'package:restaurant/presentation/components/components.dart';

void modalPictureRegister({ required BuildContext ctx, VoidCallback? onPressedChange, VoidCallback? onPressedTake }){

  showModalBottomSheet(
    context: ctx,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black12,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
    builder: (context) 
      => Container(
          margin: const EdgeInsets.only(bottom: 20.0),
          height: 170,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40.0),
            boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 10, spreadRadius: -5.0)
            ]
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextCustom(text: 'Change profile picture', fontWeight: FontWeight.w500),
                const SizedBox(height: 8.0),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 0,
                    margin: const EdgeInsets.all(0),
                    child: InkWell(
                      onTap: onPressedChange,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: const TextCustom(text: 'Select an image', fontSize: 17,),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 0,
                    margin: const EdgeInsets.all(0),
                    child: InkWell(
                      onTap: onPressedTake,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: const TextCustom(text: 'Take a picture', fontSize: 17,),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ),
  );


}
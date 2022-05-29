import 'package:flutter/material.dart';

class StaggeredDualView extends StatelessWidget 
{
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final double spacing;
  final double aspectRatio;
  final double alturaElement;

  const StaggeredDualView({ 
    required this.itemBuilder, 
    required this.itemCount,
    this.spacing = 0.0, 
    this.aspectRatio = 0.5,
    this.alturaElement = 0.5
  });


  @override
  Widget build(BuildContext context) {
    
    return LayoutBuilder(
      builder: (context, constraints){

      final width  = constraints.maxWidth;
      final itemHeight = (width * 0.5) / aspectRatio;
      final height = constraints.maxHeight + itemHeight;

      return OverflowBox(
        maxWidth: width,
        minWidth: width,
        maxHeight: height,
        minHeight: height,
        child: GridView.builder(
          padding: EdgeInsets.only( top: itemHeight / 2, bottom: itemHeight),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: aspectRatio,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing
          ),
          itemCount: itemCount,
          itemBuilder: (context, index){
              return Transform.translate(
                offset: Offset(0.0, index.isOdd ? itemHeight * alturaElement : 0.0),
                child: itemBuilder(context, index),
              );

          }
        ),
      );

    });
  }
}
import 'package:flutter/material.dart';

class TabIndicator extends StatelessWidget {
  final int num;
  final int pos;
  final double size;
  final double spacing;
  final Color selectedColor;
  final Color unselectedColor;

  const TabIndicator({
    required this.num,
    required this.pos,
    this.size = 60,
    this.spacing = 4,
    this.selectedColor = Colors.red,
    this.unselectedColor = Colors.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: num,
        itemBuilder: (context, index) {
          return Row(children: [
            AnimatedOpacity(
              opacity: index == pos ? 1 : 0.2,
              duration: const Duration(milliseconds: 200),
              child: Container(
                decoration: BoxDecoration(
                  color: selectedColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                width: index == pos ? size : 10,
                height: size,
              ),
            ),
            if (pos != num) SizedBox(width: spacing),
          ]);
        },
      ),
    );
  }
}

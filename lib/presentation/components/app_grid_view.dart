import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppGridView extends StatelessWidget {
  List<Widget>? list;
  AppGridView({super.key, this.list});

  int wholePart = 0;
  int residualPart = 0;
  int length = 0;

  @override
  Widget build(BuildContext context) {
    length = list?.length ?? 0;
    wholePart = length ~/ 4;
    residualPart = length % 4;

    int index = -1;
    return Column(
      children: [
        ...List.generate(wholePart, (i) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(4, (_index) {
              index++;
              return list![index];
            }),
          );
        }),
        Row(
          children: List.generate(residualPart, (index) {
            return list![(length - 1) - index];
          }),
        )
      ],
    );
  }
}

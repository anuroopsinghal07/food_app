import 'package:flutter/material.dart';
import 'package:food_app/Model/product.dart';
import 'package:food_app/screens/food_detail_screen.dart';

class NutrientWidget extends StatelessWidget {
  final Nutrition nutri;
  const NutrientWidget({Key? key, required this.nutri}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: constraints.maxHeight * 0.32,
              child: Text(nutri.title ?? '',
                  style: Theme.of(context).textTheme.headline2),
            ),
            // SizedBox(
            //   height: constraints.maxHeight * 0.05,
            // ),
            SizedBox(
              height: constraints.maxHeight * 0.32,
              child: Text(nutri.value ?? '',
                  style: Theme.of(context).textTheme.bodyText1),
            ),
          ],
        );
      },
    );
  }
}

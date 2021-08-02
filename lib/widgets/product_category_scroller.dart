import 'package:flutter/material.dart';

class ProductCategoryScroller extends StatefulWidget {
  ProductCategoryScroller({Key? key}) : super(key: key);

  @override
  State<ProductCategoryScroller> createState() =>
      _ProductCategoryScrollerState();
}

class _ProductCategoryScrollerState extends State<ProductCategoryScroller> {
  final List<String> categories = [
    'Salads',
    'Pizza',
    'Bevarages',
    'Snacks',
    'Main Course',
    'Desserts'
  ];

  int? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      height: 80,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedItem = index;
                  });
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    color: _selectedItem == null
                        ? Colors.grey.shade200
                        : _selectedItem == index
                            ? Colors.blue
                            : Colors.grey.shade200,
                    child: Center(
                      child: Text(
                        categories[index],
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

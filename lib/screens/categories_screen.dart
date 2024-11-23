import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  static const nameRoute = '/';

  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
        childAspectRatio: 3 / 2,
      ),
      children: dummyCategories
          .map(
            (catData) => CategoryItem(
              catData.id,
              catData.title,
              catData.color,
            ),
          )
          .toList(),
    );
  }
}

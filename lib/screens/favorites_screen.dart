import 'package:flutter/material.dart';

import '../models/meals.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeal;

  FavoritesScreen(this.favoriteMeal);

  @override
  Widget build(BuildContext context) {
    return favoriteMeal.isEmpty ? Center(
      child: Text(
        'No favourite meals found.',
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20,),
      ),
    ) : ListView.builder(
      itemBuilder: (ctx, i) {
        return MealItem(
          id: favoriteMeal[i].id,
          title: favoriteMeal[i].title,
          imageUrl: favoriteMeal[i].imageUrl,
          duration: favoriteMeal[i].duration,
          complexity: favoriteMeal[i].complexity,
          affordability: favoriteMeal[i].affordability,
          //removeItem: _removeMeals,
        );
      },
      itemCount: favoriteMeal.length,
    );
  }
}

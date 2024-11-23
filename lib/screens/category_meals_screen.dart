import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meals.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const nameRoute = '/category_meals';
  final List<Meal> availableMeals;
  const CategoryMealsScreen(this.availableMeals, {super.key});

  @override
  CategoryMealsScreenState createState() => CategoryMealsScreenState();
}

class CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryTitle;
  late List<Meal> displayedMeals;
  @override
  void initState() {
    // If initState() not work then use didChangedDependencies();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final routeArgs =
    ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    categoryTitle = routeArgs['title']!;
    final categoryId = routeArgs['id'];
    displayedMeals = widget.availableMeals
        .where(
          (meals) => meals.categories.contains(categoryId),
    )
        .toList();
    super.didChangeDependencies();
  }

  // void _removeMeals(String mealId) {
  //   setState(() {
  //     displayedMeals.removeWhere((meal)=> meal.id == mealId);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) {
          return MealItem(
            id: displayedMeals[i].id,
            title: displayedMeals[i].title,
            imageUrl: displayedMeals[i].imageUrl,
            duration: displayedMeals[i].duration,
            complexity: displayedMeals[i].complexity,
            affordability: displayedMeals[i].affordability,
            //removeItem: _removeMeals,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}

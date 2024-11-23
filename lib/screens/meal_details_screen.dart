import 'package:flutter/material.dart';

import '../data/dummy_data.dart';

class MealDetailsScreen extends StatelessWidget {
  static const nameRoute = 'mealDetails_screen';
  final Function toggleFavorite;
  final Function isMealFav;

  const MealDetailsScreen(this.toggleFavorite, this.isMealFav, {super.key});

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget buildContainer(
      Widget child, double height, double margin, double padding) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      height: height,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: margin),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: padding),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = dummyMeals.firstWhere((meal) => meal.id == mealId);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(selectedMeal.title, style: const TextStyle(color: Colors.white),),
              background: Container(
                height: 250,
                width: double.infinity,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0.0, 1.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Image.network(
                  selectedMeal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 20),
                buildSectionTitle(context, 'Ingredient'),
                buildContainer(
                  ListView.builder(
                    itemCount: selectedMeal.ingredients.length,
                    itemBuilder: (ctx, i) => Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: Theme.of(context).colorScheme.secondary,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Text(selectedMeal.ingredients[i], style: const TextStyle(color: Colors.white),),
                      ),
                    ),
                  ),
                  200,
                  20,
                  10,
                ),
                buildSectionTitle(context, 'Steps'),
                buildContainer(
                  ListView.builder(
                    itemCount: selectedMeal.steps.length,
                    itemBuilder: (ctx, i) => ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          '# ${i + 1}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      title: Text(selectedMeal.steps[i]),
                    ),
                  ),
                  300,
                  5,
                  0,
                ),
                const SizedBox(height: 20)
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isMealFav(mealId) ? Icons.star : Icons.star_border),
        onPressed: () => toggleFavorite(mealId),
      ),
    );
  }
}

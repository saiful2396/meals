import 'package:flutter/material.dart';

import '../data/dummy_data.dart';

class MealDetailsScreen extends StatelessWidget {
  static const NameRoute = 'mealDetails_screen';
  final Function toggleFavorite;
  final Function isMealFav;

  MealDetailsScreen(this.toggleFavorite, this.isMealFav);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
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
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('${selectedMeal.title}'),
              background: Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0.0, 1.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                margin: EdgeInsets.only(left: 15, right: 15, top: 10),
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
                SizedBox(height: 20),
                buildSectionTitle(context, 'Ingredient'),
                buildContainer(
                  ListView.builder(
                    itemCount: selectedMeal.ingredients.length,
                    itemBuilder: (ctx, i) => Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: Theme.of(context).accentColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Text(selectedMeal.ingredients[i]),
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
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      title: Text(selectedMeal.steps[i]),
                    ),
                  ),
                  300,
                  5,
                  0,
                ),
                SizedBox(height: 20)
              ],
            ),
          ),
        ],
      ),
      /*appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(0.0, 1.0),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              margin: EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredient'),
            buildContainer(
              ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                itemBuilder: (ctx, i) => Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(selectedMeal.ingredients[i]),
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
                    child: Text('# ${i + 1}',style: Theme.of(context).textTheme.headline6,),
                  ),
                  title: Text(selectedMeal.steps[i]),
                ),
              ),
              300,
              5,
              0,
            ),
            SizedBox(height: 20)
          ],
        ),
      ),*/
      floatingActionButton: FloatingActionButton(
        child: Icon(isMealFav(mealId) ? Icons.star : Icons.star_border),
        onPressed: () => toggleFavorite(mealId),
      ),
    );
  }
}

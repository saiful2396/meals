import 'package:flutter/material.dart';

import './data/dummy_data.dart';
import './models/meals.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_details_screen.dart';
import './screens/category_meals_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeal = dummyMeals;
  final List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeal = dummyMeals.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex = _favoriteMeals.indexWhere(
      (meal) => meal.id == mealId,
    );
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(dummyMeals.firstWhere(
          (meal) => meal.id == mealId,
        ));
      });
    }
  }

  bool _isMealFavorite(String id){
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Delicious Meals',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        primaryColor: Colors.pink,
        canvasColor: const Color.fromRGBO(225, 254, 229, 1),
        fontFamily: 'Quicksand',
        textTheme: Theme.of(context).textTheme.copyWith(
          bodyMedium: const TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          bodyLarge: const TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          titleLarge: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          headlineSmall: const TextStyle(
              fontSize: 24,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      //home: CategoriesScreen(),
      // Default Screen when App run;
      initialRoute: TabsScreen.nameRoute,
      routes: {
        // CategoriesScreen.nameRoute: (_) => CategoriesScreen(),
        TabsScreen.nameRoute: (_) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.nameRoute: (_) =>
            CategoryMealsScreen(_availableMeal),
        MealDetailsScreen.nameRoute: (_) => MealDetailsScreen(_toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (_) => FiltersScreen(_filters, _setFilters),
      },
      onGenerateRoute: (settings) {
        return;
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (_) => TabsScreen(_favoriteMeals));
      },

    );
  }
}

import 'package:flutter/material.dart';

import './Models/routes.dart';
import './Models/meal.dart';
import './Models/dummy_data.dart';
import './Screens/Main_Page/main_page.dart';
import './Screens/Category_Meals/category_meals.dart';
import './Screens/Meal_Details/meal_details_screen.dart';
import './Screens/Settings/settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'glutenFree': false,
    'lactoseFree': false,
    'vegeterian': false,
    'vegan': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    _filters = filterData;
    _availableMeals = DUMMY_MEALS.where((meal) {
      if (_filters['glutenFree'] && !meal.isGlutenFree) {
        return false;
      }
      if (_filters['lactoseFree'] && !meal.isLactoseFree) {
        return false;
      }
      if (_filters['vegeterian'] && !meal.isVegetarian) {
        return false;
      }
      if (_filters['vegan'] && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
  }

  void _toggleFav(String mealId) {
    final existingIndex =
        _favouriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex != -1) {
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favouriteMeals
            .add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFav(String id) {
    return _favouriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            title: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      routes: {
        Routes.Home: (ctx) => MainPage(_favouriteMeals),
        Routes.CategoryMealScreen: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        Routes.MealDetailScreen: (ctx) =>
            MealDetailScreen(_toggleFav, _isMealFav),
        Routes.SettingScreen: (ctx) => SettingScreen(
              saveFilters: _setFilters,
              currentFilters: _filters,
            ),
      },
    );
  }
}

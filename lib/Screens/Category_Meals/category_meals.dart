import 'package:flutter/material.dart';

import './meal_item.dart';
import '../../Models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  // final String categoryId;
  // final String categoryTitle;
  // CategoryMealsScreen(this.categoryId, this.categoryTitle);

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  String categoryId;
  List<Meal> categoryMeals;
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    if (!_loaded) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      categoryId = routeArgs['id'];
      categoryMeals = widget.availableMeals
          .where((meal) => meal.categories.contains(categoryId))
          .toList();
      _loaded = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: categoryMeals.isEmpty
          ? Center(
              child: Text("No meal available in this category."),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return MealItem(
                  mealItem: categoryMeals[index],
                );
              },
              itemCount: categoryMeals.length,
            ),
    );
  }
}

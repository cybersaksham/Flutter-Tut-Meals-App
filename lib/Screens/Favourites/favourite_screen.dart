import 'package:flutter/material.dart';

import '../../Models/meal.dart';
import '../Category_Meals/meal_item.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Meal> favMeals;

  FavouritesScreen(this.favMeals);

  @override
  Widget build(BuildContext context) {
    return favMeals.isEmpty
        ? Center(
            child: Text("You have no favourite meal yet."),
          )
        : ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            mealItem: favMeals[index],
          );
        },
        itemCount: favMeals.length,
      );
  }
}

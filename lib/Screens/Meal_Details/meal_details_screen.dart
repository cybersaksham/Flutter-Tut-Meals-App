import 'package:flutter/material.dart';

import '../../Models/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  final Function toggleFav;
  final Function isFav;

  MealDetailScreen(this.toggleFav, this.isFav);

  List<Widget> buildSection(
      BuildContext ctx, String text, var allowedht, Widget child) {
    return [
      SizedBox(height: 10),
      Container(
        child: Text(
          text,
          style: Theme.of(ctx).textTheme.title,
        ),
      ),
      SizedBox(height: 10),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: allowedht * 0.2,
        child: child,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    final PreferredSizeWidget appBar = AppBar(
      title: Text("${selectedMeal.title}"),
    );

    final visibleHt = (MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top);

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: visibleHt * 0.4,
              width: double.infinity,
              child: Image.asset(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            ...buildSection(
              context,
              "Ingredients",
              visibleHt,
              ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(ctx).accentColor,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(selectedMeal.ingredients[index])),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            ...buildSection(
              context,
              "Steps",
              visibleHt,
              ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        child: Text("${index + 1}"),
                      ),
                      title: Text(selectedMeal.steps[index]),
                    ),
                    Divider(),
                  ],
                ),
                itemCount: selectedMeal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isFav(mealId) ? Icons.star : Icons.star_border,
        ),
        onPressed: () => toggleFav(mealId),
      ),
    );
  }
}

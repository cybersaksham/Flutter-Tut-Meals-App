import 'package:flutter/material.dart';

import '../Categories/categories_screen.dart';
import '../Favourites/favourite_screen.dart';
import '../Main_Drawer/main_drawer.dart';
import '../../Models/meal.dart';

class MainPage extends StatefulWidget {
  final List<Meal> favMeals;

  MainPage(this.favMeals);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {
        'title': "Categories",
        'screen': CategoriesScreen(),
      },
      {
        'title': "Favourites",
        'screen': FavouritesScreen(widget.favMeals),
      }
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return DefaultTabController(
    //   length: 2,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: Text("Meals"),
    //       bottom: TabBar(
    //         tabs: <Widget>[
    //           Tab(
    //             text: "Categories",
    //           ),
    //           Tab(
    //             text: "Favourites",
    //           ),
    //         ],
    //       ),
    //     ),
    //     body: TabBarView(
    //       children: <Widget>[
    //         CategoriesScreen(),
    //         FavouritesScreen(),
    //       ],
    //     ),
    //   ),
    // );

    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: _selectedPageIndex,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            title: Text("Categories"),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            title: Text("Favourites"),
          ),
        ],
      ),
    );
  }
}

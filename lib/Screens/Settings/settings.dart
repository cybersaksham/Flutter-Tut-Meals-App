import 'package:flutter/material.dart';

import '../Main_Drawer/main_drawer.dart';
import '../../Models/routes.dart';

class SettingScreen extends StatefulWidget {
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  SettingScreen({
    @required this.saveFilters,
    @required this.currentFilters,
  });

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<Map<String, Object>> _filters;

  @override
  void initState() {
    _filters = [
      {
        'title': "Gluten-Free",
        'value': widget.currentFilters['glutenFree'],
        'subtitle': "Only include gluten-free meals.",
      },
      {
        'title': "Lactose-Free",
        'value': widget.currentFilters['lactoseFree'],
        'subtitle': "Only include lactose-free meals.",
      },
      {
        'title': "Vegeterian",
        'value': widget.currentFilters['vegeterian'],
        'subtitle': "Only include vegeterian meals.",
      },
      {
        'title': "Vegan",
        'value': widget.currentFilters['vegan'],
        'subtitle': "Only include vegan meals.",
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final Map<String, bool> selectedFilters = {
                'glutenFree': _filters[0]['value'],
                'lactoseFree': _filters[1]['value'],
                'vegeterian': _filters[2]['value'],
                'vegan': _filters[3]['value'],
              };
              widget.saveFilters(selectedFilters);
              Navigator.of(context).pushReplacementNamed(Routes.Home);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection",
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return SwitchListTile(
                  title: Text(_filters[index]['title']),
                  value: _filters[index]['value'],
                  subtitle: Text(_filters[index]['subtitle']),
                  onChanged: (val) {
                    setState(() {
                      _filters[index]['value'] = val;
                    });
                  },
                );
              },
              itemCount: _filters.length,
            ),
          ),
        ],
      ),
    );
  }
}

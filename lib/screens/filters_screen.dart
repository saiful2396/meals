import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = 'settings';
  final Map<String, bool> currentFilters;
  final Function saveFiltersData;

  const FiltersScreen(this.currentFilters, this.saveFiltersData, {super.key});

  @override
  FiltersScreenState createState() => FiltersScreenState();
}

class FiltersScreenState extends State<FiltersScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegan = false;
  bool _vegetarian = false;

  Widget _buildSwitchListTile(
      String title,
      String description,
      bool currentValue,
      ValueChanged<bool> updateValue, // More specific type
      ) {
    return SwitchListTile(
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      subtitle: Text(description),
      value: currentValue,
      onChanged: updateValue, // The function will be called with the new value (true/false)
    );
  }

  void _showToast(BuildContext context) {
    const snackBar = SnackBar(content: Text('Saved'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten']!;
    _lactoseFree = widget.currentFilters['lactose']!;
    _vegan = widget.currentFilters['vegan']!;
    _vegetarian = widget.currentFilters['vegetarian']!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFiltersData(selectedFilters);
              _showToast(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                  'Gluten-free',
                  'Only Include gluten-free meals',
                  _glutenFree,
                  (newValue) {
                    setState(
                      () {
                        _glutenFree = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Lactose-free',
                  'Only Include Lactose-free meals',
                  _lactoseFree,
                  (newValue) {
                    setState(
                      () {
                        _lactoseFree = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Vegan-free',
                  'Only Include Vegan-free meals',
                  _vegan,
                  (newValue) {
                    setState(
                      () {
                        _vegan = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Vegetarian-free',
                  'Only Include Vegetarian-free meals',
                  _vegetarian,
                  (newValue) {
                    setState(
                      () {
                        _vegetarian = newValue;
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: const MainDrawer(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/views/categories_page.dart';
import 'package:meals_app/views/favorite_meal_page.dart';
import 'package:meals_app/views/widgets/drawer_main.dart';

class HomePage extends StatefulWidget {
  final List<MealModel> favoriteMeal;
  const HomePage({super.key, required this.favoriteMeal});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageSelectedIndex = 0;

  _selectedPage(int index) {
    setState(() {
      _pageSelectedIndex = index;
    });
  }

  late List<Map<String, Object>> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      {'title': 'Lista de Categorias', 'page': const CategoriesPage()},
      {
        'title': 'Favoritos',
        'page': FavoriteMealPage(
          favoriteMeal: widget.favoriteMeal,
        )
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_pages[_pageSelectedIndex]['title'].toString()),
        ),
        drawer: const DrawerMain(),
        body: _pages[_pageSelectedIndex]['page'] as Widget,
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectedPage,
          currentIndex: _pageSelectedIndex,
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categoria',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Favoritos',
            )
          ],
        ),
      ),
    );
  }
}

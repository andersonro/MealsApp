import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/models/settings_model.dart';
import 'package:meals_app/utils/app_routes.dart';
import 'package:meals_app/views/categories_meals_page.dart';
import 'package:meals_app/views/home_page.dart';
import 'package:meals_app/views/meal_detail_page.dart';
import 'package:meals_app/views/settings_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SettingsModel settingsModel = SettingsModel();
  late List<MealModel> _availableMeals;
  final List<MealModel> _favoriteMeals = [];

  void _onChangedSettings(SettingsModel settingsModel) {
    _availableMeals = _availableMeals.where((meal) {
      var filterIsGluten = settingsModel.isGlutenFree && !meal.isGlutenFree;
      var filterIsLactose = settingsModel.isLactoseFree && !meal.isLactoseFree;
      var filterIsVegan = settingsModel.isVegan && !meal.isVegan;
      var filterIsVegetarian = settingsModel.isVegetarian && !meal.isVegetarian;

      bool fg = !filterIsGluten &&
          !filterIsLactose &&
          !filterIsVegan &&
          !filterIsVegetarian;

      return fg;
    }).toList();
    this.settingsModel = settingsModel;
    setState(() {});
  }

  void _toggleFavorite(MealModel mealModel) {
    _favoriteMeals.contains(mealModel)
        ? _favoriteMeals.remove(mealModel)
        : _favoriteMeals.add(mealModel);
  }

  bool isFavorite(MealModel mealModel) {
    return _favoriteMeals.contains(mealModel);
  }

  @override
  void initState() {
    super.initState();
    _availableMeals = dummyMeals;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals App',
      theme: ThemeData(
        primaryColor: Colors.pink,
        primarySwatch: Colors.pink,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: const TextStyle(
                  fontFamily: 'RobotoCondensed', color: Colors.white),
              titleSmall: const TextStyle(
                  fontFamily: 'RobotoCondensed', color: Colors.white),
              titleLarge: const TextStyle(
                  fontFamily: 'RobotoCondensed', color: Colors.white),
            ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.pink,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
              foregroundColor: Colors.white,
              textStyle: const TextStyle(color: Colors.white)),
        ),
        appBarTheme: const AppBarTheme(
            color: Colors.pink,
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'RobotoCondensed'),
            iconTheme: IconThemeData(color: Colors.white)),
        tabBarTheme: const TabBarTheme().copyWith(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.white),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoutes.home: (ctx) => HomePage(favoriteMeal: _favoriteMeals),
        AppRoutes.categoriesMeal: (ctx) =>
            CategoriesMealsPage(meals: _availableMeals),
        AppRoutes.mealDetail: (ctx) => MealDetailPage(
            onToggleFavorite: _toggleFavorite, isFavorite: isFavorite),
        AppRoutes.settings: (ctx) => SettingsPage(
            onSettingsChanged: _onChangedSettings,
            settingsModel: settingsModel),
      },
    );
  }
}

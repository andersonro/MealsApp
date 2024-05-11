import 'package:flutter/material.dart';
import 'package:meals_app/models/category_model.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/views/widgets/meal_item.dart';

class CategoriesMealsPage extends StatelessWidget {
  final List<MealModel> meals;

  const CategoriesMealsPage({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    final categoryModel =
        ModalRoute.of(context)!.settings.arguments as CategoryModel;

    final categoryMeals = meals.where((meal) {
      return meal.categories.contains(categoryModel.id);
    }).toList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Receitas: ${categoryModel.title}'),
          backgroundColor: categoryModel.color,
        ),
        body: categoryMeals.isNotEmpty
            ? ListView.builder(
                itemCount: categoryMeals.length,
                itemBuilder: (_, index) {
                  MealModel meal = categoryMeals[index];
                  return MealItem(mealModel: meal);
                },
              )
            : Container(
                alignment: Alignment.center,
                child: Text(
                  "Nenhum registro localizado.",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
      ),
    );
  }
}

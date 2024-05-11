import 'package:flutter/material.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/views/widgets/meal_item.dart';

class FavoriteMealPage extends StatelessWidget {
  final List<MealModel> favoriteMeal;
  const FavoriteMealPage({super.key, required this.favoriteMeal});

  @override
  Widget build(BuildContext context) {
    return favoriteMeal.isEmpty
        ? const Center(
            child: Text("Nenhuma comida selecinada como favorita"),
          )
        : ListView.builder(
            itemCount: favoriteMeal.length,
            itemBuilder: (_, index) {
              return MealItem(mealModel: favoriteMeal[index]);
            },
          );
  }
}

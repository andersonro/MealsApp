import 'package:flutter/material.dart';
import 'package:meals_app/models/meal_model.dart';

class MealDetailPage extends StatefulWidget {
  final Function(MealModel) onToggleFavorite;
  final bool Function(MealModel) isFavorite;
  const MealDetailPage(
      {super.key, required this.onToggleFavorite, required this.isFavorite});

  @override
  State<MealDetailPage> createState() => _MealDetailPageState();
}

class _MealDetailPageState extends State<MealDetailPage> {
  @override
  Widget build(BuildContext context) {
    final MealModel mealModel =
        ModalRoute.of(context)!.settings.arguments as MealModel;

    bool isFgFavorite = widget.isFavorite(mealModel);

    void onFavoriteChanged() {
      setState(() {
        isFgFavorite = widget.isFavorite(mealModel);
      });
    }

    Widget createSectionTitle(BuildContext context, String title) {
      return Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
    }

    Widget createSectionList(List list) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: list.map((element) {
            return Container(
              margin: const EdgeInsets.only(bottom: 5),
              child: Text('- $element'),
            );
          }).toList(),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(mealModel.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 250,
                child: Image.network(
                  mealModel.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              createSectionTitle(context, 'Ingredientes'),
              createSectionList(mealModel.ingredients),
              const SizedBox(height: 8),
              createSectionTitle(context, 'Passos'),
              createSectionList(mealModel.steps),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            widget.onToggleFavorite(mealModel);
            onFavoriteChanged();
          },
          foregroundColor: isFgFavorite ? Colors.amber : Colors.white,
          child: const Icon(Icons.star),
        ),
      ),
    );
  }
}

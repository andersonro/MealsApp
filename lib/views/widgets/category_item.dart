import 'package:flutter/material.dart';
import 'package:meals_app/models/category_model.dart';
import 'package:meals_app/utils/app_routes.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel categoryModel;
  const CategoryItem({super.key, required this.categoryModel});

  void _categorySelected(BuildContext context) {
    /*
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CategoriesMealsPage(
          categoryModel: categoryModel,
        ),
      ),
    );
    */
    Navigator.of(context)
        .pushNamed(AppRoutes.categoriesMeal, arguments: categoryModel);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _categorySelected(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              categoryModel.color.withOpacity(0.5),
              categoryModel.color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(categoryModel.title),
      ),
    );
  }
}

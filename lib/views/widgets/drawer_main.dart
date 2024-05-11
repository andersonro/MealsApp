import 'package:flutter/material.dart';
import 'package:meals_app/utils/app_routes.dart';

class DrawerMain extends StatelessWidget {
  const DrawerMain({super.key});

  @override
  Widget build(BuildContext context) {
    final drawerHeight = MediaQuery.of(context).size.height;

    Widget drawerItemSection(IconData icon, String title, Function() onTap) {
      return ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: onTap,
      );
    }

    return Drawer(
      child: SizedBox(
        height: drawerHeight,
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, bottom: 20),
              alignment: Alignment.bottomLeft,
              height: 120,
              color: Theme.of(context).primaryColor,
              child: Text(
                "Vamos cozinhar?",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            drawerItemSection(
              Icons.restaurant,
              'Refeições',
              () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.home);
              },
            ),
            drawerItemSection(
              Icons.settings,
              'Configurações',
              () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.settings);
              },
            )
          ],
        ),
      ),
    );
  }
}

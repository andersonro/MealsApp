import 'package:flutter/material.dart';
import 'package:meals_app/models/settings_model.dart';
import 'package:meals_app/views/widgets/drawer_main.dart';

class SettingsPage extends StatefulWidget {
  final SettingsModel settingsModel;
  final Function(SettingsModel) onSettingsChanged;

  const SettingsPage(
      {super.key,
      required this.onSettingsChanged,
      required this.settingsModel});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SettingsModel settings;

  @override
  void initState() {
    super.initState();
    settings = widget.settingsModel;
  }

  Widget _createSwitch(
      {required String title,
      required String subTitle,
      required bool value,
      required Function(bool) onChanged}) {
    return SwitchListTile.adaptive(
      title: Text(title),
      subtitle: Text(subTitle),
      value: value,
      onChanged: (value) {
        onChanged(value);
        widget.onSettingsChanged(settings);
      },
      activeColor: Theme.of(context).primaryColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Configurações')),
        drawer: const DrawerMain(),
        body: Column(
          children: [
            Expanded(
                child: ListView(
              children: [
                _createSwitch(
                  title: 'Sem Gluten',
                  subTitle: 'Exibir apenas refeiões sem gluten',
                  value: settings.isGlutenFree,
                  onChanged: (value) => setState(
                    () {
                      settings.isGlutenFree = value;
                    },
                  ),
                ),
                _createSwitch(
                  title: 'Sem Lactose',
                  subTitle: 'Exibir apenas refeiões sem lactose',
                  value: settings.isLactoseFree,
                  onChanged: (value) => setState(
                    () {
                      settings.isLactoseFree = value;
                    },
                  ),
                ),
                _createSwitch(
                  title: 'Vegana',
                  subTitle: 'Exibir apenas refeiões vegana',
                  value: settings.isVegan,
                  onChanged: (value) => setState(
                    () {
                      settings.isVegan = value;
                    },
                  ),
                ),
                _createSwitch(
                  title: 'Vegetarianas',
                  subTitle: 'Exibir apenas refeiões vegetarianas',
                  value: settings.isVegetarian,
                  onChanged: (value) => setState(
                    () {
                      settings.isVegetarian = value;
                    },
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

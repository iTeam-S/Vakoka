import 'dart:async';

import 'package:flutter/material.dart';
import 'package:city_picker_from_map/city_picker_from_map.dart';
import 'package:get/get.dart';
import 'package:mybn/views/home.dart';

class CarteView extends StatefulWidget {
  @override
  _CarteView createState() => _CarteView();
}

class _CarteView extends State<CarteView> {
  City? selectedCity;
  final GlobalKey<CityPickerMapState> _mapKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected City: ${selectedCity?.title ?? '(?)'}'),
        actions: [
          IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                _mapKey.currentState?.clearSelect();
                setState(() {
                  selectedCity = null;
                });
              })
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: InteractiveViewer(
              scaleEnabled: true,
              panEnabled: true,
              constrained: true,
              child: CityPickerMap(
                key: _mapKey,
                width: double.infinity,
                height: double.infinity,
                map: Maps.MADAGASCAR,
                onChanged: (city) {
                  setState(() {
                    selectedCity = city;
                  });
                  Get.snackbar('Redirection',
                      'Recherche pour la région de ${selectedCity?.title.toString()}');

                  Timer(Duration(seconds: 2), () {
                    appController.selectedCategorie =
                        '_REGION_' + selectedCity!.title.toString();
                    appController.update();
                    Get.toNamed(
                      '/home',
                    );
                  });
                },
                actAsToggle: true,
                dotColor: Colors.black,
                selectedColor: Colors.teal,
                strokeColor: Colors.teal[600],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:turistic_poi_test/domain/entities/poi.dart';
import 'package:turistic_poi_test/utils/map_widget.dart';

class PoiDetailView extends StatelessWidget {
  final Poi poi;
  const PoiDetailView({Key? key, required this.poi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del POI'),
        leading: const BackButton(),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE0FFFF), Color(0xFFAFEEEE)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.network(
                    poi.image
                ),
                const SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    poi.title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: MapWidget(coordinates: poi.geocoordinates)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


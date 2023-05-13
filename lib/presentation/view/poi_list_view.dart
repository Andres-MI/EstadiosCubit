import 'package:flutter/material.dart';
import 'package:turistic_poi_test/presentation/view/alert_dialog.dart';
import 'package:turistic_poi_test/presentation/view/poi_detail_view.dart';

import '../../domain/entities/poi.dart';

class PoiListView extends StatefulWidget {
  final List<Poi> list;
  const PoiListView({Key? key, required this.list}) : super(key: key);

  @override
  State<PoiListView> createState() => _PoiListViewState();
}

class _PoiListViewState extends State<PoiListView> {
  @override
  void initState() {
    super.initState();
    _filteredPois.addAll(widget.list);
  }

  final TextEditingController _searchController = TextEditingController();
  List<Poi> _filteredPois = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listado de POI"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const CustomDialog(
                          contentText:
                              '¿Desea eliminar todos los POI almacenados?');
                    },
                  ).then((confirmed) {
                    if (confirmed ?? false) {
                      //Borrar todos los POI
                    }
                  });
                });
              },
              icon: const Icon(Icons.cancel))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _filteredPois = widget.list
                      .where((item) => item.title
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase()))
                      .toList();
                });
              },
              decoration: const InputDecoration(
                labelText: 'Filtrar',
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: _filteredPois.length,
                  itemBuilder: (context, index) {
                    Color? color =
                        index % 2 == 0 ? Colors.white : Colors.grey[200];
                    return ListTile(
                      title: Text(_filteredPois[index].title),
                      tileColor: color,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PoiDetailView(poi: _filteredPois[index])));
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

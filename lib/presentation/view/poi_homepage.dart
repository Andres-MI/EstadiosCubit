import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:turistic_poi_test/presentation/cubit/poi_cubit.dart';
import 'package:turistic_poi_test/presentation/view/poi_list_view.dart';

class PoiHomepage extends StatelessWidget {
  const PoiHomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<PoiCubit>(),
      child: SafeArea(
        child: BlocBuilder<PoiCubit, PoiState>(
          builder: (context, state) {
            if (state is PoiInitial) {
              return const InitialButton();
            } else if (state is PoiError) {
              return Center(
                child: Text('Error: ${state.message}'),
              );
            } else if (state is PoiLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PoiLoaded) {
              return PoiListView(list: state.poiList.list);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class InitialButton extends StatelessWidget {
  const InitialButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          context.read<PoiCubit>().getPoiList();
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 24.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 4.0,
        ),
        child: const Text(
          'Conseguir POI',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

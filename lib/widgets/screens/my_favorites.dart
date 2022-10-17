import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_cocktail_app/data/database.dart';

class MyFavorites extends StatefulWidget {
  String? uid;
  MyFavorites({required this.uid, super.key});

  @override
  State<MyFavorites> createState() => _MyFavoritesState();
}

class _MyFavoritesState extends State<MyFavorites> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("My Favorites")),
      body: Center(
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final cocktailList = ref.watch(cocktailListProvider(widget.uid));
            return cocktailList.when(
                data: (data) {
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(data[index].drinkName);
                      });
                },
                error: (e, stack) => Text('$e'),
                loading: () =>
                    const Center(child: CircularProgressIndicator()));
          },
        ),
      ),
    ));
  }
}

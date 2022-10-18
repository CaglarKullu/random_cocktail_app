import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_cocktail_app/consts/text_style.dart';
import 'package:random_cocktail_app/data/database.dart';

class MyFavorites extends StatelessWidget {
  String? uid;
  MyFavorites({required this.uid, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("My Favorites")),
      body: Center(
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final cocktailList = ref.watch(cocktailListProvider(uid));

            return cocktailList.when(
                data: (data) {
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent:
                            MediaQuery.of(context).size.width / 2,
                        childAspectRatio: 1,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                      ),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: Colors.white24,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(data[index].drinkThumb!)),
                            ),
                            child: Text(
                              data[index].drinkName!,
                              style: selectedButtonTextStyle,
                            ),
                          ),
                        );
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

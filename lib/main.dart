import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_cocktail_app/api_service/random_cocktail_api.dart';
import 'package:random_cocktail_app/consts/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: const ProviderScope(
        child: MyHomePage(
          title: 'Random Cocktail',
        ),
      ),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  int _counter = 0;

  _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(widget.title),
      ),
      body: Center(
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final drink = ref.watch(randomDrink);
            return drink.when(
                data: ((data) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                          onPressed: (() {
                            setState(() {
                              _incrementCounter();
                              ref.refresh(randomDrink);
                            });
                          }),
                          child:
                              const Text("Bartender bring me random drink!")),
                      Text(data.randomCocktail[0].drinkName),
                      Text(data.randomCocktail[0].category),
                      Text(data.randomCocktail[0].glass),
                      Text(data.randomCocktail[0].instructions),
                    ],
                  );
                }),
                error: (e, stack) => Text('$e'),
                loading: () => const CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

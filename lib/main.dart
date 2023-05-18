import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealio/models/ingredient.dart';
import 'package:mealio/providers/database.dart';
import 'package:mealio/providers/ingredients.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await openDatabase(
    join(await getDatabasesPath(), 'mealio_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE ingredients_library(id INTEGER PRIMARY KEY, name TEXT)',
      );
    },
    version: 1,
  );

  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(database),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mealio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Ingredients'),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  createState() => MyHomePageState();
}

class MyHomePageState extends ConsumerState<MyHomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ingredients = ref.watch(ingredientsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ingredients.when(
        data: (data) => ListView(
          children: [
            for (final ingredient in data)
              ListTile(
                key: ValueKey(ingredient.name),
                title: Text(ingredient.name),
              )
          ],
        ),
        error: (e, s) => Center(child: Text(e.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddIngredientDialog(context);
        },
        tooltip: 'Add ingredients',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAddIngredientDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Add Ingredient',
            key: ValueKey('add_ingredient_dialog_title'),
          ),
          content: TextField(
            key: const ValueKey('add_ingredient_text_field'),
            controller: _controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Search for ingredient',
            ),
          ),
          actions: <Widget>[
            TextButton(
              key: const ValueKey('add_ingredient_button'),
              child: const Text('Add'),
              onPressed: () {
                ref.read(ingredientsProvider.notifier).addIngredient(
                      Ingredient(id: 1, name: _controller.text),
                    );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

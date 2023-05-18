import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealio/models/ingredient.dart';
import 'package:mealio/providers/ingredients.dart';

void main() {
  runApp(const MyApp());
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
      home: const ProviderScope(
        child: MyHomePage(title: 'Ingredients'),
      ),
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
      body: ListView(
        children: [
          for (final ingredient in ingredients)
            ListTile(
              key: ValueKey(ingredient.name),
              title: Text(ingredient.name),
            )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddIngredientDialog();
        },
        tooltip: 'Add ingredients',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAddIngredientDialog() async {
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
                      Ingredient(_controller.text),
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

import 'package:mealio/models/ingredient.dart';
import 'package:mealio/providers/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

part 'ingredients.g.dart';

@riverpod
class Ingredients extends _$Ingredients {
  @override
  Future<List<Ingredient>> build() async {
    final db = ref.read(databaseProvider);

    final List<Map<String, dynamic>> maps =
        await db.query("ingredients_library");

    return List.generate(maps.length, (i) {
      return Ingredient.fromJson(maps[i]);
    });
  }

  void addIngredient(Ingredient ingredient) async {
    final db = ref.read(databaseProvider);

    // Insert into database and update state
    await db.insert(
      'ingredients_library',
      ingredient.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    state.whenData((value) => state = AsyncValue.data([...value, ingredient]));
  }
}

import 'package:mealio/models/ingredient.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ingredients.g.dart';

@riverpod
class Ingredients extends _$Ingredients {
  @override
  List<Ingredient> build() => [];

  void addIngredient(Ingredient ingredient) => state = [
        ...state,
        ingredient,
      ];
}

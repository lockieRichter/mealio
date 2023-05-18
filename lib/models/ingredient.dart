import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingredient.freezed.dart';
part 'ingredient.g.dart';

@freezed
class Ingredient with _$Ingredient {
  const factory Ingredient({
    int? id,
    required String name,
    required Category category,
  }) = _Ingredient;

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);
}

enum Category {
  meat,
  fish,
  vegetable,
  fruit,
  dairy,
  cereal,
  grain,
  legume,
  spice,
  herb,
  oil,
  other,
}

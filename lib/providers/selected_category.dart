import 'package:mealio/models/ingredient.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_category.g.dart';

@riverpod
class SelectedCategory extends _$SelectedCategory {
  @override
  Category build() => Category.meat;

  void select(Category category) => state = category;
}

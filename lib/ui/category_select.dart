import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealio/models/ingredient.dart';
import 'package:mealio/providers/selected_category.dart';

class CategorySelect extends ConsumerWidget {
  const CategorySelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dropdownValue = ref.watch(selectedCategoryProvider);

    return DropdownButton<Category>(
      value: dropdownValue,
      isExpanded: true,
      onChanged: (Category? value) {
        if (value != null) {
          ref.read(selectedCategoryProvider.notifier).select(value);
        }
      },
      items: Category.values.map<DropdownMenuItem<Category>>((Category value) {
        return DropdownMenuItem<Category>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
    );
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Ingredient _$$_IngredientFromJson(Map<String, dynamic> json) =>
    _$_Ingredient(
      id: json['id'] as int?,
      name: json['name'] as String,
      category: $enumDecode(_$CategoryEnumMap, json['category']),
    );

Map<String, dynamic> _$$_IngredientToJson(_$_Ingredient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': _$CategoryEnumMap[instance.category]!,
    };

const _$CategoryEnumMap = {
  Category.meat: 'meat',
  Category.fish: 'fish',
  Category.vegetable: 'vegetable',
  Category.fruit: 'fruit',
  Category.dairy: 'dairy',
  Category.cereal: 'cereal',
  Category.grain: 'grain',
  Category.legume: 'legume',
  Category.spice: 'spice',
  Category.herb: 'herb',
  Category.oil: 'oil',
  Category.other: 'other',
};

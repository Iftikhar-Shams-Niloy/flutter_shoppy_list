import 'package:flutter/material.dart';

import '../models/category.dart';

const categories = {
  Categories.vegetables: Category(
    'Vegetables',
    Colors.greenAccent,
  ),
  Categories.fruit: Category(
    'Fruit',
    Colors.lightGreenAccent,
  ),
  Categories.meat: Category(
    'Meat',
    Colors.yellowAccent,
  ),
  Categories.dairy: Category(
    'Dairy',
    Colors.white54,
  ),
  Categories.carbs: Category(
    'Carbs',
    Colors.blueAccent,
  ),
  Categories.sweets: Category(
    'Sweets',
    Colors.deepOrangeAccent,
  ),
  Categories.spices: Category(
    'Spices',
    Colors.orangeAccent,
  ),
  Categories.convenience: Category(
    'Convenience',
    Colors.deepPurpleAccent,
  ),
  Categories.hygiene: Category(
    'Hygiene',
    Colors.redAccent,
  ),
  Categories.other: Category('Other', Colors.lightBlueAccent),
};

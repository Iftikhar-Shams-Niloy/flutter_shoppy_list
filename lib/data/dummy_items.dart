

import 'package:flutter_shoppy_list/data/categories.dart';
import 'package:flutter_shoppy_list/models/category.dart';
import 'package:flutter_shoppy_list/models/grocery_item.dart';

final groceryItems = [
  GroceryItem(
    id: 'a',
    name: 'Milk',
    quantity: 1,
    category: categories[Categories.dairy]!,
  ),
  GroceryItem(
    id: 'b',
    name: 'Bananas',
    quantity: 5,
    category: categories[Categories.fruit]!,
  ),
  GroceryItem(
    id: 'c',
    name: 'Beef Steak',
    quantity: 1,
    category: categories[Categories.meat]!,
  ),
  GroceryItem(
    id: 'd',
    name: 'Milk',
    quantity: 1,
    category: categories[Categories.dairy]!,
  ),
];

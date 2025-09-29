import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shoppy_list/data/categories.dart';
import 'package:flutter_shoppy_list/widgets/new_item.dart';
import 'package:http/http.dart' as http;
import '../models/grocery_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItemsList = [];
  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    //* <--- Setting up URL --->
    final url = Uri.https(
      "flutter-shoppy-list-default-rtdb.firebaseio.com",
      "shopping-list.json",
    );

    //* <-- Try executes a code and looks if there is an error -->
    try {
      //* <--- Sending request to get the data --->
      final response = await http.get(url);

      //! <--- Handle content not found error --->
      if (response.statusCode >= 400) {
        _error = "Failed to get data! Try again!";
      }

      //* <--- json.decode() convers the Json file value into something readable --->
      // <--- Map<String,...> means, it is mapping "..." as String --->
      // <--- dynamic means various consisting of various types of data --->
      final Map<String, dynamic> listData = json.decode(
        response.body,
      );
      final List<GroceryItem> loadedItemsList = [];
      for (final item in listData.entries) {
        //* <--- firstWhere() goes through all the values and finds the first MATCH --->
        /* <--- categoryItem.value.title == item.value["Category"] means it matches the 
      file we got from json with the existing title exists in categories.entries ---> */
        final myCategory = categories.entries
            .firstWhere(
              (categoryItem) =>
                  categoryItem.value.title == item.value["category"],
            )
            .value;

        //* <--- Adding value of type GroceryItem in _loadedItemsList --->
        loadedItemsList.add(
          GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: myCategory,
          ),
        );
      }
      //*<--- Overwriting the groceryItems and refreshing the screen using setState() --->
      setState(() {
        _groceryItemsList = loadedItemsList;
      });
    } catch (myError) {
      //* <--- If "try" catches an error then catch the error and save it in myError --->
      setState(() {
        _error = "Something went wrong. Please try again later!";
      });
    }
  }

  void _addItem() async {
    final myNewItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );

    if (myNewItem == null) {
      return;
    } else {
      setState(() {
        _groceryItemsList.add(myNewItem);
        _isLoading = false;
      });
    }
  }

  Future<void> _removeItem(GroceryItem item) async {
    final index = _groceryItemsList.indexOf(item);
    setState(() {
      _groceryItemsList.remove(item);
    });

    final url = Uri.https(
      "flutter-shoppy-list-default-rtdb.firebaseio.com",
      "shopping-list/${item.id}.json",
    );
    final response = await http.delete(url);

    //* <--- If backend deletion fails, then re-add the deleted value on screen. --->
    if (response.statusCode >= 400) {
      setState(() {
        _groceryItemsList.insert(index, item);
      });
    }

    //* <--- When nothing on screen, does not stuck in loading screen.--->
    if (response.body == 'null') {
      setState(() {
        _isLoading = false;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget myContent = Center(
      child: Text("Nothing to show!"),
    );

    //* It will show a circular loading animation while loading
    if (_isLoading) {
      myContent = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_groceryItemsList.isNotEmpty) {
      myContent = ListView.builder(
        itemCount: _groceryItemsList.length,
        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (direction) {
            _removeItem(_groceryItemsList[index]);
          },
          key: ValueKey(_groceryItemsList[index].id),
          child: ListTile(
            title: Text(_groceryItemsList[index].name),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItemsList[index].category.color,
            ),
            trailing: Text(
              _groceryItemsList[index].quantity.toString(),
            ),
          ),
        ),
      );
    }

    if (_error != null) {
      myContent = Center(
        child: Text(_error!),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Grocery List'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),

      body: myContent,
    );
  }
}

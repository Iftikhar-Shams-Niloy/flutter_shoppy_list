import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shoppy_list/models/grocery_item.dart';
import 'package:http/http.dart' as http;
import '../data/categories.dart';
import '../models/category.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  var _nameEntered = "";
  var _quantityEntered = 1;
  var _categorySelected = categories[Categories.vegetables]!;

  //* <--- currentState: Form state
  //* <--- validate: executes it's validator function and returns boolean value. --->
  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      //* Only when when validate is true
      _formKey.currentState!.save();
      
      final url = Uri.https(
        //* Setting url from firebase
        "flutter-shoppy-list-default-rtdb.firebaseio.com",
        "shopping-list.json",
      );
      http.post(
        url,
        headers: {
          //* Setting headers to firebase
          "Content-Type": "application/json",
        },
        body: json.encode({
          //* Setting body to firebase
          "name": _nameEntered,
          "quantity": _quantityEntered,
          "category": _categorySelected.title,
        }),
      );
      Navigator.of(context).pop(
        //* Creates GroceryItem() and pass it back to previous screen
        GroceryItem(
          id: DateTime.now().toString(),
          name: _nameEntered,
          quantity: _quantityEntered,
          category: _categorySelected,
        ),
      );
      // print(_nameEntered); //! <--- Delete later!
      // print(_quantityEntered); //! <--- Delete later!
      // print(_categorySelected); //! <--- Delete later!
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Item')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                maxLength: 51,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
                //* <--- Validator to check if the input is valid -->
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length == 1 ||
                      value.trim().length > 50) {
                    return 'Invalid Name!';
                  } else {
                    return null;
                  }
                },
                onSaved: (myValue) {
                  _nameEntered = myValue!;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    //! <--- Quantity text field here --->
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Quantity'),
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: "1",
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 1) {
                          return 'Invalid Quantity!';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (myValue) {
                        _quantityEntered = int.parse(myValue!);
                      },
                    ),
                  ),

                  SizedBox(width: 10),

                  Expanded(
                    child: DropdownButtonFormField(
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: category.value.color,
                                ),
                                const SizedBox(width: 6),
                                Text(category.value.title),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (myValue) {
                        setState(() {
                          _categorySelected = myValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //* _formKey is a global key || this resets the state
                  TextButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                    },
                    child: const Text("Reset"),
                  ),
                  ElevatedButton(
                    onPressed: _saveItem,
                    child: const Text("Add Item"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

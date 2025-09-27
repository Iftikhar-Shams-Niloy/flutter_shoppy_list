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
  var _isSending = false;

  //* <--- currentState: Form state
  //* <--- validate: executes it's validator function and returns boolean value. --->
  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      //* Only when when validate is true
      _formKey.currentState!.save();

      //* When saving an item set _isSending to true
      setState(() {
        _isSending = true;
      });

      final url = Uri.https(
        //* Setting url from firebase
        "flutter-shoppy-list-default-rtdb.firebaseio.com",
        "shopping-list.json",
      );
      final response = await http.post(
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

      final responseData = json.decode(response.body);

      if (!context.mounted) {
        return;
      }

      Navigator.of(context).pop(
        GroceryItem(
          id: responseData['name'],
          name: _nameEntered,
          quantity: _quantityEntered,
          category: _categorySelected,
        ),
      );
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
                            int.tryParse(value)! < 1) {
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
                    //* If sending, then disable "Reset" button
                    onPressed: _isSending
                        ? null
                        : () {
                            _formKey.currentState!.reset();
                          },
                    child: const Text("Reset"),
                  ),
                  ElevatedButton(
                    //* if sending, then disable the button and show circular indicator
                    onPressed: _isSending ? null : _saveItem,
                    child: _isSending
                        ? SizedBox(
                            height: 12,
                            width: 12,
                            child: CircularProgressIndicator(),
                          )
                        : const Text("Add Item"),
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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:module_13_part_2/presentation/widgets/image_input.dart';
import 'package:module_13_part_2/providers/places_provider.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-palce';

  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  File? _savedImage;
  String _title = '';
  final _formKey = GlobalKey<FormState>();

  void _takeSavedImage(savedImage) {
    _savedImage = savedImage;
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _savedImage != null) {
      _formKey.currentState!.save();
      Provider.of<PlacesProvider>(context, listen: false)
          .addPlace(_title, _savedImage!);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Sayohat Joyini Qo\'shish'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Title', border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Iltimos, joy nomini kiriting!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _title = value!;
                    },
                  ),
                  const SizedBox(height: 20),
                  ImageInput(_takeSavedImage)
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
                elevation: 0,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsets.symmetric(vertical: 15)),
            child: const Text('Qo\'shish'),
          ),
        ],
      ),
    );
  }
}

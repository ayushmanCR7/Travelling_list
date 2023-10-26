import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new2/models/place.dart';
import 'package:new2/provider/user_places.dart';
import 'package:new2/widgets/image_input.dart';
import 'dart:io';

import 'package:new2/widgets/location_input.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlacesScreenState();
  }
}

class _AddPlacesScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;
  void _savedPlace() {
    final enteredTitle = _titleController.text;
    if (enteredTitle.isEmpty || _selectedImage == null) {
      return;
    }
    ref
        .read(userPlacesProvider.notifier)
        .addPlace(enteredTitle, _selectedImage!, _selectedLocation!);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new Places"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: _titleController,
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
          ImageInput(
            onPickimage: (image) {
              _selectedImage = image;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          LocationInput(
            onSelectLocation: (location) {
              _selectedLocation = location;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton.icon(
              icon: const Icon(Icons.add),
              onPressed: _savedPlace,
              label: Text('Add Place'))
        ]),
      ),
    );
  }
}

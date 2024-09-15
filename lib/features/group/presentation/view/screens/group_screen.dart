import 'package:flutter/material.dart';
import 'package:notify/shared/domin/entities/group_model.dart';

class CreateChannelScreen extends StatefulWidget {
  const CreateChannelScreen({super.key});

  @override
  CreateChannelScreenState createState() => CreateChannelScreenState();
}

class CreateChannelScreenState extends State<CreateChannelScreen> {
  // Text controllers for form fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _hexColorController = TextEditingController();
  final TextEditingController _supervisorsController = TextEditingController();
  final TextEditingController _membersController = TextEditingController();

  String? imageUrl; // To store uploaded image URL
  int creatorId = 1; // Assume the creator ID is set elsewhere in the app
  List<int> supervisors = [];
  List<int> members = [];

  final _formKey = GlobalKey<FormState>(); // To validate the form

  // Function to create a Channel object
  void _createChannel() {
    if (_formKey.currentState?.validate() ?? false) {
      final Channel newChannel = Channel(
        id: DateTime.now().millisecondsSinceEpoch, // Generate a unique ID
        title: _titleController.text,
        describtion: _descriptionController.text,
        hexColor: _hexColorController.text,
        creatorId: creatorId,
        superVisorsId: supervisors,
        membersId: members,
        imageUrl: imageUrl,
      );
      // Save or handle the new channel object as needed
      print(newChannel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Channel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Title field
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Channel Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),

              // Description field
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),

              // Hex Color field
              TextFormField(
                controller: _hexColorController,
                decoration: const InputDecoration(
                    labelText: 'Hex Color (e.g., #FFFFFF)'),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !RegExp(r'^#[0-9A-Fa-f]{6}$').hasMatch(value)) {
                    return 'Please enter a valid hex color';
                  }
                  return null;
                },
              ),

              // Supervisors field (comma separated IDs)
              TextFormField(
                controller: _supervisorsController,
                decoration: const InputDecoration(
                    labelText: 'Supervisors (comma separated IDs)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter at least one supervisor';
                  }
                  return null;
                },
                onChanged: (value) {
                  supervisors = value
                      .split(',')
                      .map((e) => int.tryParse(e.trim()) ?? 0)
                      .toList();
                },
              ),

              // Members field (comma separated IDs)
              TextFormField(
                controller: _membersController,
                decoration: const InputDecoration(
                    labelText: 'Members (comma separated IDs)'),
                onChanged: (value) {
                  members = value
                      .split(',')
                      .map((e) => int.tryParse(e.trim()) ?? 0)
                      .toList();
                },
              ),

              // Image URL (optional)
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Image URL (optional)'),
                onChanged: (value) {
                  imageUrl = value.isNotEmpty ? value : null;
                },
              ),

              // Submit button
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createChannel,
                child: const Text('Create Channel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

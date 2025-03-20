import 'package:crafti_hub/user%20side/common/button.dart';
import 'package:crafti_hub/user%20side/common/custom_expansion_tile.dart';
import 'package:crafti_hub/user%20side/common/table_row.dart';
import 'package:crafti_hub/user%20side/screens/profile/profile_provider.dart';
import 'package:crafti_hub/user%20side/screens/profile/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class PersonalInfoSetcion extends StatelessWidget {
  const PersonalInfoSetcion({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ProfileProvider>(context).user;
    return CustomExpansionTile(
        leading: const Icon(Icons.person, color: Color.fromARGB(255, 129, 63, 42),),
        title: 'Personal Info',
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: user == null
                ? Text('User not found')
                : Table(
                    columnWidths: const {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(3),
                    },
                    children: [
                      tableRow(label: 'Name', value: user.username),
                      tableRow(label: 'Email', value: user.email),
                    ],
                  ),
          ),
          if (user == null || user.username.isEmpty)
            customButton(
              isLoading: false,
              buttonName: 'Edit Info',
              color: Color.fromARGB(255, 129, 63, 42),
              onPressed: () {
                if (user != null) _showEditPersonalInfoDialog(context, user);
              },
            ),
          SizedBox(
            height: 10,
          )
        ]);
  }

  // Edit Personal Info Dialog
  void _showEditPersonalInfoDialog(BuildContext context, UserModel user) {
    final nameController = TextEditingController(text: user.username);
    final emailController = TextEditingController(text: user.email);
    final phoneController = TextEditingController(text: '');
    final dobController = TextEditingController(text: '');
    String? selectedGender = ''; // Store current gender

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Personal Info'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Required field' : null,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Required field' : null,
              ),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                validator: (value) => value!.isEmpty ? 'Required field' : null,
              ),
              TextFormField(
                controller: dobController,
                readOnly: true,
                decoration: const InputDecoration(labelText: 'Date of Birth'),
                onTap: () async {
                  // Optional: Add date picker
                  final date = await showDatePicker(
                    initialDatePickerMode: DatePickerMode.year,
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    dobController.text = DateFormat('dd-MM-yyyy').format(date);
                  }
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedGender,
                decoration: const InputDecoration(labelText: 'Gender'),
                items: const [
                  DropdownMenuItem(
                    value: 'Male',
                    child: Text('Male'),
                  ),
                  DropdownMenuItem(
                    value: 'Female',
                    child: Text('Female'),
                  ),
                ],
                onChanged: (value) => selectedGender = value,
                validator: (value) => value == null ? 'Select gender' : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

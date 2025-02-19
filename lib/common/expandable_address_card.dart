import 'package:crafti_hub/common/button.dart';
import 'package:crafti_hub/common/custom_expansion_tile.dart';
import 'package:crafti_hub/common/flush_bar.dart';
import 'package:crafti_hub/common/table_row.dart';
import 'package:crafti_hub/screens/profile/profile_provider.dart';
import 'package:crafti_hub/screens/profile/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedAddressSection extends StatelessWidget {
  const SavedAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final userAddress = profileProvider.user?.addresses;

    return CustomExpansionTile(
      initiallyExpanded: true,
      leading: const Icon(
        Icons.location_on,
        color: Colors.brown,
      ),
      title: 'Address',
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: (userAddress == null || userAddress.isEmpty)
              ? const Text('No Address Found')
              : Table(
                  columnWidths: const {
                    0: FlexColumnWidth(2), // Label column width
                    1: FlexColumnWidth(3), // Value column width
                  },
                  children: [
                    tableRow(label: 'Address', value: 'userAddress.address'),
                    tableRow(label: 'Road Name', value: 'userAddress.roadName'),
                    tableRow(label: 'City', value: ' userAddress.city'),
                    tableRow(label: 'State', value: ' userAddress.state'),
                    tableRow(label: 'Pincode', value: 'userAddress.pincode'),
                  ],
                ),
        ),
        customButton(
          isLoading: false,
          color: Colors.brown,
          buttonName: (userAddress == null || userAddress.isEmpty)
              ? '+ Address'
              : 'Edit Address',
          onPressed: () {
            if (userAddress != null) {
              _showEditAddressDialog(
                  context, userAddress as Address, profileProvider);
            } else {
              showFlushbar(
                  message: 'Error: UserAddress not found!',
                  color: Colors.red,
                  icon: Icons.error,
                  context: context);
            }
          },
        ),
      ],
    );
  }

  /// ✅ Edit Address Dialog (Null-Safe)
  void _showEditAddressDialog(BuildContext context, Address userAddress,
      ProfileProvider profileProvider) {
    final tcAddress = TextEditingController(text: 'userAddress.address' ?? '');
    final tcCity = TextEditingController(text: userAddress.city ?? '');
    final tcState = TextEditingController(text: userAddress.state ?? '');
    final tcPincode = TextEditingController(text: userAddress.pincode ?? '');
    final tcRoadName =
        TextEditingController(text: 'userAddress.roadName ' ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Address'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: tcAddress,
                decoration: const InputDecoration(labelText: 'Street Address'),
              ),
              TextFormField(
                controller: tcRoadName,
                decoration: const InputDecoration(labelText: 'Road Name'),
              ),
              TextFormField(
                controller: tcCity,
                decoration: const InputDecoration(labelText: 'City'),
              ),
              TextFormField(
                controller: tcState,
                decoration: const InputDecoration(labelText: 'State'),
              ),
              TextFormField(
                controller: tcPincode,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Pincode'),
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
              // Ensure all fields are filled
              if (tcAddress.text.isEmpty ||
                  tcCity.text.isEmpty ||
                  tcState.text.isEmpty ||
                  tcPincode.text.isEmpty ||
                  tcRoadName.text.isEmpty) {
                showFlushbar(
                    message: 'Fill All Fields',
                    color: Colors.red,
                    icon: Icons.error,
                    context: context);
                return;
              }

              // // Validate and parse pincode safely
              // int? pincode = int.tryParse(tcPincode.text);
              // if (pincode == null) {
              //   flushBar('Invalid Pincode', context);
              //   return;
              // }

              final data = {
                "address": tcAddress.text,
                "state": tcState.text,
                "pincode": tcPincode.text,
                "city": tcCity.text,
                "road_name": tcRoadName.text
              };

              // await profileProvider.changeAddress(context, data);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

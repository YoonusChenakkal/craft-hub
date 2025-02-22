import 'package:crafti_hub/user%20side/common/button.dart';
import 'package:crafti_hub/user%20side/common/custom_expansion_tile.dart';
import 'package:crafti_hub/user%20side/common/flush_bar.dart';
import 'package:crafti_hub/user%20side/common/table_row.dart';
import 'package:crafti_hub/user%20side/screens/profile/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        color: Color.fromARGB(255, 0, 156, 177),
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
                    tableRow(
                        label: 'Address', value: userAddress[0].addressLine1),
                    tableRow(label: 'Area', value: userAddress[0].addressLine2),
                    tableRow(label: 'City', value: userAddress[0].city),
                    tableRow(label: 'State', value: userAddress[0].state),
                    tableRow(label: 'Pincode', value: userAddress[0].pincode),
                  ],
                ),
        ),
        if (userAddress == null || userAddress.isEmpty)
          customButton(
              isLoading: false,
              color: Colors.cyan,
              buttonName: '+ Address',
              onPressed: () {
                _showEditAddressDialog(context, profileProvider);
              }),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  /// ✅ Edit Address Dialog (Null-Safe)
  void _showEditAddressDialog(
      BuildContext context, ProfileProvider profileProvider) {
    final tcAddress = TextEditingController();
    final tcCity = TextEditingController();
    final tcState = TextEditingController();
    final tcPincode = TextEditingController();
    final tcArea = TextEditingController();

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
                decoration: const InputDecoration(labelText: 'Address'),
              ),
              TextFormField(
                controller: tcArea,
                decoration: const InputDecoration(labelText: 'Area'),
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
                inputFormatters: [
                  LengthLimitingTextInputFormatter(6),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  labelText: 'Pincode',
                ),
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
                  tcArea.text.isEmpty) {
                showFlushbar(
                    message: 'Fill All Fields',
                    color: Colors.red,
                    icon: Icons.error,
                    context: context);
                return;
              }

              final data = {
                "user": profileProvider.user?.id,
                "address_line1": tcAddress.text,
                "state": tcState.text,
                "pincode": tcPincode.text,
                "city": tcCity.text,
                "country": "India",
                "address_line2": tcArea.text
              };

              await profileProvider.addAddress(context, data);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

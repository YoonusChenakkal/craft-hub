import 'package:crafti_hub/user%20side/common/button.dart';
import 'package:crafti_hub/user%20side/common/custom_expansion_tile.dart';
import 'package:crafti_hub/user%20side/common/flush_bar.dart';
import 'package:crafti_hub/user%20side/common/table_row.dart';
import 'package:crafti_hub/user%20side/screens/profile/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
      leading: const Icon(Icons.location_on, color: Colors.brown),
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
                    tableRow(label: 'Mobile', value: userAddress[0].phone),
                    tableRow(label: 'Whatsapp', value: userAddress[0].whatsapp),
                    tableRow(label: 'State', value: userAddress[0].state),
                    tableRow(label: 'Pincode', value: userAddress[0].pincode),
                  ],
                ),
        ),
        userAddress == null || userAddress.isEmpty
            ? customButton(
                isLoading: false,
                color: Colors.brown,
                buttonName: '+ Address',
                onPressed: () {
                  _showEditAddressDialog(context, profileProvider,
                      isEdit: false);
                })
            : customButton(
                isLoading: false,
                color: Colors.brown,
                buttonName: 'Edit Address',
                onPressed: () {
                  _showEditAddressDialog(context, profileProvider,
                      isEdit: true);
                }),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  /// ✅ Address Dialog Box (Supports Add & Edit Mode)
  void _showEditAddressDialog(
      BuildContext context, ProfileProvider profileProvider,
      {bool isEdit = false}) {
    final userAddress = profileProvider.user?.addresses;
    final addressData = isEdit && userAddress != null && userAddress.isNotEmpty
        ? userAddress[0]
        : null;

    final tcAddress =
        TextEditingController(text: addressData?.addressLine1 ?? '');
    final tcArea = TextEditingController(text: addressData?.addressLine2 ?? '');
    final tcCity = TextEditingController(text: addressData?.city ?? '');
    final tcState = TextEditingController(text: addressData?.state ?? '');
    final tcPincode = TextEditingController(text: addressData?.pincode ?? '');
    final tcPhone = TextEditingController(text: addressData?.phone ?? '');

    final tcWhatsapp = TextEditingController(text: addressData?.whatsapp ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEdit ? 'Edit Address' : 'Add Address'),
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
                controller: tcPhone,
                decoration: const InputDecoration(labelText: 'Mobile Number'),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: tcWhatsapp,
                decoration: const InputDecoration(labelText: 'Whatsapp Number'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.digitsOnly,
                ],
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
              // Validation
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
              } else if (tcWhatsapp.text.length != 10 ||
                  tcPhone.text.length != 10) {
                showFlushbar(
                    message: 'Number Must be 10 digit',
                    color: Colors.red,
                    icon: Icons.error,
                    context: context);
                return;
              }

              final data = {
                if (!isEdit) "user": profileProvider.user?.id,
                "address_line1": tcAddress.text,
                "state": tcState.text,
                "pincode": tcPincode.text,
                "city": tcCity.text,
                "country": "India",
                "address_line2": tcArea.text,
                "mobile_number": tcPhone.text,
                "whatsapp_number": tcWhatsapp.text,
              };

              if (isEdit) {
                profileProvider.updateAddress(
                    context, userAddress![0].id, data);
              } else {
                await profileProvider.addAddress(context, data);
              }
            },
            child: Text(isEdit ? 'Update' : 'Save'),
          ),
        ],
      ),
    );
  }
}

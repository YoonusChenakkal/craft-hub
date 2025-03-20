import 'package:crafti_hub/Vandor%20side/screens/products/product_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OfferDialogBox extends StatelessWidget {
  OfferDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<VendorProductProvider>(context);

    // Reusable helper method to create the CheckboxListTile
    Widget buildCheckboxTile({
      required String title,
      required bool value,
      required ValueChanged<bool?> onChanged,
    }) {
      return CheckboxListTile(
        activeColor: Color.fromARGB(255, 129, 63, 42),
        title: Text(title),
        value: value,
        onChanged: onChanged,
      );
    }

    return AlertDialog(
      title: Text(
        'Select Product Features',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Use the reusable _buildCheckboxTile method
            buildCheckboxTile(
              title: 'Offer Product',
              value: productProvider.isOfferProduct,
              onChanged: (value) {
                productProvider.isOfferProduct = value ?? false;
              },
            ),
            buildCheckboxTile(
              title: 'Popular Products',
              value: productProvider.isPopular,
              onChanged: (value) {
                productProvider.isPopular = value ?? false;
              },
            ),
            buildCheckboxTile(
              title: 'New Arrival',
              value: productProvider.isNewArrival,
              onChanged: (value) {
                productProvider.isNewArrival = value ?? false;
              },
            ),
            buildCheckboxTile(
              title: 'Trending Product',
              value: productProvider.isTrending,
              onChanged: (value) {
                productProvider.isTrending = value ?? false;
              },
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 129, 63, 42),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Ok',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}

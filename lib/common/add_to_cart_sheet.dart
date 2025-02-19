import 'package:crafti_hub/screens/cart/view_model/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddToCartSheet extends StatefulWidget {
  final product;
  final bool isCart;

  const AddToCartSheet({super.key, required this.product, this.isCart = false});

  @override
  State<AddToCartSheet> createState() => _AddToCartSheetState();
}

class _AddToCartSheetState extends State<AddToCartSheet> {
  int quantity = 1;
  int selectedKg = 0;
  int selectedG = 0;

  // Helper method to calculate price based on weight
  String calculatePrice(String weight, product) {
    double price = product.offerPrice;

    // Calculate the price based on weight unit
    if (widget.product.weightMeasurement.toLowerCase() == 'g') {
      price = (product.offerPrice * 1000) /
          100; // Converting grams to kg equivalent
    }

    // Multiply price by weight
    double totalPrice = double.parse(weight) * price;
    return totalPrice
        .toStringAsFixed(2); // Return the price with 2 decimal places
  }

  // Increment and decrement quantity
  void increamnetQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decreamentQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final String weight = '$selectedKg.$selectedG';

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.isCart
                ? widget.product.weightMeasurement.toLowerCase() == 'kg' ||
                        widget.product.weightMeasurement.toLowerCase() == 'g'
                    ? 'Change Weight'
                    : 'Change Quantity'
                : 'Add to Cart',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          widget.product.weightMeasurement.toLowerCase() == 'kg' ||
                  widget.product.weightMeasurement.toLowerCase() == 'g'
              ? weightSection()
              : quantitySection(),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed:
                //  widget.isCart
                //     ? widget.product.weightMeasurement.toLowerCase() == 'kg' ||
                //             widget.product.weightMeasurement.toLowerCase() == 'g'
                //         ? () {
                //             final price = calculatePrice(weight, widget.product);
                //             final data = {
                //               'weight': weight,
                //               'price': price.toString(),
                //             };

                //             cartProvider.updateCart(
                //                 data, widget.product.id, context);
                //           }
                //         : () {
                //             final price = widget.product.offerPrice * quantity;
                //             final data = {
                //               'quantity': quantity.toString(),
                //               'weight': widget.product.weights[0].weight,
                //               'price': price.toString(),
                //             };
                //             cartProvider.updateCart(
                //                 data, widget.product.id, context);
                //           }
                //     : widget.product.weightMeasurement.toLowerCase() == 'kg' ||
                //             widget.product.weightMeasurement.toLowerCase() == 'g'
                //         ? () {
                //             final price = calculatePrice(weight, widget.product);
                //             final data = {
                //               'weight': weight,
                //               'price': price.toString(),
                //             };
                //             print(data);
                //             cartProvider.addToCart(
                //                 data, widget.product.id, context);
                //           }
                //         : () {
                //             final price = widget.product.offerPrice * quantity;
                //             final data = {
                //               'quantity': quantity.toString(),
                //               'weight': widget.product.weights[0].weight,
                //               'price': price.toString(),
                //             };
                //             print(data);
                //             cartProvider.addToCart(
                //                 data, widget.product.id, context);
                //           },
                () {},
            child: Text(widget.isCart ? 'Done' : 'Add to Cart'),
          ),
        ],
      ),
    );
  }

  Widget quantitySection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: decreamentQuantity,
        ),
        Text(
          quantity.toString(),
          style: const TextStyle(fontSize: 18),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: increamnetQuantity,
        ),
      ],
    );
  }

  Widget weightSection() {
    List<int> kgOptions = List.generate(51, (index) => index); // 0 to 50 kg
    List<int> gOptions =
        List.generate(10, (index) => index * 100); // 0 to 900 g

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 80,
          width: 80,
          child: DropdownButtonFormField<int>(
            value: selectedKg,
            items: kgOptions.map((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedKg = value!;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Kg',
          ),
        ),
        SizedBox(
          height: 80,
          width: 80,
          child: DropdownButtonFormField<int>(
            value: selectedG,
            items: gOptions.map((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedG = value!;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'g',
          ),
        ),
      ],
    );
  }
}

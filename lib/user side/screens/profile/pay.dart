import 'package:flutter/material.dart';
import 'package:crafti_hub/user%20side/common/custom_app_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class Pay extends StatelessWidget {
  const Pay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Payment Methods'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            PaymentMethodCard(
              icon: Icons.money,
              title: "Cash on Delivery (COD)",
              description: "Pay with cash when your order is delivered.",
              isAvailable: true,
            ),
            const SizedBox(height: 16),
            PaymentMethodCard(
              icon: LucideIcons.creditCard,
              title: "Online Payment",
              description: "Currently unavailable. Coming soon!",
              isAvailable: false,
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isAvailable;

  const PaymentMethodCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.isAvailable,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(icon,
            size: 40, color: isAvailable ? Colors.green : Colors.grey),
        title: Text(
          title,
          style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isAvailable ? Colors.black : Colors.grey,
          ),
        ),
        subtitle: Text(
          description,
          style: GoogleFonts.lato(
            fontSize: 14,
            color: isAvailable ? Colors.black87 : Colors.redAccent,
          ),
        ),
      ),
    );
  }
}

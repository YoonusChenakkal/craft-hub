import 'package:flutter/material.dart';

class CustomExpansionTile extends StatelessWidget {
  final Widget leading;
  final dynamic onExpansionChanged;
  final String title;
  final List<Widget> children;
  final bool isExpandable;
  final bool initiallyExpanded;

  const CustomExpansionTile({
    super.key,
    required this.leading,
    required this.title,
    required this.children,
    this.onExpansionChanged,
    this.isExpandable = true,
    this.initiallyExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 248, 248, 248),
      margin: const EdgeInsets.only(bottom: 16),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          initiallyExpanded: initiallyExpanded,
          leading: leading,
          title: Text(
            title,
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          trailing: isExpandable ? null : const SizedBox.shrink(),
          onExpansionChanged: onExpansionChanged,
          children: children,
        ),
      ),
    );
  }
}

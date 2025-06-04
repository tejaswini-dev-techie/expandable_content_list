import 'package:flutter/material.dart';

/// A default separator widget that can be used between content items
class ContentSeparator extends StatelessWidget {
  /// The color of the separator line
  final Color? color;

  /// The thickness of the separator line
  final double thickness;

  /// The padding around the separator
  final EdgeInsetsGeometry padding;

  const ContentSeparator({
    super.key,
    this.color,
    this.thickness = 1.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Divider(
        color: color ?? Colors.grey.shade300,
        thickness: thickness,
      ),
    );
  }
}

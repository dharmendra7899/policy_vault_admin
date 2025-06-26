import 'package:flutter/cupertino.dart';

class ResponsiveWrapper extends StatelessWidget {
  final List<Widget> children;
  final bool isColumn;
  final MainAxisAlignment rowMainAxisAlignment;
  final MainAxisAlignment columnMainAxisAlignment;
  final CrossAxisAlignment rowCrossAxisAlignment;
  final CrossAxisAlignment columnCrossAxisAlignment;
  const ResponsiveWrapper(
      {super.key,
      required this.children,
      required this.isColumn,
      this.rowMainAxisAlignment = MainAxisAlignment.start,
      this.columnMainAxisAlignment = MainAxisAlignment.start,
      this.rowCrossAxisAlignment = CrossAxisAlignment.start,
      this.columnCrossAxisAlignment = CrossAxisAlignment.start});

  @override
  Widget build(BuildContext context) {
    if (isColumn) {
      return Column(
        mainAxisAlignment: columnMainAxisAlignment,
        crossAxisAlignment: columnCrossAxisAlignment,
        children: children,
      );
    } else {
      return Row(
        crossAxisAlignment: rowCrossAxisAlignment,
        mainAxisAlignment: rowMainAxisAlignment,
        children: children,
      );
    }
  }
}

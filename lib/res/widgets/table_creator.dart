import 'package:flutter/material.dart';
import 'package:policy_vault_admin/responsive/layout.dart';
import 'package:policy_vault_admin/theme/colors.dart';

class TableCreator extends StatelessWidget {
  final List<String> headingList;
  final List<List<String>> rowDataList;

  const TableCreator({
    super.key,
    required this.headingList,
    required this.rowDataList,
  });

  final TextStyle headingRowTextStyle = const TextStyle(
      color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold);

  final TextStyle rowDataListTextStyle =
      const TextStyle(color: Colors.black, fontSize: 15);

  @override
  Widget build(BuildContext context) {
    var layout = Layout(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: layout.isDesktop ? 45 : 15,
        dataRowMaxHeight: 50,
        horizontalMargin: layout.isDesktop ? 10 : 5,
        showBottomBorder: false,
        headingRowColor: WidgetStateProperty.all<Color>(appColors.primary),
        headingRowHeight: 50,
        showCheckboxColumn: false,
        columns: [
          ...headingList.map((e) => DataColumn(
                  label: Align(
                alignment: Alignment.center,
                child: Text(
                  e,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: headingRowTextStyle,
                ),
              ))),
        ],
        rows: rowDataList.asMap().entries.map((entry) {
          List<String> row = entry.value;
          return DataRow(selected: false, cells: [
            ...row.map((e) => DataCell(InkWell(
                    child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    e,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: rowDataListTextStyle,
                  ),
                )))),
          ]);
        }).toList(),
      ),
    );
  }
}

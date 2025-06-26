import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:policy_vault_admin/theme/colors.dart';

import 'custom_pager.dart';

// const STYLE =

// ignore: must_be_immutable
class CustomDataTable extends StatefulWidget {
  final List<Map<String, dynamic>> columnData;
  final DataTableSource data;
  final int pageNumber;
  final Function(int index) updatePageNumber;
  final Function(int columnIndex, bool ascending) sortColumn;
  final int totalRecords;
  final TextStyle headerStyle;
  final int? rowPerPage;
  final double? rowHeight;
  final int? currentPage;
  int? sortColumnIndex = 0;
  bool? sortAscending = true;
  bool? showLoader = true;
  bool? showCheckbox = false;
  final Function(bool isChecked)? onTapCheckbox;
  bool? initialChecked = false;
  double? minWidth;
  final EdgeInsetsGeometry padding;
  final double columnSpacing;
  bool? isIconVisible;
  final Function(bool? select)? selectAll;

  CustomDataTable({
    super.key,
    required this.columnData,
    required this.data,
    required this.pageNumber,
    required this.updatePageNumber,
    required this.totalRecords,
    required this.headerStyle,
    required this.sortColumn,
    this.isIconVisible = true,
    this.rowPerPage,
    this.rowHeight,
    this.currentPage,
    this.selectAll,
    this.sortColumnIndex,
    this.sortAscending,
    this.minWidth,
    this.showLoader,
    this.showCheckbox,
    this.onTapCheckbox,
    this.initialChecked,
    this.columnSpacing = 0,
    this.padding = const EdgeInsets.all(0),
  });

  @override
  State<CustomDataTable> createState() => _CustomDataTableState();
}

class _CustomDataTableState extends State<CustomDataTable> {
  final int rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(child: _buildGrid()),
            _buildPagination(),
          ],
        ),
      ),
    );
  }

  Widget _buildPagination() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: widget.padding,
              child: text(
                  widget.rowPerPage!, widget.pageNumber, widget.totalRecords),
            ),
            widget.totalRecords > widget.rowPerPage!
                ? CustomPager(

                    currentPage: widget.currentPage!,
                    totalPages: (widget.totalRecords % widget.rowPerPage!) == 0
                        ? widget.totalRecords ~/ widget.rowPerPage!
                        : widget.totalRecords ~/ widget.rowPerPage! + 1,
                    onPageChanged: widget.updatePageNumber,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid() {
    return SelectionArea(
      selectionControls: materialTextSelectionControls,
      child: PaginatedDataTable2(
        lmRatio: 2,
        smRatio: 2,
        dataRowHeight: widget.rowHeight!,
        horizontalMargin: 20,
        checkboxHorizontalMargin: 12,
        columnSpacing: widget.columnSpacing,
        wrapInCard: false,
        rowsPerPage: rowPerPage(
            widget.rowPerPage!, widget.pageNumber, widget.totalRecords),
        minWidth: widget.minWidth,
        fit: FlexFit.loose,
        // sortColumnIndex: widget.sortColumnIndex,
        // sortAscending: widget.sortAscending!,
        // sortArrowIcon: Icons.arrow_drop_down_outlined,
        sortArrowAlwaysVisible: false,
        showCheckboxColumn: true,
        sortArrowAnimationDuration: const Duration(milliseconds: 0),
        onSelectAll: widget.selectAll,
        hidePaginator: true,
        columns: _getColumn(),
        headingRowColor: WidgetStateProperty.all(appColors.appBackground),
        empty: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.grey[200],
            child: const Text('No records found.'),
          ),
        ),
        source: widget.data,
      ),
    );
  }

  _getColumn() {
    return <DataColumn>[
      for (int i = 0; i <= widget.columnData.length - 1; i++)
        DataColumn(
          label: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                i == 0 && (widget.showCheckbox ?? false)
                    ? Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Checkbox(
                            value: widget.initialChecked,
                            onChanged: (checked) =>
                                widget.onTapCheckbox!(checked!)))
                    : Container(),
                Flexible(
                  child: Text(
                    widget.columnData[i]['columnName'],
                    style: widget.headerStyle,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
          ),
          onSort: (columnIndex, ascending) {
            if (widget.columnData[i]['sortable']) {
              widget.sortColumn(columnIndex, ascending);
            }
          },
        ),
    ];
  }

  int rowPerPage(int rowPerPage, int pageNo, int totalRecords) {
    return totalRecords != 0
        ? (rowPerPage * pageNo) < totalRecords
            ? rowPerPage
            : (totalRecords -
                    (widget.rowPerPage! * (widget.pageNumber - 1) + 1)) +
                1
        : rowPerPage;
  }

  Widget text(int rowPerPage, int pageNo, int totalRecords) {
    return totalRecords != 0
        ? (rowPerPage * pageNo) < totalRecords
            ? Text(
                'Showing ${widget.rowPerPage! * (widget.pageNumber - 1) + 1} to ${(rowPerPage * pageNo)} of $totalRecords entries',
                style: const TextStyle(fontSize: 14),
              )
            : Text(
                'Showing ${widget.rowPerPage! * (widget.pageNumber - 1) + 1} to $totalRecords of $totalRecords entries',
                style: const TextStyle(fontSize: 14),
              )
        : Text(
            'Showing $totalRecords to $totalRecords of $totalRecords entries',
            style: const TextStyle(fontSize: 14),
          );
  }
}

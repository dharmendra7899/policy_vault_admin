import 'package:flutter/material.dart';
import 'package:policy_vault_admin/data_table/custom_pager.dart';
import 'package:policy_vault_admin/res/widgets/app_text_field.dart';
import 'package:policy_vault_admin/res/widgets/context_extension.dart';
import 'package:policy_vault_admin/theme/colors.dart';

class SupportManagementScreen extends StatefulWidget {
  const SupportManagementScreen({super.key});

  @override
  State<SupportManagementScreen> createState() =>
      _SupportManagementScreenState();
}

class _SupportManagementScreenState extends State<SupportManagementScreen> {
  List<Map<String, String>> supportList = [
    {
      'query_no': '1',
      'customer_id': '23',
      'name': 'Umang Kalra',
      'mobile': '8586033774',
      'email': 'admin@gmail.com',
      'message': 'For testing purpose.',
      'date': '02/06/2025',
      'status': 'Closed',
      'action': 'Update',
    },
    {
      'query_no': '2',
      'customer_id': '33',
      'name': 'Dharmendra Kumar',
      'mobile': '9795541088',
      'email': 'dk@gmail.com',
      'message': 'Here i am trying to make admin panned by using Flutter ',
      'date': '22/06/2025',
      'status': 'Open',
      'action': 'Update',
    },
  ];

  String dropdownValue = 'Open';
  String listDropdownValue = 'Open';

  var listItems = ['Open', 'Closed'];
  var items = ['Open', 'In-Progress', 'Closed', 'New'];
  int currentPage = 1;
  final int itemsPerPage = 8;
  List<String> selectedIds = [];
  String searchQuery = '';

  List<Map<String, String>> get filteredPolicies {
    final query = searchQuery.toLowerCase();
    return supportList.where((p) {
      return p.values.any((v) => v.toLowerCase().contains(query));
    }).toList();
  }

  List<Map<String, String>> get paginatedPolicies {
    final start = (currentPage - 1) * itemsPerPage;
    final end = start + itemsPerPage;
    return filteredPolicies.sublist(
      start,
      end > filteredPolicies.length ? filteredPolicies.length : end,
    );
  }

  int get totalPages => (filteredPolicies.length / itemsPerPage)
      .ceil()
      .clamp(1, double.infinity)
      .toInt();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.screenBg,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: appColors.appBackground,
            boxShadow: [
              BoxShadow(
                color: appColors.borderColor.withValues(alpha: 0.2),
                blurRadius: 4,
                spreadRadius: 0.3,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  bool isNarrow = constraints.maxWidth < 600;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isNarrow
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Number of Query - 1',
                                  style: context.textTheme.titleMedium,
                                ),
                                const SizedBox(height: 12),
                                _searchAndDownloadUI(isVertical: true),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Number of Query - 1',
                                  style: context.textTheme.titleMedium,
                                ),
                                _searchAndDownloadUI(isVertical: false),
                              ],
                            ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 16),
              const Divider(thickness: 1),
              const SizedBox(height: 16),

              Scrollbar(
                thumbVisibility: true,
                controller: _scrollController,
                interactive: true,
                radius: Radius.circular(6),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Table(
                      border: TableBorder.symmetric(
                        inside: BorderSide(color: Colors.grey.shade400),
                        outside: BorderSide(color: Colors.grey.shade400),
                      ),
                      columnWidths: {
                        0: FixedColumnWidth(140),
                        1: FixedColumnWidth(140),
                        2: FixedColumnWidth(200),
                        3: FixedColumnWidth(200),
                        4: FixedColumnWidth(300),
                        5: FixedColumnWidth(400),
                        6: FixedColumnWidth(150),
                        7: FixedColumnWidth(150),
                        8: FixedColumnWidth(120),
                      },
                      children: [
                        TableRow(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                          ),
                          children: [
                            _headerCell('Query Number'),
                            _headerCell('Customer ID'),
                            _headerCell('Name'),
                            _headerCell('Mobile Number'),
                            _headerCell('Email'),
                            _headerCell('Message'),
                            _headerCell('Date'),
                            _headerCell('Status'),
                            _headerCell('Action'),
                          ],
                        ),
                        for (final policy in paginatedPolicies)
                          TableRow(
                            children: [
                              _cell(policy['query_no']!),
                              _cell(policy['customer_id']!),
                              _cell(policy['name']!),
                              _cell(policy['mobile']!),
                              _cell(policy['email']!),
                              _cell(policy['message']!),
                              _cell(policy['date']!),
                              _statusCell(policy['status']!),
                              _actionCell(policy['action']!),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 26),

              if (filteredPolicies.length > itemsPerPage)
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomPager(
                    currentPage: currentPage,
                    totalPages: totalPages,

                    onPageChanged: (page) {
                      setState(() {
                        currentPage = page;
                        selectedIds.clear();
                      });
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchAndDownloadUI({bool isVertical = false}) {
    return isVertical
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _searchField(),
              const SizedBox(height: 12),
              _downloadButton(),
            ],
          )
        : Row(
            children: [
              _searchField(),
              const SizedBox(width: 12),
              _downloadButton(),
            ],
          );
  }

  Widget _searchField() {
    return SizedBox(
      width: 250,
      child: AppTextField(
        radius: 5,
        borderWidth: 1,
        hintText: 'Search...',
        prefixIcon: const Icon(Icons.search),
        onChanged: (value) => setState(() => searchQuery = value),
      ),
    );
  }

  Widget _downloadButton() {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: appColors.borderColor),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButton(
        isExpanded: true,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8),
        style: context.textTheme.bodyMedium?.copyWith(
          fontSize: 15,
          color: appColors.titleColor,
        ),
        isDense: true,
        underline: SizedBox(),
        hint: Text("Filter BY"),
        borderRadius: BorderRadius.circular(8),
        value: dropdownValue,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: items.map((String items) {
          return DropdownMenuItem(value: items, child: Text(items));
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
      ),
    );
  }

  TableCell _headerCell(String text) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        color: Colors.grey.shade200,
        child: Text(
          text,
          style: context.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  TableCell _cell(String text) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        child: SelectableText(
          text,
          style: context.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  TableCell _statusCell(String status) {
    return TableCell(
      child: Container(
        height: 40,
        width: 140,
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: appColors.editTextColor),
          borderRadius: BorderRadius.circular(4),
        ),
        child: DropdownButton(
          isExpanded: true,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(8),
          isDense: true,
          underline: SizedBox(),

          hint: Text("Filter BY"),
          borderRadius: BorderRadius.circular(8),
          value: listDropdownValue,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: listItems.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(
                items,
                style: context.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              listDropdownValue = newValue!;
            });
          },
        ),
      ),
    );
  }

  TableCell _actionCell(String action) {
    return TableCell(
      child: Center(
        child: Container(
          width: 100,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: appColors.primary,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            action,
            style: context.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: appColors.appWhite,
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }
}

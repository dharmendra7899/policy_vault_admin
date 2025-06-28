import 'dart:html' as html;
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:policy_vault_admin/data_table/custom_pager.dart';
import 'package:policy_vault_admin/res/widgets/app_button.dart';
import 'package:policy_vault_admin/res/widgets/app_text_field.dart';
import 'package:policy_vault_admin/res/widgets/context_extension.dart';
import 'package:policy_vault_admin/theme/colors.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({super.key});

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  List<Map<String, String>> userList = [
    {
      'id': '1',
      'name': 'Umang Kalra',
      'mobile': '8586033774',
      'total': '6',
      'shared': '2',
      'date': '30/06/2025',
      'status': 'ACTIVE',
      'action': 'View',
    },
    {
      'id': '2',
      'name': 'Dharmendra Kumar',
      'mobile': '9795541088',
      'total': '8',
      'shared': '4',
      'date': '30/06/2025',
      'status': 'ACTIVE',
      'action': 'View',
    },
    {
      'id': '3',
      'name': 'Ramesh ',
      'mobile': '9876541088',
      'total': '6',
      'shared': '2',
      'date': '30/06/2025',
      'status': 'ACTIVE',
      'action': 'View',
    },

    {
      'id': '3',
      'name': 'Sonu Kumar',
      'mobile': '9721541088',
      'total': '6',
      'shared': '2',
      'date': '30/06/2025',
      'status': 'ACTIVE',
      'action': 'View',
    },
    {
      'id': '3',
      'name': 'Shyam',
      'mobile': '8821541000',
      'total': '3',
      'shared': '1',
      'date': '30/06/2025',
      'status': 'ACTIVE',
      'action': 'View',
    },
    {
      'id': '3',
      'name': 'Dharmendra Kumar',
      'mobile': '9721541088',
      'total': '2',
      'shared': '0',
      'date': '30/06/2025',
      'status': 'ACTIVE',
      'action': 'View',
    },
    {
      'id': '7',
      'name': 'Dharmendra Kumar',
      'mobile': '9721541088',
      'total': '2',
      'shared': '0',
      'date': '30/06/2025',
      'status': 'ACTIVE',
      'action': 'View',
    },
    {
      'id': '8',
      'name': 'Suraj Singh',
      'mobile': '9918541088',
      'total': '16',
      'shared': '22',
      'date': '30/06/2025',
      'status': 'ACTIVE',
      'action': 'View',
    },
    {
      'id': '9',
      'name': 'Uday Verma',
      'mobile': '9918541088',
      'total': '16',
      'shared': '22',
      'date': '30/06/2025',
      'status': 'ACTIVE',
      'action': 'View',
    },
  ];

  int currentPage = 1;
  final int itemsPerPage = 8;
  List<String> selectedIds = [];
  String searchQuery = '';

  List<Map<String, String>> get filteredPolicies {
    final query = searchQuery.toLowerCase();
    return userList.where((p) {
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

  void downloadCSV() {
    final rows = [
      [
        'Customer ID',
        'Name',
        'Mobile Number',
        'Total Policy',
        'Shared Policy',
        'Date Date',
        'Status',
        'Action',
      ],
      ...filteredPolicies.map(
        (p) => [
          p['id'],
          p['name'],
          p['mobile'],
          p['total'],
          p['shared'],
          p['date'],
          p['status'],
          p['action'],
        ],
      ),
    ];

    final csv = const ListToCsvConverter().convert(rows);
    final blob = html.Blob([csv]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.Url.revokeObjectUrl(url);
  }

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
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Customers - 12',
                    style: context.textTheme.titleMedium,
                  ),
                  Row(

                    children: [
                      SizedBox(width: 250,
                        child: AppTextField(
                          radius: 5,
                          borderWidth: 1,
                          hintText: 'Search...',
                          prefixIcon: const Icon(Icons.search),
                          onChanged: (value) => setState(() => searchQuery = value),
                        ),
                      ),
                      const SizedBox(width: 12),
                      AppButton(
                        onPressed: downloadCSV,
                        title: "Download CSV",
                        radius: 5,
                        fontSize: 12,
                        width: 160,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(thickness: 1),
              const SizedBox(height: 16),


              LayoutBuilder(
                builder: (context, constraints) {
                  final screenWidth = constraints.maxWidth;

                  return Scrollbar(
                    thumbVisibility: true,
                    controller: _scrollController,
                    interactive: true,
                    radius: Radius.circular(6),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minWidth: screenWidth),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                          ),
                          child: DataTable(
                            headingRowColor: WidgetStateProperty.all(
                              Colors.grey.shade200,
                            ),
                            columns: [
                              DataColumn(
                                label: Checkbox(
                                  value:
                                      selectedIds.length ==
                                          paginatedPolicies.length &&
                                      paginatedPolicies.isNotEmpty,
                                  onChanged: (value) {
                                    setState(() {
                                      if (value == true) {
                                        selectedIds = paginatedPolicies
                                            .map((p) => p['id']!)
                                            .toList();
                                      } else {
                                        selectedIds.clear();
                                      }
                                    });
                                  },

                                  fillColor:
                                      WidgetStateProperty.resolveWith<Color?>((
                                        Set<WidgetState> states,
                                      ) {
                                        if (states.contains(
                                          WidgetState.disabled,
                                        )) {
                                          return appColors.borderColor;
                                        }
                                        if (states.contains(
                                          WidgetState.selected,
                                        )) {
                                          return appColors.primary;
                                        }
                                        return appColors.appBackground;
                                      }),

                                  checkColor: appColors.appBackground,

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      4,
                                    ), // rounded corners
                                  ),
                                  side: BorderSide(
                                    color: appColors.editTextColor,
                                    width: 1,
                                  ),
                                ),
                              ),
                              ...[
                                'Customer ID',
                                'Name',
                                'Mobile Number',
                                'Total Policy',
                                'Shared Policy',
                                'Date Date',
                                'Status',
                                'Action',
                              ].map(
                                (title) => DataColumn(
                                  label: Text(
                                    title,
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                            rows: paginatedPolicies.map((policy) {
                              final isSelected = selectedIds.contains(
                                policy['id'],
                              );
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Checkbox(
                                      value: isSelected,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value == true) {
                                            selectedIds.add(policy['id']!);
                                          } else {
                                            selectedIds.remove(policy['id']);
                                          }
                                        });
                                      },
                                      fillColor:
                                          WidgetStateProperty.resolveWith<
                                            Color?
                                          >((Set<WidgetState> states) {
                                            if (states.contains(
                                              WidgetState.disabled,
                                            )) {
                                              return appColors.borderColor;
                                            }
                                            if (states.contains(
                                              WidgetState.selected,
                                            )) {
                                              return appColors.primary;
                                            }
                                            return appColors.appBackground;
                                          }),

                                      checkColor: appColors.appBackground,

                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          4,
                                        ), // rounded corners
                                      ),
                                      side: BorderSide(
                                        color: appColors.editTextColor,
                                        width: 1,
                                      ),
                                    ),
                                  ),

                                  DataCell(_wrapText(policy['id']!, context)),
                                  DataCell(_wrapText(policy['name']!, context)),
                                  DataCell(
                                    _wrapText(policy['mobile']!, context),
                                  ),
                                  DataCell(
                                    _wrapText(policy['total']!, context),
                                  ),
                                  DataCell(
                                    _wrapText(policy['shared']!, context),
                                  ),
                                  DataCell(_wrapText(policy['date']!, context)),
                                  DataCell(
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: appColors.activeColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        policy['status']!,
                                        style: context.textTheme.labelSmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: appColors.primary,
                                              fontSize: 10,
                                            ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    GestureDetector(onTap: () => context.goNamed("User Details"),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: appColors.primary,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          policy['action']!,
                                          style: context.textTheme.labelSmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: appColors.appWhite,
                                                fontSize: 10,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  );
                },
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

  Widget _wrapText(String text, BuildContext context) {
    return SelectableText(
      text,
      style: context.textTheme.labelSmall?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

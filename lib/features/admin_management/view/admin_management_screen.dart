import 'package:flutter/material.dart';
import 'package:policy_vault_admin/data_table/custom_pager.dart';
import 'package:policy_vault_admin/res/widgets/app_button.dart';
import 'package:policy_vault_admin/res/widgets/app_text_field.dart';
import 'package:policy_vault_admin/res/widgets/context_extension.dart';
import 'package:policy_vault_admin/theme/colors.dart';

class AdminManagementScreen extends StatefulWidget {
  const AdminManagementScreen({super.key});

  @override
  State<AdminManagementScreen> createState() => _AdminManagementScreenState();
}

class _AdminManagementScreenState extends State<AdminManagementScreen> {
  List<Map<String, String>> adminUserList = [
    {
      'user_id': '1',
      'name': 'Umang Kalra',
      'mobile': '8586033774',
      'email': 'admin@gmail.com',
      'status': 'ACTIVE',
      'action': 'Edit',
    },
    {
      'user_id': '2',
      'name': 'Umang Kalra',
      'mobile': '8586033774',
      'email': 'admin@gmail.com',
      'status': 'ACTIVE',
      'action': 'Edit',
    },
    {
      'user_id': '3',
      'name': 'Demo User',
      'mobile': '8586033774',
      'email': 'demo@gmail.com',
      'status': 'INACTIVE',
      'action': 'Edit',
    },
    {
      'user_id': '4',
      'name': 'Tester',
      'mobile': '7656033774',
      'email': 'admin@gmail.com',
      'status': 'ACTIVE',
      'action': 'Edit',
    },
    {
      'user_id': '5',
      'name': 'Dharmendra Kumar',
      'mobile': '9796543212',
      'email': 'dharm@gmail.com',
      'status': 'ACTIVE',
      'action': 'Edit',
    },
  ];

  int currentPage = 1;
  final int itemsPerPage = 8;
  List<String> selectedIds = [];
  String searchQuery = '';

  List<Map<String, String>> get filteredPolicies {
    final query = searchQuery.toLowerCase();
    return adminUserList.where((p) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Admin User - 12',
                    style: context.textTheme.titleMedium,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 250,
                        child: AppTextField(
                          radius: 5,
                          borderWidth: 1,
                          hintText: 'Search here...',
                          prefixIcon: const Icon(Icons.search),
                          onChanged: (value) =>
                              setState(() => searchQuery = value),
                        ),
                      ),
                      SizedBox(width: 12),
                      AppButton(
                        onPressed: () {},
                        title: "Add New Admin User",
                        fontSize: 12,
                        icon: Icon(Icons.add, color: appColors.appWhite),
                        radius: 5,
                        width: 220,
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
                          child: Table(
                            border: TableBorder.symmetric(
                              inside: BorderSide(color: Colors.grey.shade400),
                              outside: BorderSide(color: Colors.grey.shade400),
                            ),
                            columnWidths: const {
                              4: FixedColumnWidth(120),
                              5: FixedColumnWidth(120),
                              // Customize per column
                            },
                            children: [
                              TableRow(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                ),
                                children: [
                                  _headerCell('User ID'),
                                  _headerCell('Name'),
                                  _headerCell('Mobile Number'),
                                  _headerCell('Email'),
                                  _headerCell('Status'),
                                  _headerCell('Action'),
                                ],
                              ),
                              for (final policy in paginatedPolicies)
                                TableRow(
                                  children: [
                                    _cell(policy['user_id']!),
                                    _cell(policy['name']!),
                                    _cell(policy['mobile']!),
                                    _cell(policy['email']!),
                                    _statusCell(policy['status']!),
                                    _actionCell(policy['action']!),
                                  ],
                                ),
                            ],
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
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: appColors.activeColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          status,
          style: context.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: appColors.primary,
            fontSize: 10,
          ),
        ),
      ),
    );
  }

  TableCell _actionCell(String action) {
    return TableCell(
      child: Container(
        width: 100,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
    );
  }
}

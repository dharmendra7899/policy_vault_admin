import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:policy_vault_admin/data_table/custom_pager.dart';
import 'package:policy_vault_admin/res/widgets/app_button.dart';
import 'package:policy_vault_admin/res/widgets/context_extension.dart';
import 'package:policy_vault_admin/theme/colors.dart';

class InsuranceCompanyScreen extends StatefulWidget {
  const InsuranceCompanyScreen({super.key});

  @override
  State<InsuranceCompanyScreen> createState() => _InsuranceCompanyScreenState();
}

class _InsuranceCompanyScreenState extends State<InsuranceCompanyScreen> {
  List<Map<String, String>> faqList = [
    {
      's_no': '1',
      'question': 'Aditya Birla Health Insurance',
      'answer': 'rytr',
      'action': 'Edit',
    },
    {
      's_no': '2',
      'question': 'Universal Sompo General Insurance',
      'answer': 'ryttry',
      'action': 'Edit',
    },
    {
      's_no': '3',
      'question': 'Royal Sundaram General Insurance',
      'answer': 'rtry',
      'action': 'Edit',
    },
    {
      's_no': '3',
      'question': 'Niva Bupa Health Insurance(Max Bupa)',
      'answer': 'rtr',
      'action': 'Edit',
    },
    {
      's_no': '3',
      'question': 'Care Health Insurance (Religare)',
      'answer': 'rtr',
      'action': 'Edit',
    },
  ];

  int currentPage = 1;
  final int itemsPerPage = 8;

  List<Map<String, String>> get paginatedPolicies {
    final start = (currentPage - 1) * itemsPerPage;
    final end = start + itemsPerPage;
    return faqList.sublist(start, end > faqList.length ? faqList.length : end);
  }

  int get totalPages =>
      (faqList.length / itemsPerPage).ceil().clamp(1, double.infinity).toInt();
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Insurance Company Listing',
                    style: context.textTheme.titleMedium,
                  ),
                  AppButton(
                    onPressed: () => context.goNamed("Add Company"),
                    title: "Add An Insurance Company",
                    fontSize: 12,
                    icon: Icon(Icons.add, color: appColors.appWhite),
                    radius: 5,
                    width: 280,
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
                              0: FixedColumnWidth(80),

                              2: FixedColumnWidth(300),
                              3: FixedColumnWidth(120),
                              // Customize per column
                            },
                            children: [
                              TableRow(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                ),
                                children: [
                                  _headerCell('S.No'),
                                  _headerCell('Insurance Company'),
                                  _headerCell('Logo'),
                                  _headerCell('Action'),
                                ],
                              ),
                              for (final policy in paginatedPolicies)
                                TableRow(
                                  children: [
                                    _cell(policy['s_no']!),
                                    _cell(policy['question']!),
                                    _logoCell(policy['answer']!),
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

              if (faqList.length > itemsPerPage)
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomPager(
                    currentPage: currentPage,
                    totalPages: totalPages,
                    onPageChanged: (page) {
                      setState(() {
                        currentPage = page;
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

  TableCell _logoCell(String action) {
    return TableCell(
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
        decoration: BoxDecoration(
          color: appColors.appWhite,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Image.asset(
          'assets/images/dummy.png',
          height: 50,
          width: 80,
          fit: BoxFit.fill,
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

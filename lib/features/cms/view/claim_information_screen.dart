import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:policy_vault_admin/data_table/custom_pager.dart';
import 'package:policy_vault_admin/res/widgets/app_button.dart';
import 'package:policy_vault_admin/res/widgets/context_extension.dart';
import 'package:policy_vault_admin/theme/colors.dart';

class ClaimInformationScreen extends StatefulWidget {
  const ClaimInformationScreen({super.key});

  @override
  State<ClaimInformationScreen> createState() => _ClaimInformationScreenState();
}

class _ClaimInformationScreenState extends State<ClaimInformationScreen> {
  List<Map<String, String>> faqList = [
    {
      's_no': '1',
      'question': 'ICICI Lombard General Insurance',
      'answer': 'Health Insurance',
      'claim':
          '''An insurance claim form is a formal document used to initiate a claim for reimbursement or payment from an insurance company. It's a crucial step in the insurance claims process, providing the necessary details about the event that led to the claim. This form helps the insurance company assess the validity and coverage of the claim, leading to a potential payout to the insured or the beneficiary.''',
      'action': 'Edit',
    },
    {
      's_no': '2',
      'question': 'HDFC ERGO General Insurance',
      'answer': '2 Wheeler Insurance',
      'claim':
          'HDFC ERGO 2 Wheeler Insurance. Buy Insurance Plan for Your Car in less than 3 minutes with HDFC ERGO.',
      'action': 'Edit',
    },
    {
      's_no': '3',
      'question': 'HDFC ERGO General Insurance',
      'answer': 'Car Insurance',
      'claim':
          'HDFC ERGO Car Insurance. Buy Insurance Plan for Your Car in less than 3 minutes with HDFC ERGO.',
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
                  Text('Claim Listing', style: context.textTheme.titleMedium),
                  AppButton(
                    onPressed: () => context.goNamed("Add Claim"),
                    title: "Add Claim Details ",
                    fontSize: 12,
                    icon: Icon(Icons.add, color: appColors.appWhite),
                    radius: 5,
                    width: 180,
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
                              1: FixedColumnWidth(200),
                              2: FixedColumnWidth(300),

                              4: FixedColumnWidth(120),
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
                                  _headerCell('Policy Type'),
                                  _headerCell('Claim Information'),
                                  _headerCell('Action'),
                                ],
                              ),
                              for (final policy in paginatedPolicies)
                                TableRow(
                                  children: [
                                    _cell(policy['s_no']!),
                                    _cell(policy['question']!),
                                    _cell(policy['answer']!),
                                    _cell(policy['claim']!),
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

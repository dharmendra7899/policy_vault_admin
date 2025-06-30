import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:policy_vault_admin/data_table/custom_pager.dart';
import 'package:policy_vault_admin/res/widgets/app_button.dart';
import 'package:policy_vault_admin/res/widgets/context_extension.dart';
import 'package:policy_vault_admin/theme/colors.dart';

class FaqsScreen extends StatefulWidget {
  const FaqsScreen({super.key});

  @override
  State<FaqsScreen> createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
  List<Map<String, String>> faqList = [
    {
      's_no': '1',
      'question': 'What is the meaning of FAQs?',
      'answer':
          'abbreviation for frequently asked question: a question in a list of questions and answers intended to help people understand a particular subject: If you have any problems, consult the FAQs on our website.',
      'action': 'Edit',
    },
    {
      's_no': '2',
      'question': 'what is policy vault ?',
      'answer':
          'PolicyVault is a revolutionary Family Insurance Wallet designed to simplify the management and claims of any Insurance Policy.',
      'action': 'Edit',
    },
    {
      's_no': '3',
      'question': 'Testing',
      'answer': 'Policy Vault is provide insurance policies.',
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
                  Text('FAQs', style: context.textTheme.titleMedium),
                  AppButton(
                    onPressed: () =>context.goNamed("Add FAQ"),
                    title: "Add New FAQ's",
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
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Table(

                          border: TableBorder.symmetric(
                            inside: BorderSide(color: Colors.grey.shade400),
                            outside: BorderSide(color: Colors.grey.shade400),
                          ),
                          columnWidths: {

                            0: FixedColumnWidth(110),
                            1: FixedColumnWidth(400),
                            2: FixedColumnWidth(800),

                            3: FixedColumnWidth(160),

                          },
                          children: [
                            TableRow(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                              ),
                              children: [
                                _headerCell('S.No'),
                                _headerCell('Question'),
                                _headerCell('Answer'),
                                _headerCell('Action'),
                              ],
                            ),
                            for (final policy in paginatedPolicies)
                              TableRow(
                                children: [
                                  _cell(policy['s_no']!),
                                  _cell(policy['question']!),
                                  _cell(policy['answer']!),
                                  _actionCell(policy['action']!),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  /*  child: SingleChildScrollView(
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
                              1: FixedColumnWidth(300),

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
                                  _headerCell('Question'),
                                  _headerCell('Answer'),
                                  _headerCell('Action'),
                                ],
                              ),
                              for (final policy in paginatedPolicies)
                                TableRow(
                                  children: [
                                    _cell(policy['s_no']!),
                                    _cell(policy['question']!),
                                    _cell(policy['answer']!),
                                    _actionCell(policy['action']!),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),*/
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

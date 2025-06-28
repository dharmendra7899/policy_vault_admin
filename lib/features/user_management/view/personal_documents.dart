import 'package:flutter/material.dart';
import 'package:policy_vault_admin/data_table/custom_pager.dart';
import 'package:policy_vault_admin/res/widgets/context_extension.dart';
import 'package:policy_vault_admin/theme/colors.dart';

class PersonalDocuments extends StatefulWidget {
  const PersonalDocuments({super.key});

  @override
  State<PersonalDocuments> createState() => _PersonalDocumentsState();
}

class _PersonalDocumentsState extends State<PersonalDocuments> {
  List<Map<String, String>> documentList = [
    {
      'document_id': '1',
      'name': 'Aadhaar Card',
      'mobile': '546374657483',
      'front': '-',
      'back': '-',
    },
    {
      'document_id': '2',
      'name': 'Voter ID Card',
      'mobile': '54637485',
      'front': '-',
      'back': '-',
    },
    {
      'document_id': '3',
      'name': 'PAn Card',
      'mobile': 'PAB546372',
      'front': '-',
      'back': '-',
    },

  ];

  int currentPage = 1;
  final int itemsPerPage = 8;



  List<Map<String, String>> get paginatedPolicies {
    final start = (currentPage - 1) * itemsPerPage;
    final end = start + itemsPerPage;
    return documentList.sublist(
      start,
      end > documentList.length ? documentList.length : end,
    );
  }

  int get totalPages => (documentList.length / itemsPerPage)
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


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
                            _headerCell('ID'),
                            _headerCell('Name'),
                            _headerCell('Front'),
                            _headerCell('Back'),
                          ],
                        ),
                        for (final policy in paginatedPolicies)
                          TableRow(
                            children: [
                              _cell(policy['document_id']!),
                              _cell(policy['name']!),
                              _frontCell(policy['front']!),
                              _backCell(policy['back']!),

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

        if (paginatedPolicies.length > itemsPerPage)
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



  TableCell _frontCell(String action) {
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
          height: 80,
          width: 120,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  TableCell _backCell(String action) {
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
          height: 80,
          width: 120,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}



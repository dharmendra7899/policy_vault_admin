import 'package:flutter/material.dart';
import 'package:policy_vault_admin/data_table/custom_pager.dart';
import 'package:policy_vault_admin/res/constants/texts.dart';
import 'package:policy_vault_admin/res/widgets/context_extension.dart';
import 'package:policy_vault_admin/theme/colors.dart';

class MyPolicies extends StatefulWidget {
  const MyPolicies({super.key});

  @override
  State<MyPolicies> createState() => _MyPoliciesState();
}

class _MyPoliciesState extends State<MyPolicies> {
  List<Map<String, String>> policyList = [
    {
      'policy_id': 'P001',
      'policy_number': 'PN123456',
      'insurance_type': 'Investment Insurance',
      'insurance_company_name': 'Care Health Insurance (Religare)',
      'customer_id': 'C001',
      'customer_name': 'John Doe',
      'registration_number': '',
      'expiry_date': '2025-12-31',
      'start_date': '2025-01-01',
      'premium_amount': 'Annual',
      'maturity_amount': '31500',
      'sum_insured': '-',
      'policy_term': '51250',
      'premium_type': 'Annual',
      'investment_type': 'Guaranteed',
      'plan_type': '-',
      'nominee_name': 'Luther',
      'document_url': '-',
    },
    {
      'policy_id': 'P002',
      'policy_number': 'LICY123456',
      'insurance_type': 'Term Insurance',
      'insurance_company_name': 'LIfe Insurance Corporation',
      'customer_id': '65',
      'customer_name': 'Vindo Kumar',
      'registration_number': '-',
      'expiry_date': '-',
      'start_date': '2025-05-26',
      'premium_amount': '-',
      'maturity_amount': '-',
      'sum_insured': '100000',
      'policy_term': '51000',
      'premium_type': 'Annually',
      'investment_type': '-',
      'plan_type': '-',
      'nominee_name': 'Tester12',
      'document_url': '-',
    },
    {
      'policy_id': 'P003',
      'policy_number': 'POLICY123456',
      'insurance_type': 'Health Insurance',
      'insurance_company_name': 'SBI General Insurance',
      'customer_id': '34',
      'customer_name': 'Dharmendra Kumar',
      'registration_number': '-',
      'expiry_date': '2026-05-26',
      'start_date': '-',
      'premium_amount': '-',
      'maturity_amount': '-',
      'sum_insured': '104562',
      'policy_term': '-',
      'premium_type': '-',
      'investment_type': '-',
      'plan_type': 'Personal Accident',
      'nominee_name': '-',
      'document_url': '-',
    },
    {
      'policy_id': 'P004',
      'policy_number': 'CaCY123456',
      'insurance_type': 'Car Insurance',
      'insurance_company_name': 'ACcko General Insurance',
      'customer_id': '11',
      'customer_name': 'Tester',
      'registration_number': 'UP32KJ5364',
      'expiry_date': '2029-05-26',
      'start_date': '-',
      'premium_amount': '-',
      'maturity_amount': '-',
      'sum_insured': '-',
      'policy_term': '-',
      'premium_type': '-',
      'investment_type': '-',
      'plan_type': 'Third Party',
      'nominee_name': '-',
      'document_url': '-',
    },

  ];

  int currentPage = 1;
  final int itemsPerPage = 8;

  int get totalPages => (policyList.length / itemsPerPage)
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    0: FixedColumnWidth(100),
                    1: FixedColumnWidth(150),
                    2: FixedColumnWidth(150),
                    3: FixedColumnWidth(220),
                    4: FixedColumnWidth(150),
                    5: FixedColumnWidth(160),
                    6: FixedColumnWidth(180),
                    7: FixedColumnWidth(150),
                    8: FixedColumnWidth(120),
                    9: FixedColumnWidth(180),
                    10: FixedColumnWidth(180),
                    11: FixedColumnWidth(180),
                    12: FixedColumnWidth(140),
                    13: FixedColumnWidth(170),
                    14: FixedColumnWidth(160),
                    15: FixedColumnWidth(120),
                    16: FixedColumnWidth(160),
                    17: FixedColumnWidth(150),
                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                      ),
                      children: [
                        _headerCell('Policy ID'),
                        _headerCell('Policy Number'),
                        _headerCell('Insurance Type'),
                        _headerCell('Insurance Company Name'),
                        _headerCell('Customer ID'),
                        _headerCell('Customer Name'),
                        _headerCell('Registration Number'),
                        _headerCell('Expiry Date'),
                        _headerCell('Start Date'),
                        _headerCell('Premium Amount'),
                        _headerCell('Maturity Amount (₹)'),
                        _headerCell('Sum Insured (₹)'),
                        _headerCell('Policy Term (₹)'),
                        _headerCell('Premium Type'),
                        _headerCell('Investment Type'),
                        _headerCell('Plan Type'),
                        _headerCell('Nominee Name'),
                        _headerCell('View Document'),
                      ],
                    ),
                    for (final policy in policyList)
                      TableRow(
                        children: [
                          _cell(policy['policy_id']!),
                          _cell(policy['policy_number']!),
                          _cell(policy['insurance_type']!),
                          _cell(policy['insurance_company_name']!),
                          _cell(policy['customer_id']!),
                          _cell(policy['customer_name']!),
                          _cell(policy['registration_number']!),
                          _cell(policy['expiry_date']!),
                          _cell(policy['start_date']!),
                          _cell(policy['premium_amount']!),
                          _cell(policy['maturity_amount']!),
                          _cell(policy['sum_insured']!),
                          _cell(policy['policy_term']!),
                          _cell(policy['premium_type']!),
                          _cell(policy['investment_type']!),
                          _cell(policy['plan_type']!),
                          _cell(policy['nominee_name']!),
                          _actionCell(policy['document_url']!),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 26),
          if (policyList.length > itemsPerPage)
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
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: appColors.primary,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          texts.view,
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

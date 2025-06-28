import 'package:flutter/material.dart';
import 'package:policy_vault_admin/res/constants/texts.dart';
import 'package:policy_vault_admin/res/widgets/app_button.dart';
import 'package:policy_vault_admin/res/widgets/app_text_field.dart';
import 'package:policy_vault_admin/res/widgets/context_extension.dart';
import 'package:policy_vault_admin/theme/colors.dart';

class AddClaims extends StatefulWidget {
  const AddClaims({super.key});

  @override
  State<AddClaims> createState() => _AddClaimsState();
}

class _AddClaimsState extends State<AddClaims> {
  var statusList = ['Active', 'InActive'];
  var companyList = [
    'HDFC EGRO General Insurance',
    'Kotak General Insurance',
    'New India Assurance',
    'SBI General Insurance',
    'Star Health Insurance',
  ];
  var policyList = [
    'Car Insurance',
    '2-Wheeler Insurance',
    'Commercial Vehicle Insurance',
    'Health Insurance',
    'Term Insurance',
    'Investment Insurance',
    'Others',
  ];
  String? selectedStatus;
  String? selectedPolicyType;
  String? selectedCompany;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.screenBg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
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
                  Text(texts.selectCompany, style: context.textTheme.bodyMedium),
                  const SizedBox(height: 6),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: appColors.appWhite,
                      border: Border.all(
                        width: 1.5,
                        color: appColors.borderColor,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: DropdownButton(
                      menuWidth: MediaQuery.of(context).size.width * 0.28,
                      isExpanded: true,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(8),
                      isDense: true,
                      underline: SizedBox(),
                      hint: Text(
                        "comapny",
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontSize: 15,
                          color: appColors.titleColor,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(8),
                      value: selectedCompany,

                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: companyList.map((String items) {
                        return DropdownMenuItem(
                          value: items,

                          child: Text(
                            items,
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontSize: 15,
                              color: appColors.titleColor,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCompany = newValue!;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(texts.policyType, style: context.textTheme.bodyMedium),
                  const SizedBox(height: 6),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: appColors.appWhite,
                      border: Border.all(
                        width: 1.5,
                        color: appColors.borderColor,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: DropdownButton(
                      menuWidth: MediaQuery.of(context).size.width * 0.28,
                      isExpanded: true,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(8),
                      isDense: true,
                      underline: SizedBox(),
                      hint: Text(
                        "policy",
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontSize: 15,
                          color: appColors.titleColor,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(8),
                      value: selectedPolicyType,

                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: policyList.map((String items) {
                        return DropdownMenuItem(
                          value: items,

                          child: Text(
                            items,
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontSize: 15,
                              color: appColors.titleColor,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedPolicyType = newValue!;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(texts.claimDetail, style: context.textTheme.bodyMedium),
                  const SizedBox(height: 6),
                  AppTextField(
                    radius: 5,
                    borderWidth: 1.5,
                    maxLines: 10,
                    hintText: 'Write here...',
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.30,
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: appColors.appWhite,
                        border: Border.all(
                          width: 1,
                          color: appColors.borderColor,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: DropdownButton(
                        menuWidth: MediaQuery.of(context).size.width * 0.28,
                        isExpanded: true,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(8),
                        isDense: true,
                        underline: SizedBox(),
                        hint: Text(
                          "Status",
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontSize: 15,
                            color: appColors.titleColor,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(8),
                        value: selectedStatus,

                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: statusList.map((String items) {
                          return DropdownMenuItem(
                            value: items,

                            child: Text(
                              items,
                              style: context.textTheme.bodyMedium?.copyWith(
                                fontSize: 15,
                                color: appColors.titleColor,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedStatus = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  AppButton(
                    width: 140,
                    height: 45,
                    radius: 6,
                    onPressed: () {},
                    title: texts.save,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

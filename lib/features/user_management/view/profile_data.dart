import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:policy_vault_admin/res/constants/texts.dart';
import 'package:policy_vault_admin/res/widgets/app_button.dart';
import 'package:policy_vault_admin/res/widgets/app_text_field.dart';
import 'package:policy_vault_admin/res/widgets/context_extension.dart';
import 'package:policy_vault_admin/theme/colors.dart';
import 'package:policy_vault_admin/utils.dart';

class ProfileData extends StatefulWidget {
  const ProfileData({super.key});

  @override
  State<ProfileData> createState() => _ProfileDataState();
}

class _ProfileDataState extends State<ProfileData> {
  var incomeList = [
    'Choose Your Gross Annual Income',
    '1L-2L',
    '2L-5L',
    '5L-10L',
    '10L-20L',
  ];
  String? selectedIncome;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AppTextField(
                radius: 8,
                textCapitalization: TextCapitalization.words,
                labelText: texts.occupation,
                validator: (value) {
                  if (value == null) {
                    return "Occupation is required";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: appColors.appWhite,
                  border: Border.all(width: 2, color: appColors.borderColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton(
                  menuWidth: MediaQuery.of(context).size.width * 0.28,
                  isExpanded: true,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(8),
                  isDense: true,
                  underline: SizedBox(),
                  hint: Text(
                    texts.gross,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: 15,
                      color: appColors.titleColor,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(8),
                  value: selectedIncome,

                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: incomeList.map((String items) {
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
                      selectedIncome = newValue!;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: AppTextField(
                radius: 8,
                hintText: texts.mobileNumberHint,
                labelText: texts.mobileNumber,
                keyBoardType: TextInputType.number,

                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (val) => Utils.validateMobileNumber(val ?? ''),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: AppTextField(
                radius: 8,
                hintText: texts.emailAddressHint,
                labelText: texts.emailAddress,
                keyBoardType: TextInputType.emailAddress,
                inputFormatters: [LengthLimitingTextInputFormatter(60)],
                validator: (val) => Utils.validateEmail(val ?? ''),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        AppTextField(
          radius: 8,
          maxLines: 4,
          labelText: texts.address,
          validator: (value) {
            if (value == null) {
              return "Address is required";
            } else {
              return null;
            }
          },
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: AppTextField(
                radius: 8,
                labelText: texts.state,
                keyBoardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                inputFormatters: [LengthLimitingTextInputFormatter(100)],
                validator: (value) {
                  if (value == null) {
                    return "State is required";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: AppTextField(
                radius: 8,
                labelText: texts.city,
                keyBoardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                inputFormatters: [LengthLimitingTextInputFormatter(100)],
                validator: (value) {
                  if (value == null) {
                    return "City is required";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: AppTextField(
                radius: 8,
                labelText: texts.pinCode,
                keyBoardType: TextInputType.number,
                textCapitalization: TextCapitalization.none,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(6),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                  if (value == null) {
                    return "Pin Code is required";
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 36),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AppButton(
              width: 140,
              height: 45,
              radius: 8,
              isBorder: true,
              color: appColors.appWhite,
              textColor: appColors.primary,
              borderColor: appColors.primary,

              onPressed: () {},
              title: texts.cancel,
            ),
            SizedBox(width: 12),
            AppButton(
              width: 140,
              height: 45,
              radius: 8,
              onPressed: () {},
              title: texts.save,
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:policy_vault_admin/res/constants/messages.dart';
import 'package:policy_vault_admin/res/constants/texts.dart';
import 'package:policy_vault_admin/res/widgets/app_button.dart';
import 'package:policy_vault_admin/res/widgets/app_text_field.dart';
import 'package:policy_vault_admin/res/widgets/context_extension.dart';
import 'package:policy_vault_admin/responsive/layout.dart';
import 'package:policy_vault_admin/responsive/responsive_wrapper.dart';
import 'package:policy_vault_admin/theme/colors.dart';
import 'package:policy_vault_admin/utils.dart';

class AddAdminUserScreen extends StatefulWidget {
  const AddAdminUserScreen({super.key});

  @override
  State<AddAdminUserScreen> createState() => _AddAdminUserScreenState();
}

class _AddAdminUserScreenState extends State<AddAdminUserScreen> {
  final signupConfirmPasswordController = TextEditingController();
  var statusList = ['Active', 'InActive'];
  String? selectedStatus;

  final List<String> modules = [
    'Dashboard',
    'User Management',
    'CMS',
    'Support Management',
    'Manage Admin Users',
  ];

  final Map<String, bool> viewPermissions = {};
  final Map<String, bool> editPermissions = {};

  @override
  void initState() {
    super.initState();
    for (var module in modules) {
      viewPermissions[module] = false;
      editPermissions[module] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var layout = LayoutHelper(context);
    return Scaffold(
      backgroundColor: appColors.screenBg,
      body: SingleChildScrollView(
        child: ResponsiveWrapper(
          rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
          isColumn: layout.isTablet || layout.isMobile,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 14),
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
                    Text(
                      'Admin User detail',
                      style: context.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 6),
                    const Divider(thickness: 1),
                    const SizedBox(height: 16),
                    AppTextField(
                      radius: 8,
                      hintText: texts.fullNameHint,
                      labelText: texts.fullName,
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value == null) {
                          return "Full Name is required";
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
                            hintText: texts.mobileNumberHint,
                            labelText: texts.mobileNumber,
                            keyBoardType: TextInputType.number,

                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (val) =>
                                Utils.validateMobileNumber(val ?? ''),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: AppTextField(
                            radius: 8,
                            hintText: texts.emailAddressHint,
                            labelText: texts.emailAddress,
                            keyBoardType: TextInputType.emailAddress,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(60),
                            ],
                            validator: (val) => Utils.validateEmail(val ?? ''),
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
                            hintText: texts.passwordHint,
                            labelText: texts.password,
                            keyBoardType: TextInputType.visiblePassword,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(30),
                            ],
                            validator: (val) =>
                                Utils.passwordValidator(val ?? ''),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: AppTextField(
                            radius: 8,
                            controller: signupConfirmPasswordController,
                            hintText: texts.confirmPasswordHint,
                            labelText: texts.confirmPassword,
                            keyBoardType: TextInputType.visiblePassword,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(30),
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return Messages.CONFIRM_PASSWORD_REQ;
                              } else if (signupConfirmPasswordController.text !=
                                  value) {
                                return Messages.CON_PASSWORD_NOT_MATCHED;
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 36),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: appColors.appWhite,
                              border: Border.all(
                                width: 2,
                                color: appColors.borderColor,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButton(
                              menuWidth:
                                  MediaQuery.of(context).size.width * 0.28,
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
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(
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
                          radius: 8,
                          onPressed: () {},
                          title: texts.save,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: appColors.appBackground,
                  borderRadius: BorderRadius.circular(4),
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
                    Text(
                      'Module Access Permission',
                      style: context.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 6),
                    const Divider(thickness: 1),
                    const SizedBox(height: 12),
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(3),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(1),
                      },
                      border: TableBorder(
                        horizontalInside: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      children: [
                        _buildHeaderRow(),
                        ...modules.map((module) => _buildDataRow(module)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildHeaderRow() {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text(' ', style: context.textTheme.bodyMedium),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text(
            'View',
            style: context.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text(
            'Edit',
            style: context.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  TableRow _buildDataRow(String module) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            module,
            style: context.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Center(
          child: Checkbox(
            value: viewPermissions[module],
            onChanged: (value) {
              setState(() => viewPermissions[module] = value ?? false);
            },

            fillColor: WidgetStateProperty.resolveWith<Color?>((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.disabled)) {
                return appColors.borderColor;
              }
              if (states.contains(WidgetState.selected)) {
                return appColors.primary;
              }
              return appColors.appBackground;
            }),

            checkColor: appColors.appBackground,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4), // rounded corners
            ),
            side: BorderSide(color: appColors.editTextColor, width: 1),
          ),
        ),
        Center(
          child: Checkbox(
            value: editPermissions[module],
            onChanged: (value) {
              setState(() => editPermissions[module] = value ?? false);
            },

            fillColor: WidgetStateProperty.resolveWith<Color?>((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.disabled)) {
                return appColors.borderColor;
              }
              if (states.contains(WidgetState.selected)) {
                return appColors.primary;
              }
              return appColors.appBackground;
            }),

            checkColor: appColors.appBackground,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4), // rounded corners
            ),
            side: BorderSide(color: appColors.editTextColor, width: 1),
          ),
        ),
      ],
    );
  }
}

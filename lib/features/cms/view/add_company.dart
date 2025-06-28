import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:policy_vault_admin/res/constants/texts.dart';
import 'package:policy_vault_admin/res/widgets/app_button.dart';
import 'package:policy_vault_admin/res/widgets/app_text_field.dart';
import 'package:policy_vault_admin/res/widgets/context_extension.dart';
import 'package:policy_vault_admin/theme/colors.dart';

class AddCompany extends StatefulWidget {
  const AddCompany({super.key});

  @override
  State<AddCompany> createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {
  final TextEditingController _companyController = TextEditingController();
  String? _selectedFileName;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedFileName = result.files.first.name;
      });
    }
  }

  var statusList = ['Active', 'InActive'];
  String? selectedStatus;

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
                  Text(
                    texts.insuranceCompany,
                    style: context.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 6),

                  AppTextField(
                    controller: _companyController,
                    radius: 5,
                    borderWidth: 1.5,
                    hintText: 'Enter Information',
                  ),

                  const SizedBox(height: 16),
                  Row(
                    children: [
                      AppButton(
                        height: 33,
                        width: 100,
                        radius: 4,
                        fontSize: 12,
                        borderWidth: 1,
                        onPressed: _pickFile,
                        title: texts.chooseFile,
                        color: appColors.chooseColor,
                        isBorder: true,
                        borderColor: appColors.appBlack,
                        textColor: appColors.appBlack,
                      ),

                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(_selectedFileName ?? "No file chosen"),
                      ),
                    ],
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

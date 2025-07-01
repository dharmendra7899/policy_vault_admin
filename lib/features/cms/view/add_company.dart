import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:policy_vault_admin/res/constants/texts.dart';
import 'package:policy_vault_admin/res/widgets/app_button.dart';
import 'package:policy_vault_admin/res/widgets/app_text_field.dart';
import 'package:policy_vault_admin/res/widgets/context_extension.dart';
import 'package:policy_vault_admin/responsive/layout.dart';
import 'package:policy_vault_admin/responsive/responsive_wrapper.dart';
import 'package:policy_vault_admin/theme/colors.dart';

class AddCompany extends StatefulWidget {
  const AddCompany({super.key});

  @override
  State<AddCompany> createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _primaryColorHexController =
      TextEditingController();
  final TextEditingController _secondaryColorHexController =
      TextEditingController();
  String? _selectedFileName;
  Color _primaryColor = Colors.blue;
  Color _secondaryColor = Colors.red;

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

  void _showColorPicker(Color initialColor, Function(Color) onColorChanged) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Pick a Color"),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: initialColor,
            onColorChanged: onColorChanged,
            enableAlpha: false,
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: [
          TextButton(
            child: const Text("Select"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var layout = LayoutHelper(context);
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

                  const SizedBox(height: 26),
                  ResponsiveWrapper(
                    rowCrossAxisAlignment: CrossAxisAlignment.center,
                    rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                    columnCrossAxisAlignment: CrossAxisAlignment.start,
                    isColumn: layout.isTablet || layout.isMobile,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 350,
                          child: Row(
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
                                child: Text(
                                  _selectedFileName ?? "No file chosen",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Primary Color",
                              style: context.textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 6),
                            SizedBox(
                              width: 250,
                              height: 40,
                              child: AppTextField(
                                controller: _primaryColorHexController
                                  ..text = _primaryColor.value
                                      .toRadixString(16)
                                      .padLeft(8, '0')
                                      .substring(2),
                                radius: 6,
                                borderWidth: 1.5,
                                hintText: '#hex',
                                onChanged: (value) {
                                  final color = Color(
                                    int.parse("0xff${value.replaceAll('#', '')}"),
                                  );
                                  setState(() => _primaryColor = color);
                                },
                                iconData: IconButton(
                                  onPressed: () {
                                    _showColorPicker(_primaryColor, (color) {
                                      setState(() {
                                        _primaryColor = color;
                                        _primaryColorHexController.text = color
                                            .value
                                            .toRadixString(16)
                                            .padLeft(8, '0')
                                            .substring(2);
                                      });
                                    });
                                  },
                                  icon: Container(
                                    width: 45,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: _primaryColor,
                                      border: Border.all(
                                        color: appColors.borderColor,
                                        width: 0.4,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Secondary Color",
                              style: context.textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 6),

                            SizedBox(
                              width: 250,
                              height: 40,
                              child: AppTextField(
                                controller: _secondaryColorHexController
                                  ..text = _secondaryColor.value
                                      .toRadixString(16)
                                      .padLeft(8, '0')
                                      .substring(2),
                                radius: 6,
                                borderWidth: 1.5,
                                hintText: '#hex',
                                onChanged: (value) {
                                  final color = Color(
                                    int.parse("0xff${value.replaceAll('#', '')}"),
                                  );
                                  setState(() => _secondaryColor = color);
                                },
                                iconData: IconButton(
                                  onPressed: () {
                                    _showColorPicker(_secondaryColor, (color) {
                                      setState(() {
                                        _secondaryColor = color;
                                        _secondaryColorHexController.text = color
                                            .value
                                            .toRadixString(16)
                                            .padLeft(8, '0')
                                            .substring(2);
                                      });
                                    });
                                  },
                                  icon: Container(
                                    width: 45,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: _secondaryColor,
                                      border: Border.all(
                                        color: appColors.borderColor,
                                        width: 0.4,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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

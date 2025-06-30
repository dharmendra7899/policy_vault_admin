import 'package:flutter/material.dart';
import 'package:policy_vault_admin/responsive/layout.dart';
import 'package:policy_vault_admin/theme/colors.dart';
import 'package:policy_vault_admin/res/widgets/app_button.dart';
import 'package:policy_vault_admin/res/widgets/context_extension.dart';

class CustomPager extends StatefulWidget {
  final int totalPages;
  final Function(int) onPageChanged;
  final bool showItemsPerPage;
  final List<int>? itemsPerPageList;
  final Function(int)? onItemsPerPageChanged;
  final int currentPage;
  final int pagesView;
  final String? itemsPerPageText;
  final TextStyle? itemsPerPageTextStyle;
  final TextStyle? dropDownMenuItemTextStyle;
  final Color pageChangeIconColor;

  const CustomPager({
    super.key,
    required this.totalPages,
    required this.onPageChanged,
    this.showItemsPerPage = false,
    this.itemsPerPageList,
    this.onItemsPerPageChanged,
    this.currentPage = 1,
    this.pagesView = 3,
    this.itemsPerPageText,
    this.itemsPerPageTextStyle,
    this.dropDownMenuItemTextStyle,
    this.pageChangeIconColor = Colors.grey,
  });

  @override
  State<CustomPager> createState() => _CustomPagerState();
}

class _CustomPagerState extends State<CustomPager> {
  late int _currentPage;
  late int _pagesView;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.currentPage;
    _pagesView = widget.totalPages < widget.pagesView
        ? widget.totalPages
        : widget.pagesView;
  }

  @override
  Widget build(BuildContext context) {
    final layout = LayoutHelper(context);
    final spacing = layout.scale(8);
    final buttonSize = layout.scale(100);
    final numberSize = layout.scale(35);
    final fontSize = layout.scale(12);

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppButton(
              height: numberSize,
              width: buttonSize,
              onPressed: () {
                if (_currentPage > 1) {
                  setState(() => _currentPage--);
                  widget.onPageChanged(_currentPage);
                }
              },
              radius: 4,
              title: 'Previous',
              isBorder: true,
              borderWidth: 0.4,
              fontSize: fontSize,
              borderColor: appColors.buttonColor,
              color: appColors.appBackground,
              textColor: appColors.buttonColor,
            ),
            SizedBox(width: spacing),
            Row(
              children: List.generate(_pagesView, (index) {
                int page = getPageStart() + index;
                if (page > widget.totalPages) return const SizedBox.shrink();
                return GestureDetector(
                  onTap: () {
                    setState(() => _currentPage = page);
                    widget.onPageChanged(_currentPage);
                  },
                  child: Container(
                    width: numberSize,
                    height: numberSize,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: spacing / 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: _currentPage == page
                          ? appColors.buttonColor
                          : appColors.appBackground,
                      border: Border.all(
                        width: 0.4,
                        color: appColors.buttonColor,
                      ),
                    ),
                    child: Text(
                      "$page",
                      style: context.textTheme.bodySmall?.copyWith(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600,
                        color: _currentPage == page
                            ? appColors.appWhite
                            : appColors.titleColor,
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(width: spacing),
            AppButton(
              height: numberSize,
              width: buttonSize,
              onPressed: () {
                if (_currentPage < widget.totalPages) {
                  setState(() => _currentPage++);
                  widget.onPageChanged(_currentPage);
                }
              },
              radius: 4,
              title: 'Next',
              isBorder: true,
              borderWidth: 0.4,
              fontSize: fontSize,
              borderColor: appColors.buttonColor,
              color: appColors.appBackground,
              textColor: appColors.buttonColor,
            ),
          ],
        ),
        if (widget.showItemsPerPage &&
            widget.itemsPerPageList != null &&
            widget.itemsPerPageList!.isNotEmpty &&
            widget.onItemsPerPageChanged != null)
          Padding(
            padding: EdgeInsets.only(top: spacing),
            child: CustomItemsPerPage(
              itemsPerPage: widget.itemsPerPageList!,
              onChanged: widget.onItemsPerPageChanged!,
              itemsPerPageText: widget.itemsPerPageText,
              itemsPerPageTextStyle: widget.itemsPerPageTextStyle,
              dropDownMenuItemTextStyle: widget.dropDownMenuItemTextStyle,
            ),
          ),
      ],
    );
  }

  int getPageStart() {
    final end = (_currentPage + _pagesView > widget.totalPages)
        ? widget.totalPages
        : _currentPage + _pagesView - 1;
    return end - _pagesView + 1;
  }
}

class CustomItemsPerPage extends StatefulWidget {
  const CustomItemsPerPage({
    super.key,
    required this.itemsPerPage,
    required this.onChanged,
    this.itemsPerPageText,
    this.itemsPerPageTextStyle,
    this.dropDownMenuItemTextStyle,
  });

  final List<int> itemsPerPage;
  final Function(int) onChanged;
  final String? itemsPerPageText;
  final TextStyle? itemsPerPageTextStyle;
  final TextStyle? dropDownMenuItemTextStyle;

  @override
  State<CustomItemsPerPage> createState() => _CustomItemsPerPageState();
}

class _CustomItemsPerPageState extends State<CustomItemsPerPage> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.itemsPerPage.first;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.itemsPerPageText ?? "Items per page: ",
          style:
              widget.itemsPerPageTextStyle ??
              const TextStyle(color: Colors.grey),
        ),
        const SizedBox(width: 16),
        DropdownButton<int>(
          value: _currentValue,
          items: widget.itemsPerPage.map((value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(
                "$value",
                style:
                    widget.dropDownMenuItemTextStyle ??
                    const TextStyle(fontSize: 14),
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _currentValue = value;
              });
              widget.onChanged(value);
            }
          },
        ),
      ],
    );
  }
}

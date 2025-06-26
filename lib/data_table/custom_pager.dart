// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:policy_vault_admin/res/widgets/app_button.dart';
import 'package:policy_vault_admin/res/widgets/context_extension.dart';
import 'package:policy_vault_admin/theme/colors.dart';

class CustomPager extends StatefulWidget {
  CustomPager({
    super.key,
    required this.totalPages,
    required this.onPageChanged,
    this.showItemsPerPage = false,
    this.onItemsPerPageChanged,
    this.itemsPerPageList,
    this.pagesView = 3,
    this.currentPage = 1,
    this.pageChangeIconColor = Colors.grey,
    this.itemsPerPageText,
    this.itemsPerPageTextStyle,
    this.dropDownMenuItemTextStyle,
  }) : assert(
         currentPage > 0 && totalPages > 0 && pagesView > 0,
         "Fatal Error: Make sure the currentPage, totalPages and pagesView fields are greater than zero. ",
       ) {
    if (showItemsPerPage) {
      assert(
        onItemsPerPageChanged != null &&
            itemsPerPageList != null &&
            itemsPerPageList!.isNotEmpty,
        "Fatal error: OnItemsPerPageChanged must be implemented or itemsPerPageList is null or empty.",
      );
    }
  }

  /// How many page numbers selectable to show at once.
  int pagesView;

  /// Total pages.
  final int totalPages;

  /// The callback that is called when the page is changed.
  final Function(int) onPageChanged;

  /// Show items per page
  bool showItemsPerPage;

  /// Items per page list. Example: [5,10,20,50]
  List<int>? itemsPerPageList;

  /// The callback that is called when the page is changed.
  final Function(int)? onItemsPerPageChanged;

  /// Current page. Default is 1.
  int currentPage;


  // Color of the next, previous, first and last page icons.
  final Color pageChangeIconColor;

  // ItemsPerPage label text.
  final String? itemsPerPageText;

  // ItemsPerPage label text style.
  final TextStyle? itemsPerPageTextStyle;

  // DropDownButtonMenuItem text style.
  final TextStyle? dropDownMenuItemTextStyle;

  @override
  State<CustomPager> createState() => _CustomPagerState();
}

class _CustomPagerState extends State<CustomPager> {
  @override
  Widget build(BuildContext context) {
    pagesViewValidation();
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            AppButton(
              height: 35,
              width: 100,
              onPressed: () {
                setState(() {
                  widget.currentPage = widget.currentPage > 1
                      ? widget.currentPage - 1
                      : 1;
                  widget.onPageChanged(widget.currentPage);
                });
              },
              title: 'Previous',
              isBorder: true,
              radius: 6,
              borderWidth: 0.4,
              fontSize: 12,
              borderColor: appColors.buttonColor,
              color: appColors.appBackground,
              textColor: appColors.buttonColor,
            ),
            SizedBox(width: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int i = getPageStart(getPageEnd()); i < getPageEnd(); i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.currentPage = i;
                        widget.onPageChanged(widget.currentPage);
                      });
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(4),
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: widget.currentPage == i
                            ? appColors.buttonColor
                            : appColors.appBackground,
                        border: Border.all(
                          width: 0.4,
                          color: appColors.buttonColor,
                        ),
                      ),
                      child: Text(
                        "$i",
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: widget.currentPage == i
                              ? appColors.appWhite
                              : appColors.titleColor,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 4),
            AppButton(
              height: 35,
              width: 100,
              onPressed: () {
                setState(() {
                  widget.currentPage = widget.currentPage < widget.totalPages
                      ? widget.currentPage + 1
                      : widget.totalPages;
                  widget.onPageChanged(widget.currentPage);
                });
              },
              title: 'Next',
              isBorder: true,
              radius: 6,
              fontSize: 12,
              borderWidth: 0.4,
              borderColor: appColors.buttonColor,
              color: appColors.appBackground,
              textColor: appColors.buttonColor,
            ),

          ],
        ),
        if (widget.showItemsPerPage)
          CustomItemsPerPage(
            itemsPerPage: widget.itemsPerPageList!,
            onChanged: widget.onItemsPerPageChanged!,
            itemsPerPageText: widget.itemsPerPageText,
            itemsPerPageTextStyle: widget.itemsPerPageTextStyle,
            dropDownMenuItemTextStyle: widget.dropDownMenuItemTextStyle,
          ),
      ],
    );
  }

  /// Get last page to show in pagination.
  int getPageEnd() {
    return widget.currentPage + widget.pagesView > widget.totalPages
        ? widget.totalPages + 1
        : widget.currentPage + widget.pagesView;
  }

  /// Get first page to show in pagination.
  int getPageStart(int pageEnd) {
    return pageEnd == widget.totalPages + 1
        ? pageEnd - widget.pagesView
        : widget.currentPage;
  }

  /// Validation of pagesView field
  void pagesViewValidation() {
    if (widget.totalPages < widget.pagesView) {
      widget.pagesView = widget.totalPages;
    }
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
  final TextStyle? itemsPerPageTextStyle, dropDownMenuItemTextStyle;

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
        DropdownButton(
          value: _currentValue,
          focusColor: Colors.transparent,
          items: widget.itemsPerPage.map((value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(
                value.toString(),
                style:
                    widget.dropDownMenuItemTextStyle ??
                    const TextStyle(fontSize: 14),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _currentValue = value as int;
              widget.onChanged(value);
            });
          },
        ),
      ],
    );
  }
}

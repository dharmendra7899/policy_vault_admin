import 'package:flutter/material.dart';
import 'package:policy_vault_admin/theme/colors.dart';

part 'widget/app_bar_theme.dart';
part 'widget/bottom_sheet_theme.dart';
part 'widget/check_box_theme.dart';
part 'widget/divider_theme.dart';
part 'widget/elevated_button_theme.dart';
part 'widget/expansion_tile_theme.dart';
part 'widget/input_decoration_theme.dart';
part 'widget/search_bar_theme.dart';
part 'widget/text_theme.dart';
part 'widget/tooltip_theme.dart';

class AppTheme {
  static final darkThemeMode = ThemeData.dark(useMaterial3: true);

  static final lightThemeMode = ThemeData(
    fontFamily: 'Montserrat',
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: appColors.onSurface),
    scaffoldBackgroundColor: appColors.appWhite,
    inputDecorationTheme: _inputDecorationTheme,
    textTheme: _textTheme,
    dividerTheme: _dividerTheme,
    bottomSheetTheme: _bottomSheetTheme,
    appBarTheme: _appBarTheme,
    checkboxTheme: _checkBoxTheme,
    searchBarTheme: _searchBarTheme,
    elevatedButtonTheme: _elevatedButtonTheme,
    expansionTileTheme: _expansionTileTheme,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: appColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: appColors.appGreen, width: 2),
        ),
      ),
    ),
    tooltipTheme: _tooltipTheme,
  );
}

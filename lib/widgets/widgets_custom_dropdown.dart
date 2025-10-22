import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/constants/app_colors.dart';

class CustomDropdownMenu extends StatelessWidget {
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onSelected;
  final String hint;

  const CustomDropdownMenu({
    super.key,
    required this.items,
    required this.value,
    required this.onSelected,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return TextSelectionTheme(
      data: TextSelectionThemeData(
        selectionColor: AppColors.brand.withAlpha(77),
        selectionHandleColor: AppColors.brand,
        cursorColor: AppColors.brand,
      ),
      child: DropdownMenu<String>(
        dropdownMenuEntries: items.map((String item) {
          return DropdownMenuEntry<String>(
            value: item,
            label: item,
          );
        }).toList(),
        width: 385,
        textAlign: TextAlign.center,
        initialSelection: value,
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Dubai',
        ),
        menuStyle: MenuStyle(
            backgroundColor: WidgetStateProperty.all(Colors.white70),
            elevation: WidgetStateProperty.all(2),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            side: WidgetStateProperty.all(
              BorderSide(color: AppColors.textFieldHint),
            ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
          filled: true,
          fillColor: AppColors.textFieldBackground,
          labelStyle: TextStyle(
            fontSize: 18,
            color: AppColors.textFieldHint,
            fontFamily: 'Dubai',
          ),
          floatingLabelStyle: TextStyle(
            fontSize: 18,
            color: AppColors.brand,
            fontFamily: 'Dubai',
          ),
          hintStyle: TextStyle(
            fontSize: 20,
            color: AppColors.textFieldHint,
            fontFamily: 'Dubai',
          ),
          prefixIconColor: AppColors.textFieldHint,
          // Borders to match CustomTextField
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.textFieldHint),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.brand, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.textFieldHint),
          ),
        ),
        onSelected: onSelected,
      ),
    );
  }
}

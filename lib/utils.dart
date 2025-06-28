import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:policy_vault_admin/res/constants/messages.dart';
import 'package:policy_vault_admin/res/widgets/context_extension.dart';
import 'package:policy_vault_admin/theme/colors.dart';

class Utils {
  static String getInitials(String? name) {
    if (name == null || name.trim().isEmpty) return "";
    List<String> parts = name.trim().split(" ");
    String first = parts[0].substring(0, 1);
    String second = parts.length > 1 ? parts[1].substring(0, 1) : "";
    return (first + second).toUpperCase();
  }

  static String formatCurrency(num value) {
    final formatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 2,
    );
    return formatter.format(value.toDouble().abs());
  }

  static String formatDate(String inputDate, String formatDate) {
    try {
      final parsedDate = DateFormat("dd-MM-yyyy").parse(inputDate);
      return DateFormat(formatDate).format(parsedDate);
    } catch (e) {
      return "";
    }
  }

  static void toastMessage(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(milliseconds: 3000),
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).padding.bottom + 60,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: appColors.lightColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              message,
              style: context.textTheme.bodyMedium?.copyWith(
                color: appColors.titleColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }

  static void flushBarErrorMessage(String? message, BuildContext context) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).padding.bottom + 60,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: appColors.error,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              message.toString(),
              style: context.textTheme.bodyMedium?.copyWith(
                color: appColors.appWhite,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  // average for ratings
  static double averageRatings(List<int> ratings) {
    double avg = 0;
    for (int i = 0; i < ratings.length; i++) {
      avg += ratings[i];
    }
    avg /= ratings.length;

    return avg;
  }

  bool shouldLogout = true;

  void setShouldLogout(bool val) {
    shouldLogout = val;
  }

  static String formatTime(DateTime time) {
    return "${time.hour > 12
        ? time.hour - 12
        : time.hour == 0
        ? 12
        : time.hour}:${time.minute.toString().padLeft(2, '0')} ${time.hour >= 12 ? 'PM' : 'AM'}";
  }

  static String toTitleCase(String text) {
    if (text.isEmpty) return text;
    return text
        .split(' ')
        .map(
          (word) => word.isNotEmpty
              ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
              : '',
        )
        .join(' ');
  }

  DateTime selectedDateTime = DateTime.now();

  void pickDate({
    DateTime? firstDay,
    DateTime? lastDate,
    DateTime? dateForEditProfile,
    DateTime? selectedDateAndTime,
    required DateTime focusDate,
    required Function onDateSelected,
  }) {
    selectedDateTime = selectedDateAndTime ?? DateTime.now();
    CalendarDatePicker(
      initialDate: dateForEditProfile ?? firstDay ?? DateTime.now(),
      firstDate: firstDay ?? DateTime.now(),
      lastDate: lastDate ?? DateTime.now().add(const Duration(days: 18 * 365)),
      onDateChanged: (DateTime value) {
        selectedDateTime = value;
      },
    );
  }

  Future<File?> pickImage({
    required BuildContext context,
    required ImageSource img,
    bool allowMultiple = false,
    List<String> allowedExtensions = const ['jpg', 'png'],
    bool cropImage = false,
  }) async {
    setShouldLogout(false);
    if (img == ImageSource.gallery) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: allowMultiple,
        allowedExtensions: allowedExtensions,
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        int fileSizeInBytes = file.lengthSync();
        double fileSizeInMB = fileSizeInBytes / (1024 * 1024);
        if (fileSizeInMB > 5 && context.mounted) {
          flushBarErrorMessage("File size must be less than 5MB", context);
        } else {
          Future.delayed(
            const Duration(seconds: 5),
          ).then((_) => setShouldLogout(true));
          return file;
        }
      } else {
        Future.delayed(
          const Duration(seconds: 5),
        ).then((_) => setShouldLogout(true));
        return null;
      }
    }

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: img,
      imageQuality: 50,
      requestFullMetadata: true,
    );

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      Future.delayed(
        const Duration(seconds: 3),
      ).then((_) => setShouldLogout(true));
      return imageFile;
    } else {
      if (context.mounted) {
        flushBarErrorMessage("Nothing is selected", context);
      }
    }

    Future.delayed(
      const Duration(seconds: 3),
    ).then((_) => setShouldLogout(true));
    return null;
  }

  Future<File?> pickImageOld({
    required BuildContext context,
    required ImageSource img,
    bool allowMultiple = false,
    List<String> allowedExtensions = const ['pdf', 'jpg', 'png'],
  }) async {
    setShouldLogout(false);
    if (img == ImageSource.gallery) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: allowMultiple,
        allowedExtensions: allowedExtensions,
      );
      if (result != null) {
        File file = File(result.files.single.path!);
        int fileSizeInBytes = file.lengthSync();
        double fileSizeInMB = fileSizeInBytes / (1024 * 1024);
        if (fileSizeInMB > 5 && context.mounted) {
          flushBarErrorMessage("File size must be less than 5MB", context);
        } else {
          Future.delayed(
            const Duration(seconds: 5),
          ).then((value) => setShouldLogout(true));
          return File(result.files.single.path!);
        }
      } else {
        Future.delayed(
          const Duration(seconds: 5),
        ).then((value) => setShouldLogout(true));
        return null;
      }
    }

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: img,
      imageQuality: 50,
      requestFullMetadata: true,
    );
    if (pickedFile != null) {
      Future.delayed(
        const Duration(seconds: 3),
      ).then((value) => setShouldLogout(true));
      return File(pickedFile.path);
    } else {
      if (context.mounted) {
        flushBarErrorMessage("Nothing is selected", context);
      }
    }
    Future.delayed(
      const Duration(seconds: 3),
    ).then((value) => setShouldLogout(true));
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return Messages.PASSWORD_REQ;
    }
    final passwordPattern = RegExp(
      r'^(?=.*[A-Z])(?=.*[\W_])(?=.*\d)[A-Za-z\d\W_]{8,}$',
    );
    if (!passwordPattern.hasMatch(value)) {
      return Messages.SPECIAL_CHARACTER;
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final emailRegExp = RegExp(
      r'^([a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})$',
      caseSensitive: false,
    );
    if (value == null || value.isEmpty) {
      return Messages.EMAIL_REQ;
    } else if (!emailRegExp.hasMatch(value)) {
      return Messages.EMAIL_VALID;
    }
    return null;
  }

  static String? bankAccountValidator(String? value) {
    final RegExp bankAccountRegExp = RegExp(r'^\d{9,18}$');
    if (value == null || value.isEmpty) {
      return 'Bank account number is required';
    } else if (!bankAccountRegExp.hasMatch(value)) {
      return 'Enter a valid bank account number (9-18 digits)';
    }
    return null;
  }

  static String? validateMobileNumber(String? value) {
    final mobileRegExp = RegExp(r'^[6-9]\d{9}$');
    if (value == null || value.isEmpty) {
      return Messages.PHONE_REQ;
    } else if (!mobileRegExp.hasMatch(value)) {
      return Messages.PHONE_VALID;
    }
    return null;
  }

  static String? validateVehicleNumber(String? value) {
    final vehicleRegExp = RegExp(
      //r'^[A-Z]{2}[ -]?[0-9]{1,2}[ -]?[A-Z]{0,3}[ -]?[0-9]{4}$',
      r'^[A-Z]{2}[ -]?[0-9]{1,2}[ -]?[A-Z]{0,3}[ -]?[0-9]{4}$',
    );
    if (value == null || value.trim().isEmpty) {
      return Messages.REGISTRATION_NO_REQ;
    } else if (!vehicleRegExp.hasMatch(value.trim().toUpperCase())) {
      return Messages.REGISTRATION_NO_VALID;
    }
    return null;
  }

  static String? validatePanCard(String? value) {
    final panRegExp = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');
    if (value == null || value.trim().isEmpty) {
      return Messages.PAN_REQ;
    } else if (!panRegExp.hasMatch(value.trim().toUpperCase())) {
      return Messages.PAN_VALID;
    }
    return null;
  }

  static String? validateAadhaar(String? value) {
    final aadhaarRegExp = RegExp(r'^\d{4}\s?\d{4}\s?\d{4}$');
    if (value == null || value.trim().isEmpty) {
      return Messages.AADHAAR_REQ;
    } else if (!aadhaarRegExp.hasMatch(value.trim())) {
      return Messages.AADHAAR_VALID;
    }
    return null;
  }

  static String? validateDrivingLicense(String? value) {
    final dlRegExp = RegExp(r'^[A-Z]{2}\d{2}\s?\d{11}$');
    if (value == null || value.trim().isEmpty) {
      return Messages.DRIVING_LICENSE_REQ;
    } else if (!dlRegExp.hasMatch(value.trim().toUpperCase())) {
      return Messages.DRIVING_LICENSE_VALID;
    }
    return null;
  }

  static String? validateVoterId(String? value) {
    final voterRegExp = RegExp(r'^[A-Z]{3}[0-9]{7}$');
    if (value == null || value.trim().isEmpty) {
      return Messages.VOTER_REQ;
    } else if (!voterRegExp.hasMatch(value.trim().toUpperCase())) {
      return Messages.VOTER_VALID;
    }
    return null;
  }

  static String? validatePassport(String? value) {
    final passportRegExp = RegExp(r'^[A-PR-WYa-pr-wy][0-9]{7,8}$');
    if (value == null || value.trim().isEmpty) {
      return Messages.PASSPORT_REQ;
    } else if (!passportRegExp.hasMatch(value.trim().toUpperCase())) {
      return Messages.PASSPORT_VALID;
    }
    return null;
  }
}

import 'package:intl/intl.dart';

bool isEmailValid(String email) {
  final RegExp emailRegExp =
      RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-z]{2,4})$');
  return emailRegExp.hasMatch(email);
}

String formatDate(String date, String format) {
  try {
    final DateTime parsedDate = DateTime.parse(date);
    return DateFormat(format).format(parsedDate); // Output: 09 Dec 1985
  } catch (e) {
    return date; // Return the original string if parsing fails
  }
}





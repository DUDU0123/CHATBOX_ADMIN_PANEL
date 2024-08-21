import 'package:intl/intl.dart';

class DateProvider {
  static String convertDateToFormatted({required String date}) {
    try {
      // Parse the string to an integer (milliseconds since epoch)
      int millisecondsSinceEpoch = int.parse(date);

      // Create a DateTime object from the milliseconds
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);

      // Format the DateTime object
      String formattedDate = DateFormat('MMMM d, yyyy').format(dateTime);
      return formattedDate;
    } catch (e) {
      // If parsing fails, log the error and return a default value
      return 'Date not available';
    }
  }
}

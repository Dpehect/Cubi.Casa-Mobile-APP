import 'package:intl/intl.dart';

class Formatters {
  static String formatCurrency(double amount, {String currencySymbol = '\$'}) {
    return '$currencySymbol${amount.toStringAsFixed(2)}';
  }

  static String formatNumber(double number) {
    return NumberFormat('#,##0.00').format(number);
  }

  static String formatPhoneNumber(String phoneNumber) {
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');
    if (cleanNumber.length == 10) {
      return '(${cleanNumber.substring(0, 3)}) ${cleanNumber.substring(3, 6)}-${cleanNumber.substring(6)}';
    }
    return phoneNumber;
  }

  static String formatDate(DateTime date, {String format = 'dd/MM/yyyy'}) {
    return DateFormat(format).format(date);
  }

  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }

  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '$hours h $minutes m';
    } else if (minutes > 0) {
      return '$minutes m $seconds s';
    } else {
      return '$seconds s';
    }
  }

  static String formatArea(double area, {String unit = 'm²'}) {
    return '${area.toStringAsFixed(2)} $unit';
  }

  static String formatCoordinate(double value) {
    return value.toStringAsFixed(6);
  }

  static String formatPercentage(double value) {
    return '${(value * 100).toStringAsFixed(2)}%';
  }

  static String maskCreditCard(String cardNumber) {
    if (cardNumber.length < 4) return cardNumber;
    return '**** **** **** ${cardNumber.substring(cardNumber.length - 4)}';
  }

  static String formatCamelCaseToReadable(String text) {
    return text.replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
      (match) => '${match.group(1)} ${match.group(2)}',
    );
  }
}

import 'package:intl/intl.dart';

String formatCurrency(double amount, String currencyCode) {
  final NumberFormat formatter = NumberFormat.currency(
    locale:
        'en_US', // You can change the locale to match your preferred formatting
    name: currencyCode,
  );
  return formatter.format(amount);
}

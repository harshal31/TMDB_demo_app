import 'package:intl/intl.dart';

extension FormatCurrency on int? {
  String get formatCurrencyInDollar {
    final NumberFormat currencyFormat = NumberFormat.currency(symbol: '\$');
    return (this == null || this == 0) ? "-" : currencyFormat.format(this);
  }
}

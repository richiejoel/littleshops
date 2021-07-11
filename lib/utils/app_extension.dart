import 'fomatter.dart';

extension PriceParsing on double {
  String toPrice() {
    return "\$ ${UtilFormatter.formatNumber(this)}";
  }
}
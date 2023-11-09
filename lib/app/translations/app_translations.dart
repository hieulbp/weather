import 'en_US/en_us_translations.dart';
import 'vi_VN/vi_vn_translations.dart';

abstract class AppTranslation {
  static Map<String, Map<String, String>>
  translations =
  {
    'vi_VN' : viVN,
    'en_US' : enUs,
  };

}
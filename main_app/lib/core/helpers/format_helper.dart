class FormatHelper {
  FormatHelper._();

  static String formatPhone(String phone) {
    const countryCode = "+84";
    if (phone.startsWith("0")) {
      return countryCode + phone.substring(1);
    }
    return countryCode + phone;
  }

  static String reverseFormatPhone(String phone) {
    if (phone.startsWith("84")) {
      return "0${phone.substring(2)}";
    }
    return phone;
  }
}

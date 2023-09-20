import 'package:easy_localization/easy_localization.dart';

extension StringExt on String {
  String trans({List<String>? args, Map<String, String>? namedArgs, String? gender}) {
    return this.tr(args: args, namedArgs: namedArgs, gender: gender);
  }

  String removeWhitespaces() => replaceAll(RegExp('\\s+'), '');

  String initials() {
    String result = "";
    List<String> words = split(" ");
    for (var element in words) {
      if (element.trim().isNotEmpty && result.length < 2) {
        result += element[0].trim();
      }
    }
    return result.trim().toUpperCase();
  }

  String shortNameAvatar() => "https://ui-avatars.com/api/?name=$this&background=random&size=128?color=ffffff";
}

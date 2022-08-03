import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  int? get toInt {
    return int.tryParse(this);
  }

  String get valueOrNone => this;

  bool get isHtml => contains(RegExp(
      r'<(?=.*? .*?\/ ?>|br|hr|input|!--|wbr)[a-z]+.*?>|<([a-z]+).*?<\/\1>'));

  String capitalize() {
    if (length > 0) {
      return '${this[0].toUpperCase()}${substring(1)}';
    }
    return '';
  }

  String toTitleCase() {
    return convertToTitleCase(this);
  }

  DateTime toDate(String format) {
    return DateFormat(format).parse(this);
  }

  String formatStringDateTo(String formatInput, String formatOutput) {
    try {
      final date = DateFormat(formatInput).parse(this);
      return DateFormat(formatOutput).format(date);
    } catch (E) {
      return this;
    }
  }

  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName{
    return this.isNotNullEmpty;
  }

  bool get isValidPassword{
    final passwordRegExp =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    return passwordRegExp.hasMatch(this);
  }

  bool get isNotNull{
    return this!=null;
  }

  bool get isValidPhone{
    final phoneRegExp = RegExp(r'(84|\+84|0)[3|5|7|8|9]+[0-9]{8}$');
    return phoneRegExp.hasMatch(this);
  }
}

String convertToTitleCase(String text) {
  if (text.isEmpty) {
    return '';
  }

  if (text.length <= 1) {
    return text.toUpperCase();
  }

  // Split string into multiple words
  final words = text.split(' ');

  // Capitalize first letter of each words
  final capitalizedWords = words.map((word) {
    if (word.trim().isNotEmpty) {
      final firstLetter = word.trim().substring(0, 1).toUpperCase();
      final remainingLetters = word.trim().substring(1);

      return '$firstLetter$remainingLetters';
    }
    return '';
  });

  // Join/Merge all words back to one String
  return capitalizedWords.join(' ');
}

extension StringCantNullExtension on String? {
  bool get isNotNullEmpty {
    return this != null && this!.trim().isNotEmpty;
  }
}

extension IntExtension on int {
  String get videoTime {
    if (this > 60) {
      final min = this ~/ 60;
      final sec = this % 60;
      return "${min.toString().padLeft(2, '0')}:"
          "${sec.toString().padLeft(2, '0')}";
    } else {
      return '00:${this}';
    }
  }

  String toShort({String? suffix}) {
    if (this > 999 && suffix != null) {
      final number = (this / 1000).toPrecision(1);
      // final pos = math.min((math.log(number)/math.ln10).truncate(), SuffixShort.length);
      // final suff = SuffixShort[pos];
      return NumberFormat.compact(
            locale: 'en',
          ).format(number * 1000) +
          suffix;
    }
    return NumberFormat.compact(
      locale: 'en',
    ).format(this);
  }
}

extension DoubleExtension on double {
  double get valueOrZero {
    return this;
  }

  double toPrecision(int fractionDigits) {
    final mod = math.pow(10, fractionDigits.toDouble()).toDouble();
    return (this * mod).round().toDouble() / mod;
  }
}

extension DoubleNullableExtension on double? {
  double get valueOrZero {
    return this ?? 0;
  }
}

extension DateTimeExt on DateTime {
  bool isSameDateHour(DateTime date) {
    return DateTime(date.year, date.month, date.day)
            .difference(DateTime(year, month, day))
            .inHours ==
        0;
  }

  DateTime roundDown({Duration delta = const Duration(seconds: 15)}) {
    return DateTime.fromMillisecondsSinceEpoch(
        millisecondsSinceEpoch - millisecondsSinceEpoch % delta.inMilliseconds);
  }

  DateTime roundUp({Duration delta = const Duration(minutes: 5)}) {
    final a = minute;
    final b = delta.inMinutes;
    var mins = delta.inMinutes * ((a + b - 1) / b);
    // print (mins);
    if (mins % 5.0 != 0) {
      mins = mins - mins % 5.0 + 5;
    }
    return DateTime(year, month, day, hour)
        .add(Duration(minutes: mins.round()));
  }

  String formatToString(String formatOutput) {
    try {
      return DateFormat(formatOutput).format(this);
    } catch (E) {
      return '';
    }
  }
}

extension ContextExtension on BuildContext {
}

extension DynamicExtendsion on dynamic {
  bool get isNotNullEmpty {
    if (this is String) {
      return this != null && this.isNotEmpty;
    } else if (this is List || this is Set || this is Map) {
      return this != null && this.isNotEmpty;
    }
    return this != null;
  }

  bool get valueOrFalse {
    return this ?? this.valueOrDefault(false);
  }

  bool valueOrDefault(bool defaultValue) {
    return this ?? defaultValue;
  }

  String valueOrEmptyString() {
    return this ?? '';
  }

  List valueOrEmptyList() {
    return this ?? [];
  }

  int get valueOrZeroInt {
    return this ?? this.valueOrIntDefault(0);
  }

  int valueOrIntDefault(int defaultValue) {
    return this ?? defaultValue;
  }

  double get valueOrZeroDouble {
    return this ?? this.valueOrDoubleDefault(0);
  }

  double valueOrDoubleDefault(double defaultValue) {
    return this ?? defaultValue;
  }

}

extension ListExtendsion on List? {
  List? removeIfNull() {
    if (this != null) {
      this!.removeWhere((element) => element == null);
    }
    return this;
  }
}

extension FirstOrNullExtension<E> on Iterable<E> {
  E? get firstOrNull => isEmpty ? null : first;

  E? firstWhereOrNull(bool Function(E) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

extension ListMapExtension<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}

///Usage:
/// _productModel?.let((productModel) {
///     String url = await ActionLink().generateActionLink(
///         ActionType.MARKETDETAIL, productModel.id, productModel.url!);
///     Utils.shareLink(url);
///    });
extension ScopeFunctionsForObject<T extends Object> on T {
  ReturnType let<ReturnType>(ReturnType Function(T self) operationFor) {
    return operationFor(this);
  }

  T also(void Function(T self) operationFor) {
    operationFor(this);
    return this;
  }
}

ReturnType run<ReturnType>(ReturnType Function() operation) {
  return operation();
}

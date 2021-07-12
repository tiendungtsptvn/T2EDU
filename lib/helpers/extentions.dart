import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:fixnum/fixnum.dart' as $fixnum;

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}

extension CurrencyFormat on num {
  String formatPrice(
      {int decimalDigits = 2,
        bool convertToThounsand = false,
        bool trimBilion = false,
        bool getAbs = false,

        /// If set to true, function will remove the .00 at the last of value
        /// Eg 69.00 -> 69
        bool trimZero = false,
        bool zeroToEmpty = false}) {
    var value = this ?? 0;
    if (convertToThounsand) {
      value = value / 1000;
    }

    if (trimBilion) {
      value = value / 1000000000;
    }

    if (trimZero) {
      if (value == value.round().toDouble()) {
        decimalDigits = 0;
      }
    }

    if (zeroToEmpty && value == 0) {
      return '';
    }

    final NumberFormat format = NumberFormat.currency(
        locale: 'en-US', symbol: '', decimalDigits: decimalDigits);
    String abs = "";

    if (value > 0 && getAbs) {
      abs = "+";
    }

    return abs + format.format(value);
  }

  // Format khối lượng, tiền
  String formatVolume(
      {double unit = 1, int decimalDigits = 0, bool zeroToEmpty = false}) {
    var value = this ?? 0;
    if (zeroToEmpty && value == 0) {
      return '';
    }

    final NumberFormat format = NumberFormat.currency(
        locale: 'en-US', symbol: '', decimalDigits: decimalDigits);
    String result = this == null ? '0' : format.format(this / unit);
    return result;
  }

  // Format tỷ lệ
  String formatRate(int decimalDigits) {
    int decDigitsToFormat = decimalDigits;

    var roundVal = this.roundToDouble();
    if (roundVal == this) {
      decDigitsToFormat = 0;
    }

    final NumberFormat format = NumberFormat.currency(
        locale: 'en-US', symbol: '', decimalDigits: decDigitsToFormat);
    String result = this == null ? '0' : format.format(this);
    return result;
  }

  double toZero() {
    return this == null ? 0 : this;
  }

  double compareAndGet(num value) {
    return this > value ? this : value;
  }

  double isDouble(dynamic value) {
    return double.parse(value) is double ? double.parse(value) : 0;
  }
}

extension VolumeFormat on $fixnum.Int64 {
  String formatVolume() {
    final NumberFormat format =
    NumberFormat.currency(locale: 'en-US', symbol: '', decimalDigits: 0);
    String result = this == null ? '0' : format.format(this);
    return result;
  }
}

extension AmountFormat on String {
  num formatAmount() {
    if (this.isEmpty) {
      return 0;
    }
    return num.tryParse(this.replaceAll('.', ''));
  }

  double toDecimal() {
    if (this.isEmpty) {
      return 0;
    }
    return double.tryParse(this.replaceAll(',', ''));
  }

  int toInt() {
    if (this.isEmpty) {
      return 0;
    }
    return int.tryParse(this.replaceAll(',', ''));
  }

}

extension Money on double {
  String toMoney() {
    final NumberFormat format =
    NumberFormat.currency(locale: 'vi-VN', symbol: '');
    String result = format.format(this);
    return result;
  }

  double toZero() {
    return this == null ? 0 : this;
  }

  double multiplication(num x, {dynamic def}) {
    return this != null ? this * x : def ?? null;
  }

  double roundDouble({
    int places = 2,
  }) {
    double mod = pow(10.0, places);
    return ((this * mod).round().toDouble() / mod);
  }

  // Trim to double
  double trimToDouble({double multipleNum = 1000}) {
    double roundedVal = ((this * multipleNum).roundToDouble()) / multipleNum;
    return roundedVal;
  }

  // Trim to int
  int trimToInt({double multipleNum = 1000}) {
    int intVal = trimToDouble(multipleNum: multipleNum).toInt();
    return intVal;
  }
}

extension DateTimeFormat on num {
  String formatDate() {
    if (this == 0) {
      return '-';
    }

    final String dateString = toStringAsFixed(0);
    if (dateString.length != 8) {
      return dateString;
    }

    return dateString.substring(6, 8) +
        '/' +
        dateString.substring(4, 6) +
        '/' +
        dateString.substring(0, 4);
  }

  String formatDateIso() {
    if (this == null) {
      return '';
    }
    final DateFormat output = DateFormat('dd/MM/yyyy');
    return output.format(DateTime.fromMillisecondsSinceEpoch(toInt()));
  }

  String formatTimeIso() {
    if (this == null) {
      return '';
    }
    final DateFormat output = DateFormat('HH:mm:ss');
    return output.format(DateTime.fromMillisecondsSinceEpoch(toInt()));
  }

  String formatFullDateIso() {
    if (this == null) {
      return '';
    }
    final DateFormat output = DateFormat('dd/MM/yyyy HH:mm:ss');
    return output.format(DateTime.fromMillisecondsSinceEpoch(toInt()));
  }

  String formatTime() {
    String matTimeSt = toStringAsFixed(0);

    if (matTimeSt.length != 5 && matTimeSt.length != 6) {
      return matTimeSt;
    }

    if (matTimeSt.length == 5) {
      matTimeSt = ':' + matTimeSt;
    }

    return matTimeSt.substring(0, 2) +
        ':' +
        matTimeSt.substring(2, 4) +
        ':' +
        matTimeSt.substring(4, 6);
  }
}

extension FormatDate on DateTime {
  String formatTimeServer({String format = "yyyyMMdd"}) {
    if (this == null) return null;

    final DateFormat formatter = DateFormat(format);
    return formatter.format(this);
  }

  String formatDDMMYYY({String def}) {
    if (this == null) return def ?? "";

    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(this);
  }

  String formatDDMMYYY2({String def}) {
    if (this == null) return def ?? "";

    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(this);
  }

  int formatTimeServerToNum() {
    if (this == null) return null;

    final DateFormat formatter = DateFormat('yyyyMMdd');
    return int.tryParse(formatter.format(this));
  }
}

extension ListGetExtension<T> on List<T> {
  T tryGet(int index) {
    return this.isEmpty || index < 0 || index >= this.length
        ? null
        : this[index];
  }

  T getFromIndex(int index) =>
      this != null && this.length > index ? this[index] : null;
}

extension StringFormat on String {
  bool isString() {
    return RegExp('[a-zA-Z]').hasMatch(this);
  }

  String formatDecimal(String s) {
    return s.replaceAll(",", "");
  }

  String formatToDDMMYYYY() {
    if (this == null || this.isEmpty) return "";
    DateTime dateTime = DateTime.parse(this);
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateTime);
  }

  bool isDerivative() {
    return this.contains('D');
  }

  String replaceSemicolon({String fromDecimal = ",", String toDecimal = ""}) {
    return this != null && this.isNotEmpty
        ? this.replaceAll(fromDecimal, toDecimal)
        : "";
  }

  bool isAlphanumeric() {
    if (this == null || this.isEmpty) return true;
    final notAlphanumeric = RegExp('[^a-zA-Z0-9 .,]');
    int numberChar = notAlphanumeric.allMatches(this).length;
    return numberChar == 0;
  }
}

extension booleanFormat on bool {
  bool togger() {
    return this != null ? !this : true;
  }
}

extension MyDateUtils on DateTime {
  DateTime copyWith(
      {int year,
        int month,
        int day,
        int hour,
        int minute,
        int second,
        int millisecond,
        int microsecond}) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }
}

extension TimeOfDayFormat on TimeOfDay {
  /// return 1 if greater, 0 if equals else smaller
  int compareTo(TimeOfDay other) {
    if(this.hour - other.hour == 0){
      return this.minute - other.minute;
    }else return this.hour - other.hour;
  }
}
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppUtils {
  BuildContext context;
  AppUtils(this.context);

  void showAlert(String? message) {
    if (message != null && message.isNotEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(8),
            content: Text(message),
          ),
        );
    }
  }

  static String convertDateFormat(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  static OutlineInputBorder buildInputBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xffE5E7EB)),
      borderRadius: BorderRadius.circular(5),
    );
  }

  static String shortenText(String nameRaw,
      {int nameLimit = 10, bool addDots = false}) {
    //* Limiting val should not be gt input length (.substring range issue)
    final max = nameLimit < nameRaw.length ? nameLimit : nameRaw.length;
    //* Get short name
    final name = nameRaw.substring(0, max);
    //* Return with '..' if input string was sliced
    if (addDots && nameRaw.length > max) return name + '..';
    return name;
  }

  static String generateRandomName(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  static String replaceCharAt(
      {required String text, required String char, required int index}) {
    final chars = text.characters.toList();
    chars[index] = char;
    return chars.join('');
  }
}

extension FormatDateExtension on DateTime {
  DateTime formattedDate(DateTime dateTime) {
    return DateFormat('').parse('inputString');
  }
}

extension TimeOfDayExtension on TimeOfDay {
  TimeOfDay add({int hour = 0, int minute = 0}) {
    return replacing(hour: this.hour + hour, minute: this.minute + minute);
  }

  TimeOfDay addMinutes(int minutes) {
    if (minutes == 0) {
      return this;
    } else {
      int mofd = hour * 60 + minute;
      int newMofd = ((minutes % 1440) + mofd + 1440) % 1440;
      if (mofd == newMofd) {
        return this;
      } else {
        int newHour = newMofd ~/ 60;
        int newMinute = newMofd % 60;
        return TimeOfDay(hour: newHour, minute: newMinute);
      }
    }
  }

  String time() {
    return hour.toString().padLeft(2, '0') +
        ':' +
        minute.toString().padLeft(2, '0');
  }

  static TimeOfDay parseTime(String time) {
    final timeParts = time.split(':');
    return TimeOfDay(
      hour: int.parse(timeParts[0]),
      minute: int.parse(timeParts[1]),
    );
  }

  TimeOfDay sub(TimeOfDay other) {
    double _doubleYourTime =
        other.hour.toDouble() + (other.minute.toDouble() / 60);
    double _doubleNowTime = hour.toDouble() + (minute.toDouble() / 60);

    double _timeDiff = _doubleYourTime - _doubleNowTime;

    final _hr = _timeDiff.truncate();
    int _minute = ((_timeDiff - _timeDiff.truncate()) * 60).truncate();

    if (_hr <= 0 && _minute <= 0) {
      return const TimeOfDay(hour: 0, minute: 0);
    }
    return TimeOfDay(hour: _hr, minute: _minute);
  }

  bool equals(TimeOfDay otherDate) {
    return hour == otherDate.hour && minute == otherDate.minute;
  }
}

extension DurationFormatter on Duration {
  /// Converts the duration into a readable string
  /// 05:15
  String toHoursMinutes() {
    String twoDigitMinutes = _toTwoDigits(inMinutes.remainder(60));
    return "${_toTwoDigits(inHours)}:$twoDigitMinutes";
  }

  /// Converts the duration into a readable string
  /// 05:15:35
  String toHoursMinutesSeconds() {
    String twoDigitMinutes = _toTwoDigits(inMinutes.remainder(60));
    String twoDigitSeconds = _toTwoDigits(inSeconds.remainder(60));
    return "${_toTwoDigits(inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  String _toTwoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  // 01:01:01
  String format() => '$this'.split('.')[0].padLeft(8, '0');

  static Duration parseTime(String time) {
    final timeParts = time.split(':');
    return Duration(
      hours: int.parse(timeParts[0]),
      minutes: int.parse(timeParts[1]),
    );
  }

  Duration diff(Duration other) {
    return Duration(seconds: other.inSeconds - inSeconds);
  }
}

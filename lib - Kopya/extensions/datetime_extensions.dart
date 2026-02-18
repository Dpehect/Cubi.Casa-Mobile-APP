extension DateTimeExtensions on DateTime {
  String get formattedDate {
    return '$year-$month-$day';
  }

  String get formattedDateTime {
    return '$year-$month-$day $hour:$minute:$second';
  }

  String get formattedTime {
    return '$hour:$minute';
  }

  String get formattedDateWithMonth {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '$day ${months[month - 1]} $year';
  }

  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year && month == tomorrow.month && day == tomorrow.day;
  }

  bool get isPast {
    return isBefore(DateTime.now());
  }

  bool get isFuture {
    return isAfter(DateTime.now());
  }

  int get daysAgo {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }

  int get daysUntil {
    return difference(DateTime.now()).inDays;
  }

  String get timeAgo {
    final duration = DateTime.now().difference(this);
    
    if (duration.inSeconds < 60) {
      return '${duration.inSeconds}s ago';
    } else if (duration.inMinutes < 60) {
      return '${duration.inMinutes}m ago';
    } else if (duration.inHours < 24) {
      return '${duration.inHours}h ago';
    } else if (duration.inDays < 30) {
      return '${duration.inDays}d ago';
    } else {
      return formattedDateWithMonth;
    }
  }
}

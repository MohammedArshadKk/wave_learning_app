String calculateTimeDiff(String time) {
  final now = DateTime.now();
  final date = DateTime.parse(time);
  final diff = now.difference(date);

  if (diff.inDays > 0 && diff.inDays < 7) {
    return '${diff.inDays} days ago';
  } else if (diff.inDays >= 7 && diff.inDays < 30) {
    return '${diff.inDays ~/ 7} weeks ago';
  } else if (diff.inDays >= 30 && diff.inDays < 365) {
    return '${diff.inDays ~/ 30} months ago';
  } else if (diff.inDays >= 365) {
    return '${diff.inDays ~/ 365} years ago';
  } else if (diff.inHours > 0) {
    return '${diff.inHours} hours ago';
  } else {
    return '${diff.inMinutes} minutes ago';
  }
}

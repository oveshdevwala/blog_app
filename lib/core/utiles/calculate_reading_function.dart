int calculateReadingTime(String content) {
  var wordCount = content.split(' ').length;
  final readingTime = wordCount / 225;
  return readingTime.ceil();
}

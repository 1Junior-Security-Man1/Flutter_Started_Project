String parseTaskIdFromHtml(String content) {
  try {
    const start = '/task/';
    const end = '">';

    final startIndex = content.indexOf(start);
    final endIndex = content.indexOf(end, startIndex + start.length);

    return content.substring(startIndex + start.length, endIndex);
  }catch(e) {
    return "";
  }
}
String formatDate(DateTime date) {
  return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}

String formatDateToYYYYMMDD(DateTime date){

  // 각 부분 추출 및 두 자릿수로 변환
  String year = date.year.toString();
  String month = date.month.toString().padLeft(2, '0');
  String day = date.day.toString().padLeft(2, '0');
  String formattedDate = '$year.$month.$day';

  return formattedDate;
}
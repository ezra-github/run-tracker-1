import 'package:intl/intl.dart';

class TextFormatter{
  
  static String getMonth(DateTime date){
    String formattedDate = DateFormat('MMM').format(date);
    return formattedDate; 
  }

  static String getDate(DateTime date){
    String formattedDate = DateFormat('dd').format(date);
    return formattedDate;
  }

  static String getStartDate(DateTime date){
    String formattedDate = DateFormat('h:mma').format(date);
    return formattedDate;
  }

  static String getEndDate(DateTime date){
    String formattedDate = DateFormat('h:mma').format(date);
    return formattedDate;
  }

  
}
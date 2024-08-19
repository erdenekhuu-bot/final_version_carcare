import 'package:google_maps_flutter/google_maps_flutter.dart';
class Store {
  static int confirmationId = 0;
  static String remote_accessToken = '';
  static String accessToken = '';
  static List<LatLng> location = [];
  static String storeUsername = '';
  static String storePhone = '';
  static String storePassword = '';
  static double amount = 0;
  static bool month = true;
  static List<LatLng> Addressing = [];
  static List<String> schedule = [];
  static String storeShopName = '';
  static String tempToken='';

  static String convertPhone(String phone) {
    return phone.length == 8
        ? phone.substring(0, 4) + ' - ' + phone.substring(4)
        : phone;
  }

  static String Divide(String phone){
    return phone.split(' ')[0];
  }

  static String filter(String phone) {
    if (phone.length == 7) {
      return phone.substring(0, 7);
    } else {
      return phone.substring(0, 8);
    }
  }

  static String convertPM(String time) {
    try {
      String rightTime = '';
      if(time.length >= 2){
        switch (time.substring(0, 2)) {
          case '00':
            rightTime = '00:00';
            break;
          case '01':
            rightTime = '13:00';
            break;
          case '02':
            rightTime = '14:00';
            break;
          case '03':
            rightTime = '15:00';
            break;
          case '04':
            rightTime = '16:00';
            break;
          case '05':
            rightTime = '17:00';
            break;
          case '06':
            rightTime = '18:00';
            break;
          case '07':
            rightTime = '19:00';
            break;
          case '08':
            rightTime = '20:00';
            break;
          case '09':
            rightTime = '21:00';
            break;
          case '10':
            rightTime = '22:00';
            break;
          case '11':
            rightTime = '23:00';
            break;
          case '12':
            rightTime = '24:00';
            break;
          default:
            rightTime = '00:00';
        }
      }
      return rightTime;
    } catch (error) {
      return error.toString();
    }
  }

  static String timePM(String arg){
    int result=0;
    if(arg.length >= 2){
      result=int.parse(arg.substring(0,2))+12;
    }
    return result.toString().length < 2 ? '0'+result.toString()+':00' : result.toString()+':00';
  }

  static String timeAM(String arg){
    int result=0;
    if(arg.length >= 2){
      result=int.parse(arg.substring(0,2));
    }
    return result.toString().length < 2 ? '0'+result.toString()+':00' : result.toString()+':00';
  }

  static String splitTime(String args){
    if(args.length >= 16){
      return args.substring(11,16);
    }
    return '';
  }


  static int colorsRange(String services) {
    Map<String, int> serviceColors = {
      'Агрегат': 0xFFFF0000, // Red
      'Кузов': 0xFFFF7F00, // Orange
      'Дугуй': 0xFFFFFF00, // Yellow
      'Угаалга': 0xFF00FF00, // Green
      'Мотоцикл': 0xFF00FFFF, // Cyan
      'Машин худалдаа': 0xFF0000FF, // Blue
      'Сэлбэг худалдаа': 0xFF8B00FF, // Indigo
      'Авто будаг': 0xFFFF00FF, //
      'Мотоцикл' : 0xFF3043d1,
      'Авто шил' : 0xFF2ab7eb,
      'Хуулга' : 0xFF4ebd35,
      'Суудлын бүрээс' : 0xFF7439d4,
    };

    if (serviceColors.containsKey(services)) {
      return serviceColors[services]!;
    }
    return 0;
  }

  static bool isDayEnabled(DateTime day) {
    return day.isBefore(DateTime.now().add(const Duration(days: 1)));
  }

  static List<LatLng> filterAddress=[];
  static List<dynamic> filterShops=[];
  static List<dynamic> filterSubdirServices=[];
  static List<dynamic> filterServices=[];
  static List<dynamic> swappingCategory=[];

  static String filtering(String img){
      return 'https://d3v7ghkqvtko5q.cloudfront.net/'+img;
  }
}

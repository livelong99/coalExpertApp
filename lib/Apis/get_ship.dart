import 'dart:async';
import 'package:http/http.dart' as http;

class GetShip {
  static Future getShips() {
    return http.get(Uri.parse("https://coal-expert-back.herokuapp.com/get-ship-data"));
  }
}
import 'dart:async';
import 'package:http/http.dart' as http;

class GetOrders {
  static Future getOrders(uid) {
    return http.get(Uri.parse("https://coal-expert-back.herokuapp.com/get-orders?uid=" + uid));
  }
}
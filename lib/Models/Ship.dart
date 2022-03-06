class Ship {
  String id;
  String name;
  String origin;
  double quantity;
  double rate;
  String quality;
  String destination;
  String link;
  String add1;
  String add2;

  Ship.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        origin = json['originCntry'],
        rate = json['rate'].toDouble(),
        quality = json['gnar'],
        destination = json['destination'],
        quantity = json['quantity'].toDouble(),
        add1 = json.containsKey("add1") ? json['add1'] : "",
        add2 = json.containsKey("add2") ? json['add2'] : "",
        link = json['reportLink'];

  Map toJson() {
    return {'id': id, 'name': name, 'originCntry': origin, 'rate': rate,'gnar': quality, 'destination': destination, 'quantity': quantity, 'reportLink': link, 'add1': add1, 'add2': add2};
  }
}
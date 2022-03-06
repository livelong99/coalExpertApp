class UserM {
  String id;
  String Cname;
  String Email;
  String contact;
  String GST;
  String ProfilePic;
  bool TnC;

  void setTnC(bool TnC){
    this.TnC = TnC;
  }

  UserM.fromParams(String id, String Cname, String Email, String contact, String GST, bool TnC)
    : this.id = id,
        this.Cname = Cname,
        this.Email = Email,
        this.contact = contact,
        this.GST = GST,
        this.TnC = TnC,
        this.ProfilePic = "images";



   UserM.fromJson(Map json)
      : id = json['id'],
        Cname = json['Cname'],
        Email = json['Email'],
        contact = json['Contact'],
        GST = json['GST'],
        TnC = json['TnC'],
        ProfilePic = json['ProfilePic'];

  Map toJson() {
    return {'id': id, 'Cname': Cname, 'Email': Email, 'Contact': contact, 'GST': GST, 'ProfilePic': ProfilePic, 'TnC': TnC};
  }
}
class User {
  int id;
  String name;
  String? secondName;
  String? phone;

  User({
    required this.id,
    required this.name,
    required this.secondName,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      secondName: json['second_name'],
      phone: json['phone'],
    );
  }
}

class UserData {
  User user;
  List qarzlar;
  double jamiOlinganQarzlar;
  double jamiTulanganQarzlar;
  double qolganQarz;

  UserData({
    required this.user,
    required this.qarzlar,
    required this.jamiOlinganQarzlar,
    required this.jamiTulanganQarzlar,
    required this.qolganQarz,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      user: User.fromJson(json['user']),
      qarzlar: List.from(json['qarzlar']),
      jamiOlinganQarzlar: (json['jami_olingan_qarzlar'] ?? 0) * 1.0,
      jamiTulanganQarzlar: (json['jami_tulangan_qarzlar'] ?? 0) * 1.0,
      qolganQarz: (json['qolgan_qarz'] ?? 0) * 1.0,
    );
  }
}

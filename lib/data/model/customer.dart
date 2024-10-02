class Customer {
  List<Points> points;
  String? phone;
  String? name;
  String? email;
  String? password;
  List<Addresses> addresses;

  Customer({
    required this.addresses,
    required this.points,
    this.phone,
    this.name,
    this.password,
    this.email,
  });

  factory Customer.fromJson(Map<String, dynamic> map) {
    return Customer(
      addresses: (map['addresses'] as List<dynamic>)
          .map((e) => Addresses.fromJson(e as Map<String, dynamic>))
          .toList(),
      points: (map['points'] as List<dynamic>)
          .map((e) => Points.fromJson(e as Map<String, dynamic>))
          .toList(),
      phone: map['phone'],
      name: map['fullName'],
      password: map['password'],
      email: map['email'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Customer &&
          runtimeType == other.runtimeType &&
          points == other.points &&
          phone == other.phone &&
          name == other.name &&
          email == other.email &&
          password == other.password &&
          addresses == other.addresses;

  @override
  int get hashCode =>
      points.hashCode ^
      phone.hashCode ^
      name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      addresses.hashCode;

  @override
  String toString() {
    return 'Customer{points: $points, phone: $phone, name: $name, email: $email, password: $password, addresses: $addresses}';
  }
}

class Points {
  String id;
  int point;

  Points({required this.point, required this.id});

  factory Points.fromJson(Map<String, dynamic> map) {
    return Points(point: map['point'], id: map['_id']);
  }

  @override
  String toString() {
    return 'Points{id: $id, point: $point}';
  }
}

class Addresses {
  String province;
  String district;
  String id;
  String detailedAddress;

  Addresses(
      {required this.province,
      required this.district,
      required this.id,
      required this.detailedAddress});

  factory Addresses.fromJson(Map<String, dynamic> map) {
    return Addresses(
        province: map['province'] ?? '',
        district: map['district'] ?? '',
        id: map['_id'],
        detailedAddress: map['detailAddress']);
  }

  @override
  String toString() {
    return '$detailedAddress, $district, $province';
  }
}

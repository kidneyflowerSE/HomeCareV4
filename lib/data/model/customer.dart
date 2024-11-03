class Customer {
  List<Points> points;
  String phone;
  String name;
  String email;
  String password;
  List<Addresses> addresses;

  Customer({
    required this.addresses,
    required this.points,
    required this.phone,
    required this.name,
    required this.password,
    required this.email,
  });

  factory Customer.fromJson(Map<String, dynamic> map) {
    return Customer(
      addresses: (map['addresses'] as List<dynamic>?)
          ?.map((e) => Addresses.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],  // Default to empty list if null
      points: (map['points'] as List<dynamic>?)
          ?.map((e) => Points.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],  // Default to empty list if null
      phone: map['phone'] ?? '',  // Default to empty string if null
      name: map['fullName'] ?? '',  // Default to empty string if null
      password: map['password'] ?? '',  // Default to empty string if null
      email: map['email'] ?? '',  // Default to empty string if null
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
      province: map['province'] ?? '',  // Default to empty string if null
      district: map['district'] ?? '',  // Default to empty string if null
      id: map['_id'] ?? '',  // Default to empty string if null
      detailedAddress: map['detailAddress'] ?? '',  // Default to empty string if null
    );
  }


  @override
  String toString() {
    return '$detailedAddress, $district, $province';
  }
}

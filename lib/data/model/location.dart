class Location {
  String province;
  List<District> districts;

  Location({
    required this.province,
    required this.districts,
  });

  // Hàm factory để ánh xạ từ JSON
  factory Location.fromJson(Map<String, dynamic> map) {
    return Location(
      province: map['province'] ?? '',
      districts: (map['districts'] as List<dynamic>)
          .map((districtJson) => District.fromJson(districtJson))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'Location{province: $province, districts: $districts}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Location &&
          runtimeType == other.runtimeType &&
          province == other.province &&
          districts == other.districts;

  @override
  int get hashCode => province.hashCode ^ districts.hashCode;
}

class District {
  String districtName;
  String districtId;

  District({
    required this.districtName,
    required this.districtId,
  });

  // Hàm factory để ánh xạ từ JSON
  factory District.fromJson(Map<String, dynamic> map) {
    return District(
      districtName:
          map['district'] ?? '', // Kiểm tra giá trị null của districtName
      districtId: map['_id'] ?? '', // Kiểm tra giá trị null của districtId
    );
  }

  @override
  String toString() {
    return 'District{districtName: $districtName, districtId: $districtId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is District &&
          runtimeType == other.runtimeType &&
          districtName == other.districtName &&
          districtId == other.districtId;

  @override
  int get hashCode => districtName.hashCode ^ districtId.hashCode;
}

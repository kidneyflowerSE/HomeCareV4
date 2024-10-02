class Services {
  String title;
  int basicPrice;
  String extraFee;
  int overTimePriceHelper;
  int overTimePriceCustomer;
  String description;
  String status;

  Services(
      {required this.title,
      required this.basicPrice,
      required this.extraFee,
      required this.overTimePriceHelper,
      required this.overTimePriceCustomer,
      required this.description,
      required this.status});

  factory Services.fromJson(Map<String, dynamic> map) {
    return Services(
        title: map['title'],
        basicPrice: map['basicPrice'],
        extraFee: map['extraFee'],
        overTimePriceHelper: map['overTimePrice_Helper'],
        overTimePriceCustomer: map['overTimePrice_Customer'],
        description: map['description'],
        status: map['status']);
  }

  @override
  String toString() {
    return 'Services{title: $title, basicPrice: $basicPrice, extraFee: $extraFee, overTimePriceHelper: $overTimePriceHelper, overTimePriceCustomer: $overTimePriceCustomer, description: $description, status: $status}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Services &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          basicPrice == other.basicPrice &&
          extraFee == other.extraFee &&
          overTimePriceHelper == other.overTimePriceHelper &&
          overTimePriceCustomer == other.overTimePriceCustomer &&
          description == other.description &&
          status == other.status;

  @override
  int get hashCode =>
      title.hashCode ^
      basicPrice.hashCode ^
      extraFee.hashCode ^
      overTimePriceHelper.hashCode ^
      overTimePriceCustomer.hashCode ^
      description.hashCode ^
      status.hashCode;
}

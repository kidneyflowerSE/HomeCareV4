class Services {
  String title;
  String id;
  int basicPrice;
  String extraFee;
  int overTimePriceHelper;
  int overTimePriceCustomer;
  String description;
  String status;

  Services(
      {required this.title,
      required this.id,
      required this.basicPrice,
      required this.extraFee,
      required this.overTimePriceHelper,
      required this.overTimePriceCustomer,
      required this.description,
      required this.status});

  factory Services.fromJson(Map<String, dynamic> map) {
    return Services(
      title: map['title'] ?? 'Unknown Title',  // Default value for title
      id: map['_id'] ?? 'Unknown ID',          // Default value for id
      basicPrice: map['basicPrice'] ?? 0,      // Default to 0 if not present
      extraFee: map['extraFee'] ?? '0',        // Default to '0' if not present
      overTimePriceHelper: map['overTimePrice_Helper'] ?? 0, // Default to 0
      overTimePriceCustomer: map['overTimePrice_Customer'] ?? 0, // Default to 0
      description: map['description'] ?? 'No description', // Default message
      status: map['status'] ?? 'inactive', // Default to 'inactive'
    );
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

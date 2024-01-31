class UserDetails{
  String? id;
  String fullName;
  String mobileNumber;
  String buildingName;
  String street;
  String state;
  String pinCode;
  String city;

  UserDetails({
    this.id,
    required this.fullName,
    required this.mobileNumber,
    required this.buildingName,
    required this.street,
    required this.state,
    required this.pinCode,
    required this.city
  });

  factory UserDetails.fromMap(Map<String,dynamic> e) => UserDetails(
      id: e["id"],
      fullName: e["fullName"],
      mobileNumber: e["mobileNumber"],
      buildingName: e["buildingName"],
      street: e["street"],
      state: e["state"],
      pinCode: e["pinCode"],
      city: e["city"]);

  Map<String,dynamic> toMap() {
    return {
      "id" : id,
      "fullName" : fullName,
      "mobileNumber" : mobileNumber,
      "buildingName" : buildingName,
      "street" : street,
      "state" : state,
      "pinCode" : pinCode,
      "city" : city
    };
  }

}
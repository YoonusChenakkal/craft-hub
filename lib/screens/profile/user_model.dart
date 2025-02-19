// class UserModel {
//   final int id;
//   final String name;
//   final String contactNumber;
//   final String whatsappNumber;
//   final String email;
//   final String? otp;
//   final String displayImage;
//   final bool isActive;
//   final bool isApproved;
//   final String? otpExpiry;
//   final String createdAt;
//   final bool isFullyActive;

//   UserModel({
//     required this.id,
//     required this.name,
//     required this.contactNumber,
//     required this.whatsappNumber,
//     required this.email,
//     this.otp,
//     required this.displayImage,
//     required this.isActive,
//     required this.isApproved,
//     this.otpExpiry,
//     required this.createdAt,
//     required this.isFullyActive,
//   });

//   // Factory constructor to create a UserModel from JSON
//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['id'],
//       name: json['name'],
//       contactNumber: json['contact_number'],
//       whatsappNumber: json['whatsapp_number'],
//       email: json['email'],
//       otp: json['otp'],
//       displayImage: json['display_image'],
//       isActive: json['is_active'],
//       isApproved: json['is_approved'],
//       otpExpiry: json['otp_expiry'],
//       createdAt: json['created_at'],
//       isFullyActive: json['is_fully_active'],
//     );
//   }
// }

class UserModel {
  final int id;
  final String username;
  final String email;
  final bool isVerified;
  final bool isActive;
  final bool isStaff;
  final List<Address> addresses;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.isVerified,
    required this.isActive,
    required this.isStaff,
    required this.addresses,
  });

  // Factory method to create a User object from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    var addressList = json['addresses'] as List;
    List<Address> addresses =
        addressList.map((address) => Address.fromJson(address)).toList();

    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      isVerified: json['is_verified'],
      isActive: json['is_active'],
      isStaff: json['is_staff'],
      addresses: addresses,
    );
  }

  // Method to convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'is_verified': isVerified,
      'is_active': isActive,
      'is_staff': isStaff,
      'addresses': addresses.map((address) => address.toJson()).toList(),
    };
  }
}

class Address {
  final int id;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String country;
  final String pincode;
  final bool isPrimary;
  final String createdAt;
  final String updatedAt;

  Address({
    required this.id,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.country,
    required this.pincode,
    required this.isPrimary,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create an Address object from JSON
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      addressLine1: json['address_line1'],
      addressLine2: json['address_line2'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      pincode: json['pincode'],
      isPrimary: json['is_primary'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  // Method to convert Address object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address_line1': addressLine1,
      'address_line2': addressLine2,
      'city': city,
      'state': state,
      'country': country,
      'pincode': pincode,
      'is_primary': isPrimary,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

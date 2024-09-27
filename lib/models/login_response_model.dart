// import 'dart:convert';
//
// LoginResponseModel loginResponseModelFromJson(String str) =>
//     LoginResponseModel.fromJson(json.decode(str));
//
// String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());
//
// class LoginResponseModel {
//   final bool status;
//   final String message;
//   final String fcm;
//   final String id;
//   final String userName;
//   final String email;
//   final bool verification;
//   final String phone;
//   final bool phoneVerification;
//   final String userType;
//   final String profile;
//   final String address;
//   final String userToken;
//
//   LoginResponseModel({
//     required this.status,
//     required this.message,
//     required this.fcm,
//     required this.id,
//     required this.userName,
//     required this.email,
//     required this.verification,
//     required this.phone,
//     required this.phoneVerification,
//     required this.userType,
//     required this.profile,
//     required this.address,
//     required this.userToken,
//   });
//
//   factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
//         status: json["status"],
//         message: json["message"],
//         fcm: json["fcm"],
//         id: json["_id"],
//         userName: json["userName"],
//         email: json["email"],
//         verification: json["verification"],
//         phone: json["phone"],
//         phoneVerification: json["phoneVerification"],
//         userType: json["userType"],
//         profile: json["profile"],
//         address: json["address"],
//         userToken: json["userToken"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "fcm": fcm,
//         "_id": id,
//         "userName": userName,
//         "email": email,
//         "verification": verification,
//         "phone": phone,
//         "phoneVerification": phoneVerification,
//         "userType": userType,
//         "profile": profile,
//         "address": address,
//         "userToken": userToken,
//       };
// }
import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  final bool status;
  final String message;
  final String? fcm;
  final String? id;
  final String? userName;
  final String? email;
  final bool verification;
  final String? phone;
  final bool phoneVerification;
  final String? userType;
  final String? profile;
  final String? address;
  final String? userToken;

  LoginResponseModel({
    required this.status,
    required this.message,
    this.fcm,
    this.id,
    this.userName,
    this.email,
    required this.verification,
    this.phone,
    required this.phoneVerification,
    this.userType,
    this.profile,
    this.address,
    this.userToken,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        status: json["status"] ?? false,
        message: json["message"] ?? '',
        fcm: json["fcm"] ?? '',
        id: json["_id"] ?? '',
        userName: json["userName"] ?? '',
        email: json["email"] ?? '',
        verification: json["verification"] ?? false,
        phone: json["phone"] ?? '',
        phoneVerification: json["phoneVerification"] ?? false,
        userType: json["userType"] ?? '',
        profile: json["profile"] ?? '',
        address: json["address"] ?? '',
        userToken: json["userToken"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "fcm": fcm ?? '',
        "_id": id ?? '',
        "userName": userName ?? '',
        "email": email ?? '',
        "verification": verification,
        "phone": phone ?? '',
        "phoneVerification": phoneVerification,
        "userType": userType ?? '',
        "profile": profile ?? '',
        "address": address ?? '',
        "userToken": userToken ?? '',
      };
}

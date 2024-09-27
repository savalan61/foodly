import 'dart:convert';

List<RestaurantsModel> restaurantsModelFromJson(String str) =>
    List<RestaurantsModel>.from(json.decode(str).map((x) => RestaurantsModel.fromJson(x)));

String restaurantsModelToJson(List<RestaurantsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RestaurantsModel {
  final String id;
  final String title;
  final String time;
  final String imageUrl;
  final List<dynamic> foods;
  final bool pickup;
  final bool delivery;
  final bool isAvailable;
  final String owner;
  final String code;
  final String logoUrl;
  final double rating;
  final String ratingCount;
  final Verification verification;
  final VerificationMessage verificationMessage;
  final Coords coords;

  RestaurantsModel({
    required this.id,
    required this.title,
    required this.time,
    required this.imageUrl,
    required this.foods,
    required this.pickup,
    required this.delivery,
    required this.isAvailable,
    required this.owner,
    required this.code,
    required this.logoUrl,
    required this.rating,
    required this.ratingCount,
    required this.verification,
    required this.verificationMessage,
    required this.coords,
  });

  factory RestaurantsModel.fromJson(Map<String, dynamic> json) => RestaurantsModel(
        id: json["_id"],
        title: json["title"],
        time: json["time"],
        imageUrl: json["imageUrl"],
        foods: List<dynamic>.from(json["foods"].map((x) => x)),
        pickup: json["pickup"],
        delivery: json["delivery"],
        isAvailable: json["isAvailable"],
        owner: json["owner"],
        code: json["code"],
        logoUrl: json["logoUrl"],
        rating: json["rating"]?.toDouble(),
        ratingCount: json["ratingCount"],
        verification: verificationValues.map[json["verification"]]!,
        verificationMessage: verificationMessageValues.map[json["verificationMessage"]]!,
        coords: Coords.fromJson(json["coords"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "time": time,
        "imageUrl": imageUrl,
        "foods": List<dynamic>.from(foods.map((x) => x)),
        "pickup": pickup,
        "delivery": delivery,
        "isAvailable": isAvailable,
        "owner": owner,
        "code": code,
        "logoUrl": logoUrl,
        "rating": rating,
        "ratingCount": ratingCount,
        "verification": verificationValues.reverse[verification],
        "verificationMessage": verificationMessageValues.reverse[verificationMessage],
        "coords": coords.toJson(),
      };
}

class Coords {
  final String id;
  final double latitude;
  final double longitude;
  final String address;
  final String title;
  final double latitudeDelta;
  final double longitudeDelta;

  Coords({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.title,
    required this.latitudeDelta,
    required this.longitudeDelta,
  });

  factory Coords.fromJson(Map<String, dynamic> json) => Coords(
        id: json["id"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        address: json["address"],
        title: json["title"],
        latitudeDelta: json["latitudeDelta"]?.toDouble(),
        longitudeDelta: json["longitudeDelta"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "title": title,
        "latitudeDelta": latitudeDelta,
        "longitudeDelta": longitudeDelta,
      };
}

enum Verification { PENDING }

final verificationValues = EnumValues({"Pending": Verification.PENDING});

enum VerificationMessage { WE_WILL_NOTIFY }

final verificationMessageValues =
    EnumValues({"We Will notify ....": VerificationMessage.WE_WILL_NOTIFY});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

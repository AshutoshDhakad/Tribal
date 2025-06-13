import 'dart:convert';

Folwers folwersFromJson(String str) => Folwers.fromJson(json.decode(str));

String folwersToJson(Folwers data) => json.encode(data.toJson());

class Folwers {
  String? status;
  List<MyFollower>? myFollowers;
  int? currentPage;
  int? perPage;
  int? total;

  Folwers({
    this.status,
    this.myFollowers,
    this.currentPage,
    this.perPage,
    this.total,
  });

  factory Folwers.fromJson(Map<String, dynamic> json) => Folwers(
    status: json["status"],
    myFollowers: (json['my_followers'] as List<dynamic>?)
        ?.map((e) => MyFollower.fromJson(e))
        .toList() ?? [],
    currentPage: json["current_page"],
    perPage: json["per_page"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": myFollowers == null
        ? []
        : List<dynamic>.from(myFollowers!.map((x) => x.toJson())),
    "current_page": currentPage,
    "per_page": perPage,
    "total": total,
  };
}

class MyFollower {
  int? id;
  dynamic firstName;
  dynamic lastName;
  String? brandName;
  String? userType;
  String? kyc;
  UserProfile? userProfile;

  MyFollower({
    this.id,
    this.firstName,
    this.lastName,
    this.brandName,
    this.userType,
    this.kyc,
    this.userProfile,
  });

  factory MyFollower.fromJson(Map<String, dynamic> json) => MyFollower(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    brandName: json["brand_name"],
    userType: json["user_type"],
    kyc: json["kyc"],
    userProfile: json["user_profile"] == null ? null : UserProfile.fromJson(json["user_profile"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "brand_name": brandName,
    "user_type": userType,
    "kyc": kyc,
    "user_profile": userProfile?.toJson(),
  };
}

class UserProfile {
  int? userId;
  String? profileImage;

  UserProfile({
    this.userId,
    this.profileImage,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    userId: json["user_id"],
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "profile_image": profileImage,
  };
}

import 'dart:convert';

Folowing folowingFromJson(String str) => Folowing.fromJson(json.decode(str));

String folowingToJson(Folowing data) => json.encode(data.toJson());

class Folowing {
  String? status;
  List<MyFollowing>? myFollowings;
  int? currentPage;
  int? perPage;
  int? total;

  Folowing({
    this.status,
    this.myFollowings,
    this.currentPage,
    this.perPage,
    this.total,
  });

  factory Folowing.fromJson(Map<String, dynamic> json) => Folowing(
    status: json["status"],
    myFollowings: (json['my_followings'] as List<dynamic>?)
        ?.map((e) =>  MyFollowing.fromJson(e))
        .toList() ?? [],
    currentPage: json["current_page"],
    perPage: json["per_page"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "my_followings": myFollowings == null
        ? []
        : List<dynamic>.from(myFollowings!.map((x) => x.toJson())),
    "current_page": currentPage,
    "per_page": perPage,
    "total": total,
  };
}

class MyFollowing {
  int? id;
  String? firstName;
  String? lastName;
  String? brandName;
  String? userType;
  String? kyc;
  UserProfile? userProfile;

  MyFollowing({
    this.id,
    this.firstName,
    this.lastName,
    this.brandName,
    this.userType,
    this.kyc,
    this.userProfile,
  });

  factory MyFollowing.fromJson(Map<String, dynamic> json) => MyFollowing(
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

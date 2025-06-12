import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  String? status;
  UserInfo? userInfo;
  List<Vertical>? verticals;

  Welcome({
    this.status,
    this.userInfo,
    this.verticals,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    status: json["status"],
    userInfo: json["userInfo"] == null ? null : UserInfo.fromJson(json["userInfo"]),
    verticals: json["verticals"] == null ? [] : List<Vertical>.from(json["verticals"]!.map((x) => Vertical.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "userInfo": userInfo?.toJson(),
    "verticals": verticals == null ? [] : List<dynamic>.from(verticals!.map((x) => x.toJson())),
  };
}

class UserInfo {
  int? id;
  String? firstName;
  String? lastName;
  dynamic brandName;
  String? userType;
  String? kyc;
  dynamic website;
  String? email;
  int? age;
  String? instagramLink;
  String? tiktokLink;
  UserProfile? userProfile;

  UserInfo({
    this.id,
    this.firstName,
    this.lastName,
    this.brandName,
    this.userType,
    this.kyc,
    this.website,
    this.email,
    this.age,
    this.instagramLink,
    this.tiktokLink,
    this.userProfile,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    brandName: json["brand_name"],
    userType: json["user_type"],
    kyc: json["kyc"],
    website: json["website"],
    email: json["email"],
    age: json["age"],
    instagramLink: json["instagram_link"],
    tiktokLink: json["tiktok_link"],
    userProfile: json["user_profile"] == null ? null : UserProfile.fromJson(json["user_profile"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "brand_name": brandName,
    "user_type": userType,
    "kyc": kyc,
    "website": website,
    "email": email,
    "age": age,
    "instagram_link": instagramLink,
    "tiktok_link": tiktokLink,
    "user_profile": userProfile?.toJson(),
  };
}

class UserProfile {
  final String? verticalIds;
  int? id;
  int? userId;
  String? profileImage;
  String? profileImgSecond;
  String? profileImgThird;
  List<dynamic>? portfolio;
  dynamic bio;
  dynamic contactEmail;
  dynamic website;
  dynamic campaign;
  String? featured;
  String? tiktokUsername;
  String? instagramUsername;
  dynamic twitter;
  dynamic youtube;
  String? isSocialVerified;
  String? isTribalRecommended;
  String? maxSocialPlatform;
  int? maxSocialFollowers;
  DateTime? dob;
  String? gender;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserProfile({
    this.id,
    this.userId,
    this.profileImage,
    this.profileImgSecond,
    this.profileImgThird,
    this.portfolio,
    this.bio,
    this.contactEmail,
    this.website,
    this.campaign,
    this.featured,
    this.tiktokUsername,
    this.instagramUsername,
    this.twitter,
    this.youtube,
    this.isSocialVerified,
    this.isTribalRecommended,
    this.maxSocialPlatform,
    this.maxSocialFollowers,
    this.dob,
    this.gender,
    this.verticalIds,
    this.createdAt,
    this.updatedAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    id: json["id"],
    userId: json["user_id"],
    profileImage: json["profile_image"],
    profileImgSecond: json["profile_img_second"],
    profileImgThird: json["profile_img_third"],
    portfolio: json["portfolio"] == null ? [] : List<dynamic>.from(json["portfolio"]!.map((x) => x)),
    bio: json["bio"],
    contactEmail: json["contact_email"],
    website: json["website"],
    campaign: json["campaign"],
    featured: json["featured"],
    tiktokUsername: json["tiktok_username"],
    instagramUsername: json["instagram_username"],
    twitter: json["twitter"],
    youtube: json["youtube"],
    isSocialVerified: json["is_social_verified"],
    isTribalRecommended: json["is_tribal_recommended"],
    maxSocialPlatform: json["max_social_platform"],
    maxSocialFollowers: json["max_social_followers"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    gender: json["gender"],
    verticalIds: json["vertical_ids"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "profile_image": profileImage,
    "profile_img_second": profileImgSecond,
    "profile_img_third": profileImgThird,
    "portfolio": portfolio == null ? [] : List<dynamic>.from(portfolio!.map((x) => x)),
    "bio": bio,
    "contact_email": contactEmail,
    "website": website,
    "campaign": campaign,
    "featured": featured,
    "tiktok_username": tiktokUsername,
    "instagram_username": instagramUsername,
    "twitter": twitter,
    "youtube": youtube,
    "is_social_verified": isSocialVerified,
    "is_tribal_recommended": isTribalRecommended,
    "max_social_platform": maxSocialPlatform,
    "max_social_followers": maxSocialFollowers,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "vertical_ids": verticalIds,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Vertical {

  int? id;
  String? verticalName;
  String? image;
  bool isSelected;

  Vertical({
    this.id,
    this.verticalName,
    this.image,
    this.isSelected = false,
  });

  factory Vertical.fromJson(Map<String, dynamic> json) =>
      Vertical(
    id: json["id"],
    verticalName: json["vertical_name"],
    image: json["image"],
        isSelected: false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vertical_name": verticalName,
    "image": image,
  };
}

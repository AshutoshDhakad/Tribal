// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  int? isAlreadyFollow;
  UserProfileInfo? userProfileInfo;
  List<Vertical>? verticals;

  Profile({
    this.isAlreadyFollow,
    this.userProfileInfo,
    this.verticals,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    isAlreadyFollow: json["is_already_follow"],
    userProfileInfo: json["user_profile_info"] == null ? null : UserProfileInfo.fromJson(json["user_profile_info"]),
    verticals: json["verticals"] == null ? [] : List<Vertical>.from(json["verticals"]!.map((x) => Vertical.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "is_already_follow": isAlreadyFollow,
    "user_profile_info": userProfileInfo?.toJson(),
    "verticals": verticals == null ? [] : List<dynamic>.from(verticals!.map((x) => x.toJson())),
  };
}

class UserProfileInfo {
  int? id;
  dynamic firstName;
  dynamic lastName;
  String? brandName;
  String? userType;
  String? kyc;
  String? email;
  dynamic website;
  int? age;
  String? instagramLink;
  String? tiktokLink;
  UserProfile? userProfile;

  UserProfileInfo({
    this.id,
    this.firstName,
    this.lastName,
    this.brandName,
    this.userType,
    this.kyc,
    this.email,
    this.website,
    this.age,
    this.instagramLink,
    this.tiktokLink,
    this.userProfile,
  });

  factory UserProfileInfo.fromJson(Map<String, dynamic> json) => UserProfileInfo(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    brandName: json["brand_name"],
    userType: json["user_type"],
    kyc: json["kyc"],
    email: json["email"],
    website: json["website"],
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
    "email": email,
    "website": website,
    "age": age,
    "instagram_link": instagramLink,
    "tiktok_link": tiktokLink,
    "user_profile": userProfile?.toJson(),
  };
}

class UserProfile {
  int? id;
  int? userId;
  String? profileImage;
  String? profileImgSecond;
  String? profileImgThird;
  List<dynamic>? portfolio;
  String? bio;
  dynamic contactEmail;
  String? website;
  String? campaign;
  String? featured;
  String? tiktokUsername;
  String? instagramUsername;
  String? twitter;
  String? youtube;
  String? isSocialVerified;
  String? isTribalRecommended;
  String? maxSocialPlatform;
  int? maxSocialFollowers;
  dynamic dob;
  dynamic gender;
  String? verticalIds;
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
    dob: json["dob"],
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
    "dob": dob,
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

  Vertical({
    this.id,
    this.verticalName,
    this.image,
  });

  factory Vertical.fromJson(Map<String, dynamic> json) => Vertical(
    id: json["id"],
    verticalName: json["vertical_name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vertical_name": verticalName,
    "image": image,
  };
}

// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  List<Vertical>? verticals;
  List<Datum>? data;
  int? currentPage;
  int? perPage;
  int? totalItems;
  int? totalPages;
  int? lastPage;

  Post({
    this.verticals,
    this.data,
    this.currentPage,
    this.perPage,
    this.totalItems,
    this.totalPages,
    this.lastPage,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    verticals: json["verticals"] == null ? [] : List<Vertical>.from(json["verticals"]!.map((x) => Vertical.fromJson(x))),
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    currentPage: json["current_page"],
    perPage: json["per_page"],
    totalItems: json["total_items"],
    totalPages: json["total_pages"],
    lastPage: json["last_page"],
  );

  Map<String, dynamic> toJson() => {
    "verticals": verticals == null ? [] : List<dynamic>.from(verticals!.map((x) => x.toJson())),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "current_page": currentPage,
    "per_page": perPage,
    "total_items": totalItems,
    "total_pages": totalPages,
    "last_page": lastPage,
  };
}

class Datum {
  int? id;
  int? userId;
  int? verticalId;
  dynamic image;
  List<Media>? media;
  String? title;
  String? pin;
  String? description;
  dynamic instagramPostLink;
  Status? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? totalLikes;
  int? totalComments;
  int? alreadyLiked;
  int? isLoginUser;
  User? user;

  Datum({
    this.id,
    this.userId,
    this.verticalId,
    this.image,
    this.media,
    this.title,
    this.pin,
    this.description,
    this.instagramPostLink,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.totalLikes,
    this.totalComments,
    this.alreadyLiked,
    this.isLoginUser,
    this.user,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    verticalId: json["vertical_id"],
    image: json["image"],
    media: json["media"] == null ? [] : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
    title: json["title"],
    pin: json["pin"],
    description: json["description"],
    instagramPostLink: json["instagram_post_link"],
    status: statusValues.map[json["status"]]!,
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    totalLikes: json["total_likes"],
    totalComments: json["total_comments"],
    alreadyLiked: json["already_liked"],
    isLoginUser: json["is_login_user"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "vertical_id": verticalId,
    "image": image,
    "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x.toJson())),
    "title": title,
    "pin": pin,
    "description": description,
    "instagram_post_link": instagramPostLink,
    "status": statusValues.reverse[status],
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "total_likes": totalLikes,
    "total_comments": totalComments,
    "already_liked": alreadyLiked,
    "is_login_user": isLoginUser,
    "user": user?.toJson(),
  };
}

class Media {
  String? type;
  String? media;
  String? thumbnail;
  String? url;
  String? thumbnailUrl;

  Media({
    this.type,
    this.media,
    this.thumbnail,
    this.url,
    this.thumbnailUrl,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    type: json["type"],
    media: json["media"],
    thumbnail: json["thumbnail"],
    url: json["url"],
    thumbnailUrl: json["thumbnail_url"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "media": media,
    "thumbnail": thumbnail,
    "url": url,
    "thumbnail_url": thumbnailUrl,
  };
}

enum Status {
  ACTIVE
}

final statusValues = EnumValues({
  "active": Status.ACTIVE
});

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? brandName;
  UserType? userType;
  String? kyc;
  UserProfile? userProfile;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.brandName,
    this.userType,
    this.kyc,
    this.userProfile,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    brandName: json["brand_name"],
    userType: userTypeValues.map[json["user_type"]]!,
    kyc: json["kyc"],
    userProfile: json["user_profile"] == null ? null : UserProfile.fromJson(json["user_profile"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "brand_name": brandName,
    "user_type": userTypeValues.reverse[userType],
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

enum UserType {
  BRAND,
  CREATOR
}

final userTypeValues = EnumValues({
  "brand": UserType.BRAND,
  "creator": UserType.CREATOR
});

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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

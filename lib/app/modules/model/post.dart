

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  String? status;
  PostInfo? postInfo;
  List<Comment>? comments;

  Post({
    this.status,
    this.postInfo,
    this.comments,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    status: json["status"],
    postInfo: json["post_info"] == null ? null : PostInfo.fromJson(json["post_info"]),
    comments: json["comments"] == null ? [] : List<Comment>.from(json["comments"]!.map((x) => Comment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "post_info": postInfo?.toJson(),
    "comments": comments == null ? [] : List<dynamic>.from(comments!.map((x) => x.toJson())),
  };
}

class Comment {
  int? id;
  int? postId;
  int? userId;
  String? comment;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;
  int? alreadyLiked;
  int? isLoginUser;
  List<dynamic>? commentReplies;
  String? type;

  Comment({
    this.id,
    this.postId,
    this.userId,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.alreadyLiked,
    this.isLoginUser,
    this.commentReplies,
    this.type,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
    postId: json["post_id"],
    userId: json["user_id"],
    comment: json["comment"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    alreadyLiked: json["already_liked"],
    isLoginUser: json["is_login_user"],
    commentReplies: json["comment_replies"] == null ? [] : List<dynamic>.from(json["comment_replies"]!.map((x) => x)),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "post_id": postId,
    "user_id": userId,
    "comment": comment,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "user": user?.toJson(),
    "already_liked": alreadyLiked,
    "is_login_user": isLoginUser,
    "comment_replies": commentReplies == null ? [] : List<dynamic>.from(commentReplies!.map((x) => x)),
    "type": type,
  };
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  dynamic brandName;
  String? userType;
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

class PostInfo {
  int? id;
  int? userId;
  int? verticalId;
  dynamic image;
  List<dynamic>? media;
  String? title;
  String? pin;
  String? description;
  dynamic instagramPostLink;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? alreadyLiked;
  int? totalComments;
  int? totalLikes;
  int? isLoginUser;
  User? user;

  PostInfo({
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
    this.alreadyLiked,
    this.totalComments,
    this.totalLikes,
    this.isLoginUser,
    this.user,
  });

  factory PostInfo.fromJson(Map<String, dynamic> json) => PostInfo(
    id: json["id"],
    userId: json["user_id"],
    verticalId: json["vertical_id"],
    image: json["image"],
    media: json["media"] == null ? [] : List<dynamic>.from(json["media"]!.map((x) => x)),
    title: json["title"],
    pin: json["pin"],
    description: json["description"],
    instagramPostLink: json["instagram_post_link"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    alreadyLiked: json["already_liked"],
    totalComments: json["total_comments"],
    totalLikes: json["total_likes"],
    isLoginUser: json["is_login_user"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "vertical_id": verticalId,
    "image": image,
    "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x)),
    "title": title,
    "pin": pin,
    "description": description,
    "instagram_post_link": instagramPostLink,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "already_liked": alreadyLiked,
    "total_comments": totalComments,
    "total_likes": totalLikes,
    "is_login_user": isLoginUser,
    "user": user?.toJson(),
  };
}

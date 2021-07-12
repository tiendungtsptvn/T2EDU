class User {
  int id;
  String username;
  String email;
  String phoneNumber;
  String servicePhone;
  String name;
  bool gender;
  String avatar;
  String birthday;
  List<dynamic> address;
  VerifyStatus verifyStatus;
  String createdAt;
  String updatedAt;
  Subscription subscription;
  Profile profile;

  User(
      {this.id,
        this.username,
        this.email,
        this.phoneNumber,
        this.servicePhone,
        this.name,
        this.gender,
        this.avatar,
        this.birthday,
        this.address,
        this.verifyStatus,
        this.createdAt,
        this.subscription,
        this.updatedAt,
        this.profile
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email']??"";
    phoneNumber = json['phoneNumber']??"";
    servicePhone = json['servicePhone']??"";
    name = json['name']??"";
    gender = json['gender'];
    avatar = json['avatar'];
    birthday = json['birthday'];
    if(json['address'] != null)
      address = List<dynamic>.from(json["address"].map((x) => x));
    if(json['verifyStatus'] != null) {
      if(json['verifyStatus'] is Map<String,dynamic>)
        verifyStatus = VerifyStatus.fromJson(json['verifyStatus']);
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if(json['subscription'] != null) {
      if(json['subscription'] is Map<String,dynamic>)
        subscription = Subscription.fromJson(json['subscription']);
    }

    if(json['profile'] != null) {
      if(json['profile'] is Map<String,dynamic>)
        profile = Profile.fromJson(json['profile']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['avatar'] = this.avatar;
    data['birthday'] = this.birthday;
    data['address'] = this.address;
    if(data['verifyStatus'] != null)
      data['verifyStatus'] = this.verifyStatus.toJson();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if(data['subscription'] != null)
      data['subscription'] = this.subscription.toJson();
    if(data['profile'] != null)
      data['profile'] = this.profile.toJson();
    return data;
  }
}

class Subscription {
  String type;
  String expiredAt;
  String updatedAt;

  Subscription({this.type, this.expiredAt, this.updatedAt});

  Subscription.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    expiredAt = json['expiredAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['expiredAt'] = this.expiredAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class VerifyStatus {
  VerifyStatus({
    this.phone,
    this.identity,
    this.email,
  });

  bool phone;
  bool identity;
  bool email;

  factory VerifyStatus.fromJson(Map<String, dynamic> json) => VerifyStatus(
    phone: json["phone"],
    identity: json["identity"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "identity": identity,
    "email": email,
  };
}

class Profile {
  Profile({
    this.id,
    this.name,
    this.username,
    this.address,
    this.email,
    this.servicePhone,
    this.gender,
    this.avatar,
    this.subscription,
    this.subscriptionExpiry,
    this.phoneVerified,
    this.emailVerified,
    this.identityVerified,
    this.point,
    this.createdAt,
    this.totalTaskPosted,
    this.totalTaskReceived,
    this.totalDoing,
    this.totalDone,
    this.totalRating,
    this.ratingAvg,
  });

  int id;
  String name;
  String username;
  List<dynamic> address;
  String email;
  String servicePhone;
  bool gender;
  String avatar;
  String subscription;
  DateTime subscriptionExpiry;
  bool phoneVerified;
  bool emailVerified;
  bool identityVerified;
  int point;
  DateTime createdAt;
  int totalTaskPosted;
  int totalTaskReceived;
  int totalDoing;
  int totalDone;
  int totalRating;
  int ratingAvg;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    address: List<dynamic>.from(json["address"]??[].map((x) => x)),
    email: json["email"],
    servicePhone: json["servicePhone"],
    gender: json["gender"],
    avatar: json["avatar"],
    subscription: json["subscription"],
    subscriptionExpiry: DateTime.parse(json["subscriptionExpiry"]),
    phoneVerified: json["phoneVerified"],
    emailVerified: json["emailVerified"],
    identityVerified: json["identityVerified"],
    point: json["point"],
    createdAt: DateTime.parse(json["created_at"]),
    totalTaskPosted: json["totalTaskPosted"],
    totalTaskReceived: json["totalTaskReceived"],
    totalDoing: json["totalDoing"],
    totalDone: json["totalDone"],
    totalRating: json["totalRating"],
    ratingAvg: json["ratingAvg"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "username": username,
    "address": List<dynamic>.from(address.map((x) => x)),
    "email": email,
    "servicePhone": servicePhone,
    "gender": gender,
    "avatar": avatar,
    "subscription": subscription,
    "subscriptionExpiry": subscriptionExpiry.toIso8601String(),
    "phoneVerified": phoneVerified,
    "emailVerified": emailVerified,
    "identityVerified": identityVerified,
    "point": point,
    "created_at": createdAt.toIso8601String(),
    "totalTaskPosted": totalTaskPosted,
    "totalTaskReceived": totalTaskReceived,
    "totalDoing": totalDoing,
    "totalDone": totalDone,
    "totalRating": totalRating,
    "ratingAvg": ratingAvg,
  };
}




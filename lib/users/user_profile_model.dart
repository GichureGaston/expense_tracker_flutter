import 'package:expense_tracker/users/user_model.dart';

class UserProfile {
  String? url;
  String? email;
  String? firstName;
  String? lastName;
  Profile? profile;

  UserProfile(
      {this.url, this.email, this.firstName, this.lastName, this.profile});

  UserProfile.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profile =
        json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    return data;
  }
}

class Profile {
  int? id;
  String? title;
  String? dob;
  String? address;
  DateTime? createdTime;
  String? country;
  String? city;
  String? zip;
  String? photo;

  Profile({
    this.id,
    this.title,
    this.dob,
    this.address,
    this.createdTime,
    this.country,
    this.city,
    this.zip,
    this.photo,
  });

  // Profile.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   title = json['title'];
  //   dob = json['dob'];
  //   address = json['address'];
  //   createdTime = json['createdTime'];
  //   country = json['country'];
  //   city = json['city'];
  //   zip = json['zip'];
  //   photo = json['photo'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['dob'] = dob;
    data['address'] = address;
    data['createdTime'] = createdTime;
    data['country'] = country;
    data['city'] = city;
    data['zip'] = zip;
    data['photo'] = photo;
    return data;
  }

  Profile copy({
    int? id,
    String? title,
    String? dob,
    String? address,
    DateTime? createdTime,
  }) =>
      Profile(
        id: id ?? this.id,
        title: title ?? this.title,
        dob: dob ?? this.dob,
        address: address ?? this.address,
        createdTime: createdTime ?? this.createdTime,
      );
  factory Profile.fromJson(Map<String, Object?> json) => Profile(
        id: json[UserModelFields.id] as int?,
        title: json[UserModelFields.title] as String,
        dob: json[UserModelFields.dob] as String,
        address: json[UserModelFields.address] as String,
        createdTime: json[UserModelFields.createdTime] as DateTime,
      );
}

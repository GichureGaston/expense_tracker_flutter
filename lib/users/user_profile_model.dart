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
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['email'] = this.email;
    data['first_name'] = firstName;
    data['last_name'] = this.lastName;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    return data;
  }
}

class Profile {
  String? title;
  String? dob;
  String? address;
  String? country;
  String? city;
  String? zip;
  String? photo;

  Profile(
      {this.title,
      this.dob,
      this.address,
      this.country,
      this.city,
      this.zip,
      this.photo});

  Profile.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    dob = json['dob'];
    address = json['address'];
    country = json['country'];
    city = json['city'];
    zip = json['zip'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['dob'] = this.dob;
    data['address'] = this.address;
    data['country'] = this.country;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['photo'] = this.photo;
    return data;
  }
}

class LoginSuccess {
  String? access;
  String? refresh;
  User? user;

  LoginSuccess({this.access, this.refresh, this.user});

  LoginSuccess.fromJson(Map<String, dynamic> json) {
    access = json['access'];
    refresh = json['refresh'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access'] = this.access;
    data['refresh'] = this.refresh;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? pk;
  String? email;
  String? firstName;
  String? lastName;

  User({this.pk, this.email, this.firstName, this.lastName});

  User.fromJson(Map<String, dynamic> json) {
    pk = json['pk'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pk'] = this.pk;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}

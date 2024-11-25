class LoginUser {
  String? email;
  String? password;
  LoginUser({
    this.email,
    this.password,
  });
  LoginUser.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }
  static final empty = LoginUser(email: '', password: '');

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}

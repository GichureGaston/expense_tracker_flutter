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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}

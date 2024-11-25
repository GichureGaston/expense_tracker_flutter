class RegisterUser {
  String? email;
  String? password1;
  String? password2;

  RegisterUser({
    this.email,
    this.password1,
    this.password2,
  });
  RegisterUser.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password1 = json['password1'];
    password2 = json['password2'];
  }
  static final empty = RegisterUser(email: '', password1: '', password2: '');

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password1'] = this.password1;
    data['password2'] = this.password2;

    return data;
  }
}

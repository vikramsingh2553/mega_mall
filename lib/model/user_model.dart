class UserModel {
  String username;
  String password;

  UserModel({required this.username, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'],
      password: map['password'],
    );
  }

  @override
  String toString() {
    return 'UserModel{username: $username, password: $password}';
  }
}
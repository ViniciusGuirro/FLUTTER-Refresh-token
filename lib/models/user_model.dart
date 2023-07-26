class UserModel {
  int? id;
  String? realName;
  String? userName;
  String? email;
  String? token;

  UserModel({this.id, this.realName, this.userName, this.email, this.token});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    try {
      return UserModel(
        id: map['id'],
        realName: map['realName'],
        userName: map['userName'],
        email: map['email'],
        token: map['token'],
      );
    } catch (e) {
      throw Exception('Erro ao criar UserModel a partir do mapa');
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'realName': realName,
      'userName': userName,
      'email': email,
      'token': token,
    };
  }

  Map<String, dynamic> toJson() {
    try {
      return {
        'user': {
          'id': id,
          'realName': realName,
          'userName': userName,
          'email': email,
          'token': token,
        },
      };
    } catch (e) {
      throw Exception('Erro ao criar UserModel a partir do mapa');
    }
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      realName: json['realName'],
      userName: json['userName'],
      email: json['email'],
      token: json['token'],
    );
  }

  @override
  String toString() {
    return '{ id: $id, realName: $realName, userName: $userName, email: $email, token: $token}';
  }
}

class UserModel {
  String? uid;
  String? email;
  String? username;
  String? phone;
  String? address;

  UserModel({this.uid, this.email, this.username, this.phone, this.address});

  // receive data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        username: map['username'],
        phone: map['phone'],
        address: map['address']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
    };
  }
}

class UserModel{
  int? id;
  String? name;
  String? email;
  String? status;
  String? datetime;
  String? comment;
  String? complaint;

  UserModel({this.name, this.email, this.status, this.datetime, this.comment, this.id, this.complaint});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        status: json['status'],
        datetime: json['datetime'],
        comment: json['comment'],
      complaint: json['complaint']
    );
  }
}
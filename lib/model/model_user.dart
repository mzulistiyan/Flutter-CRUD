class UsersModel {
  final String name;

  final String id;

  UsersModel({
    required this.name,
    required this.id,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        name: json["name"],
        id: json["id"],
      );
}

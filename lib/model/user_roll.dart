
class UserRollFields{
  static final String? tableName = 'UserRoll';
  static final String? id = '_id';
  static final String? name = 'name';
  static final String? roll = 'roll';
}

class UserRoll{
  int? id;
  String? name;
  String? roll;

  UserRoll({this.id,
      required this.name,
      required this.roll});

  factory UserRoll.fromMap(Map<String, dynamic> json) =>
      UserRoll(
        id: json[UserRollFields.id],
        name: json[UserRollFields.name],
        roll: json[UserRollFields.roll],
      );

  Map<String, dynamic> toMap() {
    return {
      UserRollFields.id! : id,
      UserRollFields.name! : name,
      UserRollFields.roll! : roll,
    };
  }
}
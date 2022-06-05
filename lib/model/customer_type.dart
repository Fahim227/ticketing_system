
class CustomerTypeFields{
  static final String? tableName = 'CustomerType';
  static final String? id = '_id';
  static final String? name = 'name';
  static final String? type = 'type';
}

class CustomerType{
  int? id;
  String? name;
  String? type;

  CustomerType({this.id,
    required this.name,
    required this.type});

  factory CustomerType.fromMap(Map<String, dynamic> json) =>
      CustomerType(
        id: json[CustomerTypeFields.id],
        name: json[CustomerTypeFields.name],
        type: json[CustomerTypeFields.type],
      );

  Map<String, dynamic> toMap() {
    return {
      CustomerTypeFields.id! : id,
      CustomerTypeFields.name! : name,
      CustomerTypeFields.type! : type,
    };
  }
}
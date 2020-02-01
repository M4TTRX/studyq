import 'package:uuid/uuid.dart';

class Account {
  String id;
  final String name;

  Account({this.name}) {
    this.id = Uuid().v4();
  }
}

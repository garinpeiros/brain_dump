import '../model/db/db.dart';

class TagMemoRepository {
  late MyDatabase _db;
  TagMemoRepository() {
    _db = MyDatabase.getInstance();
  }
}

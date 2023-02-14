import 'package:brain_dump/model/db/db.dart';

class DoramaRepository {
  late MyDatabase _db;
  DoramaRepository() {
    _db = MyDatabase();
  }
}

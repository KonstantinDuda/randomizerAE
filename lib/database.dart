class MyDatabase {
  static final MyDatabase _db = MyDatabase._internal();

  late int count;
  factory MyDatabase() {
    return _db;
  }

  MyDatabase._internal();

  setCount(int number) {
    count = number;
  }

  getCount() {
    return count;
  }
}

class MyDatabase {
  static final MyDatabase _db = MyDatabase._internal();

  int _count = 10;
  factory MyDatabase() {
    return _db;
  }

  MyDatabase._internal();

  setCount(int number) {
    _count = number;
  }

  getCount() {
    return _count;
  }
}

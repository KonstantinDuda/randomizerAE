class MyDatabase {
  static final MyDatabase _db = MyDatabase._internal();

  final List<FormDatabase> _list = [];
  factory MyDatabase() {
    return _db;
  }

  MyDatabase._internal();

  addObj(String name, int max, int numberOfRes) {
    _list.add(FormDatabase(name, max, numberOfRes));
  }

  addFDB(FormDatabase fdb) {
    _list.add(fdb);
  }

  changeObj(FormDatabase newObj, int indexOfAnOldObj) {
    _list[indexOfAnOldObj] = newObj;
  }

  FormDatabase getObj(int index) {
    return _list[index];
  }

  getLength() {
    return _list.length;
  }
}

class FormDatabase {
  final String name;
  final int maximum;
  final int numberOfResults;

  FormDatabase(this.name, this.maximum, this.numberOfResults);

  @override
  String toString() {
    return 'Name: $name, /n Maximum object count: $maximum, \n The count of objects that you need: $numberOfResults /n';
  }
}

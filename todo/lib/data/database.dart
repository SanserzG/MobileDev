import 'package:hive_flutter/hive_flutter.dart';


class ToDoDataBase {
  
  List ToDoList = [];
  
  final _mybox = Hive.box('mybox');

  void createInitialData() {
    ToDoList = [
      ["1", false],
      ["2", false]
    ];
  }

  void loadData() {
    ToDoList = _mybox.get("ToDo");
  }

  void updateData() {
    _mybox.put('ToDo', ToDoList);
  }


}
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/database.dart';
import 'package:todo/dialogs/addTask.dart';
import 'package:todo/dialogs/editTask.dart';
import 'package:todo/tiles/todoTile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controller = TextEditingController();
  

  final myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  String filterText = 'Все';
  int filter = 0;
  List filteredList = [];

  @override
  void initState() {
    if(myBox.get("ToDo") == null) {
      db.createInitialData();
    } else  {
      db.loadData();
      filteredList = getList();
    }
    super.initState();
  }

void saveNewTask() {
  setState(() {
    db.ToDoList.add([_controller.text, false]);
    filteredList = getList();
  });
  db.updateData();
  Navigator.of(context).pop();
}

void checkboxChanged(bool? value, int index) {
  setState(() {
    db.ToDoList[index][1] = !db.ToDoList[index][1];
    filteredList = getList();
  });
  db.updateData();
}
void createNewTask() {
  showDialog(context: context, builder: (context) {
    return AddTask(
      controller: _controller,
      onSave: saveNewTask,
      onCancel: () => Navigator.of(context).pop(),
    );  
  },);
}

void deleteCurrentTask(int index) {
  setState(() {
  db.ToDoList.removeAt(index); 
  filteredList = getList();
  });
  db.updateData();
  Navigator.of(context).pop();
}

void saveChangeTask(int index) {
  setState(() {
  db.ToDoList[index][0] = _controller.text;  
  
  });
  db.updateData();
  Navigator.of(context).pop();
}

void editCurrentTask(int index) {
  showDialog(context: context, builder: (context) {
    return EditTask(
      controller: _controller,
      onSave: () { saveChangeTask(index);},
      onCancel: () => Navigator.of(context).pop(),
      onRemove: () => deleteCurrentTask(index),
    );
  },);
}

List getList() {
    if (filter != 2) {
      bool temp = filter == 1 ? true : false;
      filteredList = db.ToDoList
          .asMap()
          .entries
          .where((item) => item.value[1] == temp)
          .map((item) => item.key)
          .toList();
    } else {
      filteredList = db.ToDoList.asMap().entries.map((item) => item.key).toList();
    }
    return filteredList;
  }

 
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        backgroundColor: const Color.fromARGB(255, 248, 227, 136),
        centerTitle: true,
        actions: [MaterialButton(onPressed:  () {
                  setState(() {
                    filter = (filter + 1) % 3;
                    switch (filter) {
                      case (0):
                        filterText = 'Активные';
                      case (1):
                        filterText = 'Выполненные';
                      default:
                        filterText = 'Все';
                    }
                    filteredList = getList();
                  });
                },
        child: Text(filterText),
        )],
      ),
      backgroundColor: const Color.fromARGB(255, 31, 31, 31),
      floatingActionButton: FloatingActionButton(
        onPressed:()  {
          _controller.text = '';
          createNewTask();},
        backgroundColor: const Color.fromARGB(255, 248, 227, 136),
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
          taskName: db.ToDoList[filteredList[index]][0],
          taskCompleted: db.ToDoList[filteredList[index]][1],
          onChanged: (value) => checkboxChanged(value, filteredList[index]),
          onEdit: () { 
            _controller.text = db.ToDoList[filteredList[index]][0];
            editCurrentTask(filteredList[index]);
            },
          );
        },
        ),
    );
  }
}

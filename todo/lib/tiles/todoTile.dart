import 'package:flutter/material.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function()? onEdit;
  ToDoTile(
      {super.key,
      required this.taskName,
      required this.taskCompleted,
      required this.onChanged,
      required this.onEdit
      }
      
      );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Container(
        padding: EdgeInsets.all(20),
        child:   Row(
          children: [
            Checkbox(value: taskCompleted, onChanged: onChanged),
             Expanded(
               child: Text(
                taskName,
                style: TextStyle(decoration: taskCompleted ? TextDecoration.lineThrough : TextDecoration.none),
                softWrap: true,),
             ), 
            IconButton(
              onPressed: onEdit,
              icon: Icon(Icons.settings),
              color: Colors.black87,
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 248, 227, 136),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

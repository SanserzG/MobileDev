import 'package:flutter/material.dart';

class EditTask extends StatelessWidget {
  
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  VoidCallback onRemove;

  EditTask(
    {super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    required this.onRemove
    });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 248, 227, 136),
      content: Container(
        height: 120,
        child:  Column(children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(border: OutlineInputBorder(),
            
          ),),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                onPressed: onSave,
                color: Colors.black87,
                child: Text('Сохранить', style: TextStyle(color:Colors.white)),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
              MaterialButton(
                onPressed: onCancel,
                color: Colors.black87,
                child: Text('Отменить', style: TextStyle(color:Colors.white)),
              ), IconButton(icon: Icon(Icons.delete), color: const Color.fromARGB(255, 170, 0, 0),
              onPressed: onRemove,
              )
              

            ],
            
          )
        ],),
      )
    );
  }
}
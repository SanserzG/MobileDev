import 'package:flutter/material.dart';

class AddTask extends StatelessWidget {
  
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  AddTask(
    {super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
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
            hintText: 'Название задачи'
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
              ),

            ],
            
          )
        ],),
      )
    );
  }
}
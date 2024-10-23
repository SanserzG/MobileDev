import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Конвертер'),
          backgroundColor: const Color.fromARGB(255, 64, 175, 255),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [Padding(
              padding: EdgeInsets.all(15.0),
              child: Container(
                width: 200,
                height: 50,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.fitness_center),
                  onPressed: () => {Navigator.pushNamed(context, '/weight')},
                   label: Text('Вес'),
                  ),
                )
            ),Padding(
              padding: EdgeInsets.all(15.0),
              child: Container(
                width: 200,
                height: 50,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.align_horizontal_left_outlined),
                  onPressed: () => {Navigator.pushNamed(context, '/length')},
                   label: Text('Длина'),
                  ),
                )
            ),Padding(
              padding: EdgeInsets.all(15.0),
              child: Container(
                width: 200,
                height: 50,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.legend_toggle_sharp),
                  onPressed: () => {Navigator.pushNamed(context, '/temperature')},
                   label: Text('Температура'),
                  ),
                )
            ),Padding(
              padding: EdgeInsets.all(15.0),
              child: Container(
                width: 200,
                height: 50,
                child: ElevatedButton.icon(
                  
                  icon: Icon(Icons.attach_money),
                  onPressed: () => {Navigator.pushNamed(context, '/money')},
                   label: Text('Валюта'),
                  ),
                )
            ), Padding(
              padding: EdgeInsets.all(15.0),
              child: Container(
                width: 200,
                height: 50,
                child: ElevatedButton.icon(
                  
                  icon: Icon(Icons.access_time),
                  onPressed: () => {Navigator.pushNamed(context, '/time')},
                   label: Text('Время'),
                  ),
                )
            ),],

          )
          )
          );
  }
}

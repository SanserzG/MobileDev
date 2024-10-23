import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Length extends StatefulWidget {
  const Length({super.key});

  @override
  State<Length> createState() => _LengthState();
}

class _LengthState extends State<Length> {
  void convert(String value) {
    setState(() {
      if (value.isEmpty) {
        outputValue = '';
        return;
      }
      int selectId = 1;
      int targetId = 1;
      if (_selectedValue == 'Метр') {
        selectId = 0;
      } else if (_selectedValue == 'Километр') {
        selectId = 1;
      } else if (_selectedValue == 'Миля') {
        selectId = 2;
      } else if (_selectedValue == 'Фута') {
        selectId = 3;
      }

      if (_targetValue == 'Метр') {
        targetId = 0;
      } else if (_targetValue == 'Километр') {
        targetId = 1;
      } else if (_targetValue == 'Миля') {
        targetId = 2;
      } else if (_targetValue == 'Фута') {
        targetId = 3;
      }
  

  
      double _val = double.parse(value);

      solution = _val / metricArray[selectId][targetId];
      solution = double.parse(solution.toStringAsFixed(8));

      outputValue = solution.toString();
    });
  }

  String? _selectedValue = 'Метр';
  String? _targetValue = 'Метр';
  String inputValue = '';
  double solution = 0;
  String outputValue = '';

  List<String> items = ['Метр', 'Километр', 'Миля', 'Фута'];
  List<List<double>> metricArray = [
    [1, 1000, 1609.34, 0.3048],
    [0.001, 1, 1.60934],
    [0.00062137, 0.621371, 1],
    [3.28084, 3280.84, 5280, 1 ]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Длина'),
          backgroundColor: const Color.fromARGB(255, 64, 175, 255),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(children: [
            Row(children: [
              DropdownMenu(
                initialSelection: _selectedValue,
                onSelected: (newValue) {
                  setState(() {
                    _selectedValue = newValue;
                    convert(inputValue);
                  });
                },
                dropdownMenuEntries: items.map((String item) {
                  return DropdownMenuEntry<String>(
                    value: item,
                    label: item,
                  );
                }).toList(),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Center(
                  child: Text('В'),
                ),
              ),
              DropdownMenu(
                initialSelection: _targetValue,
                onSelected: (newValue) {
                  setState(() {
                    _targetValue = newValue;
                    convert(inputValue);
                  });
                },
                dropdownMenuEntries: items.map((String item) {
                  return DropdownMenuEntry<String>(
                    value: item,
                    label: item,
                  );
                }).toList(),
              ),
            ]),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Container(
                      width: 135,
                      height: 50,
                      color: const Color.fromARGB(255, 235, 229, 228),
                      child: TextField(
                        inputFormatters: [
                          FilteringTextInputFormatter(RegExp(r'^\d+\.?\d*'),
                              allow: true),
                        ],
                        onChanged: (value) {
                          inputValue = value;
                          convert(inputValue);
                        },
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: Center(
                    child: Text('='),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: Center(
                    child: Text(
                      '$outputValue',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            )
          ]),
        ));
  }
}

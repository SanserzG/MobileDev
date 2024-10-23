
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Time extends StatefulWidget {
  const Time({super.key});

  @override
  State<Time> createState() => _TimeState();
}

class _TimeState extends State<Time> {
 void convert(String value) {
    setState(() {
      if (value.isEmpty) {
        outputValue = '';
        return;
      }
       double _val = double.parse(value);

      if (_selectedValue == 'Секунда') {
        if (_targetValue == 'Минута') {
          solution = _val / 60;
        }
        if (_targetValue == 'Час') {
          solution = _val / 3600;
        }
      }
      if (_selectedValue == 'Минута') {
        if (_targetValue == 'Секунда') {
          solution = _val*60;
        }
        if (_targetValue == 'Час') {
           solution = _val/60;
        }
      }
      if (_selectedValue == 'Час') {
        if (_targetValue == 'Секунда') {
          solution = _val * 3600;
        }
        if (_targetValue == 'Минута') {
           solution = _val*60;
        }
      }
      
      if (_selectedValue == _targetValue) {
        solution = _val * 1;
      }
     
      solution = double.parse(solution.toStringAsFixed(6));

      outputValue = solution.toString();
    });
  }

  String? _selectedValue = 'Секунда';
  String? _targetValue = 'Секунда';
  String inputValue = '';
  double solution = 0;
  String outputValue = '';

  List<String> items = ['Секунда', 'Минута', 'Час'];
  List<List<double>> metricArray = [
    [1, 60, 3600],
    [0.0166666666666667, 1, 1.60934],
    [0.00027777833333, 0.0166666666666667, 1],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Время'),
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

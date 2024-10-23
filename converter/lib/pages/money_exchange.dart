import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Money extends StatefulWidget {
  const Money({super.key});

  @override
  State<Money> createState() => _MoneyState();
}

class _MoneyState extends State<Money> {
 void convert(String value) {
    setState(() {
      if (value.isEmpty) {
        outputValue = '';
        return;
      }
      int selectId = 1;
      int targetId = 1;
      if (_selectedValue == 'RUB') {
        selectId = 0;
      } else if (_selectedValue == 'USD') {
        selectId = 1;
      } else if (_selectedValue == 'EUR') {
        selectId = 2;
      }
      if (_targetValue == 'RUB') {
        targetId = 0;
      } else if (_targetValue == 'USD') {
        targetId = 1;
      } else if (_targetValue == 'EUR') {
        targetId = 2;
      }
  
      double _val = double.parse(value);

      solution = _val * metricArray[selectId][targetId];
      solution = double.parse(solution.toStringAsFixed(5));

      outputValue = solution.toString();
    });
  }

  String? _selectedValue = 'RUB';
  String? _targetValue = 'RUB';
  String inputValue = '';
  double solution = 0;
  String outputValue = '';

  List<String> items = ['RUB', 'USD', 'EUR'];
  List<List<double>> metricArray = [
    [1, 0.0104, 0.0095],
    [96.4, 1, 0.9195],
    [104.8, 1.0875, 1],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Валюта'),
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
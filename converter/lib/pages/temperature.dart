import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Temerature extends StatefulWidget {
  const Temerature({super.key});

  @override
  State<Temerature> createState() => _TemeratureState();
}

class _TemeratureState extends State<Temerature> {
  void convert(String value) {
    setState(() {
      
      if (value.isEmpty) {
        outputValue = '';
        return;
      }
      
      double _val = double.parse(value);


      if (_selectedValue == 'C') {
        if (_targetValue == 'F') {
          solution = (_val * 9/5)+32;
        }
        if (_targetValue == 'K') {
          solution = _val + 273.15;
        }
      }
      if (_selectedValue == 'F') {
        if (_targetValue == 'C') {
          solution = (_val-32)*5/9;
        }
        if (_targetValue == 'K') {
           solution = (_val-32)*5/9+273.15;
        }
      }
      if (_selectedValue == 'K') {
        if (_targetValue == 'C') {
          solution = (_val-273.15);
        }
        if (_targetValue == 'F') {
           solution = (_val-273.15)*9/5+32;
        }
      }
      
      if (_selectedValue == _targetValue) {
        solution = _val * 1;
      }
      // solution = double.parse(solution.toStringAsFixed(8));

      // outputValue = solution.toString();
      solution = double.parse(solution.toStringAsFixed(8));   
      outputValue = solution.toString();
    });
  }

  String? _selectedValue = 'C';
  String? _targetValue = 'C';
  String inputValue = '';
  double solution = 0.1;
  String outputValue = '';

  List<String> items = ['C', 'F', 'K'];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Температура'),
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
                          convert(value);
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

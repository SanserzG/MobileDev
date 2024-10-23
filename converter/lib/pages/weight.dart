import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Weight extends StatefulWidget {
  const Weight({super.key});

  @override
  State<Weight> createState() => _WeightState();
}

class _WeightState extends State<Weight> {
  void convert(String value) {
    setState(() {
      if (value.isEmpty) {
        outputValue = '';
        return;
      }
      int selectId = 1;
      int targetId = 1;
      if (_selectedValue == 'Грамм') {
        selectId = 0;
      } else if (_selectedValue == 'Кг') {
        selectId = 1;
      } else if (_selectedValue == 'Фунт') {
        selectId = 2;
      }
      if (_targetValue == 'Грамм') {
        targetId = 0;
      } else if (_targetValue == 'Кг') {
        targetId = 1;
      } else if (_targetValue == 'Фунт') {
        targetId = 2;
      }
      if (value.isEmpty) {
        return;
      }
      double _val = double.parse(value);

      solution = _val / metricArray[selectId][targetId];
      solution = double.parse(solution.toStringAsFixed(8));

      outputValue = solution.toString();
    });
  }

  String? _selectedValue = 'Грамм';
  String? _targetValue = 'Грамм';
  String inputValue = '';
  double solution = 0;
  String outputValue = '';

  List<String> items = ['Грамм', 'Кг', 'Фунт'];
  List<List<double>> metricArray = [
    [1, 1000, 453.592],
    [0.001, 1, 0.453592],
    [0.00220462, 2.2046199998910895879, 1],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Вес'),
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

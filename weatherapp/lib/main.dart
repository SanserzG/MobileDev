import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';


void main() {
  initializeDateFormatting('ru', null);
  runApp(MyApp());
 }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WeatherApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherApState();
}

class _WeatherApState extends State<WeatherApp> {




  
  int selectedCity = 0;
  String ?curCity = 'khanty-mansiysk';
  String key = 'bd0690dc0d6a478a95395000240511';


  List<String> weekDayList = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт','Сб', 'Вс'];

  List<String> cities = ['khanty-mansiysk','Moscow', 'Volgograd', 'Yakutsk', 'Kazan' ];
  List<int> utcCities = [5,3,3,9,3];
   Map<String, int> citiesUtc = {
    'khanty-mansiysk': 5,
    'Moscow': 3,
    'Volgograd': 3,
    'Yakutsk': 9,
    'Kazan': 3,
  };

  late Future<Map<String, dynamic>> response;
  int selected = 0;

  Future<Map<String,dynamic>> loadData() async {
    final responseApi = await Dio().get('http://api.weatherapi.com/v1/forecast.json?key=$key&q=$curCity&days=7');
    if (responseApi.statusCode == 200) {
      return responseApi.data;
    } else {
      throw Exception(responseApi.statusCode);
     
    }
    
  }
  @override
  void initState() {
     response = loadData();
     
  }
  
 
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        response = loadData();
        setState(() {
         
        });
      }),
      appBar: AppBar(title: Text(curCity!,style: TextStyle(color: Colors.white),), backgroundColor: Colors.blue, centerTitle: true,
      actions: [IconButton(onPressed:() { 
        showDialog(context: context , builder:(context) {
          
          return AlertDialog(
          content: Container(
            height: 120,
            child: Padding(padding: EdgeInsets.all(20),
            child: Column(
              children: [Text('Город'), SizedBox(height: 10,), 
              DropdownButton(value: curCity, 
              items: cities.map((String item) {

                 return DropdownMenuItem<String>(
                  value: item,
                  child: Text('$item'),
                );
              }
              ).toList(),
               onChanged: (String? newValue) {
                setState(() {
                curCity = newValue;
                response = loadData();  
                });
                
                Navigator.pop(context); 
               })],
            ),
          )));
        });
        
        }, icon: Icon(Icons.menu), color: Colors.white,)],
      ),
      body: FutureBuilder(
        future: response , 
        builder:(context, snapshot) {
          if (snapshot.hasData) {
             var curDay = snapshot.data!['current'];
             var forecast = snapshot.data!['forecast'];
             
            
            return Column(
              
              children: [
                Padding(padding: EdgeInsets.all(20),
               child:  Container(
                
                 decoration: BoxDecoration(
                      border:  Border.all(
                      color: const Color.fromARGB(255, 244, 237, 237), 
                      width: 2.0,
                    ),  
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                 ),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: 
                  [Column( children: [ 
                    Text('Сейчас ' ,style: 
                    TextStyle(fontSize: 15)),
                    Text(weekDayList[DateTime.now().weekday-1] + ' ' + (DateTime.now().toUtc().add(Duration(hours:  citiesUtc[curCity]!)).hour.toString()) + ':00',style: 
                    TextStyle(fontSize: 15)),
                  ],), Padding(padding: EdgeInsets.symmetric(horizontal: 40)),
                    Text(curDay["temp_c"].toStringAsFixed(0) + '°',style: TextStyle(fontSize: 30),), Image.network('http:' + snapshot.data!['current']['condition']['icon'])
                    ],
                               ),
               ) )
              ,
              Container(
              height: 130, 
              child: ListView.builder(
                scrollDirection: Axis.horizontal, 
                itemCount: 24,
                itemBuilder: (context, index) {
                  return Container(
                    width: 100, 
                    margin: EdgeInsets.symmetric(horizontal: 8), 
                    decoration: BoxDecoration(
                      border:  Border.all(
                      color: const Color.fromARGB(255, 244, 237, 237),
                      width: 2.0, 
                    ),  
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text((index).toString() + ':00', style: TextStyle(fontSize: 15)),
                        Image.network('http:' + forecast['forecastday'][selected]['hour'][index]['condition']['icon']),
                        Text(forecast['forecastday'][selected]['hour'][index]['temp_c'].toStringAsFixed(0) + '°', style: TextStyle(fontSize: 15),)
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 30),
           
             Container(
              height: 70,  
                child:  ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index ){
                  
                  DateTime date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day+index);
                 
                  return ElevatedButton(
                    onPressed: () {
                      selected = index;
                    
                      setState(() {
                        
                      });
                    }, 
                    child: Text((DateTime.now().day+index).toString() +'  ' + weekDayList[date.weekday-1]),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selected== index ?const Color.fromARGB(255, 239, 221, 221)  : Colors. white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero),
                    minimumSize: Size(70, 70), 
          ),
                  );
                
                })

             )
              ],
                
            );
          }
           else if (snapshot.hasError) {
              return const Center(child: Text('Error'));
              
           }
           else {
            return const Center(child: Text('loading'));
           }
        } 
      )
    );

}
}
 
 

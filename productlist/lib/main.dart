import 'package:flutter/material.dart';
import 'package:productlist/pages/current_category.dart';
import 'package:productlist/pages/cuurent_item.dart';
import 'package:productlist/pages/favorite_items.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV4a2FyZHRlenV1dWhocWx4d3h6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE0MzI2MzcsImV4cCI6MjA0NzAwODYzN30.7e4gNO_bYuG-orEShOztJB0ZBDTbbPIfcFPDPnRVjP8',
      url: 'https://exkardtezuuuhhqlxwxz.supabase.co'
      
    );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'productList',
      debugShowCheckedModeBanner: false,
      home: const Products(),
      routes: {
        '/home': (context) => Products(),
        '/category': (context) => CurrentCatergory(),
        '/item' : (context) => CurrentItem(number: 1,),
        '/favorite' : (context) => FaavoriteItems()
    
      },
    );
  }
}

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final _future = Supabase.instance.client
      .from('ProductCategory')
      .select();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        Navigator.pushNamed(context, '/favorite');
        setState(() {
        
      });},
      child:  Icon(Icons.favorite),
      ),
      appBar: AppBar(
      title: Text('Категории'),
      centerTitle: true,
      backgroundColor: Colors.green[200],
    ),
    body: 
    FutureBuilder(
      future: _future, 
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
        
        final categories = snapshot.data!;
        return ListView.builder(
                itemCount: categories.length,
                itemBuilder: ((context, index) {
                  
                  final category = categories[index];
                  print(category['name']);
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(onPressed: (
                            
                          
                        ) {
                          Navigator.pushNamed(context, '/category',arguments: category['id']);
  
                        },
                          style: ElevatedButton.styleFrom( 
                          minimumSize: Size(180, 50),),
                         child: Text(category['name'], style: TextStyle(fontSize: 30),))
                        ],
                    ),
                  );
              }),
            );
        
      
     
     
    } ),
    
    );
  }
}



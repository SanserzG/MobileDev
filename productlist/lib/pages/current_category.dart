
import 'package:flutter/material.dart';
import 'package:productlist/pages/cuurent_item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CurrentCatergory extends StatefulWidget {
  final int? number;
  CurrentCatergory({Key? key, this.number}) : super(key: key);
 

  @override
  State<CurrentCatergory> createState() => _CurrentCatergoryState();
}

class _CurrentCatergoryState extends State<CurrentCatergory> {

  
  
  @override
  Widget build(BuildContext context) {
    final number = ModalRoute.of(context)!.settings.arguments as int;
    final _future = Supabase.instance.client
      .from('Product').select().eq('category_id', number);
      
    return Scaffold(
      appBar: AppBar(
      title: Text('Список продуктов'),
      centerTitle: true,
      backgroundColor: Colors.green[200],
    ),
    body: Padding(
      padding: const EdgeInsets.only(top: 8),
      child: FutureBuilder(future: _future, builder:(context, snapshot) {
        if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
        final products = snapshot.data!;
        return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index){
          final product = products[index];
          return Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16,2,16,0),
            child: InkWell(
              onTap: () {
               
                  Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CurrentItem(number: product['id']),
              ),
            );
              },
      
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), 
                      blurRadius: 10.0,
                      offset: Offset(0, 5),
                    ),],
                ),
                child: Center(child: Text(product['name'])),
              ),
            ),
          )
          );
        } );
      } ),
    ) 
    
    );
  }
}
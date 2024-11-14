
import 'package:flutter/material.dart';
import 'package:productlist/pages/cuurent_item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FaavoriteItems extends StatefulWidget {
  final int? number;
  FaavoriteItems({Key? key, this.number}) : super(key: key);
 

  @override
  State<FaavoriteItems> createState() => _FaavoriteItemsState();
}

class _FaavoriteItemsState extends State<FaavoriteItems> {

   
   Future<String> _itemCheck(int number) async {
print(number);
 try {
    final response = await Supabase.instance.client
        .from('Product')
        .select()
        .eq('id', number)
        .single();
    
    return response['name'];    

  } catch (error) {
    return 'Error';
   

  }    

   
  }

  Future<void> navigate(int item_id) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CurrentItem(number: item_id),
        ),
      );
    

    setState(() {
  
    });
  }

  
  @override
  Widget build(BuildContext context) {
    final _future = Supabase.instance.client
      .from('FavoriteProduct').select();
     
      
    return Scaffold(
      appBar: AppBar(
      title: Text('Избранное'),
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
              
                  navigate(product['product_id']);
        
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
                child: Center(child: FutureBuilder<String>(
                  future: _itemCheck(product['product_id']),
                  builder: (context, snapshot) {
                   if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final str = snapshot.data;
                  return Text('$str');
                  
                  })),
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
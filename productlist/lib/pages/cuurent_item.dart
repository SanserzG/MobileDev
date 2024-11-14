import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:productlist/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CurrentItem extends StatefulWidget {
 final int number;
  CurrentItem({Key? key, required this.number}) : super(key: key);
 

  @override
  State<CurrentItem> createState() => _CurrentItemState();
}

class _CurrentItemState extends State<CurrentItem> {
  late int item_id;
  bool _isFavorite = false;
  int? number;
   

  @override
  void initState() {
    item_id = widget.number;
    _checkIfFavorite(item_id);
    setState(() {
      
    });
    super.initState();
  }
Future<void> _checkIfFavorite(int number) async {
print(number);
 try {
    final response = await Supabase.instance.client
        .from('FavoriteProduct')
        .select()
        .eq('product_id', number)
        .single();

  
    if(response['product_id'] as int == number) {
      _isFavorite = true;
      print(number);
      print(response['product_id']);
      setState(() {
        
      });
    }

  } catch (error) {
    
    _isFavorite = false;
  }    

   
  }

  Future<void> _toggleFavorite() async {
    final client = Supabase.instance.client;
  
    if (_isFavorite) {
      await client.from('FavoriteProduct').delete().eq('product_id', item_id);
    } else {
      await client.from('FavoriteProduct').insert([
        {'product_id': item_id}
      ]);
    }
    _isFavorite = !_isFavorite;
    setState(() {
      
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
   

   
    final _future = Supabase.instance.client
      .from('Product').select().eq('id', widget.number);
      

    
     print(_isFavorite);
    return Scaffold(
      appBar: AppBar(
      title: Text('Продукт'),
      centerTitle: true,
      backgroundColor: Colors.green[200],
      actions: [
        IconButton(onPressed: () {
        _toggleFavorite();
        
      }, icon: Icon( _isFavorite ? Icons.favorite : Icons.favorite_border,  
              color: _isFavorite==true ? Colors.red : Colors.grey,  ))
       
        ],
    ),
    body: Padding(
      padding: const EdgeInsets.only(top: 0),
      child: FutureBuilder(future: _future, builder:(context, snapshot) {
        if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
        final product = snapshot.data![0];
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
                        color: Colors.white,
                      
                      ),
          
          child: Column(
            children: [
              Expanded(
                child: Container(
                        width: double.infinity,
                        height: 1000,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: ListView(
                            children: [
                              product['image_path']!=null ? Image(image: AssetImage(product['image_path'])) : Container(),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                    child: Text(product['name'], style: TextStyle(fontSize: 20),),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(15, 15,15, 4),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text( 'Пищевая ценность на 100 г:',
                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                                            ],
                                          ),
                                            Row(
                                              children: [
                                                Text('${product['food_value']!= null ? product['food_value'] : 'Неизвестно'}',
                                                style: TextStyle(fontSize: 16)),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ), 
                                Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 10, left: 15),
                                      child: Row(
                                        children: [
                                          Text( 'Каллорийность: ',
                                            textAlign: TextAlign.justify, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                                            Text('${product['callories']!= null ? product['callories'] : 'Неизвестно'}',
                                            textAlign: TextAlign.justify, style: TextStyle(fontSize: 16),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ), 
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text( 'Описание продукта:',
                                                textAlign: TextAlign.justify, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
                                            ],
                                          ),
                                          Text( '${product['description']!= null ? product['description'] : 'Неизвестно'}',
                                        textAlign: TextAlign.justify, style: TextStyle(fontSize: 16),),
                                        ],
                                      ),
                                        
                                    ),
                                  ),
                                ],
                              ), 
                             
                              
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
        );
      } ),
    ) 
    
    );
  }
}
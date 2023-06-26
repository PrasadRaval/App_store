import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'data/product.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future<Product> getPostApi() async{

    final response = await http.get(Uri.parse("https://webhook.site/0bc6e564-18f7-4ffe-9755-7b40cfe8756b"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      return Product.fromJson(data);
    }else{
      return Product.fromJson(data);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Column(
          children:  const [
            SizedBox(height: 40,),
             Text("Apps",style: TextStyle(fontSize: 20.0,color: Colors.black),),
             Center(
              child: TextField(
                decoration: InputDecoration(
                  helperText: ("search here"),
                  prefixIcon: Icon(Icons.search,color: Colors.grey,),
                  suffixIcon: Icon(Icons.mic,color: Colors.grey,),
                ),
              ),
            ),
          ],
        ),
        bottom: const PreferredSize(
          preferredSize: Size(90, 30),
          child: SizedBox(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(onPressed: (){},
                      child: const Text("Top Free"),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(onPressed: (){},
                      child: const Text("Top Paid"),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<Product>(
              future: getPostApi(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                      itemCount: snapshot.data!.feed!.results!.length,
                      itemBuilder: (context,index){
                        return Column(
                          children: [
                            Text(index.toString())
                          ],
                        );
                      }
                  );
                }else{
                  return const Text("Loading");
                }
              },
            ),
          ),

        ],
      ),
    );
  }
}

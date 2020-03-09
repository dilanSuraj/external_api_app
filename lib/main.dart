import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyAPICallApp(),
    );
  }
}

class MyAPICallApp extends StatefulWidget {
  @override
  _MyAPICallAppState createState() => _MyAPICallAppState();
}

class _MyAPICallAppState extends State<MyAPICallApp> {

  final String apiUrl = "https://swapi.co/api/people";
  List data;

  Future<String> getJSONData() async{
    var response  = await http.get(
      Uri.encodeFull(apiUrl),
      headers: {
        "Accept":"application/json"
      }
    );
    print(response.body);

    setState(() {
      var dataConvertedToJSON = json.decode(response.body);

      data = dataConvertedToJSON['results'];

    });

    return 'successfull!!';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Retrieve JSON data via HTTP GET"),
      ),
      body: ListView.builder(
        itemCount: data == null ? 0: data.length,
        itemBuilder: (BuildContext context, int index){
          return Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    child: InkWell(
                      onTap: (){
                        showDialog(context: context, builder: (BuildContext context)=>AlertDialog(
                          content: Text(
                            "You have tapped on : "+ data[index]['name'],
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                          ),
                        ));  
                      },
                      child: Container(
                        child: Text(
                        data[index]['name'],
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      padding: const EdgeInsets.all(15),
                      )
                      
                    ),
                  )
                ],
              ),
            ),
          );
        },),
    );
  }

  @override
  void initState(){
    super.initState();

    this.getJSONData();
  }
}
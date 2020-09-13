import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../PageManager.dart';
import 'AttendCreate.dart';

  final _url = PageManagerView.url;
  // ignore: non_constant_identifier_names
  Color CornflowerBlue = Color(0xFF7087F0);

  Future<List> fetchBaby() async {
    http.Response _res = await http.get(_url + "/baby");
    List<dynamic> _resBody = json.decode(_res.body);
    return _resBody;
  }

  class AttendView extends StatefulWidget {
    @override
    _AttendViewState createState() => _AttendViewState();
  }

  class _AttendViewState extends State<AttendView> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: FutureBuilder<List>(
          future: fetchBaby(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return !snapshot.hasData ? Center(
                child: CircularProgressIndicator()) :
            SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.69,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                          color: Colors.blue[50]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0
                          ),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                print("bb");
                              },
                              onLongPress: () {
                                print("aa");
                              },
                              child: Card(
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width,
                                          child: Center(child: Text(snapshot.data[index]['fields']['BabyName'].toString(), style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                                        ),

                                        SizedBox(
                                          height: 10.0,
                                        ),

                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          child: Row(
                                            children: <Widget>[
                                              Text('학부모명 : ', style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                                              Text(snapshot.data[index]['fields']['ParentsName'].toString(), style: TextStyle(fontSize: 12))
                                            ],
                                          ),
                                        ),

                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          child: Row(
                                            children: <Widget>[
                                              Text('연락처 : ', style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                                              Text(snapshot.data[index]['fields']['Phone'].toString(), style: TextStyle(fontSize: 12))
                                            ],
                                          ),
                                        ),

                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          child: Row(
                                            children: <Widget>[
                                              Text('오늘 출석여부 : ',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                                              Text(snapshot.data[index]['fields']['attend'].toString(), style: TextStyle(fontSize: 12))
                                            ],
                                          ),
                                        ),

                                        Container(
                                          width: 55.0,
                                          height: 55.0,
                                          margin: EdgeInsetsDirectional.only(top: 5.0),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(snapshot.data[index]['fields']['attendImage'].toString()),fit: BoxFit.contain
                                            ),
                                          ),
                                        )

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),

        floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
             Navigator.of(context).push(MaterialPageRoute(builder: (context) => AttendCreate())).then((value){
              setState((){});
            });
          },
          label: Text("원아 등록", style: TextStyle(fontWeight: FontWeight.bold),
          ),
          icon: Icon(Icons.person_add),
          backgroundColor: CornflowerBlue,
        ),
      );
    }
  }

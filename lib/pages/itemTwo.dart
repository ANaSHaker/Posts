import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class itemTwo extends StatefulWidget {
  @override
  _itemTwoState createState() => _itemTwoState();
}

class _itemTwoState extends State<itemTwo> {

  Future getHomePost() async {
    var firestore = Firestore.instance;
    QuerySnapshot snap = await firestore.collection("HomeData").getDocuments();
    return snap.documents;
  }
  Future<Null>getRefresh()async{
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      getHomePost();
    });
  }
  List<MaterialColor>_colorItem =[
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.purple,
    Colors.cyan,
    Colors.amber,
    Colors.blue
  ];
  MaterialColor color;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
       future:  getHomePost(),
      builder: (context,snapshot){
         if(snapshot.connectionState == ConnectionState.waiting){
           return Center(
             child: CircularProgressIndicator(),
           );
         }else{
           return RefreshIndicator( onRefresh: getRefresh,
             child: Container(

               child: ListView.builder(
                   itemCount: snapshot.data.length,
                   itemBuilder: (context,index){
                     var ourData = snapshot.data[index];
                     color = _colorItem[index % _colorItem.length];
                     return Container(
                       height: 420.0,
                       margin: EdgeInsets.all(5),
                       child: Card(
                         elevation: 10.0,
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(20),
                         ),
                         child: Column(
                           children: <Widget>[
                            Container(
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          child: CircleAvatar(
                                            child: Text(ourData.data["title"][0],style: TextStyle(fontSize: 20),),
                                            backgroundColor: color,
                                          ),
                                        ),
                                        SizedBox(width:5),
                                        Container(
                                          child: Text(ourData.data["title"],
                                            style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 20),
                                    child: Icon(Icons.more_horiz,size: 30,),
                                  )
                                ],
                              )
                            ),
                             SizedBox(height: 10,),
                             Container(
                               margin: EdgeInsets.all(10),
                               child: ClipRRect(
                                 borderRadius: BorderRadius.circular(15),
                                 child: Image.network(ourData.data["image"],
                                   height: 200,
                                 width: MediaQuery.of(context).size.width,
                                 fit: BoxFit.contain,),
                               ),
                             ),

                             SizedBox(height: 10,),
                             Container(
                               margin: EdgeInsets.all(8),
                               child: Text(ourData.data["des"],
                               maxLines: 4,
                               style: TextStyle(
                                 fontSize: 17.0,
                                 color: Colors.black
                               ),),
                             )


                           ],
                         ),
                       ),
                     );

                   }),
             ),
           );
         }
      }),

    );
  }
}

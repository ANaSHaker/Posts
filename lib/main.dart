import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:posts/pages/itemOne.dart';
import 'package:posts/pages/itemThree.dart';
import 'package:posts/pages/itemTwo.dart';

void main() => runApp(MaterialApp(
  home: Home(),
  title: "Posts App",
  debugShowCheckedModeBanner: false,
));
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
  ItemOne(),
    itemTwo(),
    ItemThree()

  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = itemTwo(); // Our first view in viewport


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigoAccent,
        child: Icon(Icons.home),
        onPressed: () {
          setState(() {
            currentScreen =
                itemTwo(); // if user taps on this dashboard tab will be active
            currentTab = 0;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.deepPurpleAccent,

        shape: CircularNotchedRectangle(),
        notchMargin: 20,
        child: Container(

          height: 60,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                MaterialButton(
                  minWidth: 60,
                  onPressed: () {
                     setState(() {
                      currentScreen =
                          ItemOne(); // if user taps on this dashboard tab will be active
                      currentTab = 1;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.chat,
                        color: currentTab == 1 ? Colors.blue : Colors.white,
                      ),
                      Text(
                        'Chats',
                        style: TextStyle(
                          color: currentTab == 1 ? Colors.blue : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                     setState(() {
                      currentScreen =
                          ItemThree(); // if user taps on this dashboard tab will be active
                      currentTab = 2;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.dashboard,
                        color: currentTab == 2 ? Colors.blue : Colors.white,
                      ),
                      Text(
                        'Profile',
                        style: TextStyle(
                          color: currentTab == 2 ? Colors.blue : Colors.white,
                        ),
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}



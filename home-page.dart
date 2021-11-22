import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hargun2021/auth/profileBCM.dart';
import 'package:hargun2021/profile-page/user-profile.dart';
import 'package:hargun2021/tutorials/Home--page.dart';
// import 'package:hargun2021/tutorials/fetch-current-location.dart';
import 'package:hargun2021/tutorials/google-maps-with-location.dart';
import 'package:hargun2021/util/constants.dart';
// import 'package:hargun2021/tutorials/image-picker.dart';

import '../restaurants-page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int index = 0;
  List<Widget> widgets = [
    RestaurantsPage(),
    UserProfilePage(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("EDU LEARN"),
        actions: [
          util.appUser!.IsAdmin!=null ?
          util.appUser!.IsAdmin==true ?
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, "/add");
            }, icon: Icon(Icons.add_business_rounded),
            tooltip: "",

          )
          :
        Container()
          :
        Container(),
          // IconButton(
          //   onPressed: (){
          //     Navigator.pushNamed(context, "/cart");
          //   }, icon: Icon(Icons.shopping_cart),
          //   tooltip: "Cart",
          //
          // ),

          IconButton(
            onPressed: (){
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, "/login");
            }, icon: Icon(Icons.logout),
            tooltip: "",

          )
        ],
      ),

      body: widgets[index],

      bottomNavigationBar: BottomNavigationBar(
        items: [
          // 0
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "HOME"
          ),
          //2
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: "PROFILE"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_sharp),
              label: "ABOUT"
          )
        ],

        currentIndex: index,
        selectedFontSize: 16,
        selectedItemColor: Colors.deepOrange,
        onTap: (idx){ // idx will have value of the index of BottomNavBarItem
          setState(() {
            index = idx;
          });
        },
      ),

    );
  }
}
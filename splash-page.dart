import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hargun2021/model/user.dart';
import 'package:hargun2021/util/constants.dart';


class SplashPage extends StatelessWidget {

  fetchUserDetails() async{
    String uid = await FirebaseAuth.instance.currentUser!.uid.toString();
    DocumentSnapshot document = await FirebaseFirestore.instance.collection(util.USERS_COLLECTION).doc(uid).get();
    util.appUser = AppUser();

    util.appUser!.uid = document.get('uid').toString();
    util.appUser!.name = document.get('name').toString();
    util.appUser!.email = document.get('email').toString();
    util.appUser!.ImageUrl = document.get('ImageUrl').toString();
    util.appUser!.IsAdmin = document.get('IsAdmin') as bool?;
  }

  navigateToHome(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser != null ? FirebaseAuth
        .instance.currentUser!.uid : "";

    Future.delayed(
        Duration(seconds: 3),
            () {
          if (uid.isNotEmpty) {
            Navigator.pushReplacementNamed(context, "/home");
          } else {
            //Navigator.pushNamed(context, "/home");
            Navigator.pushReplacementNamed(context, "/login");
          }
        });
  }



  @override
  Widget build(BuildContext context) {

    navigateToHome(context);
    fetchUserDetails();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("educationn.png"),
            SizedBox(height: 8,),
            Text("EDU LEARN", style: TextStyle(color: Colors.deepOrange, fontSize: 20),),
            Divider(),
            Text("Build your Future", style: TextStyle(color: Colors.deepOrange, fontSize: 18),),
            SizedBox(height: 4,),
          ],
        ),
      ),
    );
  }
}
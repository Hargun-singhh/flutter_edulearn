
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  void authenticateUser(BuildContext context) async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginIDController.text,
          password: passwordController.text
      );

      print("User ID is:"+userCredential.user!.uid.toString());

      if(userCredential.user!.uid.toString().isNotEmpty){
        Navigator.pushReplacementNamed(context, "/");
      }else{
        setState(() {
          showLoader=false;

        });
      }


    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  TextEditingController loginIDController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool showLoader = false;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showLoader ? Center(child:CircularProgressIndicator()):Scaffold(
        body: Stack(
          children: [
            Column(children: [
              Expanded(
                child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: <Color>[
                          Colors.blue,
                          Colors.blueAccent,
                        ],
                        tileMode:
                        TileMode.clamp, // repeats the gradient over the canvas
                      ),
                    )),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                color: Colors.blue,
              )
            ]),
            Align(
              alignment: Alignment.center,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.0)
                ),
                margin: EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset("assets/login.png", fit: BoxFit.fill),
                            SizedBox(height: 4,),
                            Text(
                              "Enter Details to Proceed.",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 12),
                            TextFormField(
                              controller: loginIDController,
                              style: TextStyle(
                                  fontSize: 17.0, color: Colors.grey.shade900),
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              autofocus: false,
                              enabled: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Login ID is required. Please Enter.';
                                } else if (value.trim().length == 0) {
                                  return 'Login ID is required. Please Enter.';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                alignLabelWithHint: true,
                                labelText: "Login ID",
                                labelStyle: TextStyle(color: Colors.blue),
                                fillColor: Colors.transparent,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    borderSide: BorderSide(
                                        width: 1,
                                        style: BorderStyle.solid,
                                        color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    borderSide: BorderSide(
                                        width: 1,
                                        style: BorderStyle.solid,
                                        color: Colors.black)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    borderSide: BorderSide(
                                        width: 1,
                                        style: BorderStyle.solid,
                                        color: Colors.red)),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    borderSide: BorderSide(
                                        width: 1,
                                        style: BorderStyle.solid,
                                        color: Colors.grey)),
                                border: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    borderSide: BorderSide(
                                        width: 1,
                                        style: BorderStyle.solid,
                                        color: Colors.grey)),
                                contentPadding:
                                new EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                              ),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              controller: passwordController,
                              obscureText: _obscureText,
                              style: TextStyle(
                                  fontSize: 17.0, color: Colors.grey.shade900),
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              autofocus: false,
                              enabled: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password is required. Please Enter.';
                                } else if (value.trim().length < 7) {
                                  return 'Password must be 7 characters.';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  filled: true,
                                  alignLabelWithHint: true,
                                  labelText: "Password",
                                  labelStyle: TextStyle(color: Colors.blue),
                                  fillColor: Colors.transparent,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                      borderSide: BorderSide(
                                          width: 1,
                                          style: BorderStyle.solid,
                                          color: Colors.grey)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                      borderSide: BorderSide(
                                          width: 1,
                                          style: BorderStyle.solid,
                                          color: Colors.black)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                      borderSide: BorderSide(
                                          width: 1,
                                          style: BorderStyle.solid,
                                          color: Colors.red)),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                      borderSide: BorderSide(
                                          width: 1,
                                          style: BorderStyle.solid,
                                          color: Colors.grey)),
                                  border: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                      borderSide: BorderSide(
                                          width: 1,
                                          style: BorderStyle.solid,
                                          color: Colors.grey)),
                                  contentPadding:
                                  new EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                                  suffixIcon: IconButton(
                                      color: Colors.blue,
                                      icon: Icon(_obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        _toggle();
                                      })),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(top: 10, bottom: 4),
                                child: TextButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        showLoader=true;
                                        authenticateUser(context);
                                      });

                                    }
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    elevation: 10,
                                  ),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                            Text("By Logging in You accept our Terms & Conditions", style: TextStyle(
                                fontSize: 12.0, color: Colors.grey, fontWeight: FontWeight.w300),
                              textAlign: TextAlign.center,),
                            InkWell(
                              onTap: (){
                                // open the webview for privacy
                              },
                              child: Text(
                                'Privacy Policy',
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.orange, fontWeight: FontWeight.w300, decoration: TextDecoration.underline),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 4),
                            InkWell(
                              onTap: (){
                                // open the webview for terms and conditions
                              },
                              child: Text(
                                'Terms & Conditions',
                                style: TextStyle(
                                  fontSize: 14.0, color: Colors.orange, fontWeight: FontWeight.w300, decoration: TextDecoration.underline,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 4),
                            InkWell(
                              onTap:(){
                                Navigator.pushNamed(context, "/register");
                              } ,
                              child: Text(
                                'New User? Register Here',
                                style: TextStyle(
                                  fontSize: 18.0, color: Colors.blue, fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              ),
            ),
          ],
        ));  }
}

class MyTextField extends StatefulWidget {
  const MyTextField({Key? key}) : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField();
  }
}
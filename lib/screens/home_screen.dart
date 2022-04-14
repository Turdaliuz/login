import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  final String loginText;

  const HomeScreen(this.loginText, {Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  String phone = "";

  @override
  void initState() {
    super.initState();
    final User? user = _auth.currentUser;
    phone = user?.phoneNumber ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              color: Colors.cyan,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 16),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/img.png"),
                      radius: 56,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 12, bottom: 10),
                    child: Center(
                        child: Column(
                          children: [
                            Text(
                              "${widget.loginText}",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black),
                ),
              ),
            ),
            OutlinedButton(
              onPressed: () {},
              child: Container(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Ism:",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(width: 30),
                    Text(
                      "${widget.loginText}",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),

            OutlinedButton(
              onPressed: () {},
              child: Container(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Telefon raqam:",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(width: 30),
                    Text(
                      "$phone",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            // OutlinedButton(
            //   onPressed: () {  },
            //   child: Container(
            //     padding: EdgeInsets.only(left: 20),
            //
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         Text("", style: TextStyle(color: Colors.black),),
            //         SizedBox(width: 80),
            //         Text("34 000 so'm", style: TextStyle(color: Colors.grey),),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _auth.signOut();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}

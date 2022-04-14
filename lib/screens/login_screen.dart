import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

import 'home_screen.dart';

enum MobileVerificationState {
  // ignore: constant_identifier_names
  SHOW_MOBILE_FORM_STATE,
  // ignore: constant_identifier_names
  SHOW_OTP_FORM_STATE,
}

// ignore: use_key_in_widget_constructors
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final phoneController = TextEditingController();


  final loginController = TextEditingController();

  final otpController = TextEditingController();

  // ignore: prefer_final_fields
  FirebaseAuth _auth = FirebaseAuth.instance;

  late String verificationId;

  bool showLoading = false;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });


    
    try {
      final authCredential =
      await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential.user != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(loginController.text)));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      _scaffoldKey.currentState
      // ignore: deprecated_member_use
          ?.showSnackBar(SnackBar(content: Text("$e.message")));
    }
  }

  getMobileFormWidget(context) {
    return Column(
      children: [
        const Spacer(),
        TextField(
          controller: loginController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelText: 'Ismingiz',
          ),
        ),
        SizedBox(height: 24),

        TextField(
          controller: phoneController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelText: 'Telefon raqamingiz',
          ),
        ),

        SizedBox(height: 24),

        const SizedBox(
          height: 28,
        ),
        // ignore: deprecated_member_use
        FlatButton(
          height: 44,
          onPressed: () async {
            setState(() {
              showLoading = true;
            });

            await _auth.verifyPhoneNumber(
              phoneNumber: phoneController.text,
              verificationCompleted: (phoneAuthCredential) async {
                setState(() {
                  showLoading = false;
                });
                //signInWithPhoneAuthCredential(phoneAuthCredential);
              },
              verificationFailed: (verificationFailed) async {
                setState(() {
                  showLoading = false;
                });
                // ignore: deprecated_member_use
                _scaffoldKey.currentState?.showSnackBar(
                    SnackBar(content: Text("$verificationFailed.message")));
              },
              codeSent: (verificationId, resendingToken) async {
                setState(() {
                  showLoading = false;
                  currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                  this.verificationId = verificationId;
                });
              },
              codeAutoRetrievalTimeout: (verificationId) async {},
            );
          },
          child: const Text(
            "Tizimga kirish",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          color: Colors.blue,
          textColor: Colors.white,
        ),
        const Spacer(),
      ],
    );
  }

  getOtpFormWidget(context) {
    return Column(
      children: [
        const Spacer(),

        TextField(
          controller: otpController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelText: 'SMS-da borgan kodni kiriting...',
          ),
        ),

        const SizedBox(
          height: 16,
        ),
        // ignore: deprecated_member_use
        FlatButton(
          onPressed: () async {
            PhoneAuthCredential phoneAuthCredential =
            PhoneAuthProvider.credential(
                verificationId: verificationId,
                smsCode: otpController.text);

            signInWithPhoneAuthCredential(phoneAuthCredential);
          },
          child: const Text("Tasdiqlash"),
          color: Colors.blue,
          textColor: Colors.white,
        ),
        const Spacer(),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          child: showLoading
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
              ? getMobileFormWidget(context)
              : getOtpFormWidget(context),
          padding: const EdgeInsets.all(16),
        ));
  }
}

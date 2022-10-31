import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent /*Color(0xffE4E0E5)*/,
        elevation: 0,
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 48.0,
          ),
        ),
      ),
      backgroundColor: Color(0xffE4E0E5),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                  ),
                ),
                SingleChildScrollView(
                    child: Column(
                  children: [
                    Lottie.asset('assets/image/forget-password.json',
                        width: 300.0, height: 300.0),
                    SizedBox(height: 20.0),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Recovery email...',
                        fillColor: Color(0xffD2D2D2),
                        filled: true,
                        prefixIcon: Icon(Icons.email),
                        prefixIconColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffD2D2D2)),
                            borderRadius: BorderRadius.circular(12.0)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffD2D2D2)),
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        minimumSize: Size.fromHeight(50.0),
                        primary: Color(0xffD4BEBE),
                        onPrimary: Colors.black,
                      ),
                      onPressed: () {},
                      child: Text('Reset Password'),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:complaint_app/screens/complaint_details.dart';
import 'package:complaint_app/screens/forgot_password.dart';
import 'package:complaint_app/screens/view_complain_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/image/loginbg.png'),
          )),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20.0),
                    Text(
                      'Welcome Admin',
                      style: const TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Lottie.asset('assets/image/hello.json'),
                    SizedBox(height: 10.0),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        prefixIcon: Icon(Icons.email),
                        fillColor: Colors.grey.shade400,
                        filled: true,
                        prefixIconColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                          BorderSide(width: 0, color: Colors.grey.shade400),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                          BorderSide(width: 0, color: Colors.grey.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                          BorderSide(width: 0, color: Colors.grey.shade400),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        prefixIcon: Icon(Icons.lock),
                        fillColor: Colors.grey.shade400,
                        filled: true,
                        prefixIconColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                          BorderSide(width: 0, color: Colors.grey.shade400),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                          BorderSide(width: 0, color: Colors.grey.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                          BorderSide(width: 0, color: Colors.grey.shade400),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ForgotPassword(),
                            ));
                          },
                          child: Text(
                            'Forgot password?',
                            style: TextStyle(color: Colors.red, fontSize: 20.0),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                        minimumSize: Size.fromHeight(55.0),
                        primary: Color(0xffD4BEBE),
                        onPrimary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onPressed: () async {
                        var email = emailController.text.trim();
                        var password = passwordController.text.trim();
                        if(email == 'admin@gmail.com'){
                          try {
                            if (email.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text('Email field is required', style: TextStyle(color: Colors.white),),));
                              return;
                            }
                            if (password.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text('Password field is required', style: TextStyle(color: Colors.white),),));
                              return;
                            }

                            //connection to firebase authentication
                            FirebaseAuth authentication =  FirebaseAuth.instance;
                            UserCredential userCredentials = await authentication.signInWithEmailAndPassword(
                                email: email,
                                password: password
                            );
                            if(userCredentials != null){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text('Logged in Successfully',
                                      style: TextStyle(color: Colors.white, fontSize: 18),),));
                            }
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>ViewComplainList()));
                          }on FirebaseAuthException catch (e) {
                            if(e.code == 'user-not-found'){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text('User not found!',
                                      style: TextStyle(color: Colors.white, fontSize: 18),),));
                            }
                            if(e.code == 'wrong-password'){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text('Wrong password!',
                                      style: TextStyle(color: Colors.white, fontSize: 18),),));
                            }
                          }catch (e){
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text('Something went wrong',
                                    style: TextStyle(color: Colors.white, fontSize: 18),),));
                          }
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('You are not authorized for this admin app',
                                  style: TextStyle(color: Colors.white, fontSize: 18),),));
                          return;
                        }
                      },
                      child: Text('Sign In'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

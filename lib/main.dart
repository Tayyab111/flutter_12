import 'package:complaint_app/admin_login.dart';
import 'package:complaint_app/screens/complaint_details.dart';
import 'package:complaint_app/screens/view_complain_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FirebaseAuth.instance.currentUser != null ? ViewComplainList() : AdminLogin(),
  ));
}



import 'package:complaint_app/screens/complains_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import '../admin_login.dart';
import 'complaint_details.dart';

class ViewComplainList extends StatefulWidget {
  const ViewComplainList({Key? key}) : super(key: key);

  @override
  State<ViewComplainList> createState() => _ViewComplainListState();
}

class _ViewComplainListState extends State<ViewComplainList> {
  DatabaseReference? databaseReference;

  @override
  void initState() {
    super.initState();
     databaseReference = FirebaseDatabase.instance.reference().child("users");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xffE4E0E5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Registered Users', style: TextStyle(color: Colors.black),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => AdminLogin()));
          }, icon: Icon(Icons.logout, color: Colors.black,))
        ],
      ),
      body: StreamBuilder(
          stream: databaseReference != null ? databaseReference!.onValue : null,
          builder: (context, snapshot){
            try{
              if(snapshot.hasData){
                var snapshotData = Map<String, dynamic>.from((snapshot.data as dynamic).snapshot.value);

                var userList = [];
                snapshotData.forEach((key, value) {
                  userList.add(value);
                });

                return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, i){
                      return Container(
                        padding: EdgeInsets.only(top: 10,bottom: 10,left: 12 ,right: 12),
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Color(0xffD2D2D2),
                            borderRadius: BorderRadius.circular(13.0)
                        ),
                        child: InkWell(
                          onTap: (){

                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => ComplainsList(
                                  userId: userList[i]['userId'],
                                )));
                          },
                          child:  ListTile(
                            title: Text('${userList[i]['fullName']}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xff19303E)),),
                            subtitle: Text('${userList[i]['email']}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Color(0xff19303E)),),
                            //trailing: Text('Status',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Color(0xff19303E))),
                          ),
                        ),
                      );
                    });

              }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }catch (e){
              return Center(
                child: Text('No users available yet!'),
              );
            }


          }),
    );
  }
}

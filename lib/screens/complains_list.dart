import 'package:complaint_app/admin_login.dart';
import 'package:complaint_app/screens/complaint_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ComplainsList extends StatefulWidget {
  final userId;
  const ComplainsList({Key? key, required this.userId}) : super(key: key);

  @override
  State<ComplainsList> createState() => _ComplainsListState();
}

class _ComplainsListState extends State<ComplainsList> {
  DatabaseReference? databaseReference;
  String? uid ;
  int _selectedIndex = 0;
  var _status = 'all';


  @override
  void initState() {
    super.initState();
     uid = widget.userId;
    databaseReference = FirebaseDatabase.instance.reference()
        .child("Complains").child(uid!);

  }
  List _selectedPage = <String>[
    'all',
    'Unseen',
    'Seen'
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE4E0E5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios, color: Colors.black,)),
        actions: [
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminLogin()));
          }, icon: Icon(Icons.logout, color: Colors.black,))
        ],
      ),
      body: StreamBuilder(
          stream: databaseReference != null ? databaseReference!.onValue : null,
          builder: (context, snapshot){
            try{
              if(snapshot.hasData){
                var snapshotData = Map<String, dynamic>.from((snapshot.data as dynamic).snapshot.value);

                var complainList = [];
                snapshotData.forEach((key, value) {
                  complainList.add(value);
                });

                return ListView.builder(
                    itemCount: complainList.length,
                    itemBuilder: (context, i){
                      if(complainList[i]['status'] == _status){
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
                                builder: (context) => ComplaintDetails(
                                  complainId: complainList[i]['complainId'],
                                  userId: uid
                                )));
                          },
                          child:  ListTile(
                            title: Text('${complainList[i]['complainTitle']}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xff19303E)),),
                            subtitle: Text('${complainList[i]['description']}', overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Color(0xff19303E),),),
                            trailing: Text('${complainList[i]['status']}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Color(0xff19303E))),
                          ),
                        ),
                      );
                      }else if(_status == 'all'){
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
                                  builder: (context) => ComplaintDetails(
                                      complainId: complainList[i]['complainId'],
                                      userId: uid
                                  )));
                            },
                            child:  ListTile(
                              title: Text('${complainList[i]['complainTitle']}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xff19303E)),),
                              subtitle: Text('${complainList[i]['description']}', overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Color(0xff19303E),),),
                              trailing: Text('${complainList[i]['status']}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Color(0xff19303E))),
                            ),
                          ),
                        );
                      }else{
                        return SizedBox(
                          height: 0,
                        );

                      }
                    });

              }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }catch (e){
              return Center(
                child: Text('No compalains registered yet!', style: TextStyle(fontSize: 20,),),
              );
            }
          }),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value){
          print(_selectedPage[value]);
          setState((){
            _selectedIndex = value;
            _status = _selectedPage[value];
          });
        },
          selectedFontSize: 18,
          showSelectedLabels: false,
          unselectedFontSize: 18,
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.list, color: Colors.grey,),
              label: 'All',
              activeIcon: Icon(Icons.list, color: Colors.grey.shade700,), ),
            BottomNavigationBarItem(
                icon: Icon(Icons.visibility_off, color: Colors.redAccent,),
              label: 'Unseen',
              activeIcon: Icon(Icons.visibility_off, color: Colors.red,), ),
            BottomNavigationBarItem(
                icon: Icon(Icons.visibility, color: Colors.greenAccent,),
              label: 'Seen',
              activeIcon: Icon(Icons.visibility, color: Colors.green,),),
          ],
      ),
    );
  }
}

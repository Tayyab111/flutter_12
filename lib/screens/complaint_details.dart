import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ComplaintDetails extends StatefulWidget {
  final complainId;
  final userId;
  const ComplaintDetails({Key? key, required this.complainId, required this.userId}) : super(key: key);

  @override
  State<ComplaintDetails> createState() => _ComplaintDetailsState();
}

class _ComplaintDetailsState extends State<ComplaintDetails> {
  DatabaseReference? databaseReference;

  @override
  void initState() {
    super.initState();
    String complainId = widget.complainId;
    String userId = widget.userId;
    databaseReference = FirebaseDatabase.instance
        .reference().child("Complains")
        .child(userId)
        .child(complainId);
   // print(userId);

    databaseReference?.update({
      'status': 'Seen'
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE4E0E5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 30.0,
            color: Colors.black,
          ),
        ),
      ),
      body: StreamBuilder(
          stream: databaseReference != null ? databaseReference!.onValue : null,
          builder: (context, snapshot){
            try{
              if(snapshot.hasData){
                var data = Map<String, dynamic>.from((snapshot.data as dynamic).snapshot.value);
                //print(data);
                return Padding(
                  padding: EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Color(0xffD2D2D2),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              data['fullName'].toString().toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Color(0xffD2D2D2),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              data['rollNo'].toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Color(0xffD2D2D2),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              data['mobileNo'].toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Color(0xffD2D2D2),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              data['hostelName'].toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Color(0xffD2D2D2),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              data['roomNo'].toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Color(0xffD2D2D2),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              data['complainTitle'].toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Color(0xffD2D2D2),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Text(
                                data['description'].toString(),
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                )),
                          ),
                        ),
                        SizedBox(height: 30.0),
                        /*Container(
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(0, 5), blurRadius: 5.0)],
                  borderRadius: BorderRadius.circular(12.0),
                    gradient: LinearGradient(
                        colors: [Color(0xffD2D2D2), Color(0xffD4BEBE)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [0.0, 1.0],
                    ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                    minimumSize: Size(300.0, 50.0),
                    primary: Colors.transparent,
                    shadowColor: Colors.transparent,
                    onSurface: Colors.transparent,
                    onPrimary: Colors.black
                  ),
                  onPressed: () {

                  },
                  child: Text('Print'),
                ),
              ),*/
                        //SizedBox(height: 30.0)
                      ],
                    ),
                  ),
                );
              }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }catch (e){
              return Center(
                child: Text('Something went wrong!'),
              );
            }

          })
    );
  }
}

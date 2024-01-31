import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/model/details.dart';
import 'package:firebase_crud/pages/user_registration.dart';
import 'package:firebase_crud/services/database.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var fullName = TextEditingController();
  var mobileNumber = TextEditingController();
  var buildingName = TextEditingController();
  var street = TextEditingController();
  var city = TextEditingController();
  var state = TextEditingController();
  var pinCode = TextEditingController();
  Stream? UserStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getData();
    });
  }

  void getData() async {
      UserStream = await FirebaseMethods().getUserDetails();
      print(UserStream);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Employee Details",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black45,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserRegistrationScreen(),
              ));
        },
        tooltip: "Add User",
        child: Icon(Icons.add),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: StreamBuilder(
          stream: UserStream,
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: Text("Loading...",
                      style:
                          TextStyle(color: Color(0xffF67952), fontSize: 30)));
            }
            return snapshot.data!.docs.isEmpty
                ? Center(
                    child: Text("No Addresses to Display",
                        style:
                            TextStyle(color: Color(0xffF67952), fontSize: 30)))
                : ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 10,
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white)),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data.docs[index]["fullName"],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700,
                                    fontFamily: "sans-serif-condensed-light"),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.data.docs[index]["buildingName"],
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700,
                                    fontFamily: "sans-serif-condensed-light"),
                              ),
                              Text(
                                snapshot.data.docs[index]["street"],
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700,
                                    fontFamily: "sans-serif-condensed-light"),
                              ),
                              Text(
                                snapshot.data.docs[index]["city"],
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700,
                                    fontFamily: "sans-serif-condensed-light"),
                              ),
                              Text(
                                snapshot.data.docs[index]["state"],
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700,
                                    fontFamily: "sans-serif-condensed-light"),
                              ),
                              Text(
                                snapshot.data.docs[index]["pinCode"],
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700,
                                    fontFamily: "sans-serif-condensed-light"),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Phone : ${snapshot.data.docs[index]["mobileNumber"]}",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700,
                                    fontFamily: "sans-serif-condensed-light"),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                      child: Container(
                                        margin: EdgeInsets.all(5),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                fullName.text = snapshot.data.docs[index]["fullName"];
                                                mobileNumber.text = snapshot.data.docs[index]["mobileNumber"];
                                                buildingName.text = snapshot.data.docs[index]["buildingName"];
                                                street.text = snapshot.data.docs[index]["street"];
                                                city.text = snapshot.data.docs[index]["city"];
                                                pinCode.text = snapshot.data.docs[index]["pinCode"];
                                                state.text = snapshot.data.docs[index]["state"];
                                                String id = snapshot.data.docs[index]["id"];
                                                showDialog(context: context, builder: (context) => AlertDialog(
                                                  actions: [
                                                    Container(
                                                        margin: EdgeInsets.all(5),
                                                        child: ElevatedButton(
                                                            onPressed: () async{
                                                              if(fullName.text.isNotEmpty && mobileNumber.text.isNotEmpty && buildingName.text.isNotEmpty && street.text.isNotEmpty && state.text.isNotEmpty && pinCode.text.isNotEmpty && city.text.isNotEmpty ){
                                                                var userInfo = UserDetails(id: id,fullName: fullName.text, mobileNumber: mobileNumber.text, buildingName: buildingName.text, street: street.text, state: state.text, pinCode: pinCode.text, city: city.text);
                                                                await FirebaseMethods().updateUserDetails(userInfo, id).then((value) {
                                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User Details Updated Successfully")));
                                                                });
                                                                fullName.clear();
                                                                mobileNumber.clear();
                                                                buildingName.clear();
                                                                street.clear();
                                                                city.clear();
                                                                pinCode.clear();
                                                                state.clear();

                                                              }
                                                              else{
                                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter All the Details")));
                                                              }
                                                              Navigator.pop(context);
                                                            },
                                                            child: Text("Update")))
                                                  ],
                                                  content: SingleChildScrollView(
                                                    child: Container(
                                                      padding: EdgeInsets.all(10),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [

                                                          Card(
                                                            shape:OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.white)),
                                                            elevation: 10,
                                                            child: Container(
                                                                padding: EdgeInsets.all(10),
                                                                width: double.infinity,
                                                                child: Column(
                                                                  children: [
                                                                    Container(alignment: Alignment.topLeft,
                                                                      child: Text("User Info :",style: TextStyle(
                                                                          fontSize: 20,
                                                                          fontWeight: FontWeight.bold,
                                                                          color: Colors.grey.shade700,
                                                                          fontFamily: "sans-serif-condensed-light"),),
                                                                    ),
                                                                    SizedBox(height: 10,),
                                                                    TextField(
                                                                        controller: fullName,
                                                                        cursorColor: Color(0xffF67952),
                                                                        decoration: InputDecoration(
                                                                            labelText: "Full Name",
                                                                            labelStyle: TextStyle(color: Color(0xffF67952)),
                                                                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffF67952)))
                                                                        )
                                                                    ),
                                                                    SizedBox(height: 10,),
                                                                    TextField(
                                                                      controller: mobileNumber,
                                                                      keyboardType: TextInputType.number,
                                                                      decoration: InputDecoration(
                                                                          labelStyle: TextStyle(color: Color(0xffF67952)),
                                                                          labelText: "Mobile Number",
                                                                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffF67952)))
                                                                      ),
                                                                    ),
                                                                    SizedBox(height: 10,)
                                                                  ],
                                                                )
                                                            ) ,
                                                          ),
                                                          SizedBox(height: 30,),
                                                          Card(
                                                            shape:OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.white)),
                                                            elevation: 10,
                                                            child: Container(
                                                                padding: EdgeInsets.all(10),
                                                                width: double.infinity,
                                                                child: Column(
                                                                  children: [
                                                                    Container(alignment: Alignment.topLeft,
                                                                      child: Text("Address Info :",style: TextStyle(
                                                                          fontSize: 20,
                                                                          fontWeight: FontWeight.bold,
                                                                          color: Colors.grey.shade700,
                                                                          fontFamily: "sans-serif-condensed-light"),),
                                                                    ),
                                                                    SizedBox(height: 10,),
                                                                    TextField(
                                                                        controller: buildingName,
                                                                        cursorColor: Color(0xffF67952),
                                                                        decoration: InputDecoration(
                                                                            labelText: "Building Name/Flat no/Door no ",
                                                                            labelStyle: TextStyle(color: Color(0xffF67952)),
                                                                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffF67952)))
                                                                        )
                                                                    ),
                                                                    SizedBox(height: 10,),
                                                                    TextField(
                                                                      controller: street,
                                                                      decoration: InputDecoration(
                                                                          labelStyle: TextStyle(color: Color(0xffF67952)),
                                                                          labelText: "Street / Area / Locality",
                                                                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffF67952)))
                                                                      ),
                                                                    ),
                                                                    SizedBox(height: 10,),
                                                                    TextField(
                                                                        controller: city,
                                                                        cursorColor: Color(0xffF67952),
                                                                        decoration: InputDecoration(
                                                                            labelText: "City / Village ",
                                                                            labelStyle: TextStyle(color: Color(0xffF67952)),
                                                                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffF67952)))
                                                                        )
                                                                    ),
                                                                    SizedBox(height: 10,),
                                                                    TextField(
                                                                          controller: pinCode,
                                                                          keyboardType: TextInputType.number,
                                                                          cursorColor: Color(0xffF67952),
                                                                          decoration: InputDecoration(
                                                                              labelText: "Pin Code",
                                                                              labelStyle: TextStyle(color: Color(0xffF67952)),
                                                                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffF67952)))
                                                                          )
                                                                      ),
                                                                    SizedBox(height: 10,),
                                                                    TextField(
                                                                          controller: state,
                                                                          cursorColor: Color(0xffF67952),
                                                                          decoration: InputDecoration(
                                                                              labelText: "State",
                                                                              labelStyle: TextStyle(color: Color(0xffF67952)),
                                                                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffF67952)))
                                                                          )
                                                                      ),
                                                                    SizedBox(height: 10,),


                                                                  ],

                                                                )
                                                            ) ,
                                                          ),
                                                          SizedBox(height: 30,),

                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  title: Text("Edit User Details"),
                                                ),);
                                              },
                                              child: Text("Edit")))),
                                  Expanded(
                                      child: Container(
                                          margin: EdgeInsets.all(5),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                showDialog(context: context, builder: (context) => AlertDialog(
                                                  title: Text("Do you really want to delete ?"),
                                                  actions: [
                                                    ElevatedButton(onPressed: (){
                                                      Navigator.pop(context);
                                                    }, child: Text("No")),
                                                    ElevatedButton(onPressed: () async{
                                                      String id = snapshot.data.docs[index]["id"];
                                                      await FirebaseMethods().deleteUserDetails(id);
                                                      Navigator.pop(context);
                                                    }, child: Text("Yes"))
                                                  ],
                                                ),);

                                              },
                                              child: Text("Delete")))),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}

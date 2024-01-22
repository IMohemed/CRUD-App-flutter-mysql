//import 'dart:typed_data';

import 'dart:io';

//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mysql/dbconnection.dart';
import 'package:flutter_mysql/first.dart';
import 'package:flutter_mysql/form.dart';
import 'package:fluttertoast/fluttertoast.dart';

class view extends StatefulWidget {
  const view({super.key});

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {
  FToast? fToast;
  Uint8List? selectedImage;
  Image? selectedImage1;
  List wholedata=[];
  File? imag;
  @override
  void initState() {
    getdata();
    super.initState();
    fToast=FToast();
    //deletedata();
  }
  


  getdata()async{ 
    database local= database();
    
    await local.getData();
    wholedata = local.data;
    setState(() {
      
    });
    print(wholedata);
  }

  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: ()async {
        
        Navigator.push(context,MaterialPageRoute(builder: (context) => First()),);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
           automaticallyImplyLeading: false,
      leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.push(context,MaterialPageRoute(builder: (context) => First()),);
        
      },
      ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Sample app",style: TextStyle(color: Colors.black),),
              //Text("News",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)
            ],
            ),
            //centerTitle: true,
            backgroundColor: Colors.blue,
          elevation: 0.0,
         ),
         body: SingleChildScrollView(
           child:Container(
                  child: ListView.builder(shrinkWrap: true,physics: ClampingScrollPhysics(),itemCount: wholedata.length,itemBuilder: (context,index){
                    var fname = wholedata[index]["firstName"];
                var lname = wholedata[index]["lastName"];
                var uname = wholedata[index]["username"];
                var pass = wholedata[index]["passwod"];
                var img = wholedata[index]["image"];
                var path = wholedata[index]["imagePath"];
                    // return BlogTile(imageUrl: articles[index].urltoimage!, title: articles[index].title!,
                    //  desc:articles[index].description!,auther: articles[index].auther!,
                    //  );
                    return GestureDetector(
                  onTap: ()=> {
                   // _showToast(context)
                    },
                 
                child:Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 6.0),
                    child: Material(
                      
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(10.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 4.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top:25.0),
                                child: img!=null? CircleAvatar(
                                                radius: 50,
                                                backgroundImage: NetworkImage(img),
                                              ):const CircleAvatar(
                                                radius: 50,
                                                backgroundImage: NetworkImage("https://icon-library.com/images/add-image-icon-png/add-image-icon-png-21.jpg"),
                                              ),
                              ),
                              SizedBox(width: 7.0,),
                              
                              Padding(
                                padding: EdgeInsets.only (left:20.0),
                                child: Column(
                                
                                  children: [Container(
                                    width: MediaQuery.of(context).size.width/1.9,
                                    child: Text("First name:  ${fname}",maxLines: 2,style: TextStyle(color: Colors.black,fontSize: 17.0,fontWeight: FontWeight.w500),)
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.9,
                                    child: Text("Last name:  ${lname}",maxLines: 2,style: TextStyle(color: Colors.black,fontSize: 17.0,fontWeight: FontWeight.w500),)
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.9,
                                    child: Text("Username:  ${uname}",maxLines: 2,style: TextStyle(color: Colors.black,fontSize: 17.0,fontWeight: FontWeight.w500),)
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.9,
                                    child: Text("Password:  ${pass}",maxLines: 2,style: TextStyle(color: Colors.black,fontSize: 17.0,fontWeight: FontWeight.w500),)
                                  ),
                                  SizedBox(height: 5.0,),
                                  Row(
                                    children: [
                                      Container(
                                      width: MediaQuery.of(context).size.width/1.9,
                                      child: OutlinedButton.icon(
                                          label: Text('Delete',style: TextStyle(color: Colors.red[400])),
                                          icon: Icon(Icons.delete),
                                            onPressed: () async{
                                              showAlertDialog(uname);
                                },
                                      ),),
                                    ],
                                  ),
                                  SizedBox(height: 5.0,),
                                  Container(
                                  width: MediaQuery.of(context).size.width/1.9,
                                  child: OutlinedButton.icon(
                                      label: Text('update',),
                                      icon: Icon(Icons.edit_sharp),
                                        onPressed: (){
                                                        Navigator.push(context,MaterialPageRoute(builder: (context) => Form1(fname: fname,lname: lname,uname: uname,pass: pass,imag:path)),);
                                                    }
                                  ),
                                ),]
                                ),
                              ),
                              
                            ],
                          ),
                      ),
                      
                    ),
                  ),
                ),
                );
    
                  }),
                )
         )
      ),
    );
  }
  showAlertDialog(String uname) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("No"),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Yes"),
    onPressed:  ()async {
      database local = database();
                              await local.deleteData(uname: uname);
    
                              await local.getData();
                               //Navigator.of(context).pop();
                              wholedata=local.data;
                             setState(() {
                               wholedata;
                             });
                             Navigator.of(context).pop();

    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Delete",style: TextStyle(color: Colors.red[700])),
    content: Text('Do you really want to delete the username "${uname}"?'),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
_showToast() {
    Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.redAccent[400],
        ),
        child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
            Icon(Icons.check),
            SizedBox(
            width: 12.0,
            ),
            Text("Deleted Successfully!"),
        ],
        ),
    );


    fToast?.showToast(
        child: toast,
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 2),
    );
    
    // Custom Toast Position
    fToast?.showToast(
        child: toast,
        toastDuration: Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            top: 16.0,
            left: 16.0,
          );
        });
}
}



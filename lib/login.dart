import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mysql/dbconnection.dart';
import 'package:flutter_mysql/first.dart';
import 'package:flutter_mysql/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';




class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formkey=GlobalKey<FormState>();
   FToast? fToast;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast=FToast();
    fToast!.init(context);
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
        
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Login '),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                    validator: (name) {
                  if(name == ""){
                    //if(name!.length<3){return "name should have atleast 3 characters";}
                  return "Required*";
                  };
                 },
                 autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: (name) {
                  if(name == ""){
                    //if(name!.length<3)return "name should have atleast 3 characters";
                  return "Required*";
                  };
                 },
                 autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    
                    onPressed: ()async {
                      // Handle button press
                      bool idExists = await database().login(uname:usernameController.text??'',pwod:passwordController.text??'');
                      if(_formkey.currentState!.validate()){
                        if(!idExists){
                        _showTost("invalid username or password");
                      }
                     else {  
                      Navigator.push(context,MaterialPageRoute(builder: (context) => First()),);
                      
                        usernameController == null;  
                        passwordController == null;}
                      }
                      
                      else{
                       
                       // _showToast1();
                
                      // Add your logic for handling username and password
                      //print('Username: $username, Password: $password');
                    }
                      },
                      
                      
                    child: Text('Login'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle button press
                      Navigator.push(context,MaterialPageRoute(builder: (context) => signup()),);
                    },
                    child: Text('Sign up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  
    
  }
  _showTost(name) {
    Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.grey,
        ),
        child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
            //Icon(Icons.check),
            SizedBox(
            width: 12.0,
            ),
            Text(name),
        ],
        ),
    );


    // fToast?.showToast(
    //     child: toast,
    //     gravity: ToastGravity.BOTTOM,
    //     toastDuration: Duration(seconds: 2),
    // );
    
    // Custom Toast Position
    fToast?.showToast(
        child: toast,
        toastDuration: Duration(seconds: 2),
        gravity: ToastGravity.BOTTOM,
        );
}
  void _showToast1() {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content:  Text('field is empty'),
        //action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
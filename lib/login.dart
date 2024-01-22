import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mysql/dbconnection.dart';
import 'package:flutter_mysql/first.dart';
import 'package:flutter_mysql/signup.dart';


class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
        
                  onPressed: ()async {
                    // Handle button press
                    bool idExists = await database().login(uname:usernameController.text??'',pwod:passwordController.text??'');
                    if(usernameController.text != '' && passwordController.text != ''){
                      if(!idExists){
                      _showToast();
                    }
                    else{  
                    Navigator.push(context,MaterialPageRoute(builder: (context) => First()),);
                    
                      usernameController == null;  
                      passwordController == null;}
                    
                    }
                    else{
                     
                      _showToast1();
    
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
    );
  
    
  }
  void _showToast() {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content:  Text('invalid username or password'),
        //action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
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
import 'package:flutter/material.dart';
import 'package:flutter_mysql/dbconnection.dart';
import 'package:flutter_mysql/login.dart';


class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
        
        Navigator.push(context,MaterialPageRoute(builder: (context) => login()),);
        return false;
      },
      child: Scaffold(
        
        appBar: AppBar(
          title: Text('Sign up'),
        ),
        body: Padding(
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
                onPressed: () async{
                  // Handle button press
                  bool idExists = await database().login(uname: usernameController.text??'',pwod: passwordController.text??'');
                 if(usernameController.text !='' && passwordController.text !=''){
                                         if(idExists){
                                                  _showToast();
                                           }
                                          else await database().saveData(pwod: passwordController.text,uname: usernameController.text);
                                          //Navigator.of(context).pop();
                                          }
                                           
                                          // else{
                                          //   _showToast();
                                          // }
    
                  // Add your logic for handling username and password
                 // print('Username: $username, Password: $password');
                },
                child: Text('Save'),
              ),
              
            ],
          ),
        ),
      ),
    );
  
    
  }
  void _showToast() {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content:  Text('field is empty'),
        //action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
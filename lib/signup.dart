import 'package:flutter/material.dart';
import 'package:flutter_mysql/dbconnection.dart';
import 'package:flutter_mysql/login.dart';
import 'package:fluttertoast/fluttertoast.dart';

final _formkey=GlobalKey<FormState>();


class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  FToast? fToast;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast=FToast();
  }


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
                     // if(name!.length<3)return "name should have atleast 3 characters";
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
                    onPressed: () async{
                      // Handle button press
                      bool idExists = await database().login(uname: usernameController.text??'',pwod: passwordController.text??'');
                     if(_formkey.currentState!.validate()){
                                             if(idExists){
                                                      _showTost("Already esxists");
                                               }
                                              else {await database().saveData(pwod: passwordController.text,uname: usernameController.text);
                                            
                                              //Navigator.of(context).pop();
                                              }
                                               
                                              // else{
                                              //   _showToast();
                                              // }
                
                      // Add your logic for handling username and password
                     // print('Username: $username, Password: $password');
                    }},
                    child: Text('Save'),
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
        color: Colors.greenAccent,
        ),
        child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
            Icon(Icons.check),
            SizedBox(
            width: 12.0,
            ),
            Text(name),
        ],
        ),
    );


    fToast?.showToast(
        child: toast,
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 2),
    );
    
    // Custom Toast Position
    
}
  _showTost1(name) {
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
}
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class database{
  List data=[];
  var url="http://192.168.1.121/test/insert.php";
  Future<void> fetchData({fname,lname,uname,pwod,imag,base,path}) async {
  print(fname);
  
  try{final res = await http.post(Uri.parse(url),body: {
    'fname': fname,
    'lname': lname,
    'uname': uname,
    'pwod': pwod,
    'image':imag,
    'base':base,
    'filePath':path
  });
  print('Response: ${res.body}');
  if (res.statusCode == 200) {
    print("success");
    // Process the data
  } else {
    throw Exception('Failed to load data');
  }}
  catch(error){
    print("Network error: $error");
    showToast("Network error: $error");
  }
}
void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
Future<void> getData({fname,lname,uname,pwod}) async {
  var url="http://192.168.1.121/test/retrieve.php";
  print(fname);
  try{final response = await http.get(Uri.parse(url));
  data=jsonDecode(response.body);
  print("this ${data}");
  if (response.statusCode == 200) {
    print("success");
    // Process the data
  } else {
    throw Exception('Failed to load data');
  }}
  catch(error){
      print("Network error: $error");
    showToast("Network error: $error");
  }
}
Future<void> updateData({fname,lname,uname,pwod,imag,base,path}) async {
  print(fname);
  var url="http://192.168.1.121/test/update.php";
 try {final res = await http.post(Uri.parse(url),body: {
    'fname': fname,
    'lname': lname,
    'uname': uname,
    'pwod': pwod,
    'image':imag,
    'base':base,
    'filePath':path
  });
  print('Response: ${res.body}');
  if (res.statusCode==200) {
    print("success");
    // Process the data
  } else {
    throw Exception('Failed to load data');
  }}
  catch(error){
    print("Network error: $error");
    showToast("Network error: $error");
  }
}

Future<void> deleteData({uname}) async {
  var url="http://192.168.1.121/test/delete.php";
  print(uname);
  try{final response = await http.post(Uri.parse(url),body: {'uname': uname});
  //data=jsonDecode(response.body);
  if (response.statusCode == 200) {
    print("success");
    // Process the data
  } else {
    throw Exception('Failed to load data');
  }}
  catch(error){ 
      print("Network error: $error");
    showToast("Network error: $error");
  }
}

Future<void> saveData({uname,pwod}) async {
  var url="http://192.168.1.121/test/save.php";
  print(uname);
  try{final response = await http.post(Uri.parse(url),body: {'uname': uname,'pwod':pwod});
  //data=jsonDecode(response.body);
  if (response.statusCode == 200) {
    print("success");
    // Process the data
  } else {
    throw Exception('Failed to load data');
  }}
  catch(error){ 
      print("Network error: $error");
    showToast("Network error: $error");
  }
}

// Future<bool> isIdAlreadyExists({ String? uname}) async {
//   var url="http://192.168.1.121/test/exists.php";
//   print(uname);
//   final response = await http.post(Uri.parse(url),body: {'uname': uname});
//   data=jsonDecode(response.body);
//   print("this ${data}");
//   print('Response: ${response.body}');
//   if (response.statusCode == 200) {
    
//     print("success");
//     // Process the data
//   } else {
//     throw Exception('Failed to load data');
//   }
//   return data.isNotEmpty;
  
 
// }

Future<bool> isIdAlreadyExists({String? uname}) async {
  var url = "http://192.168.1.121/test/exists.php";
  print(uname);
  final response = await http.post(Uri.parse(url), body: {'uname': uname});

  if (response.statusCode == 200) {
    // Process the data
    Map<String, dynamic> data = jsonDecode(response.body);
    print("this $data");

    // Assuming your PHP script returns a JSON object with a "success" key
    if (data['success']) {
      print("success");
      return true;
    } else {
      print("failure");
      return false;
    }
  } else {
    throw Exception('Failed to load data');
  }
}
Future<bool> login({ uname,pwod}) async {
  var url = "http://192.168.1.121/test/login.php";
  print(uname);
  final response = await http.post(Uri.parse(url), body: {'uname': uname,'pwod':pwod});

  if (response.statusCode == 200) {
    // Process the data
    Map<String, dynamic> data = jsonDecode(response.body);
    print("this $data");

    // Assuming your PHP script returns a JSON object with a "success" key
    if (data['success']) {
      print("success");
      return true;
    } else {
      print("failure");
      return false;
    }
  } else {
    throw Exception('Failed to load data');
  }
}
}


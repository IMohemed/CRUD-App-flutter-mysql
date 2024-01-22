import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mysql/dbconnection.dart';
import 'package:flutter_mysql/view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

final _formkey=GlobalKey<FormState>();

class Form1 extends StatefulWidget {
  //const Form1({super.key});
  String? fname,lname,uname,pass,imag;
  Form1({this.fname,this.lname,this.uname,this.pass,this.imag,});
  @override
  State<Form1> createState() => _Form1State();
}

class _Form1State extends State<Form1> {
  TextEditingController fnameController = TextEditingController();
    TextEditingController lnameController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController pwordController = TextEditingController();
    FToast? fToast;
    File? _image;
    Uint8List? selectedImage;
    String? img,base;
    String? imageName;
    final imagePicker = ImagePicker();
    void initState() {
    //checkdata();
    //_pickimage();
    //getdata();
    super.initState();
    fToast=FToast();
    if (widget.imag != null) {
                   final imgFile = File(widget.imag!);

  if (imgFile.existsSync() && imgFile.statSync().type == FileSystemEntityType.file) {
    _image = imgFile;
    img=widget.imag;
    imageName=widget.imag!.split('/').last;
    selectedImage = _image?.readAsBytesSync();
    base = base64Encode(selectedImage!);
    print('path is ${selectedImage}');
  } else {
    print('Invalid file path: ${widget.imag!}');
  }
                         } 
    
  }

  @override
  Widget build(BuildContext context) {
    
 

 
 fnameController=widget.fname != null ? TextEditingController(text: "${widget.fname}") : fnameController;
 lnameController=widget.lname != null ? TextEditingController(text: "${widget.lname}") : lnameController;
 usernameController=widget.uname != null ? TextEditingController(text: "${widget.uname}") : usernameController;
 pwordController=widget.pass != null ? TextEditingController(text: "${widget.pass}") : pwordController;

    return Scaffold(
      appBar: AppBar(
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
        
         child: Form(
          key: _formkey,
           child: Column(
            
             
           
            children: [
              SizedBox(height: 10.0,),
              selectedImage!=null? CircleAvatar(
                radius: 50,
                backgroundImage: MemoryImage(selectedImage!),
              ):const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage("https://th.bing.com/th/id/OIP.UoP79f2D8ELqNgSbt02C1wHaHa?rs=1&pid=ImgDetMain"),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Pick image from gallery
                  _pickimage();
                },
                child: Text('Pick Image'),
              ),
              SizedBox(height: 10.0,),
              TextFormField(controller: fnameController,
                 //keyboardType: TextInputType.number,
                 //enabled:  == null,
                 
                 decoration:InputDecoration(
                  border:OutlineInputBorder(),
                  label:Text('First name'),
                 ),
                 validator: (name) {
                  if(name == ""){
                    if(name!.length<3)return "name should have atleast 3 characters";
                  return "Required*";
                  };
                 },
                 autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              SizedBox(height: 10.0,),
              TextFormField(controller: lnameController,
                 //keyboardType: TextInputType.number,
                 //enabled:  == null,
                 
                 decoration:InputDecoration(
                  border:OutlineInputBorder(),
                  label:Text('Last name'),
                 ),
               validator: (name) {
                  if(name == ""){
                    if(name!.length<3)return "name should have atleast 3 characters";
                  return "Required*";
                  };
                 },
               autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              SizedBox(height: 10.0,),
              TextFormField(controller: usernameController,
                 //keyboardType: TextInputType.number,
                 //enabled:  == null,
                 enabled: widget.uname == null,
                 decoration:InputDecoration(
                  border:OutlineInputBorder(),
                  label:Text('Username'),
                 ),
             validator: (name) {
                  if(name == ""){
                    if(name!.length<3)return "name should have atleast 3 characters";
                  return "Required*";
                  };
                 },
             autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              SizedBox(height: 10.0,),
              TextFormField(controller: pwordController,
                 //keyboardType: TextInputType.number,
                 //enabled:  == null,
                 
                 decoration:InputDecoration(
                  border:OutlineInputBorder(),
                  label:Text(' password'),
                 ),
              validator: (name) {
                  if(name == ""){
                    if(name!.length<3)return "name should have atleast 3 characters";
                  return "Required*";
                  };
                 },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              SizedBox(height: 5.0,),
              widget.uname==null?
              ElevatedButton(
                
                onPressed: () async {
                  bool idExists = await database().isIdAlreadyExists(uname:usernameController.text??'');
                  // Pick image from gallery
                  if(_formkey.currentState!.validate() && selectedImage!=null)
                  // if(fnameController.text != '' && lnameController.text != '' && usernameController.text != '' && pwordController.text != '' && selectedImage != null)
                  {
                    if(idExists){
                      _showToast2();
                    }
                    else{
                  await database().fetchData(fname: fnameController.text,lname: lnameController.text,uname: usernameController.text,pwod: pwordController.text,imag: imageName,base: base,path:img);
                  _showToast();
         
                    pwordController.text == null;
                  };
                  } 
                  
                },
                child: Text('Save'),
              ):
              
              ElevatedButton(
                                      child: Text('update'),
                                          onPressed: () async{
                                            //
                                            // pwordController == '';
                                            showAlertDialog(fnameController.text,lnameController.text,usernameController.text,pwordController.text,imageName,base,img);
                                            //await localDatabase().readAllD ata();
                                        },
                                  ),                    
            ]
            ),
         ),
          )
    );
  }
  Future _pickimage() async{
    try{
              final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
               //String? img=pickedFile?.path;
              if (pickedFile== null) return;
              
                 
                // Convert image to Uint8List
                //final bytes = await pickedFile.readAsBytes();
                
                  
                  setState(() {
                    _image=File(pickedFile!.path);
                   imageName=pickedFile.path.split('/').last;
                  selectedImage = _image?.readAsBytesSync();
                  base=base64Encode(selectedImage!);
                  });
                
                //Navigator.of(context).pop();
                //String img=Utility.
                img=pickedFile.path;
                print('base is ${base}');
                print(selectedImage);
              }
              catch(e){
                print("");
                //return "error";
              }
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
  void _showToast2() {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content:  Text('username already exists'),
        //action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
  _showToast() {
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
            Text("Saved successfully!"),
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
  showAlertDialog( fname,lname,uname,pwod,iname,base,img) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("No"),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Yes"),
    onPressed:  () async{
       if(fnameController.text != '' && lnameController.text != '' && usernameController.text != '' && pwordController.text != '' && imageName != '')
                                           await database().updateData(fname: fname,lname: lname,uname: uname,pwod: pwod,imag: iname,base: base,path: img);
                                           Navigator.push(context,MaterialPageRoute(builder: (context) => view()));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Update"),
    content: Text('Do you want to update the username "${uname}"?'),
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
}
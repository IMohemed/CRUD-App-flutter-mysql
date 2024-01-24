import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mysql/form.dart';
import 'package:flutter_mysql/view.dart';
import 'package:flutter_mysql/dependency_Injection.dart';

class First extends StatefulWidget {
  const First({super.key});

  @override
  State<First> createState() => _FirstState();
}
 
class _FirstState extends State<First> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dependencyInjection.init();
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
         body: Column(
          children: [
            ElevatedButton(
                                      child: Text('Add'),
                                          onPressed:() async{
                                            //await localDatabase().updateData(Name: pnameController?.text,id: pidController?.text,pprice: puprceController?.text,sprice: sepriceController?.text,image: img);
                                            Navigator.push(context,MaterialPageRoute(builder: (context) => Form1()));
                                            //await localDatabase().readAllD ata();
                                        },
                                  ),
            ElevatedButton(
                                      child: Text('view'),
                                          onPressed: () async{
                                            //await localDatabase().updateData(Name: pnameController?.text,id: pidController?.text,pprice: puprceController?.text,sprice: sepriceController?.text,image: img);
                                            Navigator.push(context,MaterialPageRoute(builder: (context) => view()));
                                            //await localDatabase().readAllD ata();
                                        },
                                  ),                      
          ],
         ),
    
      ),
    );
  }
}
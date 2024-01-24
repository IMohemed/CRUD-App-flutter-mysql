//import 'dart:ffi';

import 'package:flutter_mysql/network_controller.dart';
import 'package:get/get.dart';

class dependencyInjection{
  static void init(){
    Get.put<NetworkController>(NetworkController(),permanent: true);
  }
}
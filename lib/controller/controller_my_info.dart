import 'package:get/get.dart';
import 'package:jongsul/models/user/service_user.dart';
import 'package:jongsul/models/user/user_data.dart';
class MyInfo extends GetxController{
  ServiceUser _serviceUser = ServiceUser.init();
  ServiceUser get serviceUser => _serviceUser;


  Future<ServiceUser> getMyInfo() async {
    _serviceUser = await getServiceUser();
    update();
    return _serviceUser;
  }

}
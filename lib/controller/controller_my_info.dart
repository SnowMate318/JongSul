import 'package:get/get.dart';
import 'package:jongsul/models/user/service_user.dart';
import 'package:jongsul/models/user/user_data.dart';

class MyInfo extends GetxController{
  late ServiceUser _serviceUser;
  ServiceUser get serviceUser => _serviceUser;

  @override
  void onInit() {
    // TODO: implement onInit
    _serviceUser = ServiceUser.init();
    super.onInit();
  }

  void setMyInfo(ServiceUser serviceUser)
  {
    _serviceUser = serviceUser;
    update();
  }

  Future<ServiceUser> getMyInfo() async {
    _serviceUser = await getServiceUser();
    update();
    return _serviceUser;
  }

  Future<bool> setMyInfo(ServiceUser user) async {

    bool ret = await setServiceUser(user.toJson());
    update();
    return ret;
  }

//   Future<bool> removeStudent(String id) async {
//
//     // bool ret = await deleteServiceUser(id);
//     // update();
//     return ret;
// }

}
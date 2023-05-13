import 'package:get/get.dart';
import 'package:schedualmoon/component/app_color.dart';
import 'package:schedualmoon/models/login.dart';
import 'package:schedualmoon/models/repository/login_services.dart';

class LoginControllar extends GetxController {
  EmployeeLogin? employeeLogin;
  var isLoading = true.obs;
  var isError = false.obs;

  //inject for jokerepository
  @override
  onInit() {
    // i need to call this when start ann application , layout , etc..
    //and no find any need to statefullwidget
    //print("hello from controller init");
    //getLoginemployee();
    super.onInit();
    ever(isError, (value) {
      if (value == isError(true)) {
        Get.snackbar("Problem", "your have a problem in internet connection",
            backgroundColor: AppColor.blueForLogin1,
            colorText: AppColor.lighteOrange);
      }
    });
  }

  getLoginemployee(employeeId) async {
    try {
      isLoading(true);
      var employee = await LoginRepository.getLoginemployee(employeeId);
      if (employee != null) {
        employeeLogin = employee;
        return employeeLogin;
      } else {
        print("empty");
        return "";
      }
    } catch (error) {
      print("error from login view: " + error.toString());
      isError(true);
    } finally {
      isLoading(false);
    }
  }
}

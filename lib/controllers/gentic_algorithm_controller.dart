import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/models/repository/gentic_algorithm_services.dart';

class GenticAlgorithmController extends GetxController {
  run(String semester, String jsonEmployeeOff, String departmentId,
      String semesterId) async {
    try {
      EasyLoading.show(status: 'wait'.tr);
      var result = await GenticAlgorithmRepository.run(
          semester, jsonEmployeeOff, departmentId, semesterId);
      if (result == null) {
        EasyLoading.showError('error');
        return "";
      } else if (result.toString().startsWith('0000')) {
        EasyLoading.showError('error'.tr);
        print(result);
      } else {
        EasyLoading.showSuccess('True');
        return result;
      }
    } catch (error) {
      print('error from run algorithm ' + error.toString());
    }
  }
}

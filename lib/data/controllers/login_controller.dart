import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/models/authentication_models/login.dart';
import '../data_source.dart';


class LoginController extends GetxController {
  final DataSource api = DataSource();

  var isLoading = false.obs;

  Future<bool> loginUser({required String phone, required String password}) async {
    try {
      isLoading.value = true;

      final LoginModel result = await api.login(phone: phone, password: password);

      if (result.success == true) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool("isLoggedIn", true);
        await prefs.setString("token", result.data?.token ?? "");

        return true; // success
      } else {
        Get.snackbar("Error", result.message ?? "Login failed ❌", snackPosition: SnackPosition.BOTTOM);
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}

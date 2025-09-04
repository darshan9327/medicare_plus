import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/models/authentication_models/register.dart';
import '../data_source.dart';

class RegisterController extends GetxController {
  final DataSource api = DataSource();

  var isLoading = false.obs;

  /// Return bool instead of void
  Future<bool> registerUser({required String name, required String phone, required String email, required String password}) async {
    try {
      isLoading.value = true;

      final RegisterModel result = await api.register(name: name, phone: phone, email: email, password: password);

      if (result.success == true) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool("isLoggedIn", true);
        await prefs.setString("token", result.data?.token ?? "");

        return true; // ✅ success
      } else {
        Get.snackbar("Error", result.message ?? "Signup failed ❌", snackPosition: SnackPosition.BOTTOM);
        return false; // ✅ failed
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}

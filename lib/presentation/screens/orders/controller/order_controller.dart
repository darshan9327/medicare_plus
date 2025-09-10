import 'package:get/get.dart';
import '../../../../data/data_source.dart';
import '../../../../core/models/user_models/get_user_orders.dart';

class OrdersController extends GetxController {
  final DataSource api = DataSource();

  RxList<Order> orders = <Order>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders({int userId = 1, int page = 1, int limit = 10}) async {
    try {
      isLoading.value = true;
      final response = await api.getUserOrders(userId: userId, page: page, limit: limit);
      if (response.success && response.data != null) {
        orders.value = response.data as List<Order>;
      } else {
        orders.clear();
      }
    } finally {
      isLoading.value = false;
    }
  }

  void addOrder(Order order) {
    orders.insert(0, order);
  }
}

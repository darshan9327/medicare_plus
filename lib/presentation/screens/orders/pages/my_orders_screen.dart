import 'package:flutter/material.dart';
import '../../../../core/models/order_models/create_order.dart' as create_order_model;
import '../../../../core/models/user_models/get_user_orders.dart';
import '../../../../data/data_source.dart';
import '../../common/utils/common_appbar.dart';
import '../widgets/my_order_widget/order_card.dart';

class MyOrders extends StatefulWidget {
  final create_order_model.Order? newOrder;

  const MyOrders({super.key, this.newOrder});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  late Future<List<Order>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = fetchOrders();
  }

  Future<List<Order>> fetchOrders() async {
    int userId = 1;
    final response = await DataSource().getUserOrders(userId: userId);

    List<Order> orders = [];
    if (response.success && response.data != null) {
      orders = response.data!.orders;
    }

    if (widget.newOrder != null) {
      orders.insert(0, widget.newOrder! as Order);
    }

    return orders;
  }

  Future<void> _refreshOrders() async {
    final orders = await fetchOrders();
    setState(() {
      _ordersFuture = Future.value(orders);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: "My Orders"),
      body: FutureBuilder<List<Order>>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No orders available"));
          }

          final orders = snapshot.data!;
          return RefreshIndicator(
            onRefresh: _refreshOrders,
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return OrderCard(order: order);
              },
            ),
          );
        },
      ),
    );
  }
}


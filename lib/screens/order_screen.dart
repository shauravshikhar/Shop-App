import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  //for stateful widget
  // var _isLoading = false;
  // @override
  // void initState() {
  // Future.delayed(Duration.zero).then((_) async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  //   setState(() {
  //     _isLoading = false;
  //   });
  // });

  //both above and below work as same

  // _isLoading = true;
  // Provider.of<Orders>(context, listen: false).fetchAndSetOrders().then((_){
  //   setState(() {
  //     _isLoading = false;
  //   });
  //});

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    print('building orders');
    //final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapShot.error != null) {
              return Center(
                child: Text('An error occured'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, index) => OrderItem(
                    orderData.orders[index],
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}

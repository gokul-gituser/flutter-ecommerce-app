import 'package:ecommerce_app/pages/add_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/controller/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          title: Text("XYZ Store"),
        ),
        body: ListView.builder(
            itemCount: ctrl.products.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(ctrl.products[index].name ?? ''),
                subtitle: Text((ctrl.products[index].price ?? 0).toString()),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    ctrl.deleteProduct(ctrl.products[index].id ?? '');
                  },
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(onPressed: () {
          Get.to(const AddProductPage());
        },
          child: Icon(Icons.add),),);
    });
  }
}

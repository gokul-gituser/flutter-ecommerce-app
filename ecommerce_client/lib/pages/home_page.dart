import 'package:ecommerce_client/controllers/home_controller.dart';
import 'package:ecommerce_client/pages/login_page.dart';
import 'package:ecommerce_client/pages/product_details.dart';
import 'package:ecommerce_client/utils/multi_select_dropdown.dart';
import 'package:ecommerce_client/utils/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/dropdown_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return RefreshIndicator(
        onRefresh: ()async{
          await ctrl.fetchProducts();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "XYZ Store",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [IconButton(onPressed: () {
              GetStorage box = GetStorage();
              box.erase();
              Get.offAll(LoginPage());
            }, icon: Icon(Icons.logout))
            ],
          ),
          body: Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: ctrl.categories.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          ctrl.filterByCategory(ctrl.categories[index].name ?? '');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Chip(label: Text(ctrl.categories[index].name ?? 'Error')),
                        ),
                      );
                    }),
              ),
              Row(
                children: [
                  Flexible(
                    child: DropDownBtn(
                      items: ['Low to High', 'High to Low'],
                      selectedItem: 'Sort by Price',
                      onSelected: (selected) {
                        ctrl.sortByPrice( ascending: selected == 'Low to High' ?true : false,);
                        print(selected);

                      },
                    ),
                  ),
                  Flexible(
                      child: MutliSelectDropDown(
                        items: ['Sony', 'Apple','amazon'],
                        onSelectionChange: (selectedItems) {
                          print(selectedItems);
                          ctrl.filterByBrand(selectedItems);
                        },
                      ))
                ],
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8),
                    itemCount: ctrl.filteredProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        name: ctrl.filteredProducts[index].name ?? 'No Name',
                        imageUrl: ctrl.filteredProducts[index].image ?? 'No Image',
                        price: ctrl.filteredProducts[index].price ?? 00,
                        offerTag: '30% off',
                        onTap: () {
                          Get.to(ProductDetailsPage(), arguments: {'data' : ctrl.filteredProducts[index]});
                        },);
                    }),
              ),
            ],
          ),
        ),
      );
    });
  }
}

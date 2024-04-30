import 'package:ecommerce_app/utils/dropdown_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:ecommerce_app/controller/home_controller.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Add New Product"),
        ),
        body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(10),
              width: double.maxFinite,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Text("Name", style: TextStyle(),),
                    TextField(
                      controller: ctrl.productNameCtrl,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          label: Text("Product Name"),
                          hintText: "Enter the name of your product here"
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      maxLines: 4,
                      controller: ctrl.productDescriptionCtrl,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),

                          label: Text("Product Description"),
                          hintText: "Enter the description of your product here"
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                        controller: ctrl.productImgCtrl,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          label: Text("Image Url"),
                          hintText: "Enter the image url of your product here"
                      ),
                    )
                    , SizedBox(height: 10,),
                    TextField(
                        controller: ctrl.productPriceCtrl,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          label: Text("Price"),
                          hintText: "Enter the price of your product here"
                      ),
                    ),
                    SizedBox(height: 10,),

                    Row(
                      children: [
                        Flexible(child: DropDownBtn(
                          items: ['Fashion', 'Electronics','Sports'],
                          selectedItem: ctrl.category,
                          onSelected: (selectedValue) {
                           ctrl.category = selectedValue ?? 'general';
                           ctrl.update();
                          },)),
                        Flexible(child: DropDownBtn(items: ['amazon','Sony','Apple', 'Nikon'],
                            selectedItem: ctrl.brand,
                            onSelected: (selectedValue) {
                              ctrl.brand = selectedValue ?? 'xyz';
                              ctrl.update();

                            })),
                      ],
                    ),
                    SizedBox(height: 10,),

                    Text("Offer"),
                    DropDownBtn(items: ['true', 'false'],
                        selectedItem: ctrl.offer.toString(),
                        onSelected: (selectedValue) {
                          ctrl.offer = bool.tryParse(selectedValue ?? "false") ?? false;
                          ctrl.update();
                        }),
                    SizedBox(height: 10,),
                    ElevatedButton(style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white
                    ), onPressed: () {
                      ctrl.addProduct();
                    }, child: Text("Add")),

                  ]
              )
              ,
            )),
      );
    });
  }
}

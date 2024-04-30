import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_client/model/category/category.dart';
import 'package:ecommerce_client/model/product/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;
  late CollectionReference categoryCollection;

  List<Product> products =[];
  List<Product> filteredProducts =[];
  List<Category> categories =[];

  @override
  Future<void> onInit()async{
    categoryCollection = firestore.collection('categories');
    productCollection = firestore.collection('products');
    await fetchCategories();
    await fetchProducts();
    super.onInit();
  }


  fetchProducts() async{
    try {
      QuerySnapshot productSnapshot= await  productCollection.get();
      final List<Product> retrievedProducts = productSnapshot.docs.map((doc) =>
          Product.fromJson(doc.data() as Map<String,dynamic>)).toList();
      products.clear();
      products.assignAll(retrievedProducts);
      filteredProducts.assignAll(products);
      Get.snackbar("Success", "Data fetched Successfully",colorText: Colors.green);
    } catch (e) {
      Get.snackbar("Error",e.toString(),colorText: Colors.red);

      print(e);
    }finally{
      update();
    }
  }

  fetchCategories() async{
    try {
      QuerySnapshot categorySnapshot= await  categoryCollection.get();
      final List<Category> retrievedCategories= categorySnapshot.docs.map((doc) =>
          Category.fromJson(doc.data() as Map<String,dynamic>)).toList();
      categories.clear();
      categories.assignAll(retrievedCategories);
    } catch (e) {
      Get.snackbar("Error",e.toString(),colorText: Colors.red);

      print(e);
    }finally{
      update();
    }
  }

  filterByCategory(String category){
    filteredProducts.clear();
    filteredProducts = products.where((product) => product.category == category).toList();
    update();
  }

  filterByBrand(List<String> brands){
    if(brands.isEmpty){
      filteredProducts = products;
    }else{
      List<String> lowerCaseBrands = brands.map((brand) => brand.toLowerCase()).toList();
      filteredProducts = products.where((product)=> lowerCaseBrands.contains(product.brand?.toLowerCase())).toList();
    }
    update();
  }

  sortByPrice({required bool ascending}){
    List<Product> sortedProducts = List<Product>.from(filteredProducts);
    sortedProducts.sort((a,b) => ascending ? a.price!.compareTo(b.price!) : b.price!.compareTo(a.price!));
    filteredProducts = sortedProducts;
    update();
  }
}

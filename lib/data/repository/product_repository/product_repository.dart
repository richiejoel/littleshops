import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:littleshops/data/model/category_model.dart';
import 'package:littleshops/data/model/product_model.dart';
import 'package:littleshops/data/repository/product_repository/product_repository_abstract.dart';

class ProductRepository implements IProductRepository{
  final CollectionReference productCollection =
  FirebaseFirestore.instance.collection("products");

  final CollectionReference categoryCollection =
  FirebaseFirestore.instance.collection("categories");

  @override
  Future<List<Product>> fetchProducts() async {
    return await productCollection
        .get()
        .then((snapshot) => snapshot.docs
        .map((doc) => Product.fromMap(doc.id, doc.data()!))
        .toList())
        .catchError((error) {});
  }

  @override
  Future<List<Product>> fetchPopularProducts() async {
    return await productCollection
        .orderBy("soldQuantity", descending: true)
        .limit(10)
        .get()
        .then((snapshot) => snapshot.docs
        .map((doc) => Product.fromMap(doc.id, doc.data()))
        .toList())
        .catchError((error) {});
  }

  @override
  Future<List<Product>> fetchDiscountProducts() async {
    return await productCollection
        .orderBy("percentOff", descending: true)
        .where("percentOff", isGreaterThan: 0)
        .limit(10)
        .get()
        .then((snapshot) => snapshot.docs
        .map((doc) => Product.fromMap(doc.id, doc.data()!))
        .toList())
        .catchError((error) {});
  }


  @override
  Future<List<Product>> fetchProductsByCategory(String? categoryId) async {
    return await productCollection
        .where("categoryId", isEqualTo: categoryId)
        .get()
        .then((snapshot) => snapshot.docs
        .map((doc) => Product.fromMap(doc.id, doc.data()!))
        .toList())
        .catchError((error) {});
  }

  @override
  Future<Product> getProductById(String pid) async {
    return await productCollection
        .doc(pid)
        .get()
        .then((doc) => Product.fromMap(doc.id, doc.data()!))
        .catchError((error) {});
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    return await categoryCollection
        .get()
        .then((snapshot) => snapshot.docs
        .map((doc) => CategoryModel.fromMap(doc.id, doc.data()!))
        .toList())
        .catchError((err) {});
  }

  @override
  Future<CategoryModel> getCategoryById(String categoryId) async {
    return await categoryCollection
        .doc(categoryId)
        .get()
        .then((doc) => CategoryModel.fromMap(doc.id, doc.data()!))
        .catchError((err) {});
  }

  @override
  Future<void> updateProductRatingById(String id, double rating) async {
    return await productCollection
        .doc(id)
        .update({"rating": rating}).catchError((error) {});
  }

  @override
  Future<void> addProductByChief(Product newProduct) async {
    var product = productCollection.doc();
    await product
        .set(newProduct.toMap(product.id))
        .catchError((error) => print(error));
  }

  @override
  Future<void> updateProductSoldQuantityById(String id, int soldQuantity) async {
    return await productCollection
        .doc(id)
        .update({"soldQuantity": soldQuantity}).catchError((error) {});
  }

  @override
  Future<String> fetchChiefByProductId(String? productId) async {
    return await productCollection
        .doc(productId)
        .get()
        .then((doc) => doc.data()!['businessId'])
        .catchError((error) {});
  }

  ///Singleton factory
  static final ProductRepository _instance =
  ProductRepository._internal();

  factory ProductRepository() {
    return _instance;
  }

  ProductRepository._internal();

}
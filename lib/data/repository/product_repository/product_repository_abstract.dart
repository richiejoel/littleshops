import 'package:littleshops/data/model/category_model.dart';
import 'package:littleshops/data/model/product_model.dart';

abstract class IProductRepository {
  /// Obtener todos los productos
  Future<List<Product>> fetchProducts();
  /// Obtener productos populares
  Future<List<Product>> fetchPopularProducts();
  /// Obtener productos con descuento
  Future<List<Product>> fetchDiscountProducts();
  /// Obtener productos por categoria
  Future<List<Product>> fetchProductsByCategory(String? categoryId);
  /// Obtener producto por ID
  Future<Product> getProductById(String pid);
  /// Actualizar calificacion producto
  Future<void> updateProductRatingById(String pid, double rating);
  /// Obtener todas los categorias
  Future<List<CategoryModel>> getCategories();
  /// Obtener categoria por ID
  Future<CategoryModel> getCategoryById(String categoryId);
  /// Agregar nuevo producto por chief
  Future<void> addProductByChief(Product newProduct);
  ///Actualizar los productos vendidos
  Future<void> updateProductSoldQuantityById(String id, int soldQuantity);

}
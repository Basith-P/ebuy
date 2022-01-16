import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model_product.dart';
import '../models/http-exception_modal.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   desc: 'A red shirt - it is pretty red!',
    //   price: 289.99,
    //   imgURL: 'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //     id: 'p2',
    //     title: 'Trousers',
    //     desc: 'A nice pair of trousers.',
    //     price: 599.99,
    //     imgURL: 'https://allensolly.imgix.net/img/app/product/3/349170-1713908.jpg'),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   desc: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 519.99,
    //   imgURL: 'https://m.media-amazon.com/images/I/61262Gnan0L._SL1001_.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   desc: 'Prepare any meal you want.',
    //   price: 449.99,
    //   imgURL:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
    // Product(
    //   id: 'p5',
    //   title: 'Water bottle',
    //   desc:
    //       'AInstaLite Unbreakable Sports Water Bottle 1 Litre with Time Markings, BPA Free Non-Toxic Water Bottle for Gym, Office Water Bottle',
    //   price: 229.99,
    //   imgURL: 'https://m.media-amazon.com/images/I/81zdMi6Dz7L._SX425_.jpg',
    // ),
    // Product(
    //   id: 'p6',
    //   title: 'Shoe',
    //   desc:
    //       'WORLD WEAR FOOTWEAR Men Red-1243 Sports Shoes, Running Shoes for Men,Cricket Shoes,Casual Shoes,Trekking Shoes,Comfortable for Men\'s.',
    //   price: 379.00,
    //   imgURL: 'https://m.media-amazon.com/images/I/71D9ImsvEtL._UY500_.jpg',
    // ),
    // Product(
    //   id: 'p7',
    //   title: 'Casual Shirt',
    //   desc: 'IndoPrimo Men\'s Regular Fit Casual Shirt',
    //   price: 699.00,
    //   imgURL: 'https://m.media-amazon.com/images/I/41DfnHdewBL.jpg',
    // ),
    // Product(
    //   id: 'p8',
    //   title: 'Surface Laptop 4',
    //   desc:
    //       'Microsoft Surface Laptop 4 AMD Ryzen™ 5 4680U 13.5 inch Touchscreen Laptop (8GB/256GB SSD/Windows 10 Home /AMD Radeon™ Graphics/Platinum/1.265 kg, 25% Off on Microsoft 365)',
    //   price: 102366.00,
    //   imgURL: 'https://m.media-amazon.com/images/I/81KoSSAwH2L._SL1500_.jpg',
    // ),
    // Product(
    //   id: 'p9',
    //   title: 'Sports Mask',
    //   desc: 'Under Armour Adult Sports Mask',
    //   price: 4899.00,
    //   imgURL: 'https://m.media-amazon.com/images/I/51Qk6fHHB-L._UX569_.jpg',
    // ),
    // Product(
    //   id: 'p10',
    //   title: 'Galaxy S21 5G ',
    //   desc:
    //       'Samsung Galaxy S21 5G (Phantom Gray, 8GB, 128GB Storage) with No Cost EMI/Additional Exchange Offers',
    //   price: 64990.00,
    //   imgURL: 'https://m.media-amazon.com/images/I/91BGpV19r0L._SX466_.jpg',
    // ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favItems {
    return _items.where((element) => element.isFav == true).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    const url = 'https://ebuy-007-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProds = [];
      extractedData.forEach((prodId, prodData) {
        loadedProds.insert(
          0,
          Product(
            id: prodId,
            title: prodData['title'],
            desc: prodData['desc'],
            price: prodData['price'],
            imgURL: prodData['imgURL'],
          ),
        );
      });
      _items = loadedProds;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    const url = 'https://ebuy-007-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'title': product.title,
          'price': product.price,
          'desc': product.desc,
          'imgURL': product.imgURL,
          'isFav': product.isFav,
        }),
      );

      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        price: product.price,
        desc: product.desc,
        imgURL: product.imgURL,
      );
      _items.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product newProd) async {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      final url = 'https://ebuy-007-default-rtdb.firebaseio.com/products/$id.json';
      await http.patch(
        Uri.parse(url),
        body: jsonEncode({
          'title': newProd.title,
          'desc': newProd.desc,
          'price': newProd.price,
          'imgUrl': newProd.imgURL,
        }),
      );
      _items[prodIndex] = newProd;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProd(String id) async {
    final url = 'https://ebuy-007-default-rtdb.firebaseio.com/products/$id.json';
    final existingProdIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProd = _items[existingProdIndex];

    _items.removeWhere((element) => element.id == id);
    notifyListeners();

    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _items.insert(existingProdIndex, existingProd);
      notifyListeners();
      throw HttpException('Could not delete product');
    }

    existingProd.dispose();
  }
}

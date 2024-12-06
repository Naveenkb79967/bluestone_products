import 'package:bluestone_products/pages/product_details.dart';
import 'package:flutter/material.dart';
import '../services/http_service.dart';
import '../widgets/custom_text.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final ApiService _apiService = ApiService();
  List<dynamic> _products = [];
  int _currentPage = 1;
  final int _limit = 5;
  bool _isLoading = false;
  late double _deviceWidth ,_deviceHeight;
  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      final fetchedProducts =
      await _apiService.fetchProductList(limit: _limit, page: _currentPage);

      setState(() {
        _products.addAll(fetchedProducts);
        _currentPage++;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight =MediaQuery.of(context).size.height;
    _deviceWidth =MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List',style: TextStyle(
          color: Colors.white
        ),),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: _products.length + 1,
          itemBuilder: (context, index) {
            if (index < _products.length) {
              final product = _products[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(productId: product['id']),
                    ),
                  );
                },
                child: Card(

                  color: Colors.blueGrey,
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          product['image'],
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(text: product['title'],
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,),
                              const SizedBox(height: 8),
                              CustomText(text: '\$${product['price']}',
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 4),
                                  CustomText(text:  '${product['rating']['rate']}',
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : const Center(child: Text('No more products'));
            }
          },
        ),
      ),
    );
  }

}

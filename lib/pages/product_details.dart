import 'package:bluestone_products/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../services/http_service.dart';


class ProductDetailPage extends StatefulWidget {
  final int productId;

  const ProductDetailPage({required this.productId});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final ApiService _apiService = ApiService();
  Map<String, dynamic>? _product;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProductDetail();
  }

  Future<void> _loadProductDetail() async {
    try {
      final product = await _apiService.fetchProductDetail(widget.productId);
      setState(() => _product = product);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Product Details',
            style: TextStyle(
            color: Colors.white
        ),),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _product == null
          ? const Center(child: Text('Failed to load product details'))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              _prodcutImage(),
              const SizedBox(height: 16),
              _productDetails()
            ],
          ),
        ),
      ),
    );
  }


  Widget _prodcutImage(){
    return Center(
      child: Image.network(
        _product!['image'],
        height: 200,
        fit: BoxFit.fill,
      ),
    );
  }

Widget _productDetails(){
    return Container(
      child: Column(
        children: [
          CustomText(text: _product!['title'],
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,),
          const SizedBox(height: 8),
          CustomText(text: '\$${_product!['price']}',
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,),
          const SizedBox(height: 8),
          CustomText(text: 'Category: ${_product!['category']}',
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,),
          const SizedBox(height: 16),
          CustomText(text: _product!['description'],
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,),
        ],
      ),
    );
}

}

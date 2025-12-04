import 'package:e_commerce/repo/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/product_details_viewmodel.dart';
import '../viewmodels/cart_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductDetailsPage extends StatefulWidget {
  final int productId;
  const ProductDetailsPage({required this.productId, super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late ProductDetailsViewModel vm;

  @override
  void initState() {
    super.initState();
    final repository = context.read<ProductRepository>();
    vm = ProductDetailsViewModel(repository: repository);
    vm.loadProduct(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductDetailsViewModel>.value(
      value: vm,
      child: Consumer<ProductDetailsViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(title: const Text('Product')),
            body: SafeArea(
              child: model.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : model.error != null
                  ? Center(child: Text(model.error!))
                  : model.product == null
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: SizedBox(
                              height: 420,
                              child: CachedNetworkImage(
                                imageUrl: model.product!.image,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            model.product!.title,
                            style: const TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '\$${model.product!.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    'Rating: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.lightGreen,
                                    ),
                                  ),
                                  Text(
                                    "${model.product!.rating.rate} (${model.product!.rating.count})",
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Text(
                                'Category: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              Text("${model.product!.category}"),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Text(
                                model.product!.description,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.read<CartViewModel>().addToCart(
                                      model.product!,
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Added to cart'),
                                      ),
                                    );
                                  },
                                  child: const Text('Add to Cart'),
                                  style: ButtonStyle(
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}

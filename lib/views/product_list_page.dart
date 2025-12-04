import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/product_list_viewmodel.dart';
import '../widgets/product_tile.dart';
import '../viewmodels/cart_viewmodel.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});
  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ProductListViewModel>().loadProducts());
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProductListViewModel>();
    final cartVm = context.watch<CartViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Our Store'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => Navigator.pushNamed(context, '/cart'),
              ),
              if (cartVm.items.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 10,
                    child: Text(
                      '${cartVm.items.length}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            if (vm.state == ViewState.busy) {
              return const Center(child: CircularProgressIndicator());
            } else if (vm.state == ViewState.error) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(vm.errorMessage ?? 'Something went wrong'),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: vm.loadProducts,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else {
              return RefreshIndicator(
                onRefresh: vm.refresh,
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.62,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: vm.products.length,
                  itemBuilder: (context, index) {
                    final p = vm.products[index];
                    return ProductTile(
                      product: p,
                      onAdd: () => context.read<CartViewModel>().addToCart(p),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/cart_viewmodel.dart';
import '../widgets/cart_item_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartVm = context.watch<CartViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: SafeArea(
        child: cartVm.items.isEmpty
            ? const Center(child: Text('Your cart is empty'))
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartVm.items.length,
                      itemBuilder: (context, index) =>
                          CartItemWidget(item: cartVm.items[index]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total: \$${cartVm.totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('Checkout'),
                                content: const Text(
                                  'This is a demo. Checkout not implemented.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Close'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context.read<CartViewModel>().clear();
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Clear Cart'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Text('Checkout'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

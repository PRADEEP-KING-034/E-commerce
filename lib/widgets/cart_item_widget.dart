import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/cart_item.dart';
import 'package:provider/provider.dart';
import '../viewmodels/cart_viewmodel.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  const CartItemWidget({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 60,
        child: CachedNetworkImage(
          imageUrl: item.product.image,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(
        item.product.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '\$${item.product.price.toStringAsFixed(2)} x ${item.quantity} = \$${item.totalPrice.toStringAsFixed(2)}',
      ),
      trailing: SizedBox(
        width: 160,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () => context.read<CartViewModel>().decreaseQuantity(
                item.product.id,
              ),
            ),
            Text('${item.quantity}'),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => context.read<CartViewModel>().increaseQuantity(
                item.product.id,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () =>
                  context.read<CartViewModel>().removeFromCart(item.product.id),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:e_commerce/repo/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/product_list_viewmodel.dart';
import 'viewmodels/cart_viewmodel.dart';
import 'views/product_list_page.dart';
import 'views/cart_page.dart';
import 'views/product_details_page.dart';

void main() {
  final repository = ProductRepository();
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final ProductRepository repository;
  const MyApp({required this.repository, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductListViewModel(repository: repository),
        ),
        ChangeNotifierProvider(create: (_) => CartViewModel()),
        Provider.value(value: repository),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Store',
        theme: ThemeData(primarySwatch: Colors.blue),
        routes: {
          '/': (_) => const ProductListPage(),
          '/cart': (_) => const CartPage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/details') {
            final args = settings.arguments as int;
            return MaterialPageRoute(
              builder: (_) => ProductDetailsPage(productId: args),
            );
          }

          return null;
        },
      ),
    );
  }
}

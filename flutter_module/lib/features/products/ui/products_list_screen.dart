/// Created by Aabhash Shakya on 19/11/2025

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/core/bridge/flutter_bridge.dart';
import 'package:flutter_module/features/products/ui/product_details_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/provider/app_config_provider.dart';
import '../ui/provider/products_provider.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final configProvider = Provider.of<AppConfigProvider>(context);
    final spacing = configProvider.config?.theme.spacing;
    final colors = configProvider.getColors();
    final viewModel = Provider.of<ProductListViewModel>(context);

    return Scaffold(
      backgroundColor: colors?.surface,
      appBar: AppBar(
        title: Text('QuickShop', style: Theme.of(context).textTheme.titleLarge),
        actions: [
          IconButton(
            onPressed: () {
              FlutterBridge.logout();
            },
            icon: Icon(Icons.logout, color: Colors.white),
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          viewModel.loadProducts();
        },
        child: ListView(
          padding: EdgeInsets.all(spacing?.medium.toDouble() ?? 12),
          physics: AlwaysScrollableScrollPhysics(), // important
          children: [
            if (viewModel.isLoading)
              SizedBox(
                height: 400,
                child: Center(child: CircularProgressIndicator()),
              )
            else if (viewModel.error != null)
              SizedBox(
                height: 400,
                child: Center(
                  child: Text(
                    viewModel.error!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              )
            else
              ...List.generate(viewModel.products.length, (index) {
                final product = viewModel.products[index];
                return Card(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      spacing?.medium.toDouble() ?? 8,
                    ),
                  ),
                  elevation: 2,
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: spacing?.large.toDouble() ?? 12,
                      vertical: spacing?.medium.toDouble() ?? 12,
                    ),
                    leading: product.image.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: product.image,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : null,
                    title: Text(
                      product.title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    subtitle: Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailScreen(product: product),
                        ),
                      );
                    },
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}

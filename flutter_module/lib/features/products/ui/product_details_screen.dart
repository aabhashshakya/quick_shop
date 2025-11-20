/// Created by Aabhash Shakya on 19/11/2025

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../core/bridge/flutter_bridge.dart';
import '../../../core/provider/app_config_provider.dart';
import '../data/model/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final configProvider = Provider.of<AppConfigProvider>(context);
    final spacing = configProvider.config?.theme.spacing;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.chevron_left, color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),

      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(spacing?.large.toDouble() ?? 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //product image
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    spacing?.small.toDouble() ?? 8,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: product.image,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: spacing?.large.toDouble() ?? 24),

              //product title
              Text(
                product.title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              SizedBox(height: spacing?.medium.toDouble() ?? 12),

              //product category
              Text(
                product.category,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              SizedBox(height: spacing?.medium.toDouble() ?? 12),

              //price
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(height: spacing?.small.toDouble() ?? 4),

              //stars
              _StarRating(
                rating: product.rating.rate,
                size: spacing?.large.toDouble() ?? 20,
              ),
              SizedBox(height: spacing?.small.toDouble() ?? 4),

              //rating count
              Text(
                '${product.rating.count} reviews',
                style: Theme.of(context).textTheme.labelSmall,
              ),

              SizedBox(height: spacing?.medium.toDouble() ?? 8),
              SizedBox(height: spacing?.large.toDouble() ?? 20),

              //product description
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    product.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ),

              //pay button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    padding: EdgeInsets.symmetric(
                      vertical: spacing?.medium.toDouble() ?? 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () async {
                    final productJson = jsonEncode(
                      product.toJson(),
                    ); // assuming your Product model has toJson()
                    var success = await FlutterBridge.pay(productJson);
                    if (success) {
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    } else {
                      Fluttertoast.showToast(
                        msg: "An error occurred!",
                        toastLength: Toast.LENGTH_LONG,
                      );
                    }
                  },
                  child: Text(
                    'Pay',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StarRating extends StatelessWidget {
  final double rating;
  final int maxStars;
  final double size;
  final Color color;

  const _StarRating({
    Key? key,
    required this.rating,
    this.maxStars = 5,
    this.size = 20,
    this.color = Colors.amber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = [];

    for (int i = 0; i < maxStars; i++) {
      if (rating >= i + 1) {
        stars.add(Icon(Icons.star, color: color, size: size));
      } else if (rating > i && rating < i + 1) {
        stars.add(Icon(Icons.star_half, color: color, size: size));
      } else {
        stars.add(Icon(Icons.star_border, color: color, size: size));
      }
    }

    return Row(mainAxisSize: MainAxisSize.min, children: stars);
  }
}

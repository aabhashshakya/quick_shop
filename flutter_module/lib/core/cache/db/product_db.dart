/// Created by Aabhash Shakya on 20/11/2025
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../features/products/data/model/product.dart';

class ProductDatabase {
  static final ProductDatabase _instance = ProductDatabase._internal();

  factory ProductDatabase() => _instance;

  ProductDatabase._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'products.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY,
            title TEXT,
            price REAL,
            description TEXT,
            category TEXT,
            image TEXT,
            rating_rate REAL,
            rating_count INTEGER
          )
        ''');
      },
    );
  }

  Future<void> insertProducts(List<Product> products) async {
    final db = await database;
    final batch = db.batch();
    batch.delete('products'); // clear old cache
    for (var p in products) {
      batch.insert('products', {
        'id': p.id,
        'title': p.title,
        'price': p.price,
        'description': p.description,
        'category': p.category,
        'image': p.image,
        'rating_rate': p.rating.rate,
        'rating_count': p.rating.count,
      });
    }
    await batch.commit(noResult: true);
  }

  Future<List<Product>> getProducts() async {
    final db = await database;
    final maps = await db.query('products');
    return maps
        .map(
          (map) => Product(
            id: map['id'] as int,
            title: map['title'] as String,
            price: map['price'] as double,
            description: map['description'] as String,
            category: map['category'] as String,
            image: map['image'] as String,
            rating: Rating(
              rate: map['rating_rate'] as double,
              count: map['rating_count'] as int,
            ),
          ),
        )
        .toList();
  }


  Future<void> clearCache() async {
    final db = await database;
    await db.delete('products');
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_module/features/products/ui/products_list_screen.dart';
import 'package:flutter_module/features/products/ui/provider/products_provider.dart';
import 'package:provider/provider.dart';

import 'core/app_config/app_theme.dart';
import 'core/bridge/flutter_bridge.dart';
import 'core/network/network_service.dart';
import 'core/provider/app_config_provider.dart';
import 'core/theme/theme_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final configProvider = AppConfigProvider();

  FlutterBridge.setup(configProvider);
  // Attach provider to singleton
  NetworkService().attachConfigProvider(configProvider);

  runApp(ChangeNotifierProvider.value(value: configProvider, child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final configProvider = Provider.of<AppConfigProvider>(context);

    ///show loading until config is available
    if (configProvider.config == null) {
      return MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator(color: Colors.red,))),
      );
    }

    return MaterialApp(
      title: 'QuickShop Module',
      theme: themeFromConfig(configProvider.config!.theme),
      builder: (context, child) {
        return Banner(
          location: BannerLocation.topStart,
          message: "MODULE",
          color: Colors.blue,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 13.0,
            letterSpacing: 1.0,
          ),
          textDirection: TextDirection.ltr,
          child: child,
        );
      },

      home: ChangeNotifierProvider<ProductListViewModel>(
        create: (_) => ProductListViewModel(),
        child: ProductListScreen(),
      ),
    );
  }
}

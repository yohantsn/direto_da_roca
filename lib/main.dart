import 'package:aiuri_sdk/aiuri_sdk.dart';
import 'package:direto_da_roca/config/aiuri_config_generated.dart';
import 'package:flutter/material.dart';
import 'package:horta_ui/horta_ui.dart';
import 'package:iod/iod.dart';

void main() async {
  IoD.register<AiuriSDK>(AiuriSDK());
  final repository = IoD.read<AiuriSDK>();
  await repository.init(aiuriConfig);
  runApp(
    MaterialApp(
      theme: HortaTheme.light,
      home: Builder(
        builder: (context) => HortaScaffold(
          appBarDelegate: HortaAppBarDelegate(
            leadingImagePath: 'assets/images/logo.png',

            webMenuItems: HortaListMenuSectionWeb(
              menuItems: ['Home', 'Produtos', 'Sobre', 'Contato'],
              selectedItem: 'Home',
              onItemPressed: (item) {
                // Handle menu item press
              },
            ),
          ),
          children: [
            HortaProductGrid(
              itemCount: 10,
              itemBuilder: (context, index) {
                return HortaProductCard(
                  parameters: HortaProductCardParameters(
                    imageUrl:
                        "https://www.freeiconspng.com/uploads/no-image-icon.jpg",
                    title: "Produto $index",
                    price: (index + 1 * 2.5).toStringAsFixed(2),
                    unit: "kg",
                    status: ProductStatus.inStock,
                    currency: "R\$",
                    onFailureImage: 'assets/images/logo.png',
                    onOrderPressed: () {},
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}

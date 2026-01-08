import 'package:flutter/material.dart';
import 'package:horta_ui/horta_ui.dart';
import 'package:iod/iod.dart';
import 'package:repository/repository.dart';

void main() async {
  IoD.register<Repository>(Repository());
  final repository = IoD.read<Repository>();
  await repository.init();
  runApp(
    MaterialApp(
      theme: HortaTheme.light,
      home: HortaScaffold(
        body: SingleChildScrollView(
          child: Column(
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
    ),
  );
}

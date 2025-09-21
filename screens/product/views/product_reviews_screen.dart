import 'package:flutter/material.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Reviews")),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(
            child: Text("U${index + 1}"),
          ),
          title: Text("User ${index + 1}"),
          subtitle: Text("This is the review number ${index + 1}."),
          trailing: const Icon(Icons.star, color: Colors.amber),
        ),
      ),
    );
  }
}

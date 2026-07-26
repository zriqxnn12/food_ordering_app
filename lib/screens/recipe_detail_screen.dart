import 'package:flutter/material.dart';

class RecipeDetailScreen extends StatefulWidget {
  const RecipeDetailScreen({super.key});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Menu detail")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(16),
              child: Image.network(
                "",
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 220,
                    color: Colors.grey.shade300,
                    child: Icon(Icons.broken_image, size: 40),
                  );
                },
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Chicken Karaage",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                Chip(label: Text("data 1")),
                Chip(label: Text("data 1")),
                Chip(label: Text("data 1")),
              ],
            ),
            SizedBox(height: 14),
            Text(
              "Unit price: Rp15.000",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  "Quantity: ",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.remove_circle_outline),
                ),
                Text("1", style: TextStyle(fontSize: 16)),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "Total price: Rp15.000",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 12),
            Text(
              "Ingredients",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () {}, child: Text("Order now")),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_ordering_app/model/recipe.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;
  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  int quantity = 1;

  int getUnitPrice() {
    return widget.recipe.caloriesPerServing * 1000;
  }

  int getTotalPrice() {
    return getUnitPrice() * quantity;
  }

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
                widget.recipe.image,
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
              widget.recipe.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                Chip(label: Text("Cuisine: ${widget.recipe.cuisine}")),
                Chip(label: Text("⭐ ${widget.recipe.rating}")),
              ],
            ),
            // SizedBox(height: 14),
            // Text(
            //   "Unit price: Rp${getUnitPrice()}",
            //   style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            // ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  "Quantity: ",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                IconButton(
                  onPressed: quantity > 1
                      ? () {
                          setState(() {
                            quantity--;
                          });
                        }
                      : null,
                  icon: Icon(Icons.remove_circle_outline),
                ),
                Text(quantity.toString(), style: TextStyle(fontSize: 16)),
                IconButton(
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  icon: Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "Total price: Rp${getTotalPrice()}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 12),
            Text(
              "Ingredients",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ingredientSection(),
            SizedBox(height: 20),
            Text(
              "Instructions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            instructionSection(),
            SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "${widget.recipe.name} x$quantity added Rp${getTotalPrice()}",
                      ),
                    ),
                  );
                },
                child: Text("Order now"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ingredientSection() {
    final items = <Widget>[];

    final maxItem = widget.recipe.ingredients.length < 10
        ? widget.recipe.ingredients.length
        : 10;

    for (var i = 0; i < maxItem; i++) {
      items.add(Text("- ${widget.recipe.ingredients[i]}"));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    );
  }

  Widget instructionSection() {
    final items = <Widget>[];

    final maxItem = widget.recipe.instructions.length < 10
        ? widget.recipe.instructions.length
        : 10;

    for (var i = 0; i < maxItem; i++) {
      items.add(Text("- ${widget.recipe.instructions[i]}"));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    );
  }
}

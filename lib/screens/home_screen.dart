import 'package:flutter/material.dart';
import 'package:food_ordering_app/screens/recipe_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Food Order')),
      body: Padding(
        padding: EdgeInsetsGeometry.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.restaurant_menu, size: 100, color: Colors.deepOrange),
            SizedBox(height: 8),
            Text(
              "Irashaimase~",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Welcome to Food Order App, see food list to order",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            ElevatedButton.icon(
              icon: Icon(Icons.fastfood),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return RecipeListScreen();
                    },
                  ),
                );
              },
              label: Text("See menu list"),
            ),
          ],
        ),
      ),
    );
  }
}

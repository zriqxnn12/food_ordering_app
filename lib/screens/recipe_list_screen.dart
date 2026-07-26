import 'package:flutter/material.dart';
import 'package:food_ordering_app/screens/recipe_detail_screen.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu List'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.refresh))],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.fromLTRB(12, 12, 12, 8),
            child: Column(
              children: [
                // text field & search button
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "Search Food",
                          hintText: "Type Food name",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(onPressed: () {}, child: Icon(Icons.search)),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text("Sort by: "),
                    SizedBox(width: 8),
                    DropdownButton(
                      items: [
                        DropdownMenuItem(value: "food", child: Text("Food")),
                        DropdownMenuItem(
                          value: "rating",
                          child: Text("Rating"),
                        ),
                        DropdownMenuItem(
                          value: "beverage",
                          child: Text("Beverage"),
                        ),
                      ],
                      onChanged: (value) {},
                    ),
                    SizedBox(width: 20),
                    Text("Order: "),
                    SizedBox(width: 8),
                    DropdownButton(
                      items: [
                        DropdownMenuItem(value: "asc", child: Text("Asc")),
                        DropdownMenuItem(value: "desc", child: Text("Desc")),
                      ],
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          // list data
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(8),
                      child: Image.network(
                        "",
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 56,
                            height: 56,
                            color: Colors.grey.shade300,
                            child: Icon(Icons.broken_image),
                          );
                        },
                      ),
                    ),
                    title: Text("Data"),
                    subtitle: Text("this is subtitle"),
                    trailing: Icon(Icons.arrow_forward, color: Colors.grey),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return RecipeDetailScreen();
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_ordering_app/model/recipe.dart';
import 'package:food_ordering_app/screens/recipe_detail_screen.dart';
import 'package:food_ordering_app/services/recipe_service.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  final RecipeService recipeService = RecipeService();
  final TextEditingController searchController = TextEditingController();

  List<Recipe> recipes = [];
  bool isLoading = false;
  String errorMessage = "";
  String selectedSortBy = "name";
  String selectedOrder = "asc";

  Future<void> loadRecipes() async {
    setState(() {
      isLoading = true;
      errorMessage = "";
    });

    try {
      final result = await recipeService.fetchRecipe(
        searchQuery: searchController.text,
        sortBy: selectedSortBy,
        order: selectedOrder,
      );

      setState(() {
        recipes = result;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    } finally {
      isLoading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    loadRecipes();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu List'),
        actions: [
          IconButton(onPressed: loadRecipes, icon: Icon(Icons.refresh)),
        ],
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
                        controller: searchController,
                        decoration: InputDecoration(
                          labelText: "Search Food",
                          hintText: "Type Food name",
                          border: OutlineInputBorder(),
                        ),
                        onSubmitted: (value) => loadRecipes(),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: loadRecipes,
                      child: Icon(Icons.search),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text("Sort by: "),
                    SizedBox(width: 8),
                    DropdownButton(
                      value: selectedSortBy,
                      items: [
                        DropdownMenuItem(value: "name", child: Text("Name")),
                        DropdownMenuItem(
                          value: "rating",
                          child: Text("Rating"),
                        ),
                      ],
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          selectedSortBy = value;
                        });
                        loadRecipes();
                      },
                    ),
                    SizedBox(width: 20),
                    Text("Order: "),
                    SizedBox(width: 8),
                    DropdownButton(
                      value: selectedOrder,
                      items: [
                        DropdownMenuItem(value: "asc", child: Text("ASC")),
                        DropdownMenuItem(value: "desc", child: Text("DESC")),
                      ],
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          selectedOrder = value;
                        });
                        loadRecipes();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          // list data
          Expanded(child: buildContent()),
        ],
      ),
    );
  }

  Widget buildContent() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (errorMessage.isNotEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsetsGeometry.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(errorMessage, textAlign: TextAlign.center),
              ElevatedButton(onPressed: loadRecipes, child: Text("RETRY")),
            ],
          ),
        ),
      );
    }

    if (recipes.isEmpty) {
      return Center(child: Text("NO DATA"));
    }

    // list view
    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (BuildContext context, int index) {
        final recipe = recipes[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(8),
              child: Image.network(
                recipe.image,
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
            title: Text(recipe.name),
            subtitle: Text(recipe.cuisine),
            trailing: Text("⭐ ${recipe.rating}"),
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
    );
  }
}

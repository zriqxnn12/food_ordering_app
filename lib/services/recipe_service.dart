import 'dart:convert';

import 'package:food_ordering_app/model/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeService {
  Future<List<Recipe>> fetchRecipe({
    String searchQuery = "",
    String sortBy = "name",
    String order = "asc",
  }) async {
    final queryParameters = <String, String>{};
    final Uri uri;

    // for filter required
    if (searchQuery.trim().isNotEmpty) {
      queryParameters["q"] = searchQuery.trim();
    }

    queryParameters["sortBy"] = sortBy;
    queryParameters["order"] = order;

    if (searchQuery.trim().isNotEmpty) {
      uri = Uri.https("dummyjson.com", "/recipes/search", queryParameters);
    } else {
      uri = Uri.https("dummyjson.com", "/recipes", queryParameters);
    }

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception("Failed to load data");
    }

    final Map<String, dynamic> decoded = jsonDecode(response.body);
    final List<dynamic> recipesJson =
        decoded["recipes"] as List<dynamic>? ?? [];

    return recipesJson.map((item) {
      return Recipe.fromJson(item as Map<String, dynamic>);
    }).toList();
  }
}

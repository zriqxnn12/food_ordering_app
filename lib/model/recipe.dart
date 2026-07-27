class Recipe {
  final int id;
  final String name;
  final String image;
  final String cuisine;
  final int caloriesPerServing;
  final double rating;
  final List<String> ingredients;
  final List<String> instructions;

  Recipe({
    required this.id,
    required this.name,
    required this.image,
    required this.cuisine,
    required this.caloriesPerServing,
    required this.rating,
    required this.ingredients,
    required this.instructions,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      image: json["image"] ?? "",
      cuisine: json["cuisine"] ?? "",
      caloriesPerServing: json["caloriesPerServing"] ?? 0,
      rating: (json["rating"] as num?)?.toDouble() ?? 0,
      ingredients: (json["ingredients"] as List<dynamic>? ?? []).map((item) {
        return item.toString();
      }).toList(),
      instructions: (json["instructions"] as List<dynamic>? ?? []).map((item) {
        return item.toString();
      }).toList(),
    );
  }
}

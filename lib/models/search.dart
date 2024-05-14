class Recipe {
  final String title;
  final String imageUrl;
  final String sourceUrl;
  final int readyInMinutes;
  final int servings;

  Recipe({
    required this.title,
    required this.imageUrl,
    required this.sourceUrl,
    required this.readyInMinutes,
    required this.servings,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'] ?? 'Unknown Title',
      imageUrl: json['image'] != null
          ? 'https://spoonacular.com/recipeImages/${json['image']}'
          : 'https://example.com/default-image.jpg',
      sourceUrl: json['sourceUrl'] ?? 'https://example.com',
      readyInMinutes: json['readyInMinutes'] ?? 0,
      servings: json['servings'] ?? 1,
    );
  }
}

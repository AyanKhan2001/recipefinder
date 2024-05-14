import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:recipefinder/api/api_key.dart';
import 'package:recipefinder/models/search.dart';

import 'description.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  TextEditingController _controller = TextEditingController();
  List<Recipe> _recipes = [];

  Future<void> _fetchRecipes(String query) async {
    final apiKey = ApiKey.keys;
    final apiUrl = 'https://api.spoonacular.com/recipes/search?query=$query&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      final responseData = json.decode(response.body);

      setState(() {
        _recipes = (responseData['results'] as List)
            .map((json) => Recipe.fromJson(json))
            .toList();
      });
    } catch (e) {
      // Handle error
      print('Error fetching recipes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 5.0,bottom: 6.0),
          child: Image.asset('assets/images/logo.png'),
        ),
        title: const Text(
          'Recipe Finder',
          style: TextStyle(fontFamily: 'Bebas Neue', fontSize: 32, color: Colors.yellow),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              onSubmitted: (value) {
                _fetchRecipes(value);
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _recipes.length,
              separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.grey),
              itemBuilder: (context, index) {
                final recipe = _recipes[index];
                final recipe2 = _recipes[index];
                return ListTile(
                  title: Text(recipe.title),
                  leading: Container(
                    width: 90,
                    height: 90,
                    child: Image.network(
                      recipe.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RecipeDetailScreen(recipe: recipe)),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomeWidget(),
  ));
}

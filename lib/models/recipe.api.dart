import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_app/models/recipe.dart';

class RecipeApi {
  Future<List<Recipe>> getRecipes() async {
    final uri = Uri.https("yummly2.p.rapidapi.com", "feeds/list/", {
      "limit": "18",
      "start": "0",
      "tag": "list.recipe.popular",
    });
    final response = await http.get(uri, headers: {
      'x-rapidapi-key': '46c1e0fc0bmshca2bdaee646aa93p1fca9fjsn4048e13efd16',
      'x-rapidapi-host': 'yummly2.p.rapidapi.com',
    });
    Map data = jsonDecode(response.body);
    List _tmp = [];

    for (var i in data["feed"]) {
      _tmp.add(i["content"]["details"]);
    }

    return Recipe.recipesFromSnapshot(_tmp);
  }
}

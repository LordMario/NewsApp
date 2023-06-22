//https://newsapi.org/v2/top-headlines?country=us&apiKey=0d70d0a2b18d459c8c6c90153b8aed5e
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/models/models.dart';
import 'package:http/http.dart' as http;

class NewsService with ChangeNotifier {
  final String _urlBase = 'newsapi.org';
  final String _apiKey = '0d70d0a2b18d459c8c6c90153b8aed5e';

  List<Article> headlines = [];
  List<Categoria> categorias = [
    Categoria(FontAwesomeIcons.building, 'business'),
    Categoria(FontAwesomeIcons.tv, 'entertainment'),
    Categoria(FontAwesomeIcons.addressCard, 'general'),
    Categoria(FontAwesomeIcons.headSideVirus, 'health'),
    Categoria(FontAwesomeIcons.vials, 'science'),
    Categoria(FontAwesomeIcons.memory, 'technology'),
    Categoria(FontAwesomeIcons.volleyball, 'sports'),
  ];

  NewsService() {
    getToHeadlines();
  }

  Future<String> getToHeadlines() async {
    final url = Uri.http(
        _urlBase, '/v2/top-headlines', {'apiKey': _apiKey, 'country': 'us'});

    final resp = await http.get(url);

    final NewsModel respBody = NewsModel.fromRawJson(resp.body);

    headlines.addAll(respBody.articles);

    notifyListeners();
    return '';
  }

  Future<String> getNewsByCategory(String categoria) async {
    final url = Uri.http(_urlBase, '/v2/top-headlines',
        {'apiKey': _apiKey, 'country': 'us', 'category': categoria});

    final resp = await http.get(url);

    final NewsModel respBody = NewsModel.fromRawJson(resp.body);

    headlines.addAll(respBody.articles);

    notifyListeners();
    return '';
  }
}

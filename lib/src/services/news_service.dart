//https://newsapi.org/v2/top-headlines?country=us&apiKey=0d70d0a2b18d459c8c6c90153b8aed5e
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/models/models.dart';
import 'package:http/http.dart' as http;

class NewsService with ChangeNotifier {
  final String _urlBase = 'newsapi.org';
  final String _apiKey = '0d70d0a2b18d459c8c6c90153b8aed5e';

  String _categorySelected = 'business';

  List<Article> headlines = [];
  bool _isLoading = true;
  List<Categoria> categorias = [
    Categoria(FontAwesomeIcons.building, 'business'),
    Categoria(FontAwesomeIcons.tv, 'entertainment'),
    Categoria(FontAwesomeIcons.addressCard, 'general'),
    Categoria(FontAwesomeIcons.headSideVirus, 'health'),
    Categoria(FontAwesomeIcons.vials, 'science'),
    Categoria(FontAwesomeIcons.memory, 'technology'),
    Categoria(FontAwesomeIcons.volleyball, 'sports'),
  ];

  final Map<String, List<Article>> _categoryArticle = {};

  NewsService() {
    getToHeadlines();
    for (var element in categorias) {
      _categoryArticle[element.name] = [];
    }

    getNewsByCategory(_categorySelected);
  }
  bool get isLoading => _isLoading;
  get categoryArticles => _categorySelected;

  set categoryArticle(String value) {
    _categorySelected = value;

    _isLoading = true;
    getNewsByCategory(value);
  }

  List<Article> get categoryArticuleSeleted =>
      _categoryArticle[_categorySelected]!;

  getToHeadlines() async {
    final url = Uri.http(
        _urlBase, '/v2/top-headlines', {'apiKey': _apiKey, 'country': 'us'});

    final resp = await http.get(url);

    final NewsModel respBody = NewsModel.fromRawJson(resp.body);

    headlines.addAll(respBody.articles);

    notifyListeners();
    return '';
  }

  getNewsByCategory(String value) async {
    if (_categoryArticle[value]!.isNotEmpty) {
      _isLoading = false;
      notifyListeners();
      return _categoryArticle[value];
    }

    final url = Uri.http(_urlBase, '/v2/top-headlines',
        {'apiKey': _apiKey, 'country': 'us', 'category': value});

    final resp = await http.get(url);

    final NewsModel respBody = NewsModel.fromRawJson(resp.body);
    _isLoading = false;
    _categoryArticle[value]!.addAll(respBody.articles);
    notifyListeners();
  }
}

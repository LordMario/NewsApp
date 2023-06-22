import 'package:flutter/material.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class Tabs1Page extends StatefulWidget {
  const Tabs1Page({super.key});

  @override
  State<Tabs1Page> createState() => _Tabs1PageState();
}

class _Tabs1PageState extends State<Tabs1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final headlines = Provider.of<NewsService>(context).headlines;

    return Scaffold(
      body: (headlines.isEmpty)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListaNoticias(noticias: headlines),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

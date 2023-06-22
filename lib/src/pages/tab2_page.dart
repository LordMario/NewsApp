import 'package:flutter/material.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/services/services.dart';
import 'package:news_app/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class Tab2Pages extends StatelessWidget {
  const Tab2Pages({super.key});

  @override
  Widget build(BuildContext context) {
    final headlines = Provider.of<NewsService>(context).headlines;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(child: _ListaCategorias()),
            Scaffold(
              body: (headlines.isEmpty)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListaNoticias(noticias: headlines),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categorias = Provider.of<NewsService>(context).categorias;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: categorias.length,
      itemBuilder: (context, index) {
        final nombre = categorias[index].name;
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              _CategoryBoton(categoria: categorias[index]),
              const SizedBox(
                height: 5,
              ),
              Text('${nombre[0].toUpperCase()}${nombre.substring(1)}'),
            ],
          ),
        );
      },
    );
  }
}

class _CategoryBoton extends StatelessWidget {
  final Categoria categoria;
  const _CategoryBoton({
    required this.categoria,
  });

  @override
  Widget build(BuildContext context) {
    final categoriaService = Provider.of<NewsService>(context);
    return GestureDetector(
      onTap: () {
        categoriaService.getNewsByCategory(categoria.name);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(categoria.icon, color: Colors.black54),
      ),
    );
  }
}

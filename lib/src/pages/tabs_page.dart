import 'package:flutter/material.dart';
import 'package:news_app/src/pages/tab1_page.dart';
import 'package:news_app/src/pages/tab2_page.dart';
import 'package:provider/provider.dart';

class TabPages extends StatelessWidget {
  const TabPages({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (i) {
        navegacionModel.paginaActual = i;
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined), label: 'Para ti'),
        BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Nosotros'),
      ],
    );
  }
}

class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navegacionModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [Tabs1Page(), Tab2Pages()],
    );
  }
}

class _NavegacionModel with ChangeNotifier {
  final _pageControlle = PageController(
    initialPage: 0,
  );

  PageController get pageController => _pageControlle;

  int _paginaActual = 0;

  int get paginaActual => _paginaActual;

  set paginaActual(int value) {
    _paginaActual = value;
    _pageControlle.animateToPage(value,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class MySpacePage extends StatefulWidget {
  const MySpacePage({super.key});

  @override
  State<MySpacePage> createState() => _MySpacePageState();
}

class _MySpacePageState extends State<MySpacePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Le nombre d'onglets
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return const <Widget>[
           SliverAppBar(
              title: Text('Mon Espace'),
              pinned: true,
              floating: true,
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(text: 'Succès'),
                  Tab(text: 'Favoris'),
                ],
              ),
            ),
          ];
        },
        body: const TabBarView(
          children: <Widget>[
            // Contenu pour l'onglet "Succès"
            Center(child: Text('Contenu pour Succès')),
            // Contenu pour l'onglet "Favoris"
            Center(child: Text('Contenu pour Favoris')),
          ],
        ),
      ),
    );
  }

}

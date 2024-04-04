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
        body: TabBarView(
          children: <Widget>[
            // Contenu pour l'onglet "Succès"
            _buildSuccessTab(),
            // Contenu pour l'onglet "Favoris"
            const Center(child: Text('Contenu pour Favoris')),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessTab() {
    // Cette fonction construit l'onglet "Succès"
    return Column(
      children: [
        Expanded(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              // Ajouter des widgets pour chaque succès ici
              Card(child: ListTile(title: Text('Succès 1'))),
              Card(child: ListTile(title: Text('Succès 2'))),
              Card(child: ListTile(title: Text('Succès 3'))),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              // Ajouter des widgets pour chaque stat spécifique ici
              Card(child: ListTile(title: Text('Stat Spécifique 1'))),
              Card(child: ListTile(title: Text('Stat Spécifique 2'))),
              Card(child: ListTile(title: Text('Stat Spécifique 3'))),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              // Ajouter des widgets pour chaque stat générique ici
              Card(child: ListTile(title: Text('Stat Générique 1'))),
              Card(child: ListTile(title: Text('Stat Générique 2'))),
              Card(child: ListTile(title: Text('Stat Générique 3'))),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jobtaste/services/image_fetcher.dart';

class MySpacePage extends StatefulWidget {
  const MySpacePage({super.key});

  @override
  State<MySpacePage> createState() => _MySpacePageState();
}

class _MySpacePageState extends State<MySpacePage>
    with SingleTickerProviderStateMixin {

  void jobImages(String job) async {
    fetchJobImages(job);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Le nombre d'onglets
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return const <Widget>[
            SliverAppBar(
              title: Text('Mon Espace'),
              centerTitle: true,
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
            Center(
                child: FloatingActionButton(
                    onPressed: () => jobImages("engineer"),
                    child: const Icon(Icons.add))),
            // Contenu pour l'onglet "Favoris"
            _buildFavorisTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildFavorisTab() {
    return SingleChildScrollView(
      // Permet le défilement vertical de l'ensemble du contenu
      child: Column(
        children: [
          // Section pour "Favoris"
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(Icons.collections_bookmark,
                      color: Colors.amber, size: 30),
                  Text('Favoris', style: TextStyle(fontSize: 24)),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 150, // Hauteur fixe pour la ListView
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 150,
                    child: ListTile(
                      title: Text('Favoris $index'),
                    ),
                  ),
                );
              },
            ),
          ),

          // Section pour "Simulation réalisées"
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(Icons.check_circle_outline,
                      color: Colors.amber, size: 30),
                  Text('Simulation réalisées', style: TextStyle(fontSize: 24)),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 150, // Hauteur fixe pour la ListView
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 150,
                    child: ListTile(
                      title: Text('Simulation réalisées $index'),
                    ),
                  ),
                );
              },
            ),
          ),

          // Section pour "Métier explorés"
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(Icons.event_available, color: Colors.amber, size: 30),
                  Text('Métier explorés', style: TextStyle(fontSize: 24))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 150, // Hauteur fixe pour la ListView
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 150,
                    child: ListTile(
                      title: Text('Métier explorés $index'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

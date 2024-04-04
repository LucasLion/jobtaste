import 'package:flutter/material.dart';
import 'package:jobtaste/services/image_fetcher.dart';

class MySpacePage extends StatefulWidget {
  const MySpacePage({super.key});

  @override
  State<MySpacePage> createState() => _MySpacePageState();
}

class _MySpacePageState extends State<MySpacePage>
    with SingleTickerProviderStateMixin {

  Widget buildImageListView(String searchTerm) {
    return SizedBox(
      height: 200,
      child: FutureBuilder<List<String>>(
        future: fetchJobImages(searchTerm),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(8),
                    clipBehavior: Clip
                        .antiAlias, // Assure que tout contenu débordant est coupé
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      width: 160,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(snapshot.data![index]),
                          fit: BoxFit
                              .cover, // Remplit l'espace tout en conservant les proportions de l'image
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          color: Colors.black.withOpacity(0.5),
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            searchTerm,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('Aucune image trouvée.'));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
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
            const Center(child: Text('Succès')),
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
          const SizedBox(height: 10),
          buildImageListView('engineer'),
          const SizedBox(height: 40),

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
          const SizedBox(height: 10),
          buildImageListView('doctor'),
          const SizedBox(height: 40),

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
          const SizedBox(height: 10),
          buildImageListView('teacher'),
        ],
      ),
    );
  }
}

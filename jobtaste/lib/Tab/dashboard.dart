import 'package:flutter/material.dart';
import 'filter_page.dart';

class JobsOfWeekPage extends StatelessWidget {
  const JobsOfWeekPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        searchBar(context),
        category(context, 'Metiers de la semaine', Icons.push_pin, 'Comptables', 'Mecaniciens'),
        category(context, 'Recommandations', Icons.recommend, 'Laboratoire', 'Agent immobilier'),
        category(context, 'Metiers les plus populaires', Icons.star, 'Electricien', 'Pompiers'),
        category(context, 'Les nouveautes', Icons.new_releases, 'Designers', 'Ecrivains'),
      ],
    );
  }

  Row searchBar(BuildContext context) {
    return Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 12.0,
                top: 12.0,
                bottom: 12.0,
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Barre de recherche',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.grey[300],
                  filled: true,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FilterPage()),
              );
            }
          ),
        ],
      );
  }

  Container category(BuildContext context, String title, IconData icon, String job1, String job2) {
    return Container(

      child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                ),
              ]
            ),
            Row(
              children: <Expanded>[
                jobCard(context, job1),
                jobCard(context, job2),
              ]
            )
          ]
      ),
    );
  }

  Expanded jobCard(BuildContext context, String job) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(
          child: AspectRatio(
            aspectRatio: 0.6,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/images/image.jpg'),
                ),
                Text(job),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your onPressed code here!
                    },
                    child: const Text('Decouvrir'),
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}
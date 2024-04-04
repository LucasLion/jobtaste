
import 'package:flutter/material.dart';

class JobsOfWeekPage extends StatelessWidget {
  const JobsOfWeekPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        searchBar(),
        Category('Metiers de la semaine'),
        Category('Recommandations'),
        Category('Metiers les plus populaires'),
        Category('Les nouveautes'),
      ],
    );
  }

  Row searchBar() {
    return Row(
        children: <Widget>[
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
            },
          ),
        ],
      );
  }

  Container Category(String title) {
    return Container(
      child: Column(
          children: <Widget>[
            Row(
                children: [
                  const Icon(Icons.push_pin),
                  Text(title),
                ]
            ),
            Row(
              children: <Card>[
                jobCard('Comptable'),
                jobCard('Mecanicien'),
              ]
            )
          ]
      ),
    );
  }

  Card jobCard(String job) {
    return Card(
      child: SizedBox(
        height: 300,
        width: 100,
        child: Column(
          children: <Widget>[
            Image.asset('assets/images/image.jpg'),
            Text(job),
            ElevatedButton(
              onPressed: () {
                // Add your onPressed code here!
              },
              child: const Text('Decouvrir'),
            )
          ],
        ),
      )
    );
  }

}
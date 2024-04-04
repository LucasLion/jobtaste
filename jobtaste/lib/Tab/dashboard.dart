
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class JobsOfWeekPage extends StatelessWidget {
  const JobsOfWeekPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        searchBar(),
        category(context, 'Metiers de la semaine', Icons.push_pin, 'Comptables', 'Mecaniciens'),
        category(context, 'Recommandations', Icons.recommend, 'Laboratoire', 'Agent immobilier'),
        category(context, 'Metiers les plus populaires', Icons.star, 'Electricien', 'Pompiers'),
        category(context, 'Les nouveautes', Icons.new_releases, 'Designers', 'Ecrivains'),
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
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width / 2,
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
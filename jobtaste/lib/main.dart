import 'package:flutter/material.dart';
import 'package:jobtaste/Tab/my_space.dart';
import 'Tab/dashboard.dart';
import 'Tab/discover_me/discover_me.dart';

void main() {
  runApp(const JobTasteApp());
}

class JobTasteApp extends StatelessWidget {
  const JobTasteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JobTaste',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: _JobTasteHomePage(),
    );
  }
}

class _JobTasteHomePage extends StatefulWidget {
  @override
  _JobTasteHomePageState createState() => _JobTasteHomePageState();
}

class _JobTasteHomePageState extends State<_JobTasteHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TabBarView(
          controller: _tabController,
          children: const <Widget>[
            JobsOfWeekPage(),
            MySpacePage(),
            DiscoverMePage(),
            ProfilePage(), 
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.search)),
              Tab(icon: Icon(Icons.favorite)),
              Tab(icon: Icon(Icons.person)),
            ],
          ),
        ));
  }
}



class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Profile'));
  }
}

import 'package:flutter/material.dart';
import 'package:subs_tracker/widgets/developer_card.dart';
import 'package:subs_tracker/widgets/menu_bar.dart';

class TeamsScreen extends StatelessWidget {
  const TeamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Subs Tracker"), actions: []),
      drawer: SidebarMenu(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DeveloperCard(
                name: 'Selim Talha Aksoy',
                title: 'Web Developer',
                githubImageAssetsPath: 'assets/saksoypp.png',
                linkedinUrl: 'https://www.google.com',
                githubUrl: 'https://www.google.com',
                instagramUrl: 'https://www.google.com',
                youtubeUrl: 'https://www.google.com',
                twitterUrl: 'https://www.google.com',
              ),
              DeveloperCard(
                name: 'Eren Gün',
                title: 'Flutter Developer',
                githubImageAssetsPath: 'assets/egunpp.png',
                linkedinUrl: 'https://www.google.com',
                githubUrl: 'https://www.google.com',
                instagramUrl: 'https://www.google.com',
                youtubeUrl: 'https://www.google.com',
                twitterUrl: 'https://www.google.com',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

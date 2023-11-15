import 'package:flutter/material.dart';
import 'package:game_inventory/artifact.dart';
import 'package:game_inventory/widgets/left_drawer.dart';

class ShowItemPage extends StatelessWidget {
  ShowItemPage({super.key});

  final List<Artifact> artifactList = Artifact.databaseArtifact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Artifacts List'),
      ),
      drawer: const LeftDrawer(),
      body: ListView.builder(
        itemCount: artifactList.length,
        itemBuilder: (context, index) {
          Artifact artifact = artifactList[index];
          return ListTile(
            title: Text(artifact.name),
            subtitle: Text('${artifact.amount} - ${artifact.description}'),
          );
        },
      ),
    );
  }
}
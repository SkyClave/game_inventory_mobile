import 'package:flutter/material.dart';
import 'package:game_inventory/screens/artifact_form.dart';
import 'package:game_inventory/widgets/left_drawer.dart';
import 'package:game_inventory/widgets/artifact_card.dart';
import 'package:game_inventory/screens/list_item.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:game_inventory/screens/login.dart';

class MyHomePage extends StatelessWidget {
    MyHomePage({Key? key}) : super(key: key);
    final List<ArtifactItemMenu> items = [
        ArtifactItemMenu("Lihat Item", Icons.list, Colors.blue.shade700),
        ArtifactItemMenu("Tambah Item", Icons.add, Colors.red.shade700),
        ArtifactItemMenu("Logout", Icons.logout, Colors.yellow.shade700),
    ];

    @override
    Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Artifact Inventory',
            style: TextStyle(
              color: Colors.white
            )
          ),
          backgroundColor: Colors.blue.shade900
        ),
        drawer: const LeftDrawer(),
        body: SingleChildScrollView(
          // Widget wrapper yang dapat discroll
          child: Padding(
            padding: const EdgeInsets.all(10.0), // Set padding dari halaman
            child: Column(
              // Widget untuk menampilkan children secara vertikal
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                  child: Text(
                    'Artifact Menu', // Text yang menandakan toko
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Grid layout
                GridView.count(
                  // Container pada card kita.
                  primary: true,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  children: items.map((ArtifactItemMenu item) {
                    // Iterasi untuk setiap item
                    return ArtifactCardMenu(item);
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      );
    }
}

class ArtifactCardMenu extends StatelessWidget {
  final ArtifactItemMenu item;

  const ArtifactCardMenu(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Material(
      color: item.color,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () async {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}")));
            if (item.name == "Tambah Item") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ArtifactFormPage()),
            );
            }
            else if (item.name == "Lihat Item") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ItemPage()),
            );
            }
            else if (item.name == "Logout") {
              final response = await request.logout(
                  "https://alwin-djuliansah-tugas.pbp.cs.ui.ac.id/auth/logout/");
              String message = response["message"];
              if (response['status']) {
                String uname = response["username"];
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("$message Sampai jumpa, $uname."),
                ));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("$message"),
                ));
              }
            }
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
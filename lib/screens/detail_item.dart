import 'package:flutter/material.dart';

class DetailItemPage extends StatefulWidget {
  const DetailItemPage({super.key, required this.name, required this.amount, required this.description});

  final String name;
  final int amount;
  final String description;

  @override
  _DetailItemPageState createState() => _DetailItemPageState();
}

class _DetailItemPageState extends State<DetailItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Artifact Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${widget.name}',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text('Amount: ${widget.amount}'),
            const SizedBox(height: 10),
            Text('Description: ${widget.description}'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}


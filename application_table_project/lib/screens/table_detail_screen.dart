import 'package:flutter/material.dart';

class TableDetailScreen extends StatelessWidget {
  final int tableNumber;
  const TableDetailScreen({super.key, required this.tableNumber});

  @override
  Widget build(BuildContext context) {
    List<String> table = List.generate(
      10,
          (i) => "$tableNumber × ${i + 1} = ${tableNumber * (i + 1)}",
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Learn table")),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(height: 20),
          ...table.map((e) => Padding(
            padding: const EdgeInsets.all(4),
            child: Text(e, style: const TextStyle(fontSize: 22)),
          )),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ElevatedButton(onPressed: () {}, child: const Text("START MULTIPLY")),
                const SizedBox(height: 10),
                ElevatedButton(onPressed: () {}, child: const Text("START DIVISION")),
              ],
            ),
          )
        ],
      ),
    );
  }
}

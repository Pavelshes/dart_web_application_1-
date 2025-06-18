import 'package:flutter/material.dart';
import 'bmi_cubit.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("История расчетов")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: BMICubit().getHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Нет данных"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return ListTile(
                  title: Text("Рост: ${item['height']} см"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Вес: ${item['weight']} кг"),
                      Text("ИМТ: ${item['bmi'].toStringAsFixed(2)}"),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
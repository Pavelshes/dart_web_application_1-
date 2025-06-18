import 'package:flutter/material.dart';
import 'bmi_cubit.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BMICubit _bmiCubit = BMICubit();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double? _bmi;

  Future<void> _calculateBMI() async {
    final height = double.tryParse(_heightController.text);
    final weight = double.tryParse(_weightController.text);

    if (height != null && weight != null && height > 0) {
      final bmi = weight / ((height / 100) * (height / 100));
      setState(() => _bmi = bmi);
      await _bmiCubit.saveResult(height, weight, bmi);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Расчет ИМТ"),
        leading: IconButton(
          icon: const Icon(Icons.history),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HistoryScreen()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _heightController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Рост (см)")),
            TextField(controller: _weightController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Вес (кг)")),
            ElevatedButton(onPressed: _calculateBMI, child: const Text("Рассчитать")),
            if (_bmi != null)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text("ИМТ: ${_bmi!.toStringAsFixed(2)}", style: const TextStyle(fontSize: 20)),
              ),
          ],
        ),
      ),
    );
  }
}
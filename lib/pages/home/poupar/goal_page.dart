import 'package:flutter/material.dart';

class GoalModel {
  final String id;
  final String name;
  final String description;
  final double targetValue;
  double currentValue;
  final DateTime createdAt;

  GoalModel({
    required this.id,
    required this.name,
    required this.description,
    required this.targetValue,
    required this.currentValue,
    required this.createdAt,
  });
}

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  final List<GoalModel> _goals = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController targetValueController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

  void _showCreateGoalModal() {
    nameController.clear();
    targetValueController.clear();
    descriptionController.clear();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Wrap(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Nome do objetivo",
                ),
              ),
              TextField(
                controller: targetValueController,
                decoration: const InputDecoration(
                  labelText: "Valor necessário",
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Descrição"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final goal = GoalModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: nameController.text,
                    description: descriptionController.text,
                    targetValue:
                        double.tryParse(targetValueController.text) ?? 0,
                    currentValue: 0,
                    createdAt: DateTime.now(),
                  );
                  setState(() {
                    _goals.add(goal);
                  });
                  Navigator.pop(context);
                },
                child: const Text("Criar caixinha"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddMoneyDialog(GoalModel goal) {
    valueController.clear();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Adicionar dinheiro"),
            content: TextField(
              controller: valueController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Valor"),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancelar"),
              ),
              TextButton(
                onPressed: () {
                  double value = double.tryParse(valueController.text) ?? 0;
                  setState(() {
                    goal.currentValue += value;
                  });
                  Navigator.pop(context);
                },
                child: const Text("Adicionar"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minhas Metas')),
      body: ListView.builder(
        itemCount: _goals.length,
        itemBuilder: (context, index) {
          final goal = _goals[index];
          return ListTile(
            title: Text(goal.name),
            subtitle: Text(
              'Guardado: R\$ ${goal.currentValue.toStringAsFixed(2)} de R\$ ${goal.targetValue.toStringAsFixed(2)}',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _showAddMoneyDialog(goal),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateGoalModal,
        icon: const Icon(Icons.add),
        label: const Text("Criar sua caixinha de metas"),
      ),
    );
  }
}

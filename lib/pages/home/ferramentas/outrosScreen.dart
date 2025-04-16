import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OutrosScreen extends StatelessWidget {
  const OutrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Educação Financeira"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              _buildCategoryChips(),

              const SizedBox(height: 24),
              const Text(
                "Cursos disponíveis",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildCourseCard(),

              const SizedBox(height: 32),
              const Text(
                "Tarefas diárias",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildCalendarSelector(),

              const SizedBox(height: 24),
              const Text(
                "Atividades de hoje",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildTaskItem(
                1,
                "Planejamento Mensal",
                "Organize seu orçamento • 20min",
              ),
              _buildTaskItem(
                2,
                "Reserva de Emergência",
                "Crie um fundo de segurança • 15min",
              ),
              _buildTaskItem(
                3,
                "Investimento Inicial",
                "Comece a investir com pouco • 25min",
              ),
              _buildTaskItem(
                4,
                "Educação Doméstica",
                "Ensine as crianças sobre dinheiro • 30min",
              ),
              _buildTaskItem(
                5,
                "Controle de Gastos",
                "Analise suas despesas da semana • 20min",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    final categories = [
      "Recomendado",
      "Orçamento",
      "Investimentos",
      "Poupança",
      "Crédito",
      "Educação Doméstica",
      "Juros Compostos",
      "Economia Diária",
    ];
    return Wrap(
      spacing: 8,
      children:
          categories.map((e) {
            return Chip(
              label: Text(e),
              backgroundColor:
                  e == "Recomendado" ? Colors.blue : Colors.grey.shade200,
              labelStyle: TextStyle(
                color: e == "Recomendado" ? Colors.white : Colors.black,
              ),
            );
          }).toList(),
    );
  }

  Widget _buildCourseCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Finanças Pessoais para Iniciantes",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          const Text("10 Aulas • 3h 40min"),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.userGroup,
                    size: 16,
                  ), // Ícone de pessoa
                  SizedBox(width: 8), // Espaço entre o ícone e o texto
                  Text("Carla Ribeiro"),
                ],
              ),
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.star,
                    size: 16,
                    color: Colors.amber,
                  ), // Ícone de estrela
                  SizedBox(width: 8), // Espaço entre o ícone e o texto
                  Text("4.8"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarSelector() {
    final days = ["Seg", "Ter", "Qua", "Qui", "Sex", "Sáb", "Dom"];
    final selectedDay = DateTime.now().weekday - 1;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Habilita o scroll horizontal
      child: Row(
        children: List.generate(days.length, (index) {
          final isSelected = index == selectedDay;
          return Padding(
            padding: const EdgeInsets.only(
              right: 8,
            ), // Espaçamento entre os itens
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    "${15 + index}",
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    days[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTaskItem(int index, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Text(
            "$index",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          const Icon(Icons.play_circle_outline),
        ],
      ),
    );
  }
}

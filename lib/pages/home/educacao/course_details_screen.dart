// lib/screens/course_details_screen.dart
import 'package:flutter/material.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Image.network(
              "https://storage.googleapis.com/gemini-generative-ai-public/images/4a74205a-8b9a-4c2a-8924-f7b57954999f",
              fit: BoxFit.cover,
            ),
          ),
          // App Bar
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 10,
            right: 10,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: const CircleAvatar(
                backgroundColor: Colors.black38,
                child: BackButton(color: Colors.white),
              ),
              actions: [
                CircleAvatar(
                  backgroundColor: Colors.black38,
                  child: IconButton(
                    icon: const Icon(Icons.more_horiz, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          // Main Content
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Curso de Investimentos",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(),
                    const SizedBox(height: 24),
                    const Text("Descrição", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(
                      "Um curso para quem quer começar a investir do zero, entendendo os principais conceitos do mercado financeiro para tomar decisões mais inteligentes com seu dinheiro. Aprenda sobre Renda Fixa, Ações, Fundos Imobiliários e mais...",
                      style: TextStyle(color: Colors.grey[700], height: 1.5),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                         Text("Aulas (27)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                         Text("Ver Todas", style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildLessonItem("1. Introdução aos Investimentos", "Comece por aqui"),
                    const SizedBox(height: 12),
                    _buildLessonItem("2. Renda Fixa: Segurança", "CDB, Tesouro Direto"),
                     const SizedBox(height: 12),
                    _buildLessonItem("3. Renda Variável: Riscos", "Ações e dividendos"),
                    const SizedBox(height: 30),
                     SizedBox(
                       width: double.infinity,
                       child: ElevatedButton(
                         onPressed: (){},
                         style: ElevatedButton.styleFrom(
                           padding: const EdgeInsets.symmetric(vertical: 16),
                           backgroundColor: const Color(0xFF2C2C2C),
                           foregroundColor: Colors.white,
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                         ),
                         child: const Text("Inscreva-se Agora - R\$199/ano", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                       ),
                     )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        _InfoChip(icon: Icons.video_collection_outlined, text: "27 Aulas"),
        _InfoChip(icon: Icons.timer_outlined, text: "20h 24m"),
        _InfoChip(icon: Icons.person_outline, text: "453 Alunos"),
      ],
    );
  }

  Widget _buildLessonItem(String title, String subtitle){
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network("https://storage.googleapis.com/gemini-generative-ai-public/images/9944a9fd-e09b-4654-be81-6bfd7ca19421", width: 50, height: 50, fit: BoxFit.cover),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: (){},
            style: OutlinedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(12),
              side: BorderSide(color: Colors.grey[300]!)
            ),
            child: const Icon(Icons.play_arrow_rounded, color: Colors.deepPurple),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: 20),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(color: Colors.grey[800])),
      ],
    );
  }
}
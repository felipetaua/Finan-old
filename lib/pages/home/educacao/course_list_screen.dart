import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Lesson {
  final String title;
  final String category;
  Lesson(this.title, this.category);
}

class Course {
  final String title;
  final String instructor;
  final String imageAsset;
  final double completed;
  final List<Lesson> lessons;
  Course({
    required this.title,
    required this.instructor,
    required this.imageAsset,
    required this.completed,
    required this.lessons,
  });
}

// --- Tela Principal ---
class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key});

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  final List<String> _filters = [
    "Todos",
    "Orçamento",
    "Investimentos",
    "Dívidas",
  ];
  int _selectedFilterIndex = 0;

  final List<Course> _courses = [
    Course(
      title: "Investindo para Iniciantes",
      instructor: "Ricardo Financeiro",
      imageAsset: "assets/images/Educacao/educacao-financeira.png",
      completed: 0.45,
      lessons: [
        Lesson("1. O que é um investimento?", "Investimentos"),
        Lesson("2. Renda Fixa vs. Variável", "Investimentos"),
        Lesson("3. Montando sua carteira", "Investimentos"),
      ],
    ),
    Course(
      title: "Orçamento Pessoal Inteligente",
      instructor: "Clara Contas",
      imageAsset: "assets/images/Educacao/educacao-financeira.png",
      completed: 0.70,
      lessons: [
        Lesson("1. Planilha de Gastos", "Orçamento"),
        Lesson("2. A Regra 50/30/20", "Orçamento"),
        Lesson("3. Onde cortar custos?", "Orçamento"),
        Lesson("4. Criando metas", "Orçamento"),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meus Cursos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                return _buildFilterChip(index);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _courses.length,
              itemBuilder: (context, index) {
                return CourseCard(course: _courses[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(int index) {
    bool isSelected = _selectedFilterIndex == index;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(_filters[index]),
        selected: isSelected,
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              _selectedFilterIndex = index;
            }
          });
        },
        backgroundColor: Colors.white,
        selectedColor: Theme.of(context).primaryColor.withOpacity(0.1),
        labelStyle: TextStyle(
          color: isSelected ? Theme.of(context).primaryColor : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color:
                isSelected ? Theme.of(context).primaryColor : Colors.grey[300]!,
          ),
        ),
      ),
    );
  }
}

// --- Widget do Card de Curso (Expansível) ---
class CourseCard extends StatefulWidget {
  final Course course;
  const CourseCard({super.key, required this.course});

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [_buildHeader(context), if (_isExpanded) _buildLessonList()],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    widget.course.imageAsset,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.course.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'instrutor: ${widget.course.instructor}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: LinearPercentIndicator(
                    percent: widget.course.completed,
                    lineHeight: 8,
                    barRadius: const Radius.circular(4),
                    backgroundColor: Colors.grey[200],
                    progressColor: const Color(0xFF8A2BE2),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Concluído: ${(widget.course.completed * 100).toInt()}%',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.course.lessons.length,
        separatorBuilder: (_, __) => const Divider(height: 20),
        itemBuilder: (context, index) {
          final lesson = widget.course.lessons[index];
          return Row(
            children: [
              Text(
                "0${index + 1}",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      lesson.category,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.play_circle_outline, size: 18),
                label: const Text('Play'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor,
                  side: BorderSide(color: Theme.of(context).primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

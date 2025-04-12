import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AvatarSelectorPage extends StatelessWidget {
  final String? currentAvatar;
  final String? avatar;

  AvatarSelectorPage({super.key, this.currentAvatar, this.avatar});

  final List<String> avatarList = [
    'assets/avatares/avatar-1.gif',
    'assets/avatares/avatar-2.jpg',
    'assets/avatares/avatar-3.jpg',
    'assets/avatares/avatar-4.jpg',
    'assets/avatares/avatar-5.jpg',
    'assets/avatares/avatar-6.jpg',
    'assets/avatares/avatar-7.jpg',
    'assets/avatares/avatar-8.jpg',
    'assets/avatares/avatar-9.jpg',
    'assets/avatares/avatar-10.jpg',
    'assets/avatares/avatar-11.jpg',
    'assets/avatares/avatar-12.jpg',
    'assets/avatares/avatar-13.jpg',
    'assets/avatares/avatar-14.jpg',
    'assets/avatares/avatar-15.jpg',
    'assets/avatares/avatar-16.jpg',
    'assets/avatares/avatar-17.jpg',
  ];

  Future<void> _saveAvatar(BuildContext context, String? path) async {
    final prefs = await SharedPreferences.getInstance();
    if (path == null) {
      await prefs.remove('avatarPath');
    } else {
      await prefs.setString('avatarPath', path);
    }
    Navigator.pop(context, path); // Retorna o avatar selecionado
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Selecionar Avatar')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Escolha um avatar:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                children:
                    avatarList.map((avatar) {
                      final isSelected = avatar == currentAvatar;
                      return GestureDetector(
                        onTap: () => _saveAvatar(context, avatar),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.all(isSelected ? 4 : 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color:
                                  isSelected ? Colors.blue : Colors.transparent,
                              width: 3,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(avatar),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                await _saveAvatar(context, null); // Remover o avatar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Avatar removido com sucesso!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              icon: const Icon(Icons.delete, color: Colors.white),
              label: const Text(
                "Remover avatar",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

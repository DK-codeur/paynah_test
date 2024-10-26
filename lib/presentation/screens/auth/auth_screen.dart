import 'package:flutter/material.dart';
import 'package:paynah_test/presentation/screens/auth/login_screen.dart';
import 'package:paynah_test/presentation/screens/auth/register_screen.dart';

class AuthScreen extends StatefulWidget {
  final int initialPage;
  const AuthScreen({super.key, this.initialPage = 0});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  PageController? controller;
  int currentPage = 0;

  @override
  void initState() {
    controller = PageController(initialPage: widget.initialPage);
    currentPage = widget.initialPage;
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () => Navigator.pop(context), 
            icon: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: const Icon(Icons.close)
            )
          ),
      
          actions: [
            GestureDetector(
              onTap: () {
                controller?.animateToPage(currentPage == 0 ? 1 : 0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  currentPage == 0 ? "Pas de compte ?" : "Déjà un compte ?"
                ),
              ),
            )
          ],
        ),
      body: PageView(
        onPageChanged: (value) {
          setState(() {
            currentPage = value;
          });
        },
        controller: controller,
        children: const [
          LoginScreen(),
          RegisterScreen()
        ],
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          currentPage == 0 
          ? "Glissez de la droite vers la gauche pour vous inscrire"
          : "Glissez de la gauche vers la droite pour vous connecter",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}

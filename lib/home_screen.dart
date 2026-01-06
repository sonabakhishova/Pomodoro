import 'package:flutter/material.dart';
import 'package:pomodoro_app/to_do_screen.dart';
import 'timer_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 24, 88, 184),
        actions: [
          IconButton(onPressed: () {},
          icon: const Icon(Icons.menu, color: Colors.white,))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30), 
                    child: Image.asset(
                      'assets/images/bunny.jpeg',
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                  
                  SizedBox(
                    height: 250, 
                    width: 250,
                    child: ArcText(
                      radius: 100, 
                      text: "Welcome Back :)",
                      textStyle: GoogleFonts.pacifico(
                        fontSize: 26, 
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 222, 0, 0),
                      ),
                      startAngle: -1.0,
                      direction: Direction.clockwise,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30), 
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 24, 88, 184),
               borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                children: [
                  const Text(
                    "Main Menu",
                    style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    ),
                  ),

                  Expanded(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildMenuCard(context, "Pomodoro timer", Icons.timer, const TimerScreen()),
                          _buildMenuCard(context, "to-do list", Icons.edit_note, const TodoScreen()),
                        ],
                      ),
                    ),
                  ),             
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, IconData icon, Widget? targetPage){
    return GestureDetector(
      onTap: (){
        if(targetPage != null){
          Navigator.push(context, MaterialPageRoute(builder: (context) => targetPage));
        }
      },
      child: Container(
        width: 105,
        height: 110,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5, offset: const Offset(0,3))
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Color.fromARGB(255, 50, 140, 205), size: 35),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black87),
            )
          ],
        ),
      ),
    );
  }

}
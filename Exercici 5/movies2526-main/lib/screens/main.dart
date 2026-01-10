import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/bottom_navigator_controller.dart';

class Main extends StatelessWidget {
  Main({super.key});
  // Inicializa el controlador de navegación inferior
  final BottomNavigatorController controller = Get.put(BottomNavigatorController());
  @override
  Widget build(BuildContext context) {
    // Usa Obx para actualizar la UI reactivamente
    return Obx(
      () => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          // Cuerpo seguro de la pantalla
          body: SafeArea(
            child: IndexedStack(
              // Muestra la pantalla según el índice
              index: controller.index.value,
              children: Get.find<BottomNavigatorController>().screens,
            ),
          ),
          // Barra de navegación inferior
          bottomNavigationBar: Container(
            height: 78,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(0xFF0296E5),
                  width: 1,
                ),
              ),
            ),
            // Barra de navegación
            child: BottomNavigationBar(
              currentIndex: controller.index.value,
              onTap: (index) =>
                  Get.find<BottomNavigatorController>().setIndex(index),
              backgroundColor: const Color(0xFF242A32),
              selectedItemColor: const Color(0xFF0296E5),
              unselectedItemColor: const Color(0xFF67686D),
              selectedFontSize: 12,
              unselectedFontSize: 12,
              items: [
                // Elemento de navegación para "Home"
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    child: SvgPicture.asset(
                      'assets/Home.svg',
                      height: 21,
                      width: 21,
                      // ignore: deprecated_member_use
                      color: controller.index.value == 0
                          ? const Color(0xFF0296E5)
                          : const Color(0xFF67686D),
                    ),
                  ),
                  label: 'Home',
                ),
                // Elemento de navegación para "Search"
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    child: SvgPicture.asset(
                      'assets/Search.svg',
                      height: 21,
                      width: 21,
                      // ignore: deprecated_member_use
                      color: controller.index.value == 1
                          ? const Color(0xFF0296E5)
                          : const Color(0xFF67686D),
                    ),
                  ),
                  label: 'Search',
                  tooltip: 'Search Movies',
                ),
                // Elemento de navegación para "Watch list"
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    child: SvgPicture.asset(
                      'assets/Save.svg',
                      height: 21,
                      width: 21,
                      // ignore: deprecated_member_use
                      color: controller.index.value == 2
                          ? const Color(0xFF0296E5)
                          : const Color(0xFF67686D),
                    ),
                  ),
                  label: 'Watch list',
                  tooltip: 'Your WatchList',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

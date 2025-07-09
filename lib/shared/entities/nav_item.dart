import 'package:flutter/cupertino.dart';

class NavItem {
  final IconData iconData;
  final String label;

  const NavItem({required this.iconData, required this.label});

  /// BottomNavigationBarItem으로 변환
  BottomNavigationBarItem toBottomNavigationBarItem({
    bool selected = false,
    Color? selectedColor,
    Color? unselectedColor,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(iconData, color: selected ? selectedColor : unselectedColor),
      label: label,
    );
  }
}
// class NavItem {
//   final IconData icon;
//   final String label;
//
//   NavItem({required this.icon, required this.label});
// }

// class NavItem extends BottomNavigationBarItem {
//   final IconData iconData;
//
//   NavItem(this.iconData, {required super.icon});
// }

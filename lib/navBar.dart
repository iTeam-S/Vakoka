import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybn/controllers.dart';

class NavBar extends StatelessWidget {
  final NavCtrl _controller = Get.put(NavCtrl());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
        children: List.generate(
            _controller.navItems.length,
            (index) => NavBarItem(
                  texte: _controller.navItems[index],
                  siActiver: index == _controller.indexSelectionee,
                  presser: () => _controller.setNavIndex(index),
                ))));
  }
}

class NavBarItem extends StatefulWidget {
  const NavBarItem({
    Key? key,
    required this.siActiver,
    required this.texte,
    required this.presser,
  }) : super(key: key);
  final bool siActiver;
  final String texte;
  final VoidCallback presser;

  @override
  _NavBarItemState createState() => _NavBarItemState();
}

const teal = Colors.teal;

class _NavBarItemState extends State<NavBarItem> {
  bool isHover = false;
  Color _borderColor() {
    if (widget.siActiver) {
      return teal;
    } else if (!widget.siActiver && isHover) {
      return teal.withOpacity(0.4);
    } else
      return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.presser,
      onHover: (value) {
        setState(() {
          isHover = value;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(vertical: 7.0),
        margin: EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: _borderColor(), width: 3)),
        ),
        child: Text(widget.texte,
            style: TextStyle(
                color: Colors.black,
                fontWeight:
                    widget.siActiver ? FontWeight.w400 : FontWeight.normal)),
      ),
    );
  }
}

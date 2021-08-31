import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomTabWidget extends StatefulWidget {
  final int index;
  final ValueChanged<int> onChangedTab;
  const BottomTabWidget(
      {Key key, @required this.index, @required this.onChangedTab})
      : super(key: key);

  @override
  _BottomTabWidgetState createState() => _BottomTabWidgetState();
}

class _BottomTabWidgetState extends State<BottomTabWidget> {
  @override
  Widget build(BuildContext context) {
    final placeholder = Opacity(
      opacity: 0,
      child: IconButton(icon: Icon(Icons.no_cell), onPressed: null),
    );

    return BottomAppBar(
      color: Colors.greenAccent[100],
      shape: CircularNotchedRectangle(),
      notchMargin: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildTabItem(
            index: 0,
            icon: Icon(
              Icons.home,
              size: 30,
            ),
          ),
          buildTabItem(
            index: 1,
            icon: Icon(
              Icons.find_in_page,
              size: 30,
            ),
          ),
          placeholder,
          buildTabItem(
            index: 2,
            icon: Icon(
              Icons.messenger,
              size: 30,
            ),
          ),
          buildTabItem(
            index: 3,
            icon: Icon(
              Icons.settings,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTabItem({
    @required int index,
    @required Widget icon,
  }) {
    final isSelected = index == widget.index;

    return IconTheme(
      data: IconThemeData(
        color: isSelected ? Colors.black : Colors.white,
      ),
      child: IconButton(
        icon: icon,
        onPressed: () => widget.onChangedTab(index),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: const Color(0xFFEBEBEB),
      height: 48,
      child: Row(
        children: [
          _Button(
            label: 'Music app',
            icon: Icons.play_circle_outline,
            iconColor: colorScheme.primary,
          ),
          const _Button(
            label: 'Originals',
            icon: Icons.movie_creation,
          ),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button(
      {Key key,
      @required this.label,
      @required this.icon,
      this.iconColor = const Color(0xFF909090)})
      : super(key: key);

  final String label;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {},
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: iconColor,
          ),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}

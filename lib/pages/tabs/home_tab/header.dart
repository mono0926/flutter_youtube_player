import 'package:flutter/material.dart';
import 'package:flutter_youtube_player/pages/tabs/home_tab/originals_page.dart';

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
          _Button(
            label: 'Originals',
            icon: Icons.movie_creation,
            onPressed: () =>
                Navigator.of(context).pushNamed(OriginalsPage.routeName),
          ),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key key,
    @required this.label,
    @required this.icon,
    this.iconColor = _textColor,
    this.onPressed,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onPressed;

  static const _textColor = Color(0xFF909090);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: _textColor,
      ),
      onPressed: onPressed ?? () {},
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

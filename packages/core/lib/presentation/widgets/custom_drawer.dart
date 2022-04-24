import 'package:core/core.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  final MenuItem activeMenu;
  final Function(MenuItem) menuClickCallback;
  final Widget content;

  const CustomDrawer({
    required this.activeMenu,
    required this.menuClickCallback,
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  void toggle() => _animationController.isDismissed
      ? _animationController.forward()
      : _animationController.reverse();

  Widget _buildDrawer() {
    return Column(
      children: [
        const UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage('assets/circle-g.png'),
          ),
          accountName: Text('Ditonton'),
          accountEmail: Text('ditonton@dicoding.com'),
        ),
        ListTile(
          leading: const Icon(Icons.movie),
          title: const Text('Movies'),
          tileColor: widget.activeMenu == MenuItem.movie ? kDavysGrey : kGrey,
          onTap: () {
            toggle();
            widget.menuClickCallback(MenuItem.movie);
          },
        ),
        ListTile(
          leading: const Icon(Icons.tv),
          tileColor: widget.activeMenu == MenuItem.tvShow ? kDavysGrey : kGrey,
          title: const Text('Tv Show'),
          onTap: () {
            toggle();
            widget.menuClickCallback(MenuItem.tvShow);
          },
        ),
        ListTile(
          leading: const Icon(Icons.save_alt),
          title: const Text('Watchlist'),
          onTap: () {
            toggle();
            Navigator.pushNamed(context, watchlistRoute);
          },
        ),
        ListTile(
          onTap: () {
            toggle();
            Navigator.pushNamed(context, aboutRoute);
          },
          leading: const Icon(Icons.info_outline),
          title: const Text('About'),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggle,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          double slide = 255.0 * _animationController.value;
          double scale = 1 - (_animationController.value * 0.3);

          return Stack(
            children: [
              _buildDrawer(),
              Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.centerLeft,
                child: widget.content,
              ),
            ],
          );
        },
      ),
    );
  }
}

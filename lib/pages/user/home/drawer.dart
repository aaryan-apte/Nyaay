import 'package:flutter/material.dart';
// import 'package:flutter_ecommerce_ui_kit/blocks/auth_block.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    // AuthBlock auth = Provider.of<AuthBlock>(context);
    return Column(
      children: <Widget>[
        // if (auth.isLoggedIn)
          // UserAccountsDrawerHeader(
          //   decoration: BoxDecoration(
          //       image: DecorationImage(
          //     fit: BoxFit.cover,
          //     image: AssetImage('assets/images/drawer-header.jpg'),
          //   )),
          //   currentAccountPicture: CircleAvatar(
          //     backgroundImage: NetworkImage(
          //         'https://avatars2.githubusercontent.com/u/2400215?s=120&v=4'),
          //   ),
          //   // accountEmail: Text(auth.user['user_email']),
          //   // accountName: Text(auth.user['user_display_name']),
          // ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.home, color: Theme.of(context).colorScheme.secondary),
                title: Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.account_circle,
                    color: Theme.of(context).colorScheme.secondary),
                title: Text('Profile'),
                trailing: Text('New',
                    style: TextStyle(color: Theme.of(context).primaryColor)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/shop');
                },
              ),
              ListTile(
                leading:
                    Icon(Icons.account_balance_wallet_rounded, color: Theme.of(context).colorScheme.secondary),
                title: Text('Appointments'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/categorise');
                },
              ),
              ListTile(
                leading:
                    Icon(Icons.align_vertical_bottom, color: Theme.of(context).colorScheme.secondary),
                title: Text('Leaderboard'),
                trailing: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Text('4',
                      style: TextStyle(color: Colors.white, fontSize: 10.0)),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/wishlist');
                },
              ),
              ListTile(
                leading: Icon(Icons.approval_rounded,
                    color: Theme.of(context).colorScheme.secondary),
                title: Text('Why Nyaay?'),
                trailing: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Text('2',
                      style: TextStyle(color: Colors.white, fontSize: 10.0)),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/cart');
                },
              ),
              ListTile(
                leading: Icon(Icons.lock, color: Theme.of(context).colorScheme.secondary),
                title: Text('Login'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/auth');
                },
              ),
              Divider(),
              ListTile(
                leading:
                    Icon(Icons.settings, color: Theme.of(context).colorScheme.secondary),
                title: Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/settings');
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app,
                    color: Theme.of(context).colorScheme.secondary),
                title: Text('Logout'),
                onTap: () async {
                  // await auth.logout();
                },
              )
            ],
          ),
        )
      ],
    );
  }
}

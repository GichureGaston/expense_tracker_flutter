import 'package:expense_tracker/analytics/analytics_page.dart';
import 'package:expense_tracker/budget_tracker/views/budget_page.dart';
import 'package:expense_tracker/expense_tracker/views/expense_page.dart';
import 'package:flutter/material.dart';

class DrawerItem {
  final String title;
  final IconData icon;

  const DrawerItem(this.title, this.icon);
}

class HomeScreen extends StatefulWidget {
  final List<DrawerItem> drawerItems = const [
    DrawerItem("Expense", Icons.monetization_on),
    DrawerItem("Budget", Icons.money_sharp),
    DrawerItem("Analytics", Icons.insert_chart),
  ];

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedDrawerIndex = 0;

  Widget _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return const ExpensePage();
      case 1:
        return const BudgetPage();
      case 2:
        return const AnalyticsPage();
      default:
        return const Text("Error");
    }
  }

  void _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];
    for (int i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(ListTile(
        leading: Icon(d.icon),
        title: Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: const Text(
          'HOME',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.w600),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text(""),
              accountEmail: Text(""),
            ),
            Column(children: drawerOptions),
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}

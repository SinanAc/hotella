import 'package:flutter/material.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen>
    with TickerProviderStateMixin {
  final int _startingTabCount = 2;

  List<Tab> _tabs = [];
  final List<Widget> _generalWidgets = [];
  TabController? _tabController;
  @override
  void initState() {
    _tabs = getTabs(_startingTabCount);
    _tabController = getTabController();
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  List<Tab> getTabs(int count) {
    _tabs.clear();
    for (int i = 0; i < count; i++) {
      _tabs.add(getTab(i));
    }
    return _tabs;
  }

  TabController getTabController() {
    return TabController(length: _tabs.length, vsync: this);
  }

  Tab getTab(int widgetNumber) {
    return Tab(
      text: "$widgetNumber",
    );
  }

  void _addAnotherTab() {
    _tabs = getTabs(_tabs.length + 1);
    _tabController?.index = 0;
    _tabController = getTabController();
    _updatePage();
  }

  void _removeTab() {
    _tabs = getTabs(_tabs.length - 1);
    _tabController?.index = 0;
    _tabController = getTabController();
    _updatePage();
  }

  void _updatePage() {
    setState(() {});
  }

  List<Widget> getWidgets() {
    _generalWidgets.clear();
    for (int i = 0; i < _tabs.length; i++) {
      _generalWidgets.add(const Icon(Icons.add));
    }
    return _generalWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: _removeTab,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addAnotherTab,
          ),
        ],
        bottom: TabBar(
          tabs: _tabs,
          controller: _tabController,
        ),
        title: const Text('Tabs Demo'),
      ),
      body: TabBarView(
        controller: _tabController,
        children: getWidgets(),
      ),
    );
  }
}














// import 'package:flutter/material.dart';

// class SavedScreen extends StatelessWidget {
//   const SavedScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     //final size = MediaQuery.of(context).size;
//     return const Padding(
//       padding:  EdgeInsets.all(8.0),
//       // child: GridView.builder(
//       //   itemCount: 4,
//       //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//       //       crossAxisCount: 2,
//       //       crossAxisSpacing: 6.0,
//       //       mainAxisSpacing: 6.0,
//       //       ),
//       //   itemBuilder: (context, index) {
//       //     return  MainCard(name: 'Fabulous Dines', loaction: 'Delhi', img: 'assets/images/hotel_dummy.jpg', size: size);
//       //   },
//       // ),
//     );
//   }
// }

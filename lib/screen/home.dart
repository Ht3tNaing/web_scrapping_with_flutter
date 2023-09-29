
import 'package:flutter/material.dart';
import 'package:web_scrapping/model/data/items.dart';
import 'package:web_scrapping/model/services/web_get_body.dart';
import 'ui_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   late Future future;
@override
  void initState() {
    super.initState();
    future=_getData();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Thai Stock Live Data"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: future,
        builder: (context,snap){
          runEverySecond();
          Items? items=snap.data;
          return UiWidget(items: items);

        },

      ),
    );
  }
  Future<Items> _getData(){
    return WebGetBody("https://www.set.or.th/en/market/index/set/overview").get();
}
Future<void> runEverySecond() async{
  await Future.delayed(const Duration(seconds: 1));
  setState(() {
    future=_getData();
  });
}
}

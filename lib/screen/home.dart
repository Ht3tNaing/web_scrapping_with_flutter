
import 'package:flutter/material.dart';
import 'package:web_scrapping/model/items.dart';
import 'package:web_scrapping/services/get_number.dart';
import 'package:web_scrapping/services/web_get_body.dart';

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
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      GetNumber().getFirst(items?.getFirst()!.trim()??"")??"-",
                      style: const TextStyle(fontSize: 120, fontWeight: FontWeight.bold),
                    ),
                    Text( GetNumber().getLast(items?.getValue()!.trim()??"")??"-",
                        style:
                        const TextStyle(fontSize: 120, fontWeight: FontWeight.bold))
                  ],
                ),
                Text("Thai Time: ${items?.getDate()??"Loading"}",
                    style: const TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: Colors.green)),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,

                    decoration: BoxDecoration(
                        color: Colors.red, borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                const Text("Set",
                                  style: TextStyle(
                                      color: Colors.white
                                  ),),
                                Text(items?.getFirst()?.trim()??"--",
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ))],
                            ),
                            const SizedBox(width: 50,),
                            Column(
                              children: [
                                const Text("value",
                                    style: TextStyle(
                                        color: Colors.white
                                    )),
                                Text(items?.getValue()??"--",
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ))],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );

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
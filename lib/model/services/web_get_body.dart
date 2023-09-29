import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:web_scrapping/model/data/items.dart';
import 'package:http/http.dart' as http;

class WebGetBody{
  final String url;

  WebGetBody(this.url);
  Future<Items> get() async{
    final response=await http.get(Uri.parse(url));
    final bs=BeautifulSoup(response.body);
    final first=bs.find("h1",class_: "value")?.text;
    final rawValue=bs.find("div",class_: "quote-market-cost");
    final value=rawValue?.find("span")?.text;
    final rawDate=bs.find("div",class_: "quote-market-lastInfo");
    final date=rawDate?.find("span")?.text;

    Items items=Items();
    items.setFirst(first??"Error");
    items.setValue(value??"Error");
    items.setDate(date??"Error");
    return items;
  }
}
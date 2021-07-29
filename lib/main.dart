import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String url =
  //     "http://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=ed6dfc72aa7d115558dcc96ebea9a474";

  var data;
  // var res;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var res = await http.get(Uri.http(
        "api.openweathermap.org",
        "/data/2.5/weather",
        {"q": "Noida,in", "appid": "ed6dfc72aa7d115558dcc96ebea9a474"}));
    data = jsonDecode(res.body);
    print(data);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("City Weather"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: data != Null
            ? SingleChildScrollView(
                child: Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("City Name: "),
                          Text(data["name"]),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("Country: "),
                          Text(data["sys"]["country"]),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("Tempreture (F): "),
                          Text(data["main"]["temp"].toString()),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("Feels like(F): "),
                          Text(data["main"]["feels_like"].toString()),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("Today's minimum tempreture(F): "),
                          Text(data["main"]["temp_min"].toString()),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("Today's maximum tempreture(F): "),
                          Text(data["main"]["temp_max"].toString()),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("Humidity: "),
                          Text(data["main"]["humidity"].toString()),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("Wind Speed (mph): "),
                          Text(data["wind"]["speed"].toString()),
                        ],
                      ),
                    )
                  ],
                ),
              ))
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getData();
        },
        child: Icon(Icons.refresh_outlined),
      ),
    );
  }
}

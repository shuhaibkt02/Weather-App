import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/model.dart';
import 'package:weather_app/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _searchController = TextEditingController();
  String location = "Kerala";

  WeatherApiClient client = WeatherApiClient();

  Weather? data;

  Future<void> getData() async {
    data = await client.getWeatherDetails(location);
  }

  @override
  Widget build(BuildContext context) {
    const String title = 'Weather App';
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(100, 55),
        child: AppBar(
          title: const Text(title),
          centerTitle: true,
          backgroundColor: Colors.pink[800],
          elevation: 1,
        ),
      ),
      drawer: const Drawer(
        backgroundColor: Colors.purple,
        child: Icon(Icons.more_horiz),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: ((context, snapshot) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    DisplayWidget(
                      "${data!.cityName}",
                      data!.temperature!.toDouble(),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'Additioal Information',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
                    ),
                    Divider(
                      indent: 50,
                      endIndent: 50,
                      thickness: 3,
                      color: Colors.amber[400],
                    ),
                    addtionalInfromation(
                      "Wind",
                      data!.wind!,
                      "Humidity",
                      data!.humidity!.toDouble(),
                    ),
                    addtionalInfromation(
                      "Pressure",
                      data!.pressure!.toDouble(),
                      "Feels Like",
                      data!.feelslike!,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Search your location'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          setState(() {
                            location = _searchController.text;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          shape: const StadiumBorder(),
                          textStyle: const TextStyle(fontSize: 20),
                          fixedSize: const Size(200, 45),
                          primary: Colors.amber,
                          backgroundColor: Colors.black,
                        ),
                        child: const Text('Click'))
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class DisplayWidget extends StatelessWidget {
  const DisplayWidget(
    this.location,
    this.temp, {
    Key? key,
  }) : super(key: key);

  final String location;
  final double temp;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: CupertinoColors.darkBackgroundGray,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(children: [
        const Icon(
          Icons.sunny,
          size: 105,
          color: CupertinoColors.activeOrange,
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          temp.toString(),
          style: const TextStyle(
            color: CupertinoColors.extraLightBackgroundGray,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          location,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ]),
    );
  }
}

// Widget detailPage(IconData icon, double temp, String label) {
//   return
// }

Widget addtionalInfromation(
    String label, double speed, String label2, double calc) {
  return Container(
    padding: const EdgeInsets.all(7),
    // margin: const EdgeInsets.all(2),
    // alignment: Alignment.center,
    width: double.infinity,
    height: 50,
    // color: Colors.pinkAccent,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            const SizedBox(
              width: 2,
            ),
            Text(
              speed.toString(),
              style: const TextStyle(),
            ),
            Text(
              label2,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            Text(
              calc.toString(),
              style: const TextStyle(fontSize: 17),
            ),
          ],
        ),
        const SizedBox(
          height: 2,
        ),
      ],
    ),
  );
}

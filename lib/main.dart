import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/cubit.dart';
import 'package:flutter_application_1/model/todo_model.dart';
import 'package:flutter_application_1/screen/screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

const String todoBoxname = "todo";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(todoAdapter());
  await Hive.initFlutter();

  await Hive.openBox<todo>(todoBoxname);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => todoscubit())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Homescreeen(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List mobile = ["مستودع", "عملاء", "الفواتير", "السندات"];
  @override
  void initState() {
    print('object');
    super.initState();
  }

  @override
  Widget build(Object context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: Drawer(
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                  accountName: Text('akeed'),
                  accountEmail: Text('aqeedalt@gmail.com')),
              ListTile(
                title: const Text('الصفحه الرئيسيه'),
                leading: const Icon(Icons.home),
                onTap: () {},
              ),
              ListTile(
                title: const Text('العملاء '),
                leading: const Icon(Icons.home),
                onTap: () {},
              ),
              ListTile(
                title: const Text('حول '),
                leading: const Icon(Icons.home),
                onTap: () {},
              ),
              ListTile(
                title: const Text('مساعده '),
                leading: const Icon(Icons.home),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 11,
              padding: const EdgeInsets.all(22),
              children: [
                Container(
                  // ignore: sort_child_properties_last
                  child: const Text(
                    'color one',
                  ),
                  color: Colors.red,
                ),
                Container(
                  // ignore: sort_child_properties_last
                  child: const Text(
                    'color one',
                  ),
                  color: Colors.green,
                ),
                Container(
                  color: Colors.black,
                  // ignore: prefer_const_constructors
                  child: Text(
                    'color one',
                  ),
                ),
                Container(
                  color: Colors.blue,
                  // ignore: prefer_const_constructors
                  child: Text(
                    'color one',
                  ),
                )
              ]),
        ));
  }
}

class TabBar1 extends StatefulWidget {
  const TabBar1({super.key});

  @override
  State<TabBar1> createState() => _TabBarState();
}

class _TabBarState extends State<TabBar1> with SingleTickerProviderStateMixin {
  @override

  // ignore: override_on_non_overriding_member
  late TabController mycontroler;
  void initState() {
    // ignore: avoid_print
    print('object');
    // ignore: unnecessary_new
    mycontroler = new TabController(length: 4, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('hhomepage'),
          bottom: TabBar(
              controller: mycontroler,
              onTap: (index) {
                print(index);
              },
              indicatorColor: Colors.black,
              tabs: const [
                Tab(
                  // ignore: sort_child_properties_last
                  child: Text('tab1'),
                  icon: Icon(Icons.access_alarm_outlined),
                ),
                Tab(
                  // ignore: sort_child_properties_last
                  child: Text('tab2'),
                  icon: Icon(Icons.access_alarm_outlined),
                ),
                Tab(
                  // ignore: sort_child_properties_last
                  child: Text('tab3'),
                  icon: Icon(Icons.access_alarm_outlined),
                ),
                Tab(
                  // ignore: sort_child_properties_last
                  child: Text('tab4'),
                  icon: Icon(Icons.access_alarm_outlined),
                ),
              ]),
        ),
        body: TabBarView(
          controller: mycontroler,
          children: [
            Container(
              child: const Text('container on'),
              color: Colors.red,
              width: double.infinity,
            ),
            Container(
              child: const Text('container tow'),
              color: Colors.green,
              width: double.infinity,
            ),
            Container(
              child: const Text('container three'),
              color: Color.fromARGB(255, 137, 168, 138),
              width: double.infinity,
            ),
            Container(
              child: const Text('container four'),
              color: Color.fromARGB(255, 6, 44, 8),
              width: double.infinity,
            )
          ],
        ),
      ),
    );
  }
}

class Homescreeen extends StatefulWidget {
  @override
  State<Homescreeen> createState() => _HomescreeenState();
}

class _HomescreeenState extends State<Homescreeen> {
  late Box box;
  Future openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('data');
    return;
  }

  List data = [];
  Future<dynamic> getAllData() async {
    await openBox();
    String url = "https://jsonplaceholder.typicode.com/posts";
    try {
      var response = await http.get(Uri.parse(url));
      var jsoncode = jsonDecode(response.body);

      await putdata(jsoncode);
    } catch (soketexption) {
      print("no internet");
    }
    var mymap = box.toMap().values.toList();

    if (mymap.isEmpty) {
      data.add('empty');
    } else {
      data = mymap;
    }
    return data;
  }

  Future updatdata() async {
    String url = "https://jsonplaceholder.typicode.com/posts";
    try {
      var response = await http.get(Uri.parse(url));
      var jsoncode = jsonDecode(response.body);
      box.add(jsoncode);
      setState(() {});
    } catch (soketexption) {
      print("no internet");
    }
  }

  Future putdata(data) async {
    await box.clear();
    for (var item in data) {
      await box.add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder(
              future: getAllData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (data.contains('empty')) {
                    return Text("no data");
                  }
                  return Column(
                    children: [
                      const SizedBox(
                        height: 21,
                      ),
                      Expanded(
                          child: RefreshIndicator(
                        onRefresh: updatdata,
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (ctx, index) {
                              return ListTile(
                                title: Text("${data[index]['userId']}"),
                                trailing: Text("${data[index]['title']}"),
                              );
                            }),
                      ))
                    ],
                  );
                } else {}
                return Center(
                  child: Text("akeed"),
                );
              })),
    );
  }
}

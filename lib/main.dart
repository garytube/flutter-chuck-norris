import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import './models/joke.dart';
import './getJokes.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Joke> futureAlbum;
  String unsplash =
      'https://source.unsplash.com/random/?v=${new DateTime.now().millisecondsSinceEpoch}';
  final _bigger = TextStyle(
      color: Colors.blue,
      fontSize: 16,
      fontStyle: FontStyle.normal,
      textBaseline: TextBaseline.alphabetic);


  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  void _reFetch() {
    int now = new DateTime.now().millisecondsSinceEpoch;
    setState(() {
      unsplash = 'https://source.unsplash.com/random/?v=$now';
      futureAlbum = fetchAlbum();
    });
  }

  Widget _imageprovider() {
    return CachedNetworkImage(
      imageUrl: unsplash,
      fit: BoxFit.cover,
      height: 300,
      width: 350,
      placeholder: (context, url) => Container(
        width: 350,
        height: 300,
        child: Center(
          child: LinearProgressIndicator(),
        ),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  Widget roundImage(double round) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(round),
      child: _imageprovider(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chucky',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Chuck Norris Jokes'),
          elevation: 10,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _reFetch(),
          icon: Icon(Icons.cloud_download),
          backgroundColor: Colors.blueAccent,
          focusColor: Colors.black,
          label: Text('Fetch More'),
        ),
        drawer: Drawer(
          elevation: 20,
          child: Container(
            child: ListView(
              padding: EdgeInsets.zero, 
              children: [
              DrawerHeader(
                child:_imageprovider(),
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(color: Colors.blue),
              ),
                            ListTile(
          leading: Icon(Icons.message),
          title: Text('Messages'),
        ),
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Profile'),
        ),
        ListTile(
          leading: Icon(Icons.local_atm),
          title: Text('Settings'),
        ),
        Divider(thickness: 2, indent: 20, endIndent: 20,),
              ListTile(
          leading: Icon(Icons.local_airport),
          title: Text('Chuck'),
        ),
        ListTile(
          leading: Icon(Icons.favorite_border),
          title: Text('Menue Items'),
        ),
        Divider(thickness: 2, indent: 20, endIndent: 20,),
              ListTile(
          leading: Icon(Icons.crop_16_9),
          title: Text('Fany Cow'),
        ),
        ListTile(
          leading: Icon(Icons.cloud_off),
          title: Text('Dogiy'),
        ),
                ListTile(
          leading: Icon(Icons.cloud_download),
          title: Text('Load More'),
          onTap: () => _reFetch(),
          onLongPress: () => print("HELLO WORLD"),
        ),
            ]),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: FutureBuilder<Joke>(
                  future: futureAlbum,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return LinearProgressIndicator();
                    }
                    if (snapshot.hasData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          roundImage(20),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              snapshot.data.joke,
                              style: _bigger,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return LinearProgressIndicator();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

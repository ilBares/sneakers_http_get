// Primi passi per poter effettuare una richiesta HTTP
// 1. Apri "terminal" (in basso a sinistra) e scrivi "flutter pub add http"
// 2. Apri "terminal" (in basso a sinistra) e scrivi "flutter pub get"
// 3. Scrivi "import 'package:http/http.dart' as http;"
// 4. Apri il file contenuto in "android/app/src/profile/AndroidManifest.xml"
//    e aggiungi la scritta: "<uses-permission android:name="android.permission.INTERNET" />"

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(HttpGet());

class HttpGet extends StatefulWidget {
  const HttpGet({Key? key}) : super(key: key);

  @override
  State<HttpGet> createState() => _HttpGetState();
}

class _HttpGetState extends State<HttpGet> {
  // url dal quale vogliamo effettuare il "get" dei dati Json
  final url = 'https://api.nike.com/cic/browse/v2?queryid=filteredProductsWithContext&anonymousId='
      '99DE6FE16C6696A7E313890721F3478A&uuids=0f64ecc7-d624-4e91-b171-b83a03dd8550,16633190-45e5-4830'
      '-a068-232ac7aea82c,498ac76f-4c2c-4b55-bbdc-dd37011887b1&language=it&country=IT&channel=NIKE&'
      'localizedRangeStr=%7BlowestPrice%7D-%7BhighestPrice%7D&path=/it/w/uomo-jordan-scarpe-37eefznik1zy7ok&#39';
  var _text = 'loading...';

  @override
  void initState() {
    fetchSneakers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(child: Text(_text)),
        ),
      ),
    );
  }

  // funzione che invia una richiesta "HTTP GET"
  fetchSneakers() async {
    final response = await http.get(Uri.parse(url));
    final responseBody = jsonDecode(response.body);
    final List sneakers = responseBody?['data']?['filteredProductsWithContext']?['products'] ?? [];
    // quando il sito della nike invia i dati della richiesta get, "aggiorna" lo stato
    setState(() {
      _text = '';
      for (var s in sneakers) {
        _text += s['title'] + '\n';
      }
    });
  }
}

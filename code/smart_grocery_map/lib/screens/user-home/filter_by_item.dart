import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '/global.dart';
import 'TextScreen.dart';

List nameList = [];
List fullList = [];

class filter_by_item extends SearchDelegate {

  bool flag = false;

  get recentSuggest => ["a"];

//  get searchList => ["apple","apple2"];

  @override
  List<Widget> buildActions(BuildContext context) {
    getnameList();
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      //  onPressed: () => close(context, null)

      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = "";
          showSuggestions(context);
        }
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    getnameList();
    List info = [];
    for (int i = 0; i < nameList.length; i++) {
      if (query == nameList[i]) {
        flag = true;
        info = fullList[i];
        break;
      } else {
        flag = false;
      }
    }

    return flag == true
        ? Padding(
        padding: EdgeInsets.all(16),
        child: InkWell(
          child: Text(query),
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new TextScreen(s: query, info: info),
              ),
            );
          },
        ))
        : Center(
      child: Text("not found"),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionsList = query.isEmpty
        ? recentSuggest
        : nameList.where((input) => input.startsWith(query)).toList();

    return ListView.builder(
        itemCount: suggestionsList.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: ListTile(
              title: RichText(
                text: TextSpan(
                    text: suggestionsList[index].substring(0, query.length),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: suggestionsList[index].substring(query.length),
                          style: TextStyle(color: Colors.grey))
                    ]),
              ),
            ),
            onTap: () {
              List info = [];
              for (var fullinfo in fullList) {
                if (suggestionsList[index] == fullinfo[2]) {
                  info = fullinfo;
                  break;
                }
              }

              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) =>
                  new TextScreen(s: suggestionsList[index], info:info),
                ),
              );
            },
          );
        });
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: Colors.white,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
      primaryColorBrightness: Brightness.light,
      primaryTextTheme: theme.textTheme,
    );
  }
}

void getnameList() async {
  var futureList = getfutureList();
  fullList = await futureList;

  nameList = [];
  for (var info in fullList){
    nameList.add(info[2]);
  }

}

Future getfutureList() async {
  List futureList = [];
  try {
    var uri = Uri.parse(
        'http://10.0.2.2:8000/api/company/inventory/query_all');
    var request = http.MultipartRequest('GET', uri);
    http.Response response = await http.Response.fromStream(
        await request.send());
    if (response.statusCode == 201) {
      futureList = [];
      for (var item in jsonDecode(response.body)['items']) {
        futureList.add(item);
      }
    } else {
      throw Exception('Fail to get the full namelist');
    }
  } catch (e) {
    throw Exception(e.toString);
  }
  return futureList;
}
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_restaurants/models/restaurant.model.dart';
import 'package:super_restaurants/persistence/dbhelper.dart';
import 'package:super_restaurants/services/restaurants.service.dart';
import '../../authentication/views/login.dart';


class Restaurants extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app), onPressed: () { Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ClientLogin())
          ); },
          )
        ],
      ),
      body: list(),
    );
  }
}

class list extends StatefulWidget {
  @override
  State<list> createState() => _listState();
}

class _listState extends State<list> {
  List<RestaurantsModel> restaurantsList = [];
  RestaurantsService restaurantsService = RestaurantsService();
  ScrollController? _scrollController;

  Future initialize() async {
    loadMore();
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: restaurantsList.length,
      itemBuilder: (BuildContext context, int index) {
        return MyHomePage(restaurantsList[index]);
      },
    );
  }

  void loadMore() {
    String body = "";

    restaurantsService.getAllRestaurants().then((response) => {
      body = utf8.decode(response.bodyBytes),
      for (var elemento in jsonDecode(body))
        {
          setState(() {
            restaurantsList.add(RestaurantsModel(elemento["id"], elemento["title"],
                elemento["poster"], false));
          }),
        },
    });

  }
}


class MyHomePage extends StatefulWidget {

  final RestaurantsModel restaurantsModel;
  MyHomePage(this.restaurantsModel);

  @override
  _MyHomePageState createState() => _MyHomePageState(restaurantsModel);
}

class _MyHomePageState extends State<MyHomePage> {
  RestaurantsModel _restaurantsModel;
  _MyHomePageState(this._restaurantsModel);

  late bool favorite;
  late DbHelper dbHelper;
  // @override
  void initState() {
    favorite = false;
    dbHelper = DbHelper();
    isFavorite(_restaurantsModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          title: Text(widget.restaurantsModel!.title),
          leading: Image.network(widget.restaurantsModel!.poster),
          trailing: IconButton(
            icon: Icon(Icons.favorite),
            color: favorite ? Colors.red : Colors.grey,
            onPressed: () {
              favorite
                  ? dbHelper.deleteProduct(_restaurantsModel)
                  : dbHelper.insertList(_restaurantsModel);
              setState(() {
                favorite = !favorite;
                _restaurantsModel.isFavorite = favorite;
              });
            },
          )),
    );
  }

  Future isFavorite(RestaurantsModel restaurantsModel) async {
    favorite = await dbHelper.isFavorite(restaurantsModel);
    setState(() {
      restaurantsModel.isFavorite = favorite;
    });
  }
}




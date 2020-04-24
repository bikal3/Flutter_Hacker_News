import 'package:flutter/material.dart';
import 'dart:async';
// import '../screens/news_list.dart';
import '../models/item_model.dart';
import '../blocs/stories_provider.dart';
import 'loading_list_tile.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;
  NewsListTile({this.itemId});

  Widget build(context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingListTile();
        }
        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return LoadingListTile();
            }
            return Column(
              children: <Widget>[
                buildTile(context, itemSnapshot.data),
                Divider(
                  height: 8.0,
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget buildTile(context, ItemModel item) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, '/${item.id}');
      },
      title: Text(item.title),
      subtitle: Text('${item.score} votes'),
      trailing: Column(
        children: <Widget>[
          Icon(Icons.comment),
          Text('${item.descendants}'),
        ],
      ),
    );
  }
}

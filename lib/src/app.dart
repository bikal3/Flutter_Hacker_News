import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_provider.dart';
import 'blocs/comment_provider.dart';
import 'screens/news_list.dart';
// import 'blocs/stories_bloc.dart';
import 'screens/news_detail.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return CommentProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: 'News',
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          final bloc = StoriesProvider.of(context);
          bloc.fetchTopIds();
          return NewsList();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          final commentsBloc = CommentProvider.of(context);
          final int itemId =
              int.parse(settings.name.replaceFirst('/', '').toString());
          commentsBloc.fetchItemWithComments(itemId);
          return NewsDetail(
            itemId: itemId,
          );
        },
      );
    }
  }
}

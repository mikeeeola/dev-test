import 'package:dev_test/cubit/news_cubit.dart';
import 'package:dev_test/di/injection_container.dart';
import 'package:dev_test/models/news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final NewsCubit _newsCubit = injector.get<NewsCubit>();

  @override
  Widget build(BuildContext context) {
    _newsCubit.fetchNews();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
        child: Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Explore',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.menu,
                    size: 30,
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1)),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Search Article',
                      prefixIcon: Icon(Icons.search)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: Text('All'),
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: Text('Lifystyle'),
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: Text('Hot Issue'),
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: Text('Healthy'),
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                    'https://www.androidcentral.com/sites/androidcentral.com/files/styles/large/public/article_images/2021/08/samsung-galaxy-watch-4-hands-on-2.jpg'),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'For you',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(color: Colors.blue),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: BlocBuilder<NewsCubit, NewsState>(
                  bloc: _newsCubit,
                  builder: (context, state) {
                    if (state is NewsLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is NewsLoaded) {
                      final news = state.loadedNews;
                      return buildNewsList(news);
                    } else {
                      return Container();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNewsList(List<Article> loadedNews) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: loadedNews.length,
        itemBuilder: (ctx, i) => Container(
              height: 400,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200,
                        child: Image.network(
                          loadedNews[i].urlToImage!,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${loadedNews[i].publishedAt}',
                        style: TextStyle(color: Colors.blue),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: Container(
                          width: 300,
                          child: Text(
                            loadedNews[i].title!,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ));
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/view/news_detail.dart';

class ListWidget extends StatelessWidget {
  final List<Article>? article;
  final int index;
  const ListWidget({Key? key, required this.article, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String img = article![index].urlToImage.toString();
    String title = article![index].title.toString();
    String newsDescription = article![index].url.toString();

    DateTime now =
        DateTime.parse(article![index].publishedAt.toString()).toLocal();
    String date = DateFormat.yMMMd().format(now);
    String time = DateFormat.jm().format(now);
    String date1 = date + " " + time;
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => NewsDetail(
          description: newsDescription,
        ),
      )),
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Card(
          color: Theme.of(context).cardColor,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(img),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 17,
                            color: Theme.of(context).colorScheme.secondary),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.date_range,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            child: Text(
                              date1,
                              style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet/pages/community/post_list.dart';
import 'package:pet/utils/format_date.dart';

import '../../../const/models/articles.dart';

class SilverPostList extends StatelessWidget {
  final Articles articles;
  const SilverPostList({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: articles.total,
            (BuildContext context, int index) {
          final article = articles.article[index];
          return Padding(
            padding: const EdgeInsets.only(top: 30, right: 12, left: 12),
            child: Row(
              children: <Widget>[
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        article.title,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(height: 5),
                      Text(article.author, style: Theme.of(context).textTheme.labelMedium,),
                      Text(formatDateToYYYYMMDD(article.createdAt!), style: Theme.of(context).textTheme.labelMedium,),
                    ],
                  ),
                ),
                article.photos?.length != 0 ?
                    Thumbnail(hasPhoto: true, thumbnail: article.photos![0].imgPath,)
                    : Thumbnail(hasPhoto: false)
              ],
            ),
          );
        },
         // Number of items in the list
      ),
    );;
  }
}

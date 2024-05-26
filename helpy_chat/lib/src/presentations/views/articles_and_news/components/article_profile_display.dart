import 'package:cached_network_image/cached_network_image.dart';
import 'package:dh_mobile/src/core/utils/string_utils.dart';
import 'package:dh_mobile/src/domain/entities/article_creator.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/db_utils.dart';
import '../../../values/values.dart';

class ArticleProfileDisplay extends StatefulWidget {
  final ArticleCreator creator;

  const ArticleProfileDisplay({
    super.key,
    required this.creator,
  });

  @override
  State<ArticleProfileDisplay> createState() => _ArticleProfileDisplayState();
}

class _ArticleProfileDisplayState extends State<ArticleProfileDisplay> {
  String? basePhotoUrl;

  @override
  void initState() {
    super.initState();
    _getPhotoUrl();
  }

  void _getPhotoUrl() async {
    String data = await DBUtils.getCandidateConfigs(DBUtils.stroagePrefix);
    setState(() {
      basePhotoUrl = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Wrap(
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                  color: AppColors.white,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        widget.creator.avatarFilepath != null &&
                                basePhotoUrl != null
                            ? '$basePhotoUrl/${widget.creator.avatarFilepath}'
                            : '$basePhotoUrl/default/avatar.png'),
                    fit: BoxFit.cover,
                  )),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              StringUtils.censorName(
                  widget.creator.firstName, widget.creator.lastName),
              style:
                  const TextStyle(fontSize: 13, color: AppColors.primaryGrey),
            ),
          ],
        ));
  }
}

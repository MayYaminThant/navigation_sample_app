import 'package:cached_network_image/cached_network_image.dart';
import 'package:dh_mobile/src/presentations/views/star_list/components/page_view_indicator.dart';
import 'package:dh_mobile/src/presentations/widgets/video_widget.dart';
import 'package:dh_mobile/src/presentations/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../core/utils/db_utils.dart';
import '../../core/utils/generate_thumbnails.dart';
import '../../domain/entities/entities.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({Key? key, this.media}) : super(key: key);

  final List<MediaFile>? media;

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _currentPage = 0;
  String? basePhotoUrl;

  void _getPhotoUrl() async {
    String? data = await DBUtils.getCandidateConfigs(DBUtils.stroagePrefix);
    setState(() {
      basePhotoUrl = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _getPhotoUrl();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.media == null || widget.media!.isEmpty) {
      return Container();
    }

    if (basePhotoUrl == null) {
      return const SizedBox(height: 212);
    }

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: SizedBox(
            height: 210,
            child: PageView.builder(
              itemCount: widget.media!.length,
              itemBuilder: (context, index) {
                return isVideoFile(
                        '$basePhotoUrl/${widget.media![index].mediaFilePath}')
                    ? Center(
                        child: VideoWidget(
                            key: UniqueKey(),
                            width: double.infinity,
                            height: 210,
                            path:
                                '$basePhotoUrl/${widget.media![index].mediaFilePath}',
                            thumbnailPath:
                                '$basePhotoUrl/${widget.media![index].mediaThumbnailFilepath}'),
                      )
                    : InkWell(
                        onTap: () => showDialog(
                              context: context,
                              builder: (context) => CachedNetworkImage(
                                imageUrl:
                                    '$basePhotoUrl/${widget.media![index].mediaFilePath}',
                                imageBuilder: (context, imageProvider) =>
                                    ZoomableImage(
                                        image: imageProvider,
                                        tag:
                                            '$basePhotoUrl/${widget.media![index].mediaFilePath}'),
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                              ),
                            ),
                        child: CustomImageView(
                          fit: BoxFit.cover,
                          image: '${widget.media![index].mediaFilePath}',
                        ));
              },
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
          ),
        ),
        if (widget.media!.length > 1)
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 4,
              width: 28,
              child: PageViewIndicator(
                currentPage: _currentPage,
                pageCount: widget.media!.length,
              ),
            ),
          ),
      ],
    );
  }
}

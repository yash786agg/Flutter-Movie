import 'package:flutter/material.dart';
import 'package:flutter_movie/domain/model/movie_trailer.dart';
import 'package:flutter_movie/util/contants.dart';
import 'app_launcher.dart';
import 'app_state_container.dart';

class TrailerLayout extends StatelessWidget {
  final List<MovieTrailer> trailerData;
  final String trailerThumbNail;

  TrailerLayout({@required this.trailerData, this.trailerThumbNail})
      : assert(trailerData != null);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170.0,
      child: OrientationBuilder(builder: (context, orientation) {
        return new ListView.builder(
          itemCount: trailerData.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final items = trailerData[index];
            return InkWell(
              onTap: () {
                String url = '${Constant.youtubeBaseUrl}${items.trailerKey}';
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AppLauncher(
                          url: url, trailerName: items.trailerName);
                    },
                  ),
                );
              },
              child: Container(
                width: 170.0,
                margin: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Container(
                        height: 120.0,
                        decoration: BoxDecoration(
                          color:
                              AppStateContainer.of(context).theme.accentColor,
                          image: DecorationImage(
                            image: NetworkImage(
                              '${Constant.imageAppendUrl}$trailerThumbNail',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.play_circle_filled,
                            color: Colors.white,
                            size: 35.0,
                          ),
                        ),
                      ),
                      flex: 1,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      items.trailerName,
                      maxLines: 1,
                      softWrap: true,
                      style: TextStyle(
                        color: AppStateContainer.of(context).theme.accentColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movie_app_mobx_and_rxdart/core/env/env.dart';
import 'package:movie_app_mobx_and_rxdart/models/movie_response.dart';
import 'package:movie_app_mobx_and_rxdart/widgets/custom_image_network.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.movie,
    required this.onTap,
    required this.isBookmarked,
  });

  final MovieResponse movie;
  final VoidCallback onTap;
  final bool isBookmarked;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Colors.black.withOpacity(0.2),
            ),
          ]
      ),
      height: 180,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(6), bottomLeft: Radius.circular(6),),
            child: CustomImageNetwork(
              imageUrl: '${Env.baseUrlImg}${movie.posterPath}',
              width: 120,
              height: 180,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          movie.originalTitle ?? '-',
                          textScaler: TextScaler.noScaling,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      GestureDetector(
                        onTap: onTap,
                        child: Icon(
                          isBookmarked
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: isBookmarked
                              ? Colors.amber
                              : Colors.grey,
                        ),
                      )
                    ],
                  ),
                  if (movie.overview != '')...[
                    Spacer(),
                    Text(
                      movie.overview,
                      textScaler: TextScaler.noScaling,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Spacer(),
                  ],
                  Text(
                    'Score',
                    textScaler: TextScaler.noScaling,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star,
                          size: 16, color: Colors.amber),
                      SizedBox(width: 4),
                      if (movie.voteAverage != null)
                        Text(
                          movie.voteAverage!
                              .toStringAsFixed(1),
                          textScaler:
                          TextScaler.noScaling,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
                        )
                    ],
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

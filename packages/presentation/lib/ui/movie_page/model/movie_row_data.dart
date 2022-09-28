class MovieRowData {
  final String title;
  final double rating;
  final String? genres;
  final String runtime;
  final String? certification;
  final String image;
  final int ids;
  final String overview;

  const MovieRowData({
    required this.image,
    required this.title,
    required this.rating,
    required this.genres,
    required this.runtime,
    required this.certification,
    required this.ids,
    required this.overview,
  });
}

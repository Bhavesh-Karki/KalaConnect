class Craft {
  const Craft({
    required this.id,
    required this.title,
    required this.category,
    required this.region,
    required this.introduction,
    required this.context,
    required this.materials,
    required this.process,
    required this.significance,
    required this.care,
    required this.article,
    required this.artworkKind,
  });

  final String id;
  final String title;
  final String category;
  final String region;
  final String introduction;
  final String context;
  final List<String> materials;
  final List<String> process;
  final String significance;
  final String care;
  final String article;
  final String artworkKind;
}

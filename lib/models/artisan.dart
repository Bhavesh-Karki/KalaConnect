class Artisan {
  const Artisan({
    required this.id,
    required this.name,
    required this.location,
    required this.craftId,
    required this.experience,
    required this.introduction,
    required this.story,
  });

  final String id;
  final String name;
  final String location;
  final String craftId;
  final String experience;
  final String introduction;
  final String story;

  String get initials => name
      .split(' ')
      .where((part) => part.isNotEmpty)
      .take(2)
      .map((part) => part[0])
      .join();
}

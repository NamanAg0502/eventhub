class Event {
  final String id;
  final String title;
  final DateTime dateTime;
  final String location;
  final String imageUrl;
  bool isBookmarked;

  Event({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.location,
    required this.imageUrl,
    this.isBookmarked = false,
  });

  void toggleBookmark() {
    isBookmarked = !isBookmarked;
  }
}

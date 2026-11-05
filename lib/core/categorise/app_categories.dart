class AppCategory {
  String id;
  String name;
  String image;

  AppCategory({required this.id, required this.name, required this.image});
  static List<AppCategory> categories = [
    AppCategory(id: "general", name: "General", image: "assets/categoreis/general.png"),
    AppCategory(id: "business", name: "Business", image: "assets/categoreis/busniess.png"),
    AppCategory(id: "sports", name: "Sports", image: "assets/categoreis/sport.png"),
    AppCategory(id: "technology", name: "Technology", image: "assets/categoreis/technology.png"),
    AppCategory(id: "health", name: "Health", image: "assets/categoreis/health.png"),
    AppCategory(id: "science", name: "Science", image: "assets/categoreis/science.png"),
    AppCategory(id: "entertainment", name: "Entertainment", image: "assets/categoreis/entertainment.png"),
  ];
}

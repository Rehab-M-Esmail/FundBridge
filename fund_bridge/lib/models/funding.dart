class Funding {
  final int id;
  final String title;
  final String author;
  final String description;
  final String image;
  final int fundingAmount;
  final String category;

  Funding({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.image,
    required this.fundingAmount,
    required this.category,
  });

  factory Funding.fromJson(Map<String, dynamic> json) {
    return Funding(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      description: json['description'],
      image: json['image'],
      fundingAmount: json['goal_amount'],
      category: json['category'],
    );
  }
}

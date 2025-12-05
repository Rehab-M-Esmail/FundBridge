class FundPost {
  final String id;
  final String title;
  final String description;
  final double raisedAmount; 
  final double goalAmount;   
  final List<String> galleryImages;
  final List<Comment> comments;
  final List<Donation> topDonors;
  final bool isStarred;
  final String countryCode;
  final String imagePath; 

  FundPost({
    required this.id,
    required this.title,
    required this.description,
    required this.raisedAmount,
    required this.goalAmount,
    required this.galleryImages,
    required this.comments,
    required this.topDonors,
    required this.isStarred,
    required this.countryCode,
    required this.imagePath,
  });
}

class Donation {
  final String donorName;
  final double amount;
  final String avatarUrl;

  Donation({
    required this.donorName,
    required this.amount,
    required this.avatarUrl,
  });
}

class Comment {
  final String userName;
  final String comment;
  final double donatedAmount;

  Comment({
    required this.userName,
    required this.comment,
    required this.donatedAmount,
  });
}

import '../models/fund_post.dart';

class FakeDB {
  // synchronous dummy post for quick local testing
  static FundPost getDummyPost() {
    return FundPost(
      id: 'test fund',
      title: "i want to learn embroidery",
      description: "i am so done with academia pls let me go this was a mistaaake.",
      raisedAmount: 1050.0,
      goalAmount: 3000.0,
      galleryImages: [
        'imgs/img.png',
        'imgs/img.png',
        'imgs/img.png',
      ],
      comments: [
        Comment(userName: 'dad', comment: 'here is an allowance raise', donatedAmount: 100),
        Comment(userName: 'sister', comment: 'should have been a dr', donatedAmount: 300),
      ],
      topDonors: [
        Donation(donorName: 'p1', amount: 300, avatarUrl: 'imgs/profile.png'),
        Donation(donorName: 'p2', amount: 200, avatarUrl: 'imgs/profile.png'),
        Donation(donorName: 'p3', amount: 150, avatarUrl: 'imgs/profile.png'),
      ],
      isStarred: false,
      countryCode: 'EG',
      imagePath: 'imgs/screenshot.png',
    );
  }
}

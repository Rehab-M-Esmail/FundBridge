import 'package:flutter/material.dart';
import '../repository/fake_db.dart';
import '../models/fund_post.dart';

class FundPostProvider extends ChangeNotifier {
  late FundPost _post;


  FundPostProvider() {
    _post = FakeDB.getDummyPost();
  }

  // public getter used by UI
  FundPost get fundPost => _post;


  void updateDonations(double amount) {
    _post = FundPost(
      id: _post.id,
      title: _post.title,
      description: _post.description,
      raisedAmount: _post.raisedAmount + amount,
      goalAmount: _post.goalAmount,
      galleryImages: _post.galleryImages,
      comments: _post.comments,
      topDonors: _post.topDonors,
      isStarred: _post.isStarred,
      countryCode: _post.countryCode,
      imagePath: _post.imagePath,
    );
    notifyListeners();
  }

  void toggleStarred() {
    _post = FundPost(
      id: _post.id,
      title: _post.title,
      description: _post.description,
      raisedAmount: _post.raisedAmount,
      goalAmount: _post.goalAmount,
      galleryImages: _post.galleryImages,
      comments: _post.comments,
      topDonors: _post.topDonors,
      isStarred: !_post.isStarred,
      countryCode: _post.countryCode,
      imagePath: _post.imagePath,
    );
    notifyListeners();
  }


  void addComment(Comment comment) {
    final newComments = List<Comment>.from(_post.comments)..insert(0, comment);
    _post = FundPost(
      id: _post.id,
      title: _post.title,
      description: _post.description,
      raisedAmount: _post.raisedAmount,
      goalAmount: _post.goalAmount,
      galleryImages: _post.galleryImages,
      comments: newComments,
      topDonors: _post.topDonors,
      isStarred: _post.isStarred,
      countryCode: _post.countryCode,
      imagePath: _post.imagePath,
    );
    notifyListeners();
  }
}

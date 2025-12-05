import 'dart:io';
import 'package:flutter/material.dart';

class DonationProvider extends ChangeNotifier {
  String? title;
  String? description;
  int? goal;
  String? target;
  String? image;

  void setTitle(String title) {
    this.title = title;
    notifyListeners();
  }

  void setDescription(String description) {
    this.description = description;
    notifyListeners();
  }

  void setGoal(int goal) {
    this.goal = goal;
    notifyListeners();
  }

  void setTarget(String target) {
    this.target = target;
    notifyListeners();
  }

  void setImage(String image) {
    this.image = image;
    notifyListeners();
  }

  Map showDonationDetails() {
    return {
      'title': title,
      'description': description,
      'goal': goal,
      'target': target,
      'image': image,
    };
  }
}

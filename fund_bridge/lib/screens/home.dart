import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/funding.dart';
import 'package:fund_bridge/screens/donate.dart';

class SearchBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search funds, companies, or keywords...',
          prefixIcon: Icon(Icons.search, color: Colors.blueGrey),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 16.0,
          ),
          isDense: true,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late Future<List<Funding>> fundings;

  Future<List<Funding>> fetchFundings() async {
    final response = await http.get(
      Uri.parse('http://192.168.1.4:8000/api/fundings'),
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((f) => Funding.fromJson(f)).toList();
    } else {
      throw Exception('Failed to load funding data');
    }
  }

  @override
  void initState() {
    super.initState();
    fundings = fetchFundings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Funding>>(
        future: fundings,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final items = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'app_logo',
                  child: Image(
                    height: MediaQuery.of(context).size.height * 0.05,
                    image: AssetImage("imgs/logo.png"),
                  ),
                ),
                Text(
                  "Search",
                  style: TextStyle(
                    fontSize: 27,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w900,
                    color: Color(0xff333333),
                  ),
                ),
                CupertinoSearchTextField(),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final fund = items[index];
                      return TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: Duration(milliseconds: 400 + (index * 100)),
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, 50 * (1 - value)),
                              child: child,
                            ),
                          );
                        },
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: const EdgeInsets.only(bottom: 15),
                          child: ListTile(
                            leading: Hero(
                              tag: 'fund_image_${fund.id}',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  fund.image,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const CircleAvatar(
                                      backgroundColor: Colors.indigoAccent,
                                      child: Icon(
                                        Icons.trending_up,
                                        color: Colors.white,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            title: Text(
                              fund.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                color: Color(0xff333333),
                              ),
                            ),
                            subtitle: Text(fund.author),
                            trailing: Text(
                              "\$${fund.fundingAmount}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff008748)),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 500),
                                  reverseTransitionDuration:
                                      const Duration(milliseconds: 500),
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      donate(
                                    campaignData: {
                                      'id': fund.id,
                                      'title': fund.title,
                                      'description': fund.description,
                                      'donationGoal': fund.fundingAmount,
                                      'currentAmount': fund.currentAmount,
                                      'image': fund.image,
                                      'author': fund.author,
                                      'category': fund.category,
                                    },
                                  ),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

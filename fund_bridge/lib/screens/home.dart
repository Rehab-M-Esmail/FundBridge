import 'package:flutter/material.dart';
import '../common_appbar.dart';

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
            borderSide: BorderSide.none, // Hide the border
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

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CommonAppBar(title: 'FundBridge'),
        bottom: const SearchBar(),
      ),
      body: CarouselView(
        scrollDirection: Axis.vertical,
        itemExtent: double.infinity,
        children: List<Widget>.generate(10, (int index) {
          return Center(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        '../imgs/profile.jpg',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback in case image fails to load
                          return const CircleAvatar(
                            backgroundColor: Colors.indigoAccent,
                            child: Icon(Icons.trending_up, color: Colors.white),
                          );
                        },
                      ),
                    ),
                    title: Text('Fund title'),
                    subtitle: Text('Author Name'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(child: const Text('\$'), onPressed: () {}),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

void main(List<String> args) {
  runApp(
    const MaterialApp(
      title: 'FundBridge App',
      debugShowCheckedModeBanner: false,
      home: home(),
    ),
  );
}

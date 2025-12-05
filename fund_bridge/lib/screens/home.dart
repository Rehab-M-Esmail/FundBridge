import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../common_appbar.dart';
import '../models/funding.dart';

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

class _HomeState extends State<Home> {
  late Future<List<Funding>> fundings;

  Future<List<Funding>> fetchFundings() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/fundings'),
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
      appBar: AppBar(
        title: const CommonAppBar(title: 'FundBridge'),
        bottom: const SearchBar(),
      ),
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

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final fund = items[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      fund.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const CircleAvatar(
                          backgroundColor: Colors.indigoAccent,
                          child: Icon(Icons.trending_up, color: Colors.white),
                        );
                      },
                    ),
                  ),
                  title: Text(fund.title),
                  subtitle: Text(fund.author),
                  trailing: Text(
                    "\$${fund.fundingAmount}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      title: 'FundBridge App',
      debugShowCheckedModeBanner: false,
      home: Home(),
    ),
  );
}

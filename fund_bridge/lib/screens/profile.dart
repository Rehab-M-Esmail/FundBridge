import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fund_bridge/reusable-widgets/longButton.dart';
import 'package:fund_bridge/services/donations.dart';
import 'package:fund_bridge/services/userService.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final storage = FlutterSecureStorage();
  final UserService userService = UserService();
  final DonationsService donationsService = DonationsService();

  Future<Map<String, dynamic>?>? _userFuture;
  Future<List<Map<String, dynamic>>>? _campaignsFuture;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _userFuture = _loadUser();
    _campaignsFuture = _loadCampaigns();
  }

  Future<int?> _getUserId() async {
    final userIdStr = await storage.read(key: 'USER_ID');
    if (userIdStr == null || userIdStr.isEmpty || userIdStr == 'null') {
      return null;
    }
    return int.tryParse(userIdStr);
  }

  Future<Map<String, dynamic>?> _loadUser() async {
    final userId = await _getUserId();
    if (userId == null) return null;
    return userService.getUserById(userId);
  }

  Future<List<Map<String, dynamic>>> _loadCampaigns() async {
    final userId = await _getUserId();
    if (userId == null) return [];
    return donationsService.getDonationsByUserId(userId);
  }

  Future<void> _logout() async {
    await storage.delete(key: 'USER_ID');
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          26,
          MediaQuery.of(context).size.height * 0.07,
          26,
          20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              height: MediaQuery.of(context).size.height * 0.05,
              image: AssetImage("imgs/logo.png"),
            ),
            const SizedBox(height: 18),
            Text(
              "Profile",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xff0D4715),
              ),
            ),
            const SizedBox(height: 18),
            FutureBuilder<Map<String, dynamic>?>(
              future: _userFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final user = snapshot.data;
                if (user == null) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xffF1F0E9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "You are not logged in",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Color(0xff333333),
                          ),
                        ),
                        const SizedBox(height: 10),
                        LongButton(
                          text: "Log in",
                          action: () => Navigator.pushNamed(context, "/login"),
                        ),
                      ],
                    ),
                  );
                }

                final name = user['name']?.toString() ?? '';
                final email = user['email']?.toString() ?? '';

                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xffF1F0E9),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: const Color(0xffE8F3EC),
                        child: Icon(Icons.person, color: Color(0xff0D4715)),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Color(0xff333333),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              email,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff6B8A88),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 18),
            Text(
              "Your fundraisers",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Color(0xff333333),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _campaignsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final items = snapshot.data ?? [];
                  if (items.isEmpty) {
                    return Center(
                      child: Text(
                        "No fundraisers yet",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff767676),
                        ),
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      setState(() {
                        _reload();
                      });
                      await _campaignsFuture;
                    },
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final c = items[index];
                        final title = c['title']?.toString() ?? '';
                        final description = c['description']?.toString() ?? '';
                        final goal = c['donationGoal'];
                        final target = c['donationTarget']?.toString() ?? '';
                        final totalRaised = c['totalRaised'];

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xff333333),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff767676),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Target: $target",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff0D4715),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Raised: ${totalRaised ?? 0}",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff0D4715),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Goal: ${goal ?? 0}",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff0D4715),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            LongButton(text: "Log out", action: _logout),
          ],
        ),
      ),
    );
  }
}

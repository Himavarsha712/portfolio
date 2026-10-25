
import 'package:flutter/material.dart';

void main() {
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Portfolio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

// PAGE 1: LOGIN
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final rollController = TextEditingController();
  final passwordController = TextEditingController();
  bool hidePassword = true;

  @override
  void dispose() {
    rollController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    if (rollController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter roll number and password'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DashboardPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 55,
                backgroundColor: Colors.deepPurple,
                backgroundImage: AssetImage('assets/profile.jpeg'),
              ),
              const SizedBox(height: 18),
              const Icon(
                Icons.account_circle,
                size: 42,
                color: Colors.deepPurple,
              ),
              const SizedBox(height: 18),
              const Text(
                'My Portfolio',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text('Showcase your journey and achievements'),
              const SizedBox(height: 35),
              TextField(
                controller: rollController,
                decoration: const InputDecoration(
                  labelText: 'Roll Number',
                  prefixIcon: Icon(Icons.badge),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 18),
              TextField(
                controller: passwordController,
                obscureText: hidePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      hidePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: login,
                  icon: const Icon(Icons.login),
                  label: const Text('LOGIN'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// PAGE 2: DASHBOARD
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Portfolio'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(icon: Icon(Icons.school), text: 'Academics'),
              Tab(icon: Icon(Icons.workspace_premium),
                  text: 'Certificates'),
              Tab(icon: Icon(Icons.emoji_events),
                  text: 'Activities'),
              Tab(icon: Icon(Icons.photo_library),
                  text: 'Achievements'),
            ],
          ),
          actions: [
            IconButton(
              tooltip: 'Logout',
              icon: const Icon(Icons.logout),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        ),
        body: const TabBarView(
          children: [
            AcademicTab(),
            CertificatesTab(),
            ActivitiesTab(),
            AchievementsTab(),
          ],
        ),
      ),
    );
  }
}

// TAB 1: ACADEMIC DETAILS
class AcademicTab extends StatelessWidget {
  const AcademicTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Academic Details',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Course')),
                DataColumn(label: Text('Institution')),
                DataColumn(label: Text('Year')),
              ],
              rows: const [
                DataRow(cells: [
                  DataCell(Text('10th')),
                  DataCell(Text('Your School')),
                  DataCell(Text('2021')),
                ]),
                DataRow(cells: [
                  DataCell(Text('12th')),
                  DataCell(Text('Your College')),
                  DataCell(Text('2023')),
                ]),
                DataRow(cells: [
                  DataCell(Text('B.Tech CSE')),
                  DataCell(Text('BVRIT')),
                  DataCell(Text('2023-27')),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Card(
            child: ListTile(
              leading: Icon(Icons.stars, color: Colors.deepPurple),
              title: Text('My Academic Goal'),
              subtitle: Text('Learn, improve and achieve more!'),
            ),
          ),
        ],
      ),
    );
  }
}

// TAB 2: CERTIFICATIONS
class CertificatesTab extends StatelessWidget {
  const CertificatesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final certificates = [
      'Flutter Development',
      'Python Programming',
      'Cloud Computing',
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Course Certifications',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        for (final certificate in certificates)
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.workspace_premium,
                color: Colors.deepPurple,
                size: 35,
              ),
              title: Text(certificate),
              subtitle: const Text('Add platform and completion year'),
              trailing: const Icon(Icons.verified),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$certificate selected'),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

// TAB 3: EXTRA-CURRICULAR ACTIVITIES
class ActivitiesTab extends StatelessWidget {
  const ActivitiesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = [
      ['College Events', Icons.event],
      ['Technical Workshops', Icons.computer],
      ['Hackathons', Icons.code],
      ['Sports and Fitness', Icons.sports],
      ['Volunteering', Icons.volunteer_activism],
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Extra-Curricular Activities',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        for (final activity in activities)
          Card(
            child: ListTile(
              leading: Icon(
                activity[1] as IconData,
                color: Colors.deepPurple,
              ),
              title: Text(activity[0] as String),
              subtitle: const Text('Add your participation details'),
            ),
          ),
      ],
    );
  }
}


class AchievementsTab extends StatefulWidget {
  const AchievementsTab({super.key});

  @override
  State<AchievementsTab> createState() => _AchievementsTabState();
}

class _AchievementsTabState extends State<AchievementsTab> {
  late final PageController controller;
  int currentPage = 0;

  final List<Map<String, String>> certificates = [
    {
      'title': 'Certificate 1',
      'image': 'assets/certificates/certificate1.png',
    },
    {
      'title': 'Certificate 2',
      'image': 'assets/certificates/certificate2.png',
    },
    {
      'title': 'Certificate 3',
      'image': 'assets/certificates/certificate3.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    controller = PageController(viewportFraction: 0.88);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'My Achievements',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: PageView.builder(
            controller: controller,
            itemCount: certificates.length,
            onPageChanged: (index) {
              setState(() => currentPage = index);
            },
            itemBuilder: (context, index) {
              final certificate = certificates[index];

              return AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.all(12),
                child: Card(
                  elevation: 6,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(
                            certificate['image']!,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Text(
                                  'Certificate image not found.\n'
                                  'Check the filename and assets folder.',
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          certificate['title']!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              certificates.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: currentPage == index ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: currentPage == index
                      ? Colors.deepPurple
                      : Colors.deepPurple.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
        Text(
          'Certificate ${currentPage + 1} of ${certificates.length}',
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

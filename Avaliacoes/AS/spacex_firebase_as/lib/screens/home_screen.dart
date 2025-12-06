import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../services/api_service.dart';
import '../models/launch_model.dart';
import 'login_screen.dart';
import 'launch_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  final ApiService _apiService = ApiService();
  late Future<List<Launch>> _launchesFuture;

  @override
  void initState() {
    super.initState();
    _loadLaunches();
  }

  Future<void> _loadLaunches() async {
    setState(() {
      _launchesFuture = _apiService.fetchLaunches();
    });
  }

  void _logout() async {
    await _authService.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "SpaceX Launches 🚀",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "Olá, ${user?.displayName ?? 'Astronauta'}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: _logout,
            tooltip: "Sair",
          )
        ],
      ),
      // RefreshIndicator permite puxar a lista para baixo para recarregar
      body: RefreshIndicator(
        onRefresh: _loadLaunches,
        child: FutureBuilder<List<Launch>>(
          future: _launchesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Erro ao carregar dados.",
                        style: TextStyle(color: Colors.red),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _loadLaunches,
                        child: Text("Tentar Novamente"),
                      )
                    ],
                  ),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("Nenhum lançamento encontrado."));
            }

            final launches = snapshot.data!;

            return ListView.builder(
              itemCount: launches.length,
              itemBuilder: (context, index) {
                final launch = launches[index];

                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LaunchDetailScreen(launch: launch),
                        ),
                      );
                    },
                    // ------------------------------------

                    leading: launch.patchImage != null
                        ? Image.network(
                      launch.patchImage!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return CircularProgressIndicator(strokeWidth: 2);
                      },
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.rocket_launch,
                              size: 40, color: Colors.grey),
                    )
                        : Icon(Icons.rocket_launch,
                        size: 40, color: Colors.blueGrey),

                    title: Text(
                      launch.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    subtitle: Text(
                      launch.details ??
                          "Sem detalhes disponíveis para esta missão.",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    trailing: Icon(
                      launch.success == true ? Icons.check_circle : Icons.error_outline,
                      color: launch.success == true ? Colors.greenAccent : Colors.redAccent,
                    ),

                    isThreeLine: true,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
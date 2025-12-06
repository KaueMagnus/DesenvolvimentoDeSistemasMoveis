import 'package:flutter/material.dart';
import '../models/launch_model.dart';

class LaunchDetailScreen extends StatelessWidget {
  final Launch launch;

  const LaunchDetailScreen({Key? key, required this.launch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define a cor baseada no sucesso da missão
    final Color statusColor = (launch.success == true) ? Colors.greenAccent : Colors.redAccent;
    final IconData statusIcon = (launch.success == true) ? Icons.check_circle : Icons.cancel;
    final String statusText = (launch.success == true) ? "SUCESSO NA MISSÃO" : "FALHA NA MISSÃO";

    return Scaffold(
      appBar: AppBar(
        title: Text(launch.name),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 20),

            Center(
              child: Container(
                height: 220,
                width: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.15),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: Hero(
                  tag: launch.id,
                  child: launch.patchImage != null
                      ? Image.network(launch.patchImage!, fit: BoxFit.contain)
                      : Icon(Icons.rocket_launch, size: 100, color: Colors.white24),
                ),
              ),
            ),

            SizedBox(height: 40),

            Text(
              launch.name,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "ID: ${launch.id}",
                style: TextStyle(color: Colors.white54, fontSize: 12, fontFamily: 'Courier'),
              ),
            ),

            SizedBox(height: 32),

            // INDICADOR DE STATUS
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: statusColor.withOpacity(0.5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(statusIcon, color: statusColor, size: 28),
                  SizedBox(width: 12),
                  Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32),

            // CARD DE DETALHES
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Color(0xFF1E1F25),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blueAccent, size: 20),
                      SizedBox(width: 10),
                      Text(
                        "Resumo da Operação",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.white10, height: 30),
                  Text(
                    launch.details ?? "A SpaceX não forneceu descrição pública para esta missão confidencial ou padronizada.",
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
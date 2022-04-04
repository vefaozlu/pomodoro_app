import 'package:flutter/material.dart';
import 'package:pomodoro_app/colors.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({Key? key}) : super(key: key);

  static const routeName = '/informationPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PomodoroColors.color1,
      appBar: AppBar(
        backgroundColor: PomodoroColors.color2,
        title: Text('Information'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            InfoTile(title: 'Ders Adi: ', text: 'Mobil Programlama'),
            InfoTile(title: 'Dersin Kodu: ', text: '3301456'),
            InfoTile(title: 'Universite: ', text: 'Selcuk Universitesi'),
            InfoTile(title: 'Fakulte: ', text: 'Teknoloji Fakultesi'),
            InfoTile(title: 'Bolum: ', text: 'Bilgisayar Muhendisligi'),
            InfoTile(title: 'Kadir Vefa Ozlu', text: '193301006'),
          ],
        ),
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  const InfoTile({Key? key, required this.title, required this.text})
      : super(key: key);
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * .8,
        decoration: BoxDecoration(
          color: PomodoroColors.color2,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: PomodoroColors.color3,
                ),
              ),
              Text(
                text,
                style: const TextStyle(
                  color: PomodoroColors.color3,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

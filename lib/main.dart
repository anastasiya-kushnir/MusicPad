import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  List<Pad> buildPads() {
    final List<String> notes = [
      "1.mp3",
      "2.mp3",
      "3.mp3",
      "4.mp3",
      "5.mp3",
      "6.mp3",
      "7.mp3",
      "8.mp3",
      "9.mp3",
      "10.mp3",
      "11.mp3",
      "12.mp3",
      "13.mp3",
      "14.mp3",
      "15.mp3",
      "16.mp3",
      "17.mp3",
      "18.mp3",
      "19.mp3",
      "20.wav",
      "21.mp3",
      "22.wav",
      "23.wav",
      "24.wav",
      "25.wav",
      "26.wav",
      "27.wav",
      "28.mp3"
    ];

    final List<Color> colors = [
      Colors.deepPurple,
      Colors.orange,
      Colors.indigoAccent,
      Colors.teal,
    ];

    return List.generate(notes.length, (index) {
      return Pad(
        colorCenter: Colors.white,
        colorOutline: colors[index % colors.length],
        note: notes[index],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MusicPad",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("MusicPad",
              style: GoogleFonts.orbitron(color: Colors.white)),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Wrap(
            spacing: 6,
            runSpacing: 6,
            children: buildPads(),
          ),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}

class Pad extends StatefulWidget {
  final Color colorCenter;
  final Color colorOutline;
  final String note;

  const Pad(
      {super.key,
      required this.colorCenter,
      required this.colorOutline,
      required this.note});

  @override
  State<Pad> createState() => _PadState();
}

class _PadState extends State<Pad> {
  late Color _colorCenter;
  late Color _colorOutline;
  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _colorCenter = widget.colorCenter;
    _colorOutline = widget.colorOutline;
  }

  Future<void> _handleTap() async {
    setState(() {
      _colorCenter = Colors.white;
      _colorOutline = Colors.white;
    });

    await _player.play(AssetSource(widget.note));
    await Future.delayed(const Duration(milliseconds: 300));

    if (mounted) {
      setState(() {
        _colorCenter = widget.colorCenter;
        _colorOutline = widget.colorOutline;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            height: MediaQuery.of(context).size.height / 8.2,
            width: MediaQuery.of(context).size.width / 4.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              gradient: RadialGradient(
                colors: [_colorCenter, _colorOutline],
                radius: 0.5,
              ),
              boxShadow: const [
                BoxShadow(color: Colors.pink, blurRadius: 5),
              ],
            ),
          );
        },
      ),
    );
  }
}

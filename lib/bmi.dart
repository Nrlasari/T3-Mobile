import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final _bbController = TextEditingController();
  final _tbController = TextEditingController();

  final Color warnaUtama = const Color.fromARGB(255, 72, 121, 97);

  String? _jenisKelamin;
  double? hasilBMI;
  String _keterangan = 'Hasil BMI muncul di sini';

  void _logikaBMI() {
    final bb = double.tryParse(_bbController.text.replaceAll(',', '.'));

    final tbInCm = double.tryParse(_tbController.text.replaceAll(',', '.'));

    if (bb == null || tbInCm == null || bb <= 0 || tbInCm <= 0) {
      setState(() {
        hasilBMI = null;
        _keterangan = 'Masukkan berat dan tinggi badan dengan benar';
      });
      return;
    }

    if (_jenisKelamin == null) {
      setState(() {
        hasilBMI = null;
        _keterangan = 'Pilih jenis kelamin terlebih dahulu';
      });
      return;
    }

    final tbInM = tbInCm / 100;
    final bmi = bb / (tbInM * tbInM);

    setState(() {
      hasilBMI = bmi;

      if (bmi < 18.5) {
        _keterangan = 'Kekurangan berat badan';
      } else if (bmi < 25) {
        _keterangan = 'Berat badan ideal';
      } else if (bmi < 30) {
        _keterangan = 'Kelebihan berat badan';
      } else {
        _keterangan = 'Obesitas';
      }
    });
  }

  void _resetBMI() {
    setState(() {
      _bbController.clear();
      _tbController.clear();
      _jenisKelamin = null;
      hasilBMI = null;
      _keterangan = 'Hasil BMI muncul di sini';
    });
  }

  @override
  void dispose() {
    _bbController.dispose();
    _tbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Kalkulator BMI'),
          centerTitle: true,
          backgroundColor: warnaUtama,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),

              const Text(
                'Hitung BMI',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              const Text(
                'Silakan masukkan data Anda.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              const Text(
                'Jenis Kelamin',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),

              RadioListTile<String>(
                title: const Text('Laki-laki'),
                value: 'Laki-laki',
                groupValue: _jenisKelamin,
                activeColor: warnaUtama,
                contentPadding: EdgeInsets.zero,
                onChanged: (value) {
                  setState(() {
                    _jenisKelamin = value;
                  });
                },
              ),

              RadioListTile<String>(
                title: const Text('Perempuan'),
                value: 'Perempuan',
                groupValue: _jenisKelamin,
                activeColor: warnaUtama,
                contentPadding: EdgeInsets.zero,
                onChanged: (value) {
                  setState(() {
                    _jenisKelamin = value;
                  });
                },
              ),

              const SizedBox(height: 10),

              TextField(
                controller: _bbController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: 'Berat Badan (Kg)',
                  prefixIcon: const Icon(Icons.monitor_weight),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: warnaUtama),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: _tbController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: 'Tinggi Badan (Cm)',
                  prefixIcon: const Icon(Icons.height),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: warnaUtama),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _logikaBMI,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: warnaUtama,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Hitung BMI'),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: OutlinedButton(
                      onPressed: _resetBMI,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: warnaUtama,
                        side: BorderSide(color: warnaUtama),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Reset'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),
              const Divider(),

              const Text(
                'Hasil Perhitungan',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              if (hasilBMI != null) ...[
                Text(
                  'Jenis Kelamin: $_jenisKelamin',
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                Text(
                  'BMI: ${hasilBMI!.toStringAsFixed(2)}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: warnaUtama,
                  ),
                ),

                const SizedBox(height: 8),

                Text('Kategori: $_keterangan', textAlign: TextAlign.center),
              ] else
                Text(
                  _keterangan,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black54),
                ),

              const SizedBox(height: 25),
              const Divider(),

              const Text(
                'Kategori BMI Dewasa',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              const Text('Di bawah 18,5: Kekurangan berat badan'),
              const Text('18,5–24,9: Berat badan ideal'),
              const Text('25–29,9: Kelebihan berat badan'),
              const Text('30 ke atas: Obesitas'),
            ],
          ),
        ),
      ),
    );
  }
}

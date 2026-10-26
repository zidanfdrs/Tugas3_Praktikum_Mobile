import 'package:flutter/material.dart';

class Bmi extends StatefulWidget {
  const Bmi({super.key});

  @override
  State<Bmi> createState() => _BmiState();
}

class _BmiState extends State<Bmi> {
  static const _primaryColor = Color(0xFF3563E9);
  static const _backgroundColor = Color(0xFFF5F7FC);

  final bbcontroller = TextEditingController();
  final tbcontroller = TextEditingController();

  double? _bmiresult;
  String _keterangan = 'Hasil Perhitungan';
  int? _selectedGender = 0;

  void _reset() {
    setState(() {
      bbcontroller.clear();
      tbcontroller.clear();
      _bmiresult = null;
      _keterangan = 'Hasil Perhitungan';
    });
  }

  void _hitung() {
    final double bb = double.tryParse(bbcontroller.text) ?? 0;
    final double tb = double.tryParse(tbcontroller.text) ?? 0;

    if (bb <= 0 || tb <= 0) {
      return;
    }

    final double tbm = tb / 100;
    final double bmi = bb / (tbm * tbm);

    setState(() {
      _bmiresult = bmi;

      if (bmi < 18.5) {
        _keterangan = 'Kurang';
      } else if (bmi < 23) {
        _keterangan = 'Ideal';
      } else if (bmi < 25) {
        _keterangan = 'Kelebihan';
      } else {
        _keterangan = 'Obesitas';
      }
    });
  }

  void _selectGender(int gender) {
    setState(() {
      _selectedGender = _selectedGender == gender ? null : gender;
      _bmiresult = null;
      _keterangan = 'Hasil Perhitungan';
    });
  }

  Widget _buildGenderCard({
    required int gender,
    required String label,
    required IconData icon,
  }) {
    final isSelected = _selectedGender == gender;

    return Expanded(
      child: InkWell(
        onTap: () => _selectGender(gender),
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFEDF2FF) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? _primaryColor : const Color(0xFFE8ECF4),
              width: isSelected ? 1.6 : 1,
            ),
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 27,
                backgroundColor: isSelected
                    ? _primaryColor
                    : const Color(0xFFF0F3FA),
                child: Icon(
                  icon,
                  size: 30,
                  color: isSelected ? Colors.white : const Color(0xFF74809A),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  color: isSelected
                      ? const Color(0xFF233B77)
                      : const Color(0xFF596579),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required String hint,
    required String unit,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      suffixText: unit,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: const Color(0xFFF8F9FC),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFFE8ECF4)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: _primaryColor, width: 1.5),
      ),
    );
  }

  @override
  void dispose() {
    bbcontroller.dispose();
    tbcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Kalkulator BMI',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        leading: const Icon(Icons.monitor_heart_rounded),
        backgroundColor: _backgroundColor,
        foregroundColor: const Color(0xFF202B3C),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const Text(
                'Pilih gender',
                style: TextStyle(
                  color: Color(0xFF303B4E),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildGenderCard(
                    gender: 0,
                    label: 'Laki-laki',
                    icon: Icons.male_rounded,
                  ),
                  const SizedBox(width: 12),
                  _buildGenderCard(
                    gender: 1,
                    label: 'Perempuan',
                    icon: Icons.female_rounded,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: const Color(0xFFE8ECF4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Data tubuh',
                      style: TextStyle(
                        color: Color(0xFF303B4E),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: bbcontroller,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: _inputDecoration(
                        label: 'Berat badan',
                        hint: 'Contoh: 60',
                        unit: 'kg',
                        icon: Icons.monitor_weight_outlined,
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: tbcontroller,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: _inputDecoration(
                        label: 'Tinggi badan',
                        hint: 'Contoh: 165',
                        unit: 'cm',
                        icon: Icons.height_rounded,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 54,
                      child: ElevatedButton.icon(
                        onPressed: _hitung,
                        icon: const Icon(Icons.calculate_outlined),
                        label: const Text('Hitung BMI'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryColor,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    height: 54,
                    child: OutlinedButton(
                      onPressed: _reset,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text('Reset'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3563E9), Color(0xFF6288F2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hasil perhitungan',
                      style: TextStyle(
                        color: Color(0xFFDCE6FF),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _bmiresult?.toStringAsFixed(2) ?? '--',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 42,
                            height: 1,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -1,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 9, bottom: 5),
                          child: Text(
                            'BMI',
                            style: TextStyle(
                              color: Color(0xFFDCE6FF),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        _keterangan,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _bmiresult == null
                          ? 'Hasil BMI akan muncul setelah kamu menghitung.'
                          : (_selectedGender == null
                                ? 'Perkiraan berdasarkan data yang kamu masukkan.'
                                : 'Hasil untuk ${_selectedGender == 0 ? 'laki-laki' : 'perempuan'} berdasarkan data yang kamu masukkan.'),
                      style: const TextStyle(
                        color: Color(0xFFE4EBFF),
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

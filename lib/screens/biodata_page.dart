import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/section_header.dart';

/// BIODATA — Form statis
class BiodataPage extends StatefulWidget {
  const BiodataPage({super.key});

  @override
  State<BiodataPage> createState() => _BiodataPageState();
}

class _BiodataPageState extends State<BiodataPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaCtrl = TextEditingController();
  final _nimCtrl = TextEditingController();
  final _hobiCtrl = TextEditingController();
  String? _gender = 'Laki-laki';
  String? _prodi = 'Informatika';
  DateTime? _tanggal;

  @override
  void dispose() {
    _namaCtrl.dispose();
    _nimCtrl.dispose();
    _hobiCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final res = await showDatePicker(
      context: context,
      firstDate: DateTime(1990),
      lastDate: DateTime(now.year + 1),
      initialDate: _tanggal ?? DateTime(now.year - 20),
    );
    if (res != null) setState(() => _tanggal = res);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final snack = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.card,
      content: Text(
        'Tersimpan (statis): '
        'Nama=${_namaCtrl.text}, NIM=${_nimCtrl.text}, Prodi=$_prodi, '
        'Gender=$_gender, Tgl=${_tanggal?.toIso8601String().split("T").first}, '
        'Hobi=${_hobiCtrl.text}',
        style: const TextStyle(color: Colors.white),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SectionHeader(
            title: 'Biodata',
            subtitle: 'Isi data diri (statis, tidak disimpan ke database)',
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Foto profil (pakai asset jika tersedia)
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 36,
                          backgroundColor: const Color(0xFF232B3B),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/profile.jpg',
                              width: 72,
                              height: 72,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                    Icons.person,
                                    size: 38,
                                    color: AppColors.gold,
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text('Unggah foto', style: t.bodyMedium),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _namaCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Nama Lengkap',
                      ),
                      validator: (v) =>
                          (v == null || v.isEmpty) ? 'Wajib diisi' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _nimCtrl,
                      decoration: const InputDecoration(labelText: 'NIM'),
                      validator: (v) =>
                          (v == null || v.isEmpty) ? 'Wajib diisi' : null,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _prodi,
                      decoration: const InputDecoration(
                        labelText: 'Program Studi',
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Informatika',
                          child: Text('Informatika'),
                        ),
                        DropdownMenuItem(
                          value: 'Sistem Informasi',
                          child: Text('Sistem Informasi'),
                        ),
                        DropdownMenuItem(
                          value: 'Teknik Elektro',
                          child: Text('Teknik Elektro'),
                        ),
                      ],
                      onChanged: (v) => setState(() => _prodi = v),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Jenis Kelamin', style: t.titleLarge),
                    ),
                    RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      value: 'Laki-laki',
                      groupValue: _gender,
                      onChanged: (v) => setState(() => _gender = v),
                      title: const Text('Laki-laki'),
                    ),
                    RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      value: 'Perempuan',
                      groupValue: _gender,
                      onChanged: (v) => setState(() => _gender = v),
                      title: const Text('Perempuan'),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _hobiCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Hobi / Minat',
                        hintText: 'Contoh: membaca, fotografi',
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _pickDate,
                            icon: const Icon(Icons.calendar_month),
                            label: Text(
                              _tanggal == null
                                  ? 'Pilih Tanggal Lahir'
                                  : 'Tanggal: ${_tanggal!.toIso8601String().split("T").first}',
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.gold,
                              side: const BorderSide(color: AppColors.gold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.gold,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text('Simpan (Statis)'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

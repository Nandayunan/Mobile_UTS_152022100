import 'dart:math';

class Contact {
  final String name;
  final String phone;
  final String email;
  final String address;
  final String occupation;

  Contact({
    required this.name,
    required this.phone,
    String? email,
    String? address,
    String? occupation,
  }) : email = email ?? '${name.toLowerCase().replaceAll(' ', '.')}@email.com',
       address =
           address ?? 'Jl. Contoh No. ${Random().nextInt(100) + 1}, Bandung',
       occupation =
           occupation ??
           ['Mahasiswa', 'Dosen', 'Karyawan', 'Wiraswasta'][Random().nextInt(
             4,
           )];
}

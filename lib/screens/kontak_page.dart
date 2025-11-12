import 'dart:math';
import 'package:flutter/material.dart';
import '../models/contact.dart';
import '../theme/app_colors.dart';
import '../widgets/section_header.dart';
import '../widgets/contact_detail_tile.dart';

/// KONTAK — daftar statis
class KontakPage extends StatelessWidget {
  const KontakPage({super.key});

  List<Contact> _generate() {
    const names = [
      'Aisyah',
      'Budi',
      'Citra',
      'Dimas',
      'Eka',
      'Fajar',
      'Galih',
      'Hani',
      'Indra',
      'Joko',
      'Kiki',
      'Lia',
      'Mira',
      'Nanda',
      'Omar',
    ]; // >= 15
    return List.generate(
      names.length,
      (i) => Contact(
        name: names[i],
        phone: '08${(Random(i).nextInt(900000000) + 100000000)}',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final contacts = _generate();
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: contacts.length + 1,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (ctx, i) {
        if (i == 0) {
          return const SectionHeader(
            title: 'Kontak',
            subtitle: 'Daftar telepon (statis) dengan avatar melingkar.',
          );
        }
        final c = contacts[i - 1];
        final color = Colors.primaries[(i * 3) % Colors.primaries.length];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: color.shade400,
              child: Text(c.name.characters.first.toUpperCase()),
            ),
            title: Text(c.name),
            subtitle: Text(c.phone),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: AppColors.card,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header with avatar
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundColor: color.shade400,
                            child: Text(
                              c.name.characters.first.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  c.name,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  c.occupation,
                                  style: const TextStyle(
                                    color: AppColors.goldSoft,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Contact details
                      ContactDetailTile(
                        icon: Icons.phone,
                        label: 'Telepon',
                        value: c.phone,
                      ),
                      const Divider(height: 1, color: Color(0xFF2A303C)),
                      ContactDetailTile(
                        icon: Icons.email,
                        label: 'Email',
                        value: c.email,
                      ),
                      const Divider(height: 1, color: Color(0xFF2A303C)),
                      ContactDetailTile(
                        icon: Icons.location_on,
                        label: 'Alamat',
                        value: c.address,
                      ),
                      const SizedBox(height: 20),
                      // Action button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.gold,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Tutup'),
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
    );
  }
}

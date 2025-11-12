import 'package:flutter/material.dart';
import '../models/news.dart';
import '../widgets/section_header.dart';

/// BERITA — list statis
class BeritaPage extends StatelessWidget {
  const BeritaPage({super.key});

  List<News> _fakeNews() => [
    const News(
      title: 'Kampus Luncurkan Program Inovasi Mobile',
      teaser:
          'Banyak mahasiswa yang tertarik pada program baru itenas ini. dapatkan informasinya di sini.',
      time: '2 jam lalu',
    ),
    const News(
      title: 'Sidang Seminar Proposal Proyek Akhir',
      teaser:
          'Banyak mahasiswa itenas yang segera menyelesaikan seminar proposal untuk angkkatan 22.',
      time: '5 jam lalu',
    ),
    const News(
      title: 'ITENAS juarai Lomba Aplikasi Mobile Tingkat Nasional',
      teaser:
          'Abdy Ananda Yunan nrp 152022100 memenangkan Mobile Nasional Competition dengan saingan universitas terbesar di indonesia.',
      time: 'Kemarin',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final list = _fakeNews();
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: list.length + 1,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (ctx, i) {
        if (i == 0) {
          return const SectionHeader(
            title: 'Berita',
            subtitle: 'Berita ITENAS Terkini.',
          );
        }
        final n = list[i - 1];
        final color = Colors.primaries[(i * 5) % Colors.primaries.length];
        return Card(
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              radius: 26,
              backgroundColor: color.shade400,
              child: const Icon(Icons.article, color: Colors.white),
            ),
            title: Text(n.title, maxLines: 2, overflow: TextOverflow.ellipsis),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                Text(n.teaser, maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.schedule,
                      size: 16,
                      color: Color(0xFFB8C1CC),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      n.time,
                      style: const TextStyle(color: Color(0xFFB8C1CC)),
                    ),
                  ],
                ),
              ],
            ),
            onTap: () {},
          ),
        );
      },
    );
  }
}

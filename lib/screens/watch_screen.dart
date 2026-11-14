import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/video_model.dart';

class YouTubeWatchScreen extends StatefulWidget {
  final VideoItem video;

  const YouTubeWatchScreen({super.key, required this.video});

  @override
  State<YouTubeWatchScreen> createState() => _YouTubeWatchScreenState();
}

class _YouTubeWatchScreenState extends State<YouTubeWatchScreen> {
  bool _isLiked = false;
  bool _isDisliked = false;
  bool _isSubscribed = false;
  late VideoItem _currentVideo;
  final TextEditingController _commentController = TextEditingController();

  final _comments = [
    {
      'author': '@bima_pratama',
      'time': '2 jam yang lalu',
      'text':
          'Keren banget pembahasannya! Selalu ditunggu konten terbarunya 🔥',
      'initial': 'B',
    },
    {
      'author': '@sari_wijaya',
      'time': '5 jam yang lalu',
      'text': 'Auto merinding pas bagian menit ke-15, detail ceritanya dapet banget!',
      'initial': 'S',
    },
  ];

  @override
  void initState() {
    super.initState();
    _currentVideo = widget.video;
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _showFeedback(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF272727),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _addComment() {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _comments.insert(0, {
        'author': '@mahasiswa_uts',
        'time': 'Baru saja',
        'text': text,
        'initial': 'M',
      });
      _commentController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final recommendations = dummyVideos
        .where((v) => v.title != _currentVideo.title)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFFF0000),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 16,
              ),
            ),
            const SizedBox(width: 6),
            const Text(
              'YouTube',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.8,
              ),
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 900;
          if (isWide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 7, child: _buildMainPlayerArea()),
                Expanded(
                  flex: 3,
                  child: _buildRecommendationList(recommendations),
                ),
              ],
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                _buildMainPlayerArea(),
                _buildRecommendationList(recommendations),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMainPlayerArea() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Pemutar Video 16:9
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (_currentVideo.imageAsset != null)
                    Image.asset(_currentVideo.imageAsset!, fit: BoxFit.cover)
                  else
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: _currentVideo.thumbGradient,
                        ),
                      ),
                    ),
                  Container(color: Colors.black.withValues(alpha: 0.35)),
                  Center(
                    child: Container(
                      width: 68,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF0000),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 34,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        const LinearProgressIndicator(
                          value: 0.35,
                          backgroundColor: Colors.white24,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFFFF0000),
                          ),
                          minHeight: 3,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.pause,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              const Icon(
                                Icons.volume_up,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                '04:12 / ${_currentVideo.duration}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.settings,
                                color: Colors.white,
                                size: 18,
                              ),
                              const SizedBox(width: 12),
                              const Icon(
                                Icons.fullscreen,
                                color: Colors.white,
                                size: 22,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 2. Judul Video + Label "Disulih suara otomatis"
          Text(
            _currentVideo.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Row(
            children: [
              Icon(
                Icons.record_voice_over_outlined,
                color: Colors.grey,
                size: 15,
              ),
              SizedBox(width: 6),
              Text(
                'Disulih suara otomatis',
                style: TextStyle(color: Colors.grey, fontSize: 12.5),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // 3. Baris Channel, Subscribe, Like/Dislike Terpadu, Share, Ask AI, dan Menu Titik Tiga
          Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.spaceBetween,
            children: [
              // Kiri: Avatar, Nama Channel, Subscribe
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: _currentVideo.avatarBgColor,
                    child: Text(
                      _currentVideo.avatarText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            _currentVideo.channelName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          if (_currentVideo.isVerified) ...[
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.check_circle,
                              color: Colors.grey,
                              size: 14,
                            ),
                          ],
                        ],
                      ),
                      const Text(
                        '1,24 jt subscriber',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(width: 18),
                  ElevatedButton(
                    onPressed: () {
                      setState(() => _isSubscribed = !_isSubscribed);
                      _showFeedback(
                        _isSubscribed
                            ? 'Berhasil subscribe ke ${_currentVideo.channelName}'
                            : 'Berhenti subscribe',
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isSubscribed
                          ? const Color(0xFF272727)
                          : Colors.white,
                      foregroundColor: _isSubscribed
                          ? Colors.white
                          : Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      _isSubscribed ? 'Disubscribe' : 'Subscribe',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              // Kanan: Kapsul Like|Dislike, Tombol Bulat Share, Ask AI, dan Menu Titik Tiga
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Kapsul Gabungan Like & Dislike
                  Container(
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFF272727),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _isLiked = !_isLiked;
                              if (_isLiked) _isDisliked = false;
                            });
                          },
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  _isLiked
                                      ? Icons.thumb_up
                                      : Icons.thumb_up_outlined,
                                  color: _isLiked
                                      ? const Color(0xFF3EA6FF)
                                      : Colors.white,
                                  size: 18,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  _isLiked ? '15 rb' : '14 rb',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(width: 1, height: 20, color: Colors.white24),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _isDisliked = !_isDisliked;
                              if (_isDisliked) _isLiked = false;
                            });
                          },
                          borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            child: Icon(
                              _isDisliked
                                  ? Icons.thumb_down
                                  : Icons.thumb_down_outlined,
                              color: _isDisliked
                                  ? const Color(0xFF3EA6FF)
                                  : Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Tombol Bulat Share (Panah Lengkung YouTube)
                  InkWell(
                    onTap: () =>
                        _showFeedback('Tautan video disalin ke clipboard'),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: const BoxDecoration(
                        color: Color(0xFF272727),
                        shape: BoxShape.circle,
                      ),
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(math.pi),
                        child: const Icon(
                          Icons.reply,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Tombol Bulat Ask AI / Sparkle
                  InkWell(
                    onTap: () => _showFeedback(
                      'Ringkasan AI: Video membahas cerita dan eksplorasi di ${_currentVideo.channelName}.',
                    ),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: const BoxDecoration(
                        color: Color(0xFF272727),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Tombol Bulat Titik Tiga dengan Popup Menu Lengkap (Gambar 2)
                  PopupMenuButton<String>(
                    color: const Color(0xFF282828),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    offset: const Offset(0, 44),
                    onSelected: (value) {
                      _showFeedback('Fitur "$value" dipilih');
                    },
                    itemBuilder: (context) => [
                      _buildPopupItem(
                        value: 'Download',
                        icon: Icons.download_outlined,
                        title: 'Download',
                      ),
                      _buildPopupItem(
                        value: 'Terima kasih',
                        icon: Icons.volunteer_activism_outlined,
                        title: 'Terima kasih',
                        subtitle: 'Tunjukkan kepedulian Anda dengan komentar yang disorot',
                      ),
                      _buildPopupItem(
                        value: 'Simpan',
                        icon: Icons.bookmark_border,
                        title: 'Simpan',
                      ),
                      _buildPopupItem(
                        value: 'Viralkan',
                        icon: Icons.auto_awesome_outlined,
                        title: 'Viralkan',
                        subtitle: 'Beri hype untuk video kreator yang sedang naik daun ini',
                      ),
                      _buildPopupItem(
                        value: 'Laporkan',
                        icon: Icons.flag_outlined,
                        title: 'Laporkan',
                      ),
                    ],
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: const BoxDecoration(
                        color: Color(0xFF272727),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 4. Kotak Deskripsi
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF222222),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _currentVideo.isSponsored
                      ? 'Konten Bersponsor • ${_currentVideo.channelName}'
                      : '${_currentVideo.views} ditonton • ${_currentVideo.uploadedAt}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Tonton selengkapnya di channel ${_currentVideo.channelName}. Jangan lupa klik tombol Like, Share, dan Subscribe untuk mendukung kreator!',
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // 5. Bagian Komentar Interaktif
          Text(
            '${_comments.length} Komentar',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Input Tambah Komentar
          Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xFF1A73E8),
                child: Text(
                  'M',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _commentController,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  onSubmitted: (_) => _addComment(),
                  decoration: const InputDecoration(
                    hintText: 'Tambahkan komentar...',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF333333)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF3EA6FF),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _addComment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3EA6FF),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
                child: const Text(
                  'Komentar',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Daftar Komentar
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _comments.length,
            separatorBuilder: (_, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final item = _comments[index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: const Color(0xFF333333),
                    child: Text(
                      item['initial'] ?? 'U',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              item['author'] ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              item['time'] ?? '',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['text'] ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildPopupItem({
    required String value,
    required IconData icon,
    required String title,
    String? subtitle,
  }) {
    return PopupMenuItem<String>(
      value: value,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        crossAxisAlignment: subtitle != null
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationList(List<VideoItem> videos) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 20, right: 20, left: 8, bottom: 20),
      itemCount: videos.length,
      separatorBuilder: (_, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = videos[index];
        return InkWell(
          onTap: () => setState(() => _currentVideo = item),
          borderRadius: BorderRadius.circular(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 150,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: item.imageAsset != null
                        ? Image.asset(item.imageAsset!, fit: BoxFit.cover)
                        : Container(color: const Color(0xFF272727)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.channelName,
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                    if (!item.isSponsored)
                      Text(
                        '${item.views} • ${item.uploadedAt}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

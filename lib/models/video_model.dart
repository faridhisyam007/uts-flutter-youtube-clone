import 'package:flutter/material.dart';

class VideoItem {
  final String title;
  final String channelName;
  final String views;
  final String uploadedAt;
  final String duration;
  final String avatarText;
  final Color avatarBgColor;
  final List<Color> thumbGradient;
  final String thumbHeadline;
  final String thumbSubheadline;
  final String? imageAsset;
  final String? topTag;
  final bool isVerified;
  final bool isSponsored;

  const VideoItem({
    required this.title,
    required this.channelName,
    required this.views,
    required this.uploadedAt,
    required this.duration,
    required this.avatarText,
    required this.avatarBgColor,
    required this.thumbGradient,
    this.thumbHeadline = '',
    this.thumbSubheadline = '',
    this.imageAsset,
    this.topTag,
    this.isVerified = false,
    this.isSponsored = false,
  });
}

const List<VideoItem> dummyVideos = [
  VideoItem(
    title: 'Mulai dengan TikTok Ads hari ini & buka penawaran sambutan eksklusif Rp100 ...',
    channelName: 'TikTok',
    views: '',
    uploadedAt: '',
    duration: '0:07',
    avatarText: '♪',
    avatarBgColor: Colors.black,
    thumbGradient: [Color(0xFF9DF0EC), Color(0xFFB5F7F3)],
    imageAsset: 'assets/images/tiktok_ads.jpg',
    isSponsored: true,
  ),
  VideoItem(
    title:
        'SANTET DAN SIHIR TIDAK ADA? KISAH USTADZ JOJO DIKIRIM SANTET DARI ...',
    channelName: 'RJL 5 - Fajar Aditya',
    views: '138 rb',
    uploadedAt: '7 jam lalu',
    duration: '1.07.48',
    avatarText: 'RJL5',
    avatarBgColor: Color(0xFF1E293B),
    thumbGradient: [Color(0xFF3E140E), Color(0xFF8C2318)],
    imageAsset: 'assets/images/rjl5.jpg',
    isVerified: true,
  ),
  VideoItem(
    title: 'DARI MAHASISWA SAMPAI MENTERI, SEMUANYA PERNAH MAKAN DI SINI!!',
    channelName: 'Nex Carlos',
    views: '342 rb',
    uploadedAt: '9 jam lalu',
    duration: '11.33',
    avatarText: 'NC',
    avatarBgColor: Color(0xFFD97706),
    thumbGradient: [Color(0xFF78350F), Color(0xFFB45309)],
    imageAsset: 'assets/images/nex_carlos.jpg',
    isVerified: true,
  ),
  VideoItem(
    title: 'MISTERI RUMAH WINGIT PENJAGA WANGSIT DI TENGAH HUTAN',
    channelName: 'Kisah Tanah Jawa',
    views: '215 rb',
    uploadedAt: '1 hari lalu',
    duration: '34:12',
    avatarText: 'KTJ',
    avatarBgColor: Color(0xFF065F46),
    thumbGradient: [Color(0xFF0F172A), Color(0xFF1E3A2F)],
    imageAsset: 'assets/images/rumah_wingit.jpg',
    isVerified: true,
  ),
  VideoItem(
    title: 'PABRIK PALING HORROR DI JAWA - KESAKSIAN MANTAN PEKERJA',
    channelName: 'Lentera Malam',
    views: '510 rb',
    uploadedAt: '2 hari lalu',
    duration: '52:40',
    avatarText: 'LM',
    avatarBgColor: Color(0xFF991B1B),
    thumbGradient: [Color(0xFF450A0A), Color(0xFF7F1D1D)],
    imageAsset: 'assets/images/pabrik_horror.jpg',
    isVerified: true,
  ),
  VideoItem(
    title: 'BELAJAR FLUTTER DARI NOL SAMPAI BISA BIKIN CLONE YOUTUBE',
    channelName: 'Programmer Zaman Now',
    views: '189 rb',
    uploadedAt: '3 hari lalu',
    duration: '28:15',
    avatarText: 'PZN',
    avatarBgColor: Color(0xFF1D4ED8),
    thumbGradient: [Color(0xFF0C4A6E), Color(0xFF0284C7)],
    imageAsset: 'assets/images/coding_flutter.jpg',
    isVerified: true,
  ),
];

# YouTube Clone - Tugas UTS Mobile Programming

Aplikasi kloning antarmuka web/desktop **YouTube (Dark Mode)** yang dikembangkan menggunakan **Flutter**.

## Fitur Utama
1. **Logged-Out Landing Page:** Halaman awal Dark Mode menyerupai `youtube.com` dengan mini-sidebar, kotak pencarian interaktif, dan tombol login.
2. **Modal Login & Halaman Registrasi:** Validasi input email/nomor telepon, kata sandi minimal 6 karakter, fitur lihat/sembunyikan sandi, serta integrasi nama akun ke profil dashboard.
3. **Responsive Video Dashboard:** Tampilan grid video adaptif (1–3 kolom), filter chip kategori horizontal, pencarian judul/channel *real-time*, dan kartu iklan bersponsor.
4. **Halaman Pemutar Video (`WatchScreen`):** Halaman detail pemutar video 16:9 dengan tombol Like, Subscribe, serta daftar rekomendasi video di sisi kanan.

## Cara Menjalankan Proyek
```bash
flutter pub get
flutter run -d chrome
import 'package:flutter/material.dart';

class YouTubeRegisterScreen extends StatefulWidget {
  const YouTubeRegisterScreen({super.key});

  @override
  State<YouTubeRegisterScreen> createState() => _YouTubeRegisterScreenState();
}

class _YouTubeRegisterScreenState extends State<YouTubeRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _showPassword = false;

  InputDecoration _darkInputDecoration(String label, {String? suffixText}) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      suffixText: suffixText,
      suffixStyle: const TextStyle(color: Colors.white70, fontSize: 13),
      filled: true,
      fillColor: const Color(0xFF141414),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF3C3C3C)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF3EA6FF), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.redAccent, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF333333)),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo YouTube
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF0000),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'YouTube',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.8,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Buat Akun Google Anda',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Lanjutkan ke YouTube untuk membuat channel & berlangganan',
                    style: TextStyle(color: Colors.white70, fontSize: 13.5),
                  ),
                  const SizedBox(height: 24),

                  // Nama Depan & Nama Belakang
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _firstNameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: _darkInputDecoration('Nama depan'),
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Wajib diisi'
                              : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _lastNameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: _darkInputDecoration('Nama belakang'),
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Wajib diisi'
                              : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Nama Pengguna
                  TextFormField(
                    controller: _usernameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: _darkInputDecoration(
                      'Nama pengguna',
                      suffixText: '@gmail.com',
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'Masukkan nama pengguna';
                      }
                      if (v.trim().length < 4) {
                        return 'Minimal 4 karakter';
                      }
                      return null;
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 6, left: 4),
                    child: Text(
                      'Anda dapat menggunakan huruf, angka & titik',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Sandi & Konfirmasi
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _passwordController,
                          style: const TextStyle(color: Colors.white),
                          obscureText: !_showPassword,
                          decoration: _darkInputDecoration('Sandi'),
                          validator: (v) {
                            if (v == null || v.length < 6) {
                              return 'Min. 6 karakter';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          style: const TextStyle(color: Colors.white),
                          obscureText: !_showPassword,
                          decoration: _darkInputDecoration('Konfirmasi'),
                          validator: (v) {
                            if (v != _passwordController.text) {
                              return 'Sandi tidak cocok';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Checkbox Tampilkan Sandi
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: _showPassword,
                          activeColor: const Color(0xFF3EA6FF),
                          checkColor: Colors.black,
                          side: const BorderSide(color: Colors.grey),
                          onChanged: (val) {
                            setState(() => _showPassword = val ?? false);
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Tampilkan sandi',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Baris Tombol Login saja & Daftar & Masuk
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Login saja',
                          style: TextStyle(
                            color: Color(0xFF3EA6FF),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            final fullName =
                                '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}';
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/home',
                              (route) => false,
                              arguments: fullName,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3EA6FF),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Daftar & Masuk',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

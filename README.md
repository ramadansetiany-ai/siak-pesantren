# SIAK LMS - Sistem Informasi Administrasi Kelas Pesantren Terpadu

Aplikasi Sistem Informasi Administrasi Kelas (SIAK) & Learning Management System (LMS) berbasis web untuk Pondok Pesantren & Madrasah Diniyah Salaf Modern.

## 🚀 Fitur Utama
- **Autentikasi & Hak Akses Berbasis ID (RBAC)**:
  - **Staff / Admin**: Akses penuh mengelola santri, akun ustadz, dan nilai.
  - **Ustadz / Guru**: Akses menginput presensi dan melihatleger nilai kelas.
  - **Santri**: Akses melihat biodata, raport nilai, dan riwayat presensi.
- **Presensi Santri Terintegrasi**:
  - Presensi Harian santri per kelas.
  - Rekapitulasi Presensi Mingguan (Senin - Sabtu).
  - Rekapitulasi Presensi Bulanan (Akumulasi kehadiran & tingkat kedisiplinan).
- **Grafik Kehadiran Dinamis**: Visualisasi grafik Chart.js untuk Staff, Ustadz, dan Santri.
- **Integrasi WhatsApp Resmi**:
  - Share Rekap Presensi Harian, Mingguan, dan Bulanan ke WhatsApp (lengkap dengan nama santri hadir, sakit, izin, alfa, ustadz pengajar, dan jam mapel).
  - Share Raport Nilai Kitab Turats perorangan santri.
  - Share Rekap Leger Nilai kelas (Top 3 santri terbaik, % kelulusan).
- **Progressive Web App (PWA)**: Dapat diinstal langsung di smartphone / laptop.

## 🛠️ Tech Stack
- HTML5, CSS3, Tailwind CSS CDN
- Vanilla JavaScript (Tanpa build step rumit)
- Chart.js
- Font Awesome 6
- Siap deploy di Vercel

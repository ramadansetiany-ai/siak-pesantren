-- =========================================================================
-- SCHEMA DATABASE SUPABASE UNTUK SIAK LMS PESANTREN
-- MA'HAD ALY TAFAQQUH MADZHAB SYAFI'I ADZKIYA MANSYAUL HIKAM
-- =========================================================================
-- Cara Penggunaan:
-- 1. Masuk ke dashboard Supabase Anda (https://supabase.com)
-- 2. Pilih Project Anda -> Buka menu "SQL Editor" di bilah kiri
-- 3. Tempel (Paste) seluruh skrip ini, lalu klik tombol "RUN" (Jalankan)
-- =========================================================================

-- 1. TABEL KELAS & SANTRI (siak_classes)
CREATE TABLE IF NOT EXISTS public.siak_classes (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    wali TEXT DEFAULT 'Belum Ditentukan',
    santri JSONB DEFAULT '[]'::jsonb,
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. TABEL RIWAYAT PRESENSI HARIAN (siak_attendance)
CREATE TABLE IF NOT EXISTS public.siak_attendance (
    id TEXT PRIMARY KEY,
    class_id TEXT NOT NULL,
    tanggal TEXT NOT NULL,
    jam TEXT,
    mapel TEXT,
    ustadz TEXT,
    records JSONB DEFAULT '[]'::jsonb,
    summary JSONB DEFAULT '{}'::jsonb,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. TABEL JURNAL / BATAS PELAJARAN (siak_jurnal)
CREATE TABLE IF NOT EXISTS public.siak_jurnal (
    id TEXT PRIMARY KEY,
    tanggal TEXT NOT NULL,
    jam TEXT,
    kelas_id TEXT,
    ustadz TEXT,
    kitab TEXT,
    bab TEXT,
    batas TEXT,
    tugas TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. TABEL KITAB TURATS / KAJIAN (siak_kitab)
CREATE TABLE IF NOT EXISTS public.siak_kitab (
    id TEXT PRIMARY KEY,
    nama TEXT NOT NULL,
    pengarang TEXT,
    fan TEXT,
    kelas_id TEXT,
    pengampu TEXT,
    target TEXT,
    jadwal TEXT,
    selesai INT DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 5. TABEL MATA PELAJARAN KUSTOM (siak_mapel)
CREATE TABLE IF NOT EXISTS public.siak_mapel (
    id TEXT PRIMARY KEY,
    nama TEXT NOT NULL,
    kategori TEXT,
    kitab TEXT,
    pengampu TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 6. TABEL PENGGUNA & HAK AKSES (siak_accounts)
CREATE TABLE IF NOT EXISTS public.siak_accounts (
    id TEXT PRIMARY KEY,
    nama TEXT NOT NULL,
    role TEXT NOT NULL, -- 'staff', 'ustadz', 'santri'
    password TEXT NOT NULL,
    role_label TEXT,
    avatar TEXT,
    mapel TEXT,
    kelas_id TEXT,
    kelas_nama TEXT,
    nis TEXT,
    nip TEXT,
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- =========================================================================
-- AKTIFKAN AKSES PUBLIK (ROW LEVEL SECURITY POLICIES)
-- Agar aplikasi frontend dapat membaca dan menyimpan data secara langsung
-- =========================================================================

ALTER TABLE public.siak_classes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.siak_attendance ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.siak_jurnal ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.siak_kitab ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.siak_mapel ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.siak_accounts ENABLE ROW LEVEL SECURITY;

-- Izinkan Read & Write (Select, Insert, Update, Delete) untuk pengguna Anon
DO $$ 
BEGIN
    DROP POLICY IF EXISTS "Public Full Access siak_classes" ON public.siak_classes;
    DROP POLICY IF EXISTS "Public Full Access siak_attendance" ON public.siak_attendance;
    DROP POLICY IF EXISTS "Public Full Access siak_jurnal" ON public.siak_jurnal;
    DROP POLICY IF EXISTS "Public Full Access siak_kitab" ON public.siak_kitab;
    DROP POLICY IF EXISTS "Public Full Access siak_mapel" ON public.siak_mapel;
    DROP POLICY IF EXISTS "Public Full Access siak_accounts" ON public.siak_accounts;

    CREATE POLICY "Public Full Access siak_classes" ON public.siak_classes FOR ALL USING (true) WITH CHECK (true);
    CREATE POLICY "Public Full Access siak_attendance" ON public.siak_attendance FOR ALL USING (true) WITH CHECK (true);
    CREATE POLICY "Public Full Access siak_jurnal" ON public.siak_jurnal FOR ALL USING (true) WITH CHECK (true);
    CREATE POLICY "Public Full Access siak_kitab" ON public.siak_kitab FOR ALL USING (true) WITH CHECK (true);
    CREATE POLICY "Public Full Access siak_mapel" ON public.siak_mapel FOR ALL USING (true) WITH CHECK (true);
    CREATE POLICY "Public Full Access siak_accounts" ON public.siak_accounts FOR ALL USING (true) WITH CHECK (true);
END $$;

-- Masukkan akun default Editor jika belum ada
INSERT INTO public.siak_accounts (id, nama, role, password, role_label, avatar)
VALUES ('admin', 'Editor / Administrator', 'staff', 'admin123', 'Staff Administrasi', 'E')
ON CONFLICT (id) DO NOTHING;

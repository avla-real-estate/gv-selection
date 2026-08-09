# 🖼️ Görsel Havuzu — gv.selection

**Kural (2026-08-09):** Bu sayfada görseller **HTML'e base64 gömülmez**. Hepsi bu klasörde dosya olarak durur ve CDN'den servis edilir.

## Yapı
- `covers/` — proje kapak görselleri. Ad kalıbı: `<proje-slug>-<md5-8>.webp`
  Örn: `afea-residence-8f7dacfd.webp`

## Yeni proje eklerken
1. Kapak görselini **WebP**'ye çevir (kalite 82):
   `cwebp -q 82 kaynak.jpg -o img/covers/<proje-slug>-<hash>.webp`
   (hash = kaynak dosyanın md5'inin ilk 8 hanesi — içerik değişirse ad da değişir)
2. HTML'de **kök-göreli** referans ver — TR ve EN aynı dosyayı paylaşır:
   `<img class="cover-img" src="/img/covers/<ad>.webp" loading="lazy" decoding="async">`
3. Asla `data:image/...;base64` kullanma.

## Neden
- base64 önbelleğe alınamaz, paralel indirilemez, CDN optimizasyonunu devre dışı bırakır.
- 9 Ağustos 2026: 24 kapak çıkarıldı → HTML **3,45 MB → 275 KB (%92)**.
- `vercel.json` bu klasöre 1 yıllık `immutable` önbellek verir (ad hash'li olduğu için güvenli).

## Kaynak stok
Orijinal yüksek çözünürlüklü görseller: Google Drive `EMLAK/ATİNA/Portfolio/A0NNN_.../`
Bu klasör **yayın kopyasıdır**, arşiv değildir.

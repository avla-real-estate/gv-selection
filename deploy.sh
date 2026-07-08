#!/bin/bash
# gv.selection deploy — sayıları senkronla + OG kapağı üret + deploy + alias
# Kullanım: ./deploy.sh    (Melis_Deploy içinden)
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
TOOLS="$DIR/../OG-Kapak-Uretici"
echo "▶ Sayı + kapak senkronu (TR)…"; python3 "$TOOLS/sync_secki.py" "$DIR/index.html"
echo "▶ Sayı + kapak senkronu (EN)…"; python3 "$TOOLS/sync_secki.py" "$DIR/en/index.html" en
git -C "$DIR" config user.email "saka1966@gmail.com"; git -C "$DIR" config user.name "M. Sami Akbeniz"
git -C "$DIR" add -A && git -C "$DIR" commit -q -m "OG kapak + sayı senkronu (otomatik deploy.sh)" || echo "  (commit yok)"
cd "$DIR"
echo "▶ Vercel deploy…"
D=$(vercel --prod --yes --archive=tgz 2>&1 | grep -oE 'https://avla-gv-selection-[a-z0-9]+-saka1966-9445s-projects\.vercel\.app' | tail -1)
vercel alias set "$D" gv.selection.avlarealestate.com
echo "✓ Tamam: https://gv.selection.avlarealestate.com"


# Lab 5: convert staff-broken.csv from RK1048 (KZ-1048) to UTF-8
set -e

in=evidence/staff-broken.csv
out=evidence/staff-fixed.csv

# 1. encoding: KZ-1048 (iconv name RK1048) -> UTF-8
iconv -f RK1048 -t UTF-8 "$in" > "$out"

# 2. line endings: source is CRLF, I keep CRLF (Excel/Windows users), so no change here.
#    To get LF instead:  sed -i 's/\r$//' "$out"

# 3. BOM: add the UTF-8 BOM (EF BB BF) so Excel recognises UTF-8 on double-click
printf '\357\273\277' | cat - "$out" > "$out.tmp" && mv "$out.tmp" "$out"

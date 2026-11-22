# Lab 5 — Encoding forensics

Name: Mikhail Martsinovskiy 
Date: 22.11.2026
Tools: Ubuntu guest / Git Bash / macOS / PowerShell
# What I Received

**Excel (opening `staff-broken.csv` by double-clicking):** `Јбдірахманова`, `Ќасымов`.

**LibreOffice Calc:** The import window selected Cyrillic (Windows-1251) as the default encoding. Russian names appeared correctly, but Kazakh characters were displayed incorrectly. For example, `Әбдірахманова` appeared as `Јбдірахманова`, and `Қасымов` appeared as `Ќасымов`.

**Terminal (`cat`):** \<TODO: one line describing what appeared in Git Bash>

```text
ID;▒▒;▒▒;;▒▒; 101;;;▒▒;▒▒ ;▒▒
```

I did not save or modify the file in any of these applications.

# Diagnosis (Made Before the Fix)

**File command output:** `Non-ISO extended-ASCII text, with CRLF line terminators` (`evidence/file-before.txt`). This indicates that each character uses one byte, meaning the file uses a legacy code page. However, `file` cannot identify the exact encoding.

**First 16 bytes:**

```text
49 44 3b d4 e0 ec e8 eb e8 ff 3b c8 ec ff 3b ce
```

These bytes are recorded in `evidence/hexdump-before.txt`.

**Encoding:** KZ-1048 (known as `RK1048` in `iconv`). This is confirmed by the fact that Cyrillic characters are represented by individual bytes in the range `C0–FF`. For example, in the header word "Фамилия", the letter "Ф" is represented by `D4`, "а" by `E0`, and "я" by `FF`.

There are no `D0/D1` byte pairs, which rules out UTF-8, and no `xx 04` pairs, which rules out UTF-16 LE.

The encoding is KZ-1048 rather than standard Windows-1251 because the file contains Kazakh characters. The surname in row 101 begins with byte `A3`. In KZ-1048, this represents "Ә", while in Windows-1251 it appears as "Ј".

I tested both encodings using `iconv`:

- Windows-1251 produced `Јбдірахманова`, `Ќасымов`, `Жўмабаев`.
- RK1048 correctly displayed `Әбдірахманова`, `Қасымов`, `Жұмабаев`, as well as all Russian names.

The bytes that differ between these two code pages in this file are `8D 9D A2 A3 A5 AF B4 BA BC BF`.

**Line ending:** CRLF. This is confirmed by the `0D 0A` bytes at the end of the first line, immediately after "Город" (`c3 ee f0 ee e4`). The `file` command also reports CRLF line terminators.

**BOM:** No. The file begins with `49 44` ("ID") instead of any BOM signature (`EF BB BF`, `FF FE` or `FE FF`).

**Separator:** Semicolon (`;`). The header is:

```text
ID;Фамилия;Имя;Отдел;Должность;Город
```

# Decisions for the Fixed File

**BOM:** I decided to add a UTF-8 BOM (`EF BB BF`). According to the lab requirements, the file must work correctly in all applications, including Excel when opened by double-clicking. Excel on Windows recognises UTF-8 CSV files when they contain a BOM at the beginning. Without it, Excel may use the local code page, causing Russian and Kazakh characters to display incorrectly.

One disadvantage is that scripts reading the first column name may interpret it as `﻿ID` rather than `ID`.

**Line ending:** I kept CRLF. The original file already used this format, and the CSV is intended for Excel and Windows users. Since the lab does not require LF, changing the line endings was unnecessary.

A possible disadvantage is that Linux scripts may encounter a trailing `\r` in the last column. This can be removed when necessary using `sed -i 's/\r$//'`.

# Fix

The conversion is performed using `scripts/fix.sh`, executed from `labs/lab05-encoding/` with `sh scripts/fix.sh`.

```bash
#!/bin/sh

# Lab 5: convert staff-broken.csv from RK1048 (KZ-1048) to UTF-8

set -e

in=evidence/staff-broken.csv
out=evidence/staff-fixed.csv

# 1. Convert the encoding: KZ-1048 (iconv name RK1048) -> UTF-8
iconv -f RK1048 -t UTF-8 "$in" > "$out"

# 2. Line endings: the source uses CRLF, which is preserved without changes.
# To convert to LF instead: sed -i 's/\r$//' "$out"

# 3. Add the UTF-8 BOM (EF BB BF) for Excel compatibility when double-clicking.
printf '\357\273\277' | cat - "$out" > "$out.tmp" && mv "$out.tmp" "$out"
```

The original `evidence/staff-broken.csv` remained unchanged. The corrected file was generated using this script rather than by saving it from Excel.

# Verification

**`evidence/file-after.txt`:** The output identifies the corrected file as `UTF-8 (with BOM) text, with CRLF line terminators`.

The first bytes are `ef bb bf 49 44` ("ID"), and Cyrillic characters are now represented by `D0 xx` / `D1 xx` byte pairs.

**`evidence/opens-correctly.png`:** This screenshot shows `staff-fixed.csv` opened in all three applications:

- Excel.
- LibreOffice Calc (Character set: UTF-8, separator: `;`).
- Linux terminal using `cat`.

Names including `Әбдірахманова`, `Қасымов`, `Нұрлан`, `Жұмабаев` and `Ерғали` are displayed correctly in all three applications.

# What Did Not Work the First Time

Initially, LibreOffice opened `staff-broken.csv` using Windows-1251 as the default encoding. The result looked almost correct because Russian names were readable, but Kazakh characters were displayed incorrectly (`Јбдірахманова`, `Ќасымов`).

Since Windows-1251 does not support Kazakh letters, I needed to examine the bytes representing those characters (`A3`, `8D`, `A2`, etc.), compare them with the KZ-1048 encoding table, and use `iconv -f RK1048` for correct decoding.

I also had some difficulty opening the table in Git Bash because I did not immediately understand how to do it.
#!/usr/bin/env bash
# 產生 Packages 索引檔
dpkg-scanpackages --multiversion debs /dev/null > Packages

# 壓縮索引檔（APT 優先讀取壓縮檔）
gzip -k -f Packages

# 生成簡單的 Release 檔案
apt-ftparchive release . > Release

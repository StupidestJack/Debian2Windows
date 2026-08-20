# Linux2WindowsDebianRepo
在Linux修復之際，我們需要一個deb倉庫

## 相關指令教學
control文件格式：
```txt
Package: 套件名
Version: 版本（若無則填入1.0-1）
Section: utils
Priority: optional
Architecture: amd64
Maintainer: 人 <信箱>
Description: 修复 Linux 没有 ______ 的 Bug
```

封裝deb文件：
```sh
dpkg-deb --build package_1.0-1_amd64
```

產生索引
```sh
# 產生 Packages 索引檔
dpkg-scanpackages --multiversion debs /dev/null > Packages

# 壓縮索引檔（APT 優先讀取壓縮檔）
gzip -k -f Packages
```

## 貢獻
非常歡迎任何人form並提交PR，每一條PR我都會看的。

牆裂建議使用GPG金鑰對自己的commit簽名，以免PR被關閉（doge

## 特別感謝
項目開發者：
 * [@LyCecilion](https://github.com/LyCecilion)
 * [@ChenPi11](https://github.com/ChenPi11)

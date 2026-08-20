# Debian2WindowsRepo
在Linux修復之際，我們需要一個deb倉庫

## 食用方法

將本倉庫加入您的 APT 源：
```bash
echo "deb [trusted=yes] https://stupidestjack.github.io/Debian2WindowsRepo/ /" | sudo tee /etc/apt/sources.list.d/linux2windows.list
sudo apt update
```

## 貢獻教學
建立deb文件需要一個名為`套件_版本_架構`的目錄，如`package_1.0-1_amd64`。

本倉庫只有amd64架構，因為我不想編譯，除非有人想幫我編譯其他架構（doge

目錄架構：
```txt
package_1.0-1_amd64
├── DEBIAN
│   └── control
└── 根目錄下的任何文件
```
以cmd舉例：
```txt
cmd_0.1-1_amd64
├── DEBIAN
│   └── control
└── usr
    └── bin
        ├── cmd.exe
        └── COMMAND.COM
```


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

請記得確保文件是755：
```sh
chmod 755 usr/bin/*
```

封裝deb文件：
```sh
dpkg-deb --build package_1.0-1_amd64
```

產生索引：
```sh
# 產生 Packages 索引檔
dpkg-scanpackages --multiversion debs /dev/null > Packages

# 壓縮索引檔（APT 優先讀取壓縮檔）
gzip -k -f Packages

# 生成簡單的 Release 檔案
apt-ftparchive release . > Release
```

## 貢獻
非常歡迎任何人fork並提交PR，每一條PR我都會看的。

牆裂建議使用GPG金鑰對自己的commit簽名，以免PR被關閉（doge

## 特別感謝
項目開發者：
 * [@LyCecilion](https://github.com/LyCecilion)
 * [@ChenPi11](https://github.com/ChenPi11)
 * [@heyManNice](https://github.com/heyManNice)
 * [@HelloAIXIAOJI](https://github.com/HelloAIXIAOJI)

倉庫維護者：
 * [@FreshingAir](https://github.com/FreshingAir)

最後感謝我們的教學者Gemini，整個文件幾乎都它寫的

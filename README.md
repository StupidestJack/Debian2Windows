# Debian2WindowsRepo
在Linux修復之際，我們需要一個deb倉庫

## 食用方法

將本倉庫加入您的 APT 源：
```bash
echo "deb [trusted=yes] https://stupidestjack.github.io/Debian2WindowsRepo/ /" | sudo tee /etc/apt/sources.list.d/linux2windows.list
sudo apt update
```

## 倉庫內的套件
按照A-Z字母排列。

 * [bsod](https://github.com/heyManNice/bsod)：修复 Linux 没有 bsod 的 Bug
 * [cmd](https://github.com/ChenPi11/cmd)：修复 Linux 没有 cmd 的 Bug
 * [libschrodinger](https://github.com/LyCecilion/libschrodinger)：修复 Linux 没有「应用程序错误」窗口的 Bug
 * [mkwin](https://github.com/macOS-Terminal/mkwin)：從原始碼構建赤石科技的包管理器
 * [windowshit](https://github.com/HelloAIXIAOJI/windowshit)：修复 Linux 没有 24 種命令的 Bug
   * ws-choice：修复 Linux 没有「ws-choice」命令的 Bug
   * ws-clip：修复 Linux 没有「ws-clip」命令的 Bug
   * ws-control：修复 Linux 没有「ws-control」命令的 Bug
   * ws-control.template：修复 Linux 没有「ws-control.template」命令的 Bug
   * ws-expand：修复 Linux 没有「ws-expand」命令的 Bug
   * ws-fc：修复 Linux 没有「ws-fc」命令的 Bug
   * ws-findstr：修复 Linux 没有「ws-findstr」命令的 Bug
   * ws-getmac：修复 Linux 没有「ws-getmac」命令的 Bug
   * ws-hostname-win：修复 Linux 没有「ws-hostname-win」命令的 Bug
   * ws-ipconfig：修复 Linux 没有「ws-ipconfig」命令的 Bug
   * ws-makecab：修复 Linux 没有「ws-makecab」命令的 Bug
   * ws-more-win：修复 Linux 没有「ws-more-win」命令的 Bug
   * ws-pathping：修复 Linux 没有「ws-pathping」命令的 Bug
   * ws-ping-win：修复 Linux 没有「ws-ping-win」命令的 Bug
   * ws-replace：修复 Linux 没有「ws-replace」命令的 Bug
   * ws-robocopy：修复 Linux 没有「ws-robocopy」命令的 Bug
   * ws-shutdown：修复 Linux 没有「ws-shutdown」命令的 Bug
   * ws-sort-win：修复 Linux 没有「ws-sort-win」命令的 Bug
   * ws-systeminfo：修复 Linux 没有「ws-systeminfo」命令的 Bug
   * ws-taskkill：修复 Linux 没有「ws-taskkill」命令的 Bug
   * ws-tasklist：修复 Linux 没有「ws-tasklist」命令的 Bug
   * ws-tracert：修复 Linux 没有「ws-tracert」命令的 Bug
   * ws-tree-win：修复 Linux 没有「ws-tree-win」命令的 Bug
   * ws-type-win：修复 Linux 没有「ws-type-win」命令的 Bug
   * ws-ver：修复 Linux 没有「ws-ver」命令的 Bug
   * ws-where-win：修复 Linux 没有「ws-where-win」命令的 Bug
   * ws-whoami-win：修复 Linux 没有「ws-whoami-win」命令的 Bug

## 貢獻指南
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
Maintainer: 維護者 <信箱>
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
 * [@macOS-Terminal](github.com/macOS-Terminal)

倉庫維護者：
 * [@FreshingAir](https://github.com/FreshingAir)

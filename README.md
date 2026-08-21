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

 * [activate-linux](https://github.com/MrGlockenspiel/activate-linux)：修复 Linux 没有激活水印的 Bug
 * [autofix](https://github.com/xusk1234/Linux-Auto-Fix/)：修复 Linux 没有自動修復的 Bug
 * [bsod](https://github.com/heyManNice/bsod)：修复 Linux 没有 bsod 的 Bug
 * [cmd](https://github.com/ChenPi11/cmd)：修复 Linux 没有 cmd 的 Bug
 * [libschrodinger](https://github.com/LyCecilion/libschrodinger)：修复 Linux 没有「应用程序错误」窗口的 Bug
 * [mkwin](https://github.com/macOS-Terminal/mkwin)：從原始碼構建赤石科技的包管理器
 * [regedit](https://github.com/heyManNice/regedit)：修复 Linux 没有注册表编辑器的 Bug 
 * [services](https://github.com/StupidestJack/ServiceForLinux/)：修复 Linux 没有 Service 的 Bug
 * [winver](https://github.com/DeepslateQAQ/linux-winver)：修复 Linux 没有 winver Bug
 * [windowshit](https://github.com/HelloAIXIAOJI/windowshit)：修复 Linux 没有 24 種命令的 Bug
   * ws-choice：修复 Linux 没有「choice」命令的 Bug
   * ws-clip：修复 Linux 没有「clip」命令的 Bug
   * ws-expand：修复 Linux 没有「expand」命令的 Bug
   * ws-fc：修复 Linux 没有「fc」命令的 Bug
   * ws-findstr：修复 Linux 没有「findstr」命令的 Bug
   * ws-getmac：修复 Linux 没有「getmac」命令的 Bug
   * ws-hostname-win：修复 Linux 没有「hostname」命令的 Bug（需輸入`hostname-win`）
   * ws-ipconfig：修复 Linux 没有「ipconfig」命令的 Bug
   * ws-makecab：修复 Linux 没有「makecab」命令的 Bug
   * ws-more-win：修复 Linux 没有「more」命令的 Bug（需輸入`more-win`）
   * ws-pathping：修复 Linux 没有「pathping」命令的 Bug
   * ws-ping-win：修复 Linux 没有「ping」命令的 Bug（需輸入`ping-win`）
   * ws-replace：修复 Linux 没有「replace」命令的 Bug
   * ws-robocopy：修复 Linux 没有「robocopy」命令的 Bug
   * ws-shutdown：修复 Linux 没有「shutdown」命令的 Bug
   * ws-sort-win：修复 Linux 没有「sort」命令的 Bug（需輸入`sort-win`）
   * ws-systeminfo：修复 Linux 没有「systeminfo」命令的 Bug
   * ws-taskkill：修复 Linux 没有「taskkill」命令的 Bug
   * ws-tasklist：修复 Linux 没有「tasklist」命令的 Bug
   * ws-tracert：修复 Linux 没有「tracert」命令的 Bug
   * ws-tree-win：修复 Linux 没有「tree」命令的 Bug（需輸入`tree-win`）
   * ws-type-win：修复 Linux 没有「type」命令的 Bug（需輸入`type-win`）
   * ws-ver：修复 Linux 没有「ver」命令的 Bug
   * ws-where-win：修复 Linux 没有「where」命令的 Bug（需輸入`where-win`）
   * ws-whoami-win：修复 Linux 没有「whoami」命令的 Bug（需輸入`whoami-win`）

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
```toml
Package: 套件名
Version: 版本（若無則填入1.0-1）
Section: utils
Priority: optional
Architecture: amd64
Maintainer: 維護者 <信箱>
Description: 修复 Linux 没有 ______ 的 Bug
```
Maintainer 建議使用維護者，以符合 `deb` 包的規範。

請記得確保文件是755：
```sh
chmod 755 usr/bin/*
```

針對桌面應用程式，請建立desktop文件並放在套件目錄/usr/share/applications/下：
```toml
[Desktop Entry]
Version=1.0
Type=Application
Name=套件名
Comment=套件名 for Linux
Exec=軟體位置 %f
Icon=/usr/share/pixmaps/套件圖示.png
Terminal=false
Categories=Utility;
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

此外也歡迎項目開發者親自維護親自拉石，以確保Linux赤石科技生態穩定（doge

## 特別感謝
項目開發者：
 * [@LyCecilion](https://github.com/LyCecilion)
 * [@ChenPi11](https://github.com/ChenPi11)
 * [@heyManNice](https://github.com/heyManNice)
 * [@HelloAIXIAOJI](https://github.com/HelloAIXIAOJI)
 * [@macOS-Terminal](https://github.com/macOS-Terminal)
 * [@MrGlockenspiel](https://github.com/MrGlockenspiel)
 * [@xusk1234](https://github.com/xusk1234)
 * [@StupidestJack](https://github.com/StupidestJack)

倉庫維護者：
 * [@FreshingAir](https://github.com/FreshingAir)

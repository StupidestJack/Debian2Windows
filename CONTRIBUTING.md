# 貢獻指南

感謝你願意為 **Debian2WindowsRepo** 貢獻！

本專案歡迎新增套件、更新既有套件，以及為其他 CPU 架構提供支援。

不過，在提交 PR 之前，請先閱讀以下規範。

## 開始之前

請確認你已經：

- Fork 本專案。
- 建立自己的工作分支。
- 確認要加入的套件來源可靠。
- 確認套件可以正常在 Debian 系統上安裝與執行。
- 確認套件沒有包含不必要的惡意程式或破壞性操作。

> 本倉庫中的套件會直接被使用者透過 `apt` 安裝，因此請務必仔細檢查套件內容。

## 建立 `.deb` 套件

建立 `.deb` 套件時，需要先建立一個符合以下格式的目錄：

```text
套件名_版本_架構
```

例如：

```text
package_1.0-1_amd64
```

基本目錄結構如下：

```text
package_1.0-1_amd64/
├── DEBIAN/
│   └── control
└── usr/
    └── ...
```

`DEBIAN` 目錄中的檔案是套件的控制資訊，其餘內容則會按照目錄結構安裝到使用者的系統中。

### 以 `cmd` 為例

```text
cmd_0.1-1_amd64/
├── DEBIAN/
│   └── control
└── usr/
    └── bin/
        ├── cmd.exe
        └── COMMAND.COM
```

安裝後，`usr/bin` 中的檔案會對應到系統中的 `/usr/bin`。

## `control` 檔案

每個 `.deb` 套件都需要一個：

```text
DEBIAN/control
```

例如：

```text
Package: cmd
Version: 0.1-1
Section: utils
Priority: optional
Architecture: amd64
Maintainer: 維護者 <email@example.com>
Description: 修復 Linux 沒有 cmd 的 Bug
```

### 欄位說明

| 欄位 | 說明 |
| --- | --- |
| `Package` | 套件名稱 |
| `Version` | 套件版本；如果沒有特別的版本號，可以使用 `1.0-1` |
| `Section` | 套件分類，通常使用 `utils` |
| `Priority` | 套件優先級，通常使用 `optional` |
| `Architecture` | 套件架構，目前倉庫使用 `amd64` |
| `Maintainer` | 維護者名稱及電子郵件 |
| `Description` | 套件簡短說明 |

`Maintainer` 建議填寫實際維護者，以符合 Debian `.deb` 套件的基本規範。

## 檔案權限

需要作為程式執行的檔案應具有適當的執行權限。

例如：

```sh
chmod 755 usr/bin/*
```

如果套件包含其他可執行檔，也請確認其權限正確。

不要為不需要執行權限的檔案盲目設定 `755`。

## 桌面應用程式

如果你新增的是桌面應用程式，請建立 `.desktop` 文件並放置於：

```text
/usr/share/applications/
```

例如：

```text
package_1.0-1_amd64/
├── DEBIAN/
│   └── control
├── usr/
│   ├── bin/
│   │   └── package
│   └── share/
│       ├── applications/
│       │   └── package.desktop
│       └── pixmaps/
│           └── package.png
```

`.desktop` 文件可以參考：

```ini
[Desktop Entry]
Version=1.0
Type=Application
Name=套件名
Comment=套件名 for Linux
Exec=/usr/bin/軟體位置 %f
Icon=/usr/share/pixmaps/套件圖示.png
Terminal=false
Categories=Utility;
```

請根據實際程式修改 `Name`、`Comment`、`Exec` 和 `Icon`。

## 建置套件

完成目錄結構後，可以使用：

```sh
dpkg-deb --build package_1.0-1_amd64
```

成功後會產生：

```text
package_1.0-1_amd64.deb
```

建議在提交 PR 前，先在乾淨的 Debian 環境中測試：

```sh
sudo apt install ./package_1.0-1_amd64.deb
```

並確認：

- 套件可以正常安裝。
- 所有檔案都安裝到正確位置。
- 可執行檔具有正確權限。
- 程式可以正常執行。
- 桌面應用程式可以正常出現在應用程式選單中。
- 卸載套件後不會留下不必要的檔案。

## APT 索引與簽署

**不需要手動產生 APT 索引。**

本倉庫的套件索引產生及簽署工作會由 GitHub Actions 自動完成。

因此，完成 `.deb` 後：

1. 將套件相關檔案加入 Git。
2. 提交 Commit。
3. Push 到你的 Fork。
4. 建立 Pull Request。

剩下的倉庫索引及簽署流程會由自動化工作處理。

## 提交 Pull Request

提交 PR 前，請確認：

- [ ] 套件名稱及版本正確。
- [ ] `DEBIAN/control` 存在且格式正確。
- [ ] 套件架構填寫正確。
- [ ] 可執行檔具有正確權限。
- [ ] 已經實際測試套件。
- [ ] 沒有提交不必要的暫存檔。
- [ ] 沒有提交私人金鑰、密碼或其他敏感資訊。
- [ ] 已檢查套件內所有檔案的內容。
- [ ] PR 說明中清楚描述了新增或修改的內容。

## GPG 簽署 Commit

**強烈建議使用 GPG 金鑰簽署你的 Commit。**

這不是強制要求，但可以幫助確認 Commit 的作者身分。

例如：

```sh
git commit -S -m "Add package-name"
```

然後確認 Commit：

```sh
git log --show-signature -1
```

請自行按照 GitHub 的 GPG 簽署文件完成金鑰設定。

## 其他 CPU 架構

目前本倉庫只提供：

```text
amd64
```

如果你願意協助提供其他架構的套件，例如 ARM64，可以提交對應架構的套件。

請確保：

- 套件確實可以在該架構上執行。
- `Architecture` 欄位正確。
- 套件沒有偷偷依賴 AMD64 特有功能。
- 已在對應架構的系統上完成測試。

## 維護現有套件

如果你是某個上游專案的開發者，非常歡迎你親自維護自己專案對應的套件。

如果上游專案發佈新版本，可以提交 PR 更新：

- 套件版本。
- `.deb` 檔案。
- `control` 中的版本號。
- 必要的依賴。
- Desktop Entry 或其他相關檔案。

如果套件內容發生重大變化，請在 PR 中說明變更原因。

## 安全性

請特別注意：

> **這是一個可以直接被 APT 使用的第三方套件倉庫。**

一旦套件被使用者安裝，其中的程式就可能以使用者權限甚至系統管理員權限執行。

因此，提交套件前請仔細檢查：

- 安裝腳本。
- 可執行檔。
- 第三方依賴。
- 網路下載行為。
- 權限需求。
- `postinst`、`preinst`、`prerm`、`postrm` 等維護腳本。

不要提交你自己都不知道在做什麼的二進位檔。

## 最後

歡迎任何人 Fork、修改並提交 PR。

無論是新增 Windows 命令、桌面工具，還是把其他 Windows「特色」帶到 Linux，我們都非常歡迎。

當然，如果你只是想讓 Linux 更像 Windows……

**那你來對地方了。**

# 貢獻指南（Contribution Guide）

感謝你願意為 **Debian2WindowsRepo** 貢獻！  
本專案收錄各種「把 Windows 體驗帶到 Linux」的第三方 Debian 套件，所有套件皆以 `.deb` 形式提供，並經由 APT 倉庫發佈。

為了確保倉庫的安全性、合法性與可維護性，請務必依循以下 **5 個步驟** 完成你的貢獻。

---

## 步驟 1：確認來源可靠

由於本倉庫的套件會以 `root` 權限安裝至使用者系統，**安全性與版權**是最優先考量。

### 🔒 安全性檢查
- 確認上游原始碼或二進位檔來自**可信賴的來源**（如官方 GitHub 發佈頁、作者官網）。
- 檢查所有可執行檔、二進位檔及維護腳本（`preinst`、`postinst`、`prerm`、`postrm`），確保**無惡意程式、後門、破壞性行為或未經許可的網路連線**。
- 若有編譯過程，建議檢視編譯腳本（Makefile、CMake 等）避免注入危險指令。

### 📄 授權確認
- 確認上游專案的開源授權條款（如 MIT、BSD、GPL-3.0、Apache-2.0 等）。
- **請勿自行臆測授權**——「免費下載」或「可執行」不等同於「開源」或「可再散佈」。
- 若上游未明確標示授權，**請先聯繫作者取得許可**，否則不得收錄。

---

## 步驟 2：封裝 deb 文件

### 2.1 命名與目錄結構規範

- **套件名稱必須全部小寫**（符合 Debian 政策），僅允許使用小寫字母、數字及 `+`、`-`、`.` 符號。
- 目錄名稱格式：`套件名_版本_架構`（例如 `cmd_0.1-1_amd64`）。
- 標準目錄結構範例（以 `package` 為例）：

```
package_1.0-1_amd64/
├── DEBIAN/
│   └── control
└── usr/
    ├── bin/
    │   └── package
    └── share/
        ├── applications/
        │   └── package.desktop
        └── pixmaps/
            └── package.png
```

> 若套件包含 systemd 服務，請置於 `lib/systemd/system/` 等標準路徑。

---

### 2.2 專案適當拆分與虛擬中繼套件（Meta Package）

當**一個上游專案內含多個獨立可執行軟體**（例如提供多個命令列工具），應**拆分為多個獨立 deb 套件**，讓使用者按需安裝，避免不必要的依賴。

同時，**必須建立一個以該專案名稱命名的「虛擬中繼套件」（Meta Package）**，其 `Depends` 欄位列出所有子套件，以便使用者一次安裝「全家桶」。

#### 範例：專案 `windowshit` 包含 24 個命令
- 實際套件：`ws-choice`、`ws-clip`、…、`ws-whoami-win`（各為獨立 `.deb`）
- 虛擬中繼套件：`windowshit`（僅包含 `DEBIAN/control`，無實際檔案）
  - `Depends: ws-choice, ws-clip, ...`（列出全部子套件）

這樣使用者可執行：
```bash
sudo apt install windowshit   # 安裝全部
sudo apt install ws-choice    # 只安裝單一工具
```

---

### 2.3 編寫 `DEBIAN/control` 檔案

`control` 檔案定義套件的中繼資料與依賴關係，**務必正確填寫**。

#### 基本範例
```text
Package: cmd
Version: 0.1-1
Section: utils
Priority: optional
Architecture: amd64
Maintainer: 維護者 <email@example.com>
Depends: libc6 (>= 2.31), python3
Recommends: bash-completion
Suggests: wine
Description: 修復 Linux 沒有 cmd 的 Bug
 這裡可以放詳細的多行描述（每行開頭空一格）。
```

#### 欄位說明與依賴項解析

| 欄位 | 必填 | 說明 |
|------|------|------|
| `Package` | ✅ | **套件名稱（必須全小寫）**，與目錄名稱一致 |
| `Version` | ✅ | 版本號，格式建議 `上游版本號-修訂號`（例如 `1.2.3-1`） |
| `Architecture` | ✅ | 架構：`amd64`、`arm64`、`all`（若為架構無關腳本） |
| `Maintainer` | ✅ | 維護者名稱與電郵，格式 `Name <email>` |
| `Description` | ✅ | 第一行為簡短概述，後續每行以一個空格開頭為詳細說明 |
| `Depends` | ❌ | **絕對依賴**：套件正常運作**不可或缺**的軟體。APT 會強制安裝，若無法滿足則安裝失敗。可指定版本（如 `>= 1.0`），多個用逗號分隔 |
| `Recommends` | ❌ | **推薦依賴**：大多數使用者會需要的輔助功能。APT 預設會自動安裝（使用者可停用） |
| `Suggests` | ❌ | **建議依賴**：增強功能或相關但非必要的套件，APT 不會自動安裝 |
| `Section` | ❌ | 分類，通常填 `utils`、`admin`、`x11` 等 |
| `Priority` | ❌ | 優先級，通常填 `optional` |

> **注意**：若你的套件依賴其他本倉庫的套件，請務必在 `Depends` 中明確標示，以確保安裝順序正確。

---

### 2.4 設定權限與建置

- 設定可執行檔權限（例如 `usr/bin/*`）：
  ```bash
  chmod 755 usr/bin/*
  ```
- 若有桌面檔案（`.desktop`），無需特別設定權限（一般為 644）。
- 使用 `dpkg-deb` 打包：
  ```bash
  dpkg-deb --build package_1.0-1_amd64
  ```
  產生的 `.deb` 檔案即為最終套件。

---

## 步驟 3：測試要求

**提交前，請務必在乾淨的 Debian / Ubuntu 環境中（建議使用 Docker 或虛擬機）進行完整測試。**

### 安裝測試
```bash
sudo apt install ./package_1.0-1_amd64.deb
```

### 驗證項目
- ✅ 依賴套件是否被正確解析與安裝（檢查 `apt-cache show package`）。
- ✅ 可執行檔權限正確（`ls -l /usr/bin/package`）且能正常執行。
- ✅ 若為桌面應用，`.desktop` 檔案能正常顯示在應用程式選單，且圖示正確。
- ✅ 若有服務（systemd），確認服務能正常啟動（`systemctl status service`）。
- ✅ 檢查日誌有無錯誤（`journalctl -xe`）。

### 解除安裝測試
```bash
sudo apt remove package
```
- 確認卸載後**不會留下未預期的垃圾檔案**（檢查 `/etc`、`/var` 等殘留設定檔）。
- 建議使用 `dpkg -L package` 列出所有安裝檔案，移除後再次檢查。

---

## 步驟 4：加入 LICENSES 資料夾

**每個新增或更新的套件，都必須在倉庫根目錄的 `LICENSES/` 資料夾中加入授權說明檔案。**

### 命名格式
`組件名稱_授權模式`（組件名稱請維持小寫，與套件名稱一致）  
例如：
- `LICENSES/cmd_MIT`
- `LICENSES/package_GPL-3.0`
- 若多重授權：`LICENSES/package_MIT_GPL-3.0`

### 檔案內容範例
```text
Component: cmd
License: MIT
Copyright: Copyright (c) 2026 Example Author
Source: https://example.com/project
```
- 若上游有完整的 `LICENSE` 檔案（內含條款全文），可直接複製貼入該檔案，或明確標註來源連結。
- 請確保所填授權與上游聲明完全一致。

---

## 步驟 5：提交

### 5.1 Commit 與 Push
- 將你的修改（包含 `DEBIAN/control`、實際檔案、`.deb`、`LICENSES/` 等）提交至你的 Fork 儲存庫。
- **強烈建議使用 `git commit -S` 進行 GPG 簽署**，以便驗證身份。
- 提交訊息請清楚說明新增或更新的套件名稱與變更內容。

### 5.2 更新 `README.md`
在發起 Pull Request 前，**請務必同步更新倉庫根目錄的 `README.md`**，並維護以下三個表格：

#### 📦 倉庫內的套件
在「倉庫內的套件」表格中新增或修改你的套件列，格式為：
| 套件 | 專案 | 說明 |
|------|------|------|
| `你的套件名` | [作者/專案連結](URL) | 簡短描述 |

若你的專案拆分成多個子套件，請在主套件列下方補充子套件清單（可參考 `windowshit` 或 `elevende` 的呈現方式）。

#### 👨‍💻 專案開發者
在「專案開發者」區塊，**若上游作者未列出**，請新增其 GitHub 帳號（或名稱）與連結。  
若你本身就是作者，請務必將自己加入。

#### 🛠️ 倉庫維護者
在「倉庫維護者」區塊，若你是首次貢獻並願意協助維護，請將自己加入（可與現有維護者協商）。

> 以上更新確保使用者與貢獻者能清楚辨識套件來源與責任歸屬。

### 5.3 發起 Pull Request (PR)
- 前往原始倉庫（`StupidestJack/Debian2WindowsRepo`）發起 PR。
- 在 PR 描述中詳述：
  - 新增或更新的套件名稱與版本。
  - 上游專案連結與授權說明。
  - 測試結果摘要（確認通過步驟 3）。
  - 是否已更新 `README.md` 及 `LICENSES/`。

### 5.4 CI/CD 建置注意事項
- 本倉庫的 APT 索引簽署依賴維護者的 GPG 私鑰（環境變數 `GPG_KEY` 等）。
- 當你從 **自己的 Fork** 觸發 CI/CD 或提交 PR 時，**因缺少私鑰環境變數而導致的 GitHub Actions 建置失敗屬於正常現象，請直接忽略**。
- PR 合併至主分支後，官方環境會自動使用正確金鑰完成索引更新與簽署。

---

## 額外提醒

- **請勿**提交非開源或未經授權的軟體。
- 若套件為二進位檔（非原始碼），請務必在 `README` 及 `LICENSES` 中標明來源與編譯方式（若可）。
- 若你維護多個套件，歡迎成為本倉庫的長期貢獻者，我們會授予相應權限以簡化流程。

# Debian2Windows

> **在 Linux 修復之際，我們需要一個 `.deb` 倉庫。**

一個收錄各種「把 Windows 體驗帶到 Linux」工具的第三方 Debian 套件倉庫。

本專案的宗旨非常簡單：

> **Linux 已經很好用了，但我們還是可以把它修成 Windows。**

> [!WARNING]
> **胡亂使用本專案可能導致系統故障甚至無法正常使用。後果自負。**
>
> 本倉庫中的套件並非 Debian 官方套件，請在安裝前自行確認套件內容及來源。

> [!NOTE]
> 倉庫已經改名為Debian2Windows，舊有使用者可能需要修改倉庫名稱。

## 食用方式

### 1. 安裝倉庫公鑰

```sh
sudo curl -fsSL https://stupidestjack.github.io/Debian2Windows/debian2windows.gpg.key \
  | sudo gpg --dearmor -o /etc/apt/keyrings/debian2windows.gpg
```

### 2. 加入套件來源

```sh
echo "deb [signed-by=/etc/apt/keyrings/debian2windows.gpg] https://stupidestjack.github.io/Debian2Windows/ /" \
  | sudo tee /etc/apt/sources.list.d/linux2windows.list
```

### 3. 更新套件索引

```sh
sudo apt update
```

完成後，即可使用 `apt` 安裝本倉庫中的套件。

例如：

```sh
sudo apt install winver
```

> 套件名稱及可用版本請以倉庫實際提供的索引為準。

## 倉庫內的套件

以下套件依名稱排序。

| 套件 | 專案 | 說明 |
| --- | --- | --- |
| `activate-linux` | [MrGlockenspiel/activate-linux](https://github.com/MrGlockenspiel/activate-linux) | 修復 Linux 沒有「啟用 Windows」浮水印的 Bug |
| `autofix` | [xusk1234/Linux-Auto-Fix](https://github.com/xusk1234/Linux-Auto-Fix/) | 修復 Linux 沒有自動修復的 Bug |
| `bsod` | [heyManNice/bsod](https://github.com/heyManNice/bsod) | 修復 Linux 沒有 BSOD 的 Bug |
| `cmd` | [ChenPi11/cmd](https://github.com/ChenPi11/cmd) | 修復 Linux 沒有 `cmd` 的 Bug |
| `control` | [phillin-liu/WindowsControlPanel-for-Linux](https://github.com/phillin-liu/WindowsControlPanel-for-Linux) | 修復 Linux 沒有控制台的 Bug |
| `elevende` | [SYSTEM-Intel-MIC/ElevenDE](https://github.com/SYSTEM-Intel-MIC/ElevenDE) | 修復 Linux 沒有 Windows 11 桌面的 Bug |
| `libschrodinger` | [LyCecilion/libschrodinger](https://github.com/LyCecilion/libschrodinger) | 修復 Linux 沒有「應用程式錯誤」視窗的 Bug |
| `mkwin` | [macOS-Terminal/mkwin](https://github.com/macOS-Terminal/mkwin) | 從原始碼建構赤石科技的套件管理器 |
| `regedit` | [heyManNice/regedit](https://github.com/heyManNice/regedit) | 修復 Linux 沒有登錄編輯程式的 Bug |
| `service` | [StupidestJack/ServiceForLinux](https://github.com/StupidestJack/ServiceForLinux/) | 修復 Linux 沒有 Service 的 Bug |
| `vbs` | [Linming-XHL/ZakoVBS](https://github.com/Linming-XHL/ZakoVBS) | 修復 Linux 沒有 VBS 的 Bug |
| `winver` | [DeepslateQAQ/linux-winver](https://github.com/DeepslateQAQ/linux-winver) | 修復 Linux 沒有 `winver` 的 Bug |
| `windowshit` | [HelloAIXIAOJI/windowshit](https://github.com/HelloAIXIAOJI/windowshit) | 修復 Linux 沒有 24 種 Windows 命令的 Bug |

### `windowshit` 提供的命令

`windowshit` 包含以下子套件：

| 套件 | 修復的 Bug | 備註 |
| --- | --- | --- |
| `ws-choice` | 沒有 `choice` 命令 | |
| `ws-clip` | 沒有 `clip` 命令 | |
| `ws-expand` | 沒有 `expand` 命令 | |
| `ws-fc` | 沒有 `fc` 命令 | |
| `ws-findstr` | 沒有 `findstr` 命令 | |
| `ws-getmac` | 沒有 `getmac` 命令 | |
| `ws-hostname-win` | 沒有 `hostname` 命令 | 使用 `hostname-win` |
| `ws-ipconfig` | 沒有 `ipconfig` 命令 | |
| `ws-makecab` | 沒有 `makecab` 命令 | |
| `ws-more-win` | 沒有 `more` 命令 | 使用 `more-win` |
| `ws-pathping` | 沒有 `pathping` 命令 | |
| `ws-ping-win` | 沒有 `ping` 命令 | 使用 `ping-win` |
| `ws-replace` | 沒有 `replace` 命令 | |
| `ws-robocopy` | 沒有 `robocopy` 命令 | |
| `ws-shutdown` | 沒有 `shutdown` 命令 | |
| `ws-sort-win` | 沒有 `sort` 命令 | 使用 `sort-win` |
| `ws-systeminfo` | 沒有 `systeminfo` 命令 | |
| `ws-taskkill` | 沒有 `taskkill` 命令 | |
| `ws-tasklist` | 沒有 `tasklist` 命令 | |
| `ws-tracert` | 沒有 `tracert` 命令 | |
| `ws-tree-win` | 沒有 `tree` 命令 | 使用 `tree-win` |
| `ws-type-win` | 沒有 `type` 命令 | 使用 `type-win` |
| `ws-ver` | 沒有 `ver` 命令 | |
| `ws-where-win` | 沒有 `where` 命令 | 使用 `where-win` |
| `ws-whoami-win` | 沒有 `whoami` 命令 | 使用 `whoami-win` |

### `elevende` 提供的元件

`elevende` 是一個 Windows 11 風格的桌面環境，包含以下元件：

| 套件 | 修復的 Bug | 備註 |
| --- | --- | --- |
| `elevende-assets` | 沒有 Windows 11 圖示和桌布 | 所有elevende系列皆依賴此 |
| `elevende-core` | 沒有 Windows 11 任務欄 | 附加工作列、開始功能表、通知中心、鎖定畫面、Win+R、Ctrl+Alt+Del |
| `elevende-calc` | 沒有小算盤 | |
| `elevende-notepad` | 沒有記事本 | |
| `elevende-photos` | 沒有相片 | |
| `elevende-taskmgr` | 沒有工作管理員 | |
| `elevende-settings` | 沒有設定 | |
| `elevende-explorer` | 沒有檔案總管 | |
| `elevende-screenshot` | 沒有截圖工具 | |

#### 安裝 ElevenDE

```sh
# 安裝完整 ElevenDE 桌面（全家桶）
sudo apt install elevende

# 或只安裝特定元件
sudo apt install elevende-core elevende-explorer
```

> `elevende` 是虛擬套件，會自動安裝所有 ElevenDE 元件。

## 相容性

目前倉庫只提供 **AMD64 (`amd64`)** 架構的套件。

其他架構暫不提供預編譯套件。

如果你願意幫忙編譯其他架構，歡迎提交 PR。

> 因為我不想編譯，除非有人想幫我編譯其他架構（doge

## 貢獻

歡迎任何人 Fork 本專案並提交 Pull Request。

如果你想新增套件或更新現有套件，請先閱讀：

**[CONTRIBUTING.md](CONTRIBUTING.md)**

每一條 PR 我都會看的。

此外，也非常歡迎上游專案的開發者親自維護自己的套件，讓 Linux 赤石科技生態更加穩定。

> 強烈建議使用 GPG 金鑰簽署自己的 Commit，以避免 PR 被關閉。
>
> 也歡迎各位專案開發者親自維護、親自拉石，為 Linux 赤石科技生態貢獻一份力量。

## 特別感謝

### 專案開發者

- [@LyCecilion](https://github.com/LyCecilion)
- [@ChenPi11](https://github.com/ChenPi11)
- [@heyManNice](https://github.com/heyManNice)
- [@HelloAIXIAOJI](https://github.com/HelloAIXIAOJI)
- [@macOS-Terminal](https://github.com/macOS-Terminal)
- [@MrGlockenspiel](https://github.com/MrGlockenspiel)
- [@xusk1234](https://github.com/xusk1234)
- [@StupidestJack](https://github.com/StupidestJack)
- [@SYSTEM-Intel-MIC](https://github.com/SYSTEM-Intel-MIC)
- [@Linming-XHL](https://github.com/Linming-XHL)

### 倉庫維護者

- [@FreshingAir](https://github.com/FreshingAir)
- [@StupidestJack](https://github.com/StupidestJack)


### 文件

- ChatGPT（GPT-5.6 Luna）
- Deepseek-V3（Instant）
- [@StupidestJack](https://github.com/StupidestJack)

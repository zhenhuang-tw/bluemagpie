# bluemagpie

Traditional Chinese note package for [Typst](https://typst.app/). The name `bluemagpie` comes from the Taiwan blue magpie (_Urocissa caerulea_), a species endemic to Taiwan.

適用於 [Typst](https://typst.app/) 的繁體中文筆記套件，得名於臺灣藍鵲（Taiwan blue magpie）。

只要選擇其中一個 show 規則，就會套用全部的筆記樣式（版面、字型、註腳、標題編號、目錄等）：

| show 規則    | 用途                                         | 引註方式                   |
| ------------ | -------------------------------------------- | -------------------------- |
| `basic-note` | 課堂筆記、讀書摘要、公文草稿、單篇文章       | 選用；Typst 原生，僅隨頁註 |
| `large-note` | 整學年筆記、長篇報告：在「壹、」之上分「章」 | 同上                       |

兩者共用 [yuhina](https://github.com/zhenhuang-tw/yuhina) 套件中的字體、行內樣式、註腳與標題編號。本套件與 yuhina 都尚未上架 Typst Universe，須各自安裝為本機套件（local package），見〈安裝〉。我們另有一姊妹作 [flamegold](https://github.com/zhenhuang-tw/flamegold)，專為法學院研究生撰寫課程報告使用；它也援引 yuhina 的排版設計，所以成品會長得和我們輸出的筆記很像。

## 環境需求

1. [Typst](https://github.com/typst/typst#installation) 0.14 以上。
2. 建議安裝下列字型。缺少時 Typst 會以其他字型替補，但外觀會不同：
   - Times New Roman、Arial
   - 微軟正黑體（`Microsoft JhengHei UI`）
   - 新細明體（`PMingLiU`）、標楷體（`DFKai-SB`）
   - [TaiwanPearl 台灣圓體](https://github.com/max32002/TaiwanPearl) 的 Light 版本（`#hypo` 使用）
   - [Zhuque Fangsong 朱雀仿宋](https://github.com/TrionesType/zhuque)（`#thought` 使用）

首次編譯時，Typst 會自動下載 `@preview/cuti`。

## 安裝

Typst 會在 `%APPDATA%\typst\packages\local\<名稱>\<版本>` 尋找本機套件。clone 本 repo 後執行 `install.ps1`，會為本套件與 yuhina 各建立一個指向 clone 的目錄連結（junction）；之後 clone 內容變動，不必重新複製。建立 junction 不需要系統管理員權限。

```powershell
git clone https://github.com/zhenhuang-tw/bluemagpie.git
cd bluemagpie
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

腳本的行為：

- 從各自的 `typst.toml` 讀取套件名稱與版本來決定資料夾，不會對不上。
- 在本 repo 旁邊的 `..\yuhina` 尋找 yuhina 的 clone；找不到就 clone 到那裡（需要 git）。
- 可重複執行：已正確連結的會略過；該路徑上已有真實資料夾時會中止，不會刪除；已有指向別處的 junction 時，加上 `-Force` 才會替換（只移除 junction，不動它所指向的資料夾）。
- `-YuhinaPath` 指定 yuhina clone 的位置，`-PackageRoot` 指定本機套件目錄。

`-ExecutionPolicy Bypass` 只對這一次執行有效。Windows 用戶端預設的執行原則不允許執行 `.ps1`；若你已調整過，可直接執行 `.\install.ps1`。使用 PowerShell 7 時，將 `powershell` 換成 `pwsh`。

安裝後，文件即可 `#import "@local/bluemagpie:0.1.0": *`。未安裝時，編譯會出現 `package not found (searched for @local/bluemagpie:0.1.0)`；少了 yuhina 則是 `@local/yuhina:0.1.0`。

### 更新

在兩個 clone 內各執行 `git pull`。junction 指向 clone 本身，所有文件下次編譯就會用到新版。

若 `typst.toml` 的 `version` 提高（例如 0.2.0），再執行一次 `install.ps1` 即會建立新版本的 junction，並把文件中的 `@local/bluemagpie:0.1.0` 改為新版本。

## 快速開始

### 一般筆記（`basic-note`）

```typ
#import "@local/bluemagpie:0.1.0": *

#show: basic-note.with(
  title: "民法債編總論筆記",
  authors: "授課老師：何孝元教授",
)

= 前言

這是一份用 Typst 撰寫的中文筆記。可以用 #keyword[重點強調] 標示重點，
或用 #hypo[教學設例] 寫下假設情境。
```

```powershell
typst compile note.typ     # 產生 note.pdf
typst watch note.typ       # 監看檔案，存檔即重新編譯
```

`basic-note` 已套用全部排版規則，不必再寫其他 `#show`。以 `*` 匯入會一併取得兩個 show 規則、行內樣式函式與字型；也可以只匯入需要的名稱，例如 `#import "@local/bluemagpie:0.1.0": basic-note, hypo`。

### 大型筆記（`large-note`）

參數與 `basic-note` 完全相同，只差在標題多一層「章」：

```typ
#import "@local/bluemagpie:0.1.0": *

#show: large-note.with(title: "全學年刑法總則筆記")

= 導論          // 第一章 導論（另起新頁）
== 問題意識     // 壹、問題意識
=== 小結        // 一、小結
```

## 參數說明

兩個 show 規則的參數相同，以 `#show: basic-note.with(...)` 或 `#show: large-note.with(...)` 套用。

| 參數           | 型別             | 預設值 | 說明                                                 |
| -------------- | ---------------- | ------ | ---------------------------------------------------- |
| `title`        | 字串             | `""`   | **必填**。主標題。                                   |
| `title-thanks` | 內容／`none`     | `none` | 標題的註解，例如「本文為某計畫成果」，以腳註呈現。   |
| `subtitle`     | 內容／`none`     | `none` | 副標題。                                             |
| `authors`      | 字串／字典／陣列 | `()`   | 作者，寫法見下節。                                   |
| `bib`          | bytes／`none`    | `none` | 參考文獻（`.yml` 或 `.bib`）。不傳則不載入，見下節。 |

### 作者（`authors`）

```typ
// 1. 單純一個字串
authors: "何孝元"

// 2. 一位作者並附上職銜（以腳註呈現）
authors: (name: "何孝元", thanks: "國立臺北大學法律學系")

// 3. 多位作者，以「、」連接
authors: (
  (name: "何孝元", thanks: "國立臺北大學法律學系"),
  "蔡蔭恩",
)
```

### 筆記的參考文獻（`bib`）

筆記的引用一律以**腳註**呈現（`chicago-shortened-notes`），文末**不**輸出參考文獻清單。若不需要參考文獻，省略 `bib` 即可。

`bib` 只接受 bytes，請由你的文件讀檔後傳入：

```typ
#show: basic-note.with(
  title: "筆記",
  bib: read("ref.yml", encoding: none),   // 或 ref.bib
)
```

不可直接傳路徑字串（如 `bib: "ref.yml"`）：Typst 會以**套件所在資料夾**解析路徑，指不到你的檔案，所以會直接報錯。

## 行內樣式函式

以 `#import "@local/bluemagpie:0.1.0": *` 匯入時，會一併取得下列函式：

| 函式           | 用途                   | 範例                            |
| -------------- | ---------------------- | ------------------------------- |
| `keyword`      | 重點強調（原字體加粗） | `#keyword[重要]`                |
| `very-keyword` | 非常重要（黑體粗體）   | `#very-keyword[極重要]`         |
| `hypo`         | 教學設例（圓體）       | `#hypo[假設小明……]`             |
| `thought`      | 個人想法（仿宋）       | `#thought[我認為……]`            |
| `inquote`      | 行內引用（楷體）       | `#inquote[被引用之文字]`        |
| `right-note`   | 靠右的灰色小字註解     | `#right-note[（0218 W1 節一）]` |

## 編號規則

### 標題

| 寫法         | `basic-note`     | `large-note`                  |
| ------------ | ---------------- | ----------------------------- |
| `= 標題`     | 壹、標題（置中） | 第一章 標題（置中、另起新頁） |
| `== 標題`    | 一、標題         | 壹、標題                      |
| `=== 標題`   | (一) 標題        | 一、標題                      |
| `==== 標題`  | 1.標題           | (一) 標題                     |
| `===== 標題` | (1) 標題         | 1.標題                        |

### 交互參照

在標題後加上標籤，內文以 `@標籤` 參照，會輸出完整的層級路徑：

```typ
== 問題意識 <issue>

（後文）關於本文之問題意識，見@issue。     // 見壹、一
#footnote[詳見@issue[本文]。]              // 詳見本文壹、一
```

| 參照對象    | `basic-note`   | `large-note`       |
| ----------- | -------------- | ------------------ |
| `= 標題`    | 壹             | 第一章             |
| `== 標題`   | 壹、二         | 第一章壹           |
| `=== 標題`  | 壹、二、(三)   | 第一章壹、二       |
| `==== 標題` | 壹、二、(三)1. | 第一章壹、二、(三) |

路徑結尾的「、」會省略，方便直接接續文字或標點；方括號內的文字會放在路徑前面。參照可以指向後文的標題，也可以寫在腳註裡。中文字後直接接 `@` 即可，不必空格。

要參照頁碼，請寫 `#ref(<issue>, form: "page")`，輸出「頁 5」；這種寫法不受上述路徑格式影響。

```typ
+ 第一項        // 1.
+ 第二項        // 2.
  + 子項        // (1)
```

依層級依序為 `1. → (1) → A. → (A) → a. → (a)`。

## 版面

A4，左右邊距 3cm、上下 2.5cm，頁碼置中；內文新細明體 12pt，段落不縮排，行距 1.1em；腳註文內標籤為黑體上標，頁底採懸掛縮排；圖說置於圖片上方。首頁為標題、作者，其下接目錄；文末不輸出參考文獻清單。

## 衍生模板

要自行撰寫模板，或只挑部分排版規則（頁面、段落、註腳、標題編號等）、傳入不同參數，請直接匯入 yuhina：`#import "@local/yuhina:0.1.0": *`。各函式的名稱、參數與範例見 [yuhina 的 README-zh.md](https://github.com/zhenhuang-tw/yuhina/blob/main/README-zh.md)。`basic-note` 與 `large-note` 只是以 yuhina 的 `common-style` 將這些規則全部套用，再加上標題、目錄與參考文獻。

## 從舊版遷移

原本以 Git submodule 使用本專案（舊名 `typst-basic-zh`）的專案，請依序處理：

1. 依〈安裝〉安裝本套件與 yuhina。
2. 在專案根目錄移除 submodule。先用 `ls .git\modules` 確認其名稱；以舊版更名而來的，名稱可能仍是 `typst-basic-zh`。最後一行是清理，可省略：

   ```powershell
   git submodule deinit -f bluemagpie     # 舊路徑則為 typst-basic-zh
   git rm -f bluemagpie
   git commit -m "chore(tpl): replace bluemagpie submodule with local package"
   Remove-Item -Recurse -Force .git\modules\<名稱>
   ```

3. 修改文件中的匯入與 show 規則：

   | 原本                                                                             | 改為                                                                  |
   | -------------------------------------------------------------------------------- | --------------------------------------------------------------------- |
   | `#import "…/basic-note.typ": *`<br>`#show: project.with(…)`                      | `#import "@local/bluemagpie:0.1.0": *`<br>`#show: basic-note.with(…)` |
   | `#import "…/large-note.typ": *`<br>`#show: project.with(…)`                      | `#import "@local/bluemagpie:0.1.0": *`<br>`#show: large-note.with(…)` |
   | `#rightNote[…]`                                                                  | `#right-note[…]`                                                      |
   | `bib: "ref.yml"`                                                                 | `bib: read("ref.yml", encoding: none)`                                |
   | 直接匯入 `…/common.typ`（例如舊版 flamegold）                                  | `#import "@local/yuhina:0.1.0": *`                                    |
   | `…/academic-paper.typ`（論文模板）                                               | 改用 [flamegold](https://github.com/zhenhuang-tw/flamegold)，見其 README |

   更舊的 `basic-zh.typ` 比照前兩列處理；原本設有 `isLargeReport: true` 者改用 `large-note`，並刪除該參數。

## License

[MIT](LICENSE)

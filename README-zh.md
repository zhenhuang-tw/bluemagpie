# typst-basic-zh

適用於 [Typst](https://typst.app/) 的繁體中文筆記模板，提供兩個入口檔：

| 入口檔           | 用途                                         | 引註方式                   |
| ---------------- | -------------------------------------------- | -------------------------- |
| `basic-note.typ` | 課堂筆記、讀書摘要、公文草稿、單篇文章       | 選用；Typst 原生，僅隨頁註 |
| `large-note.typ` | 整學年筆記、長篇報告：在「壹、」之上分「章」 | 同上                       |

兩者共用 `common.typ` 中的字體、行內樣式、註腳與標題編號。`common.typ` 不是入口檔，文件請勿直接匯入。

投稿用學術論文（中英封面、摘要、citrus 引註、分類參考文獻）的模板已獨立為 [typst-ntulj](https://github.com/zhenhuang-tw/typst-ntulj)。該模板以 submodule 引入本專案並沿用 `common.typ`，因此兩者外觀一致。

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

### 方式一：Git submodule（建議）

在你的專案根目錄執行：

```powershell
git submodule add https://github.com/zhenhuang-tw/typst-basic-zh.git typst-basic-zh
```

之後以 `#import "typst-basic-zh/basic-note.typ": *` 匯入。以下範例皆假設模板位於 `typst-basic-zh/` 資料夾。

### 方式二：直接複製

將 `common.typ` 與你要用的入口檔一起複製到專案中。入口檔都依賴 `common.typ`，`large-note.typ` 另依賴 `basic-note.typ`，缺一無法編譯。

## 快速開始

### 一般筆記（`basic-note.typ`）

```typ
#import "typst-basic-zh/basic-note.typ": *

#show: project.with(
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

### 大型筆記（`large-note.typ`）

參數與 `basic-note.typ` 完全相同，只差在標題多一層「章」：

```typ
#import "typst-basic-zh/large-note.typ": *

#show: project.with(title: "全學年刑法總則筆記")

= 導論          // 第一章 導論（另起新頁）
== 問題意識     // 壹、問題意識
=== 小結        // 一、小結
```

## 參數說明

兩個入口檔的主函式都叫 `project`，參數相同，以 `#show: project.with(...)` 套用。

### `basic-note.typ`、`large-note.typ`

| 參數           | 型別                | 預設值 | 說明                                                 |
| -------------- | ------------------- | ------ | ---------------------------------------------------- |
| `title`        | 字串                | `""`   | **必填**。主標題。                                   |
| `title-thanks` | 內容／`none`        | `none` | 標題的註解，例如「本文為某計畫成果」，以腳註呈現。   |
| `subtitle`     | 內容／`none`        | `none` | 副標題。                                             |
| `authors`      | 字串／字典／陣列    | `()`   | 作者，寫法見下節。                                   |
| `bib`          | 字串／bytes／`none` | `none` | 參考文獻（`.yml` 或 `.bib`）。不傳則不載入，見下節。 |

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

筆記模板的引用一律以**腳註**呈現（`chicago-shortened-notes`），文末**不**輸出參考文獻清單。若不需要參考文獻，省略 `bib` 即可。

傳入方式依模板位置而定：

```typ
// 模板放在 submodule（建議）：由你的文件讀檔，傳入 bytes
bib: read("ref.yml", encoding: none),

// 模板與文件在同一資料夾：也可以直接傳路徑
bib: "ref.yml",
```

傳入字串時，Typst 會以**模板檔所在資料夾**解析路徑；在 submodule 架構下會指向 `typst-basic-zh/ref.yml`，因此請改傳 bytes。

## 行內樣式函式

兩個入口檔都會一併匯出下列函式：

| 函式           | 用途                   | 範例                           |
| -------------- | ---------------------- | ------------------------------ |
| `keyword`      | 重點強調（原字體加粗） | `#keyword[重要]`               |
| `very-keyword` | 非常重要（黑體粗體）   | `#very-keyword[極重要]`        |
| `hypo`         | 教學設例（圓體）       | `#hypo[假設小明……]`            |
| `thought`      | 個人想法（仿宋）       | `#thought[我認為……]`           |
| `inquote`      | 行內引用（楷體）       | `#inquote[被引用之文字]`       |
| `rightNote`    | 靠右的灰色小字註解     | `#rightNote[（0218 W1 節一）]` |

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

## 衍生模板：可個別套用的排版規則

`common.typ` 的 `common-style` 由下列函式依序組成。撰寫衍生模板（例如論文模板或期刊預設格式）時，可以只挑需要的幾項、傳入不同參數，或換成自己的版本。每個函式都以 `#show: 函式` 或 `#show: 函式.with(...)` 套用，只影響其後的內容。

| 函式             | 作用                     | 參數（預設值）                                               |
| ---------------- | ------------------------ | ------------------------------------------------------------ |
| `document-style` | PDF 標題與作者           | `title: ""`、`authors: ()`                                   |
| `page-style`     | 紙張、邊距、頁尾置中頁碼 | `paper: "a4"`、`margin: (x: 3cm, y: 2.5cm)`                  |
| `text-style`     | 字型、語言、CJK 粗體     | `font: font-song`、`size: 12pt`                              |
| `par-style`      | 段落                     | `first-line-indent: 0em`、`leading: 1.1em`、`spacing: 1.6em` |
| `quote-style`    | 區塊引用                 | `font: font-kai`                                             |
| `list-style`     | 編號與項目清單           | 無                                                           |
| `figure-style`   | 圖說                     | `font: font-kai`                                             |
| `footnote-style` | 註腳                     | `font: font-song`、`label-font: font-hei`                    |
| `heading-style`  | 標題編號與外觀           | `font: font-hei`、`large: false`                             |
| `ref-style`      | 交互參照                 | `large: false`（須與 `heading-style` 一致）                  |

例如，只換邊距並讓段落首行縮排：

```typ
#import "typst-basic-zh/common.typ": *

#show: document-style.with(title: "論文標題")
#show: page-style.with(margin: (x: 2.5cm, y: 2cm))
#show: text-style
#show: par-style.with(first-line-indent: 2em, leading: 1.2em)
#show: quote-style
#show: list-style
#show: figure-style
#show: footnote-style
#show: heading-style
#show: ref-style
```

## 從舊版遷移

### 原本匯入 `basic-zh.typ`

`basic-zh.typ` 已移除，更新 submodule 後舊文件會無法編譯。請改為：

| 原本                              | 改為                                        |
| --------------------------------- | ------------------------------------------- |
| `#import "basic-zh.typ": *`       | `#import "basic-note.typ": *`               |
| 加上 `isLargeReport: true` 的文件 | `#import "large-note.typ": *`，並刪除該參數 |

### 原本匯入 `academic-paper.typ`

`academic-paper.typ` 已移至 [typst-ntulj](https://github.com/zhenhuang-tw/typst-ntulj)，更新本 submodule 後，匯入它的文件會無法編譯。請在論文專案根目錄執行：

```powershell
git submodule add https://github.com/zhenhuang-tw/typst-ntulj.git typst-ntulj
git submodule update --init --recursive
```

再把 `#import "typst-basic-zh/academic-paper.typ": *` 改為 `#import "typst-ntulj/ntulj.typ": *`。`project`、`ncite`、`ncitef` 的參數都不變。若該專案只用來寫論文，可以接著移除 `typst-basic-zh` submodule。

## 更新 submodule

在你的專案根目錄執行：

```powershell
git submodule update --remote --merge typst-basic-zh
git add typst-basic-zh
git commit -m "chore(tpl): update typst-basic-zh submodule"
```

主專案只記錄 submodule 指向的 commit，所以更新後必須把 submodule 資料夾 `git add` 並提交，其他電腦 clone 時才會取得新版。其他電腦拉取主專案後，執行 `git submodule update --init` 即可同步。

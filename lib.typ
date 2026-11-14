// lib.typ
// bluemagpie: Traditional Chinese note templates for Typst, built on yuhina.
//
//   #import "@local/bluemagpie:0.1.0": *
//
//   #show: basic-note.with(title: "標題", authors: "作者")   // 一般筆記 / ordinary notes
//   #show: large-note.with(title: "標題", authors: "作者")   // 大型筆記 / large notes
//
// 以 `*` 匯入即可同時取得兩個 show 規則、行內樣式函式與字型；也可只匯入需要的名稱。
// Importing with `*` brings in both show rules, the inline style functions, and the fonts;
// you can also import only the names you need.
//
// 公開名稱以外的內容屬內部實作，日後可能變動。
// Anything not exported here is internal and may change.

// 筆記 show 規則 / Note show rules
#import "src/note.typ": basic-note, large-note

// 筆記專用行內樣式 / Note-only inline styles
#import "src/inline.typ": hypo, right-note, thought, very-keyword

// yuhina 的通用行內樣式與字型，轉出以便文件只匯入本套件即可使用
// General inline styles and fonts from yuhina, re-exported so documents need to import only this package
#import "@local/yuhina:0.1.0": font-fsong, font-hei, font-kai, font-song, font-yuan, inquote, keyword

// src/note.typ
// 筆記版面與兩個 show 規則：basic-note、large-note。
// Note layout and the two show rules: basic-note and large-note.
//
//   #show: basic-note.with(title: "標題")
//   #show: large-note.with(title: "標題")
//
// 兩者都已套用 yuhina 的全部排版規則（common-style），不必再另外 show。
// Both already apply all of yuhina's typesetting rules (common-style); no further show rules are needed.

#import "@local/yuhina:0.1.0": common-style, normalize-authors, plain-links, title-block

// ============================================================
// § 筆記版面（basic-note 與 large-note 共用，請勿直接呼叫）
// § Note layout (shared by basic-note and large-note; do not call directly)
// ============================================================
#let _note(
  large: false,
  title: "",
  title-thanks: none,
  subtitle: none,
  authors: (),
  bib: none,
  body,
) = {
  show: common-style.with(title: title, authors: authors, large: large)

  title-block(title, title-thanks: title-thanks, subtitle: subtitle, authors: normalize-authors(authors))

  // 目錄（與標題同頁）/ Table of contents (on the same page as the title)
  v(1.5em)
  outline(indent: auto, depth: if large { 4 } else { 3 })

  pagebreak()

  show: plain-links

  body

  // 隨頁註引用：載入參考文獻以解析引用鍵，但隱藏文末清單。
  // Footnote citations: load the bibliography to resolve keys, but hide the list at the end.
  if bib != none {
    show bibliography: it => {}
    bibliography(bib, style: "chicago-shortened-notes")
  }
}

// ============================================================
// § 一般筆記：課堂筆記、讀書摘要、公文草稿、單篇文章
// § Ordinary notes: class notes, reading summaries, draft documents, standalone articles
// ============================================================
#let basic-note(
  title: "", // 標題必填 / Title (required)
  title-thanks: none, // 標題註解 / Title note
  subtitle: none, // 副標題 / Subtitle
  // 每位作者為字串或 dict：(name: "姓名", thanks: "職銜或說明")
  // Each author is a string or a dict: (name: "Name", thanks: "Affiliation or note")
  authors: (),
  bib: none, // 參考文獻（路徑或 bytes，選填）/ Bibliography (path or bytes, optional)
  body,
) = _note(
  large: false,
  title: title,
  title-thanks: title-thanks,
  subtitle: subtitle,
  authors: authors,
  bib: bib,
  body,
)

// ============================================================
// § 大型筆記：在「壹、」之上多一層「第一章」，且每章另起新頁
// § Large notes: adds a "Chapter N" level above "壹、" and starts each chapter on a new page
// ============================================================
#let large-note(
  title: "", // 標題必填 / Title (required)
  title-thanks: none, // 標題註解 / Title note
  subtitle: none, // 副標題 / Subtitle
  authors: (), // 作者 / Authors
  bib: none, // 參考文獻（路徑或 bytes，選填）/ Bibliography (path or bytes, optional)
  body,
) = _note(
  large: true,
  title: title,
  title-thanks: title-thanks,
  subtitle: subtitle,
  authors: authors,
  bib: bib,
  body,
)

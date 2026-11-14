// src/inline.typ
// 筆記專用行內樣式函式；keyword、inquote 等通用者由 yuhina 提供。
// Note-only inline style functions; general ones such as keyword and inquote come from yuhina.

#import "@local/yuhina:0.1.0": font-fsong, font-hei, font-yuan

// 非常重點強調 / Strong emphasis
#let very-keyword(content) = {
  set text(font: font-hei, weight: "bold")
  content
}
// 教學設例 / Hypothetical cases
#let hypo(content) = {
  set text(font: font-yuan, weight: "light") // "light": TaiwanPearl's font weight is on the heavy side
  content
}
// 個人想法 / Personal thoughts
#let thought(content) = {
  set text(font: font-fsong)
  content
}
// 右側註解 / Right-side note, e.g. #right-note[(0218 W1 Session 1)]
#let right-note(content) = align(right, text(size: 0.9em, fill: luma(90), content))

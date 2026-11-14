# typst-basic-zh

Traditional Chinese note templates for [Typst](https://typst.app/), with two entry points:

| Entry point      | For                                                        | Citations                              |
| ---------------- | ---------------------------------------------------------- | -------------------------------------- |
| `basic-note.typ` | Class notes, reading summaries, draft documents, articles  | Optional; native Typst, footnotes only |
| `large-note.typ` | Year-long notes and long reports, with chapters above 壹、 | Same as above                          |

Both share fonts, inline styles, footnotes, and heading numbering from the [yuhina](https://github.com/zhenhuang-tw/yuhina) package. Yuhina is not on Typst Universe yet, so it must be installed as a local package; see Requirements.

The template for journal papers (bilingual cover, abstracts, citrus citations, grouped bibliography) now lives in [typst-ntulj](https://github.com/zhenhuang-tw/typst-ntulj). It includes this repository as a submodule and is moving to yuhina as well, so both look the same.

The Chinese README, [README-zh.md](README-zh.md), is the full manual. This file covers the essentials.

## Requirements

1. [Typst](https://github.com/typst/typst#installation) 0.14 or later.
2. [yuhina](https://github.com/zhenhuang-tw/yuhina), installed as a local package (`@local/yuhina:0.1.0`). Without it, compilation fails with `package not found (searched for @local/yuhina:0.1.0)`. On Windows, run this in a clone of yuhina; the full steps are in its [README-zh.md](https://github.com/zhenhuang-tw/yuhina/blob/main/README-zh.md):

   ```powershell
   $pkg = "$env:APPDATA\typst\packages\local\yuhina\0.1.0"
   New-Item -ItemType Directory -Force (Split-Path $pkg) | Out-Null
   New-Item -ItemType Junction -Path $pkg -Target (Resolve-Path .)
   ```

3. Recommended fonts. Typst substitutes missing fonts, but the output will look different:
   - Times New Roman, Arial
   - Microsoft JhengHei UI, PMingLiU, DFKai-SB
   - [TaiwanPearl](https://github.com/max32002/TaiwanPearl) Light (used by `#hypo`)
   - [Zhuque Fangsong](https://github.com/TrionesType/zhuque) (used by `#thought`)

Typst downloads `@preview/cuti` on first compile.

## Installation

Recommended: add the repository as a Git submodule in your project root.

```powershell
git submodule add https://github.com/zhenhuang-tw/typst-basic-zh.git typst-basic-zh
```

Alternatively, copy the entry point you need. `large-note.typ` also depends on `basic-note.typ`. Either way, yuhina must be installed as described in Requirements.

## Usage

See [README-zh.md](README-zh.md).

## Paths in a submodule

Typst resolves a path against the file that reads it, which here is the template. When the template is a submodule, `bib: "ref.yml"` therefore points to `typst-basic-zh/ref.yml`. Read the file in your own document and pass the contents instead: `bib: read("ref.yml", encoding: none)`.

## Migrating

- `basic-zh.typ` has been removed. Import `basic-note.typ` instead, or `large-note.typ` if you set `isLargeReport: true`, and drop that parameter.
- `academic-paper.typ` has moved to [typst-ntulj](https://github.com/zhenhuang-tw/typst-ntulj). Add that repository as a submodule, run `git submodule update --init --recursive`, and import `typst-ntulj/ntulj.typ` instead. `project`, `ncite`, and `ncitef` take the same arguments as before.

## Updating the submodule

```powershell
git submodule update --remote --merge typst-basic-zh
git add typst-basic-zh
git commit -m "chore(tpl): update typst-basic-zh submodule"
```

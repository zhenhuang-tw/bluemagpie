# bluemagpie

Traditional Chinese note templates for [Typst](https://typst.app/). The name `bluemagpie` comes from the Taiwan blue magpie (_Urocissa caerulea_), a species endemic to Taiwan.

Both share fonts, inline styles, footnotes, and heading numbering from the [yuhina](https://github.com/zhenhuang-tw/yuhina) package.

> Yuhina is not on Typst Universe yet, so it must be installed as a local package; see Requirements.

The template for journal papers (bilingual cover, abstracts, citrus citations, grouped bibliography) now lives in [typst-ntulj](https://github.com/zhenhuang-tw/typst-ntulj). It includes this repository as a submodule and is moving to yuhina as well, so both look the same.

## Requirements, Installation & Usage

The Chinese README, [README-zh.md](README-zh.md), is the full manual.

## Paths in a submodule

Typst resolves a path against the file that reads it, which here is the template. When the template is a submodule, `bib: "ref.yml"` therefore points to `bluemagpie/ref.yml`. Read the file in your own document and pass the contents instead: `bib: read("ref.yml", encoding: none)`.

## Migrating

- This project was renamed from `typst-basic-zh` to `bluemagpie`, and `common.typ` was replaced by the yuhina package. Install yuhina (see Requirements), then in your project root:

  ```powershell
  git mv typst-basic-zh bluemagpie
  git submodule set-url bluemagpie https://github.com/zhenhuang-tw/bluemagpie.git
  git submodule sync bluemagpie
  git add .gitmodules
  git commit -m "chore(tpl): rename typst-basic-zh submodule to bluemagpie"
  ```

  Change `typst-basic-zh/...` imports to `bluemagpie/...`, and replace any direct import of `common.typ` with `@local/yuhina:0.1.0`.

- `basic-zh.typ` has been removed. Import `basic-note.typ` instead, or `large-note.typ` if you set `isLargeReport: true`, and drop that parameter.
- `academic-paper.typ` has moved to [typst-ntulj](https://github.com/zhenhuang-tw/typst-ntulj). Add that repository as a submodule, run `git submodule update --init --recursive`, and import `typst-ntulj/ntulj.typ` instead. `project`, `ncite`, and `ncitef` take the same arguments as before.

## Updating the submodule

```powershell
git submodule update --remote --merge bluemagpie
git add bluemagpie
git commit -m "chore(tpl): update bluemagpie submodule"
```

# bluemagpie

Traditional Chinese note package for [Typst](https://typst.app/). The name `bluemagpie` comes from the Taiwan blue magpie (_Urocissa caerulea_), a species endemic to Taiwan.

It provides two show rules. Pick one and it applies every note style, with no other `#show` needed:

```typ
#import "@local/bluemagpie:0.1.0": *

#show: basic-note.with(title: "Notes", authors: "Author") // ordinary notes
#show: large-note.with(title: "Notes", authors: "Author") // long notes with a chapter level above 壹、
```

Both share fonts, inline styles, footnotes, and heading numbering from the [yuhina](https://github.com/zhenhuang-tw/yuhina) package.

> Neither bluemagpie nor yuhina is on Typst Universe yet, so both must be installed as local packages. `install.ps1` creates both junctions in one step; see Installation in the Chinese README.

The template for journal papers (bilingual cover, abstracts, citrus citations, grouped bibliography) lives in [typst-ntulj](https://github.com/zhenhuang-tw/typst-ntulj), which is moving to yuhina as well, so both look the same.

## Requirements, Installation & Usage

The Chinese README, [README-zh.md](README-zh.md), is the full manual.

## Migrating

This package replaces the Git submodule setup of earlier versions (`typst-basic-zh`, then `bluemagpie`). The steps are in the Chinese README. In short:

- Install bluemagpie and yuhina as local packages, and remove the submodule.
- Replace `#import "…/basic-note.typ": *` and `#show: project.with(…)` with `#import "@local/bluemagpie:0.1.0": *` and `#show: basic-note.with(…)`. For `large-note.typ`, use `large-note.with(…)`.
- `bib` accepts only bytes: change `bib: "ref.yml"` to `bib: read("ref.yml", encoding: none)`. A path would resolve against the package directory.
- Replace any direct import of `common.typ` with `@local/yuhina:0.1.0`.
- `academic-paper.typ` and the paper template have moved to [typst-ntulj](https://github.com/zhenhuang-tw/typst-ntulj).

## License

[MIT](LICENSE)

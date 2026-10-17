# Bioinformatik — Module 4: Transcriptomics & biological networks (course workbook)

Static Quarto site for Module 4 of *Bioinformatik: metoder og anvendelse* (NPLB24004U,
University of Copenhagen). **Nothing runs in the browser** — every code block is copied
by students into **RStudio on ERDA**. Plain blocks are R (base R only, no packages);
blocks marked TERMINAL are shell commands for RStudio's Terminal tab (kallisto, curl).
All paths assume one folder, `~/work/module4`; the code downloads every dataset itself.

**Live site:** https://mutwil.github.io/bioinformatik-module4-transcriptomics/

## Contents

One page, built from the module's Colab notebooks (`M4Ø1_4_v2(_answers).ipynb`,
`M4Ø5+miniproject.ipynb`, and the extra database section of `M4Ø1-4.ipynb`), with the
Python rewritten in base R:

- schedule for weeks 43–44 with per-block times, lectures and readings
- **M4Ø1** RStudio/Terminal basics; SRA; kallisto 0.46.1 index + quant on ENA reads; `run_info.json` QC; CESA4 leaf vs. internode
- **M4Ø2** EDA of the E-MTAB-7978 Arabidopsis atlas: log₂ distributions, PCA, distance heatmap, dendrogram, preprocessing
- **M4Ø3** co-expression: toy PCC examples, PsaK neighbourhood, two further genes
- **M4Ø4** UniProt, EBI Expression Atlas, ePlant, plant single-cell atlas (AP3, PsaK)
- **M4Ø5** CESA7 co-expression network → Cytoscape (styling, layouts, Network Analyzer)
- **Mini-project** BioGRID PPIs + LLM-extracted regulation → one typed multi-omic edge table → Cytoscape; online databases; presentation checklist
- appendix: connecting to RStudio on ERDA, files, troubleshooting

Answers are folded under each *Your turn*. Data: EBI Expression Atlas, TAIR10, ENA/SRA,
BioGRID 5.0.250 — all downloaded from the source.

## Build

`quarto render` → `_site/`. GitHub Actions (`.github/workflows/publish.yml`) renders and
deploys to Pages on every push to `main`. No R is needed at render time.

The first version of this site (commit `04bbdb2`) was a Google Colab / Python workbook.

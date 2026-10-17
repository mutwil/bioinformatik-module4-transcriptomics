# Bioinformatik — Module 4: Transcriptomics & biological networks (course workbook)

Static Quarto site for Module 4 of *Bioinformatik: metoder og anvendelse* (NPLB24004U,
University of Copenhagen). **Nothing runs on the page itself** — every Python block is
copied by students into **Google Colab** (free, in the browser, no installation). Lines
starting with `!` are Linux commands that Colab runs in its shell.

**Live site:** https://mutwil.github.io/bioinformatik-module4-transcriptomics/

## Contents

One page, built from the module's Colab notebooks (`M4Ø1_4_v2(_answers).ipynb`,
`M4Ø5+miniproject.ipynb`, and the extra database section of `M4Ø1-4.ipynb`):

- schedule for weeks 43–44 with per-block times, lectures and readings
- **M4Ø1** Colab basics; SRA; kallisto index + quant; `run_info.json` QC; CESA4 leaf vs. internode
- **M4Ø2** EDA of the E-MTAB-7978 Arabidopsis atlas: log₂ distributions, PCA, distance heatmap, dendrogram, preprocessing
- **M4Ø3** co-expression: toy PCC examples, PsaK neighbourhood, two further genes
- **M4Ø4** UniProt, EBI Expression Atlas, ePlant, plant single-cell atlas (AP3, PsaK)
- **M4Ø5** CESA7 co-expression network → Cytoscape (styling, layouts, Network Analyzer)
- **Mini-project** BioGRID PPIs + LLM-extracted regulation → one typed multi-omic edge table → Cytoscape; online databases; presentation checklist
- appendix: working in Colab, common errors

Answers are folded under each *Your turn*. All data are downloaded from the source
(EBI Expression Atlas, TAIR, SRA, BioGRID 5.0.250) inside the student's Colab session.

## Build

`quarto render` → `_site/`. GitHub Actions (`.github/workflows/publish.yml`) renders and
deploys to Pages on every push to `main`. No Python or R is needed at render time.

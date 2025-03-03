# Repository overview
*This project is still in progress.*

## What it is
The project aims at creating a digital edition of the medieval French novel *Li Histoire de Kanor et ses frere* in XML-TEI format, perennial and searchable. It provides a modest, yet comprehensive and accessible version for studying and exploring this fascinating version of the *Roman de Kanor*, the last of the *continuations des Sept Sages de Rome*.

This work is part of a doctoral research project by Florian-Pierre Zanardi (Unige/Lyon-II) and contributes to the FNS project **Camonizing the Seven Sages** (C7S), led by Professors Yasmina Foehr-Janssens (UNIGE) and Simone Ventura (ULB).

This **GitHub repository** brings together all the materials required for this digital edition, as preserved in manuscript BnF fr. 1446. It includes:

* Source files and images
* Bibliographic references
* Detailed guides
* An XML-TEI edition
* One transcription model trained on the fr. 1446

## How it works

**YET TO BE DONE**

The structure of this repository is simple:

| Folder name | Description |
| ----------- |  ---- |
|  |  |
|  |  |
|  |  |
|  |  |

## A few words about ms. BnF fr. 1446

Manuscript BnF fr. 1446 is significant in many respects. It stands out for the richness and originality of the works it contains, some of which can be considered exceptional. Among these is a non-cyclic and composite version of the final continuation of the Cycle of the Seven Sages of Rome, the *Roman de Kanor*. This manuscript is also notable for drafts and sketches attributed to Baudouin Butor, found in the lower margins of folios 70 to 109 and folios 108 to 115. These documents are invaluable for studying the genesis of the *Roman de Perceforest*.
Additionally, the fr. 1446 includes a unique manuscript of the *Couronnement de Renart*, a version of the *Roman de Renart*, as well as one manuscript of Marie de France’s *Fables*. Finally, its second part brings together three originally separate codices containing the poetic works of Baudouin and Jean de Condé.

# Aims and means

The main goal of the digital component of this project is to produce a semi-diplomatic transcription of the *Roman de Kanor*, as preserved in the manuscript [BnF fr. 1446, ff. 1rA-70rB](https://gallica.bnf.fr/ark:/12148/btv1b10023851v).

Ground truths were created using [eScriptorium](https://escriptorium.inria.fr). The online instance was generously provided by Ariane Pinche on the servers of the [Inria](https://inria.fr/). It leverages the Kraken OCR engine. Manuscript layout has been described using **SegmOnto** controlled vocabulary

### Transcription standards

Transcription choices adopted in this project are detailed in a dedicated document. They are based on the recommendations of the CREMMA project and Ariane Pinche’s *Transcription Guidelines for 10th to 15th Century Manuscripts* (2022): [hal-03697382](https://hal.science/hal-03697382/document).  We also tried to our best to follow the guidelines of the [cremma-medieval/HTR-United initiative](https://github.com/HTR-United/cremma-medieval).

###  Editorial choices

Our approach follows a “pseudo-graphematic” method: each allograph is reduced to a standardized form but without preserving the original sequence of letters. We chose to directly segment words to align the transcription with modern conventions and streamline the editing process. We ensured the preservation of the following elements:

* Original spellings of words
* The abbreviation system
* Punctuation marks
* Structure of the text, including word and line segmentation
* Scribal additions and deletions, along with their conditions

These choices aim to balance fidelity to the original manuscript with modern readability. The ALTO output files are available in the 'bnf_fr_1446/ground_truth/xml_alto'

# Outputs
## A golden dataset from ms. 1446

Transcriptions in `bnf_fr_1446/ground_truth/xml_alto` have been checked and controlled. Minor errors are still present the ALTO files. 

## Model trained on the ms. 1446

An initial automatic transcription of folios 1 to 10 from manuscript BnF fr. 1446 was generated using the [Generic CREMMA Model for Medieval Manuscripts (Latin and Old French), 8-15th century](https://zenodo.org/records/7234166#.Y7f69afMJhE), followed by manual corrections on eScriptorium. Based on this data, I trained an initial version of my own model. A second version was subsequently developed using a 40-folio golden data corpus. Ultimately, I created a model tailored to the primary hands of ms. BnF fr. 1446, which could facilitate faster transcription of the entire text.

This model is available in `bnf_fr_1446/model`

## XML-TEI version of the *Histoire de Kanor et ses freres*

A searchable and comprehensive edition has been made available in `xml_tei/jns.47.jns8386.c7s-fro7.xml`

A comprehensive guide to this edition is available in `ODD/ODD-c7s-fro7.pdf`

The edition is available online: [https://kanor-c7s.github.io/index.html](url)

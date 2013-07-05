Here I am creating an [abbreviation JSON][zotero] file for use with Citation
Style Language (CSL) bibliography styles. It covers most journals from the
fields of biology, medicine, ecology, and fisheries.

For example, this could be useful for [Pandoc][] where you can specify the
abbreviation file with:

```
pandoc --citation-abbreviations=csl-abbrev.json --csl=my-journal.csl --bibliography=refs.bib paper.md -o paper.pdf
```

And your file `refs.bib` might contain something like this:


```tex
@article{anderson2011,
  Author = {Sean C Anderson AND Joanna Mills Flemming AND Reg Watson AND Heike K Lotze},
  Journal = {Fish and Fisheries},
  Number = {3},
  Pages = {317--339},
  Title = {Serial exploitation of global sea cucumber fisheries},
  Volume = {12},
  Year = {2011}}
```

Then if your `.csl` file specifies abbreviated journals, your final reference will turn into:

> Anderson, S.C., J. Mills Flemming, R. Watson, H.K. Lotze. Serial
> exploitation of global sea cucumber fisheries. **Fish Fish.**
> 12(3): 317-339.

(Emphasis added to show the abbreviation.)

I gathered the original journal abbreviations from three sources: 

1. A public repository somewhere on the web that I'm trying to relocate (please
   let me know what that might have been if you know)
2. [Ram Myers'][ram] personal BibTeX abbreviation list
3. My own painstaking work over the years

You may find the following files useful:  

- `csl-abbrev.json`: The end goal of this repository -- a CSL JSON
   abbreviation file.
- `make.r`: The quick script I whipped up in R to create the `csl-abbrev.json`
   file.
- `jshort.bib`: A BibTeX abbreviation file with short journal titles.
- `jlong.bib`: A BibTeX abbreviation file with long journal titles.
- `abbrev.csv`: A `.csv` file containing a cleaned up, sorted, and merged
   version of journal titles in short and long format.

Note that I've removed journals with accents. None were journals in my
reference list, so I didn't spend time on this. If you'd like to fork the
repository and write the regular expressions to make this work, please feel
free. (And let me know!)

If you have problems or additions, please contact me at sean "at"
seananderson.ca or file a GitHub issue.

[Pandoc]: http://johnmacfarlane.net/pandoc/index.html
[zotero]: http://citationstylist.org/2011/10/19/abbreviations-for-zotero-test-release/
[ram]: http://en.wikipedia.org/wiki/Ransom_A._Myers


%% 
%% Copyright (C) 2016 by japinli <japinli@hotmail.com>
%% 
%% This file may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either
%% version 1.3 of this license or (at your option) any later
%% version. The latest version of this license is in:
%% 
%%    http://www.latex-project.org/lppl.txt
%% 
%% and version 1.3 or later is part of all distributions of
%% LaTeX version 2005/12/01 or later.
%%

ENTRY
  { address
    author
    booktitle
    chapter
    citedate
    doi
    edition
    editor
    howpublished
    institution
    journal
    key
    lang
    media
    month
    note
    number
    organization
    pages
    publisher
    school
    series
    title
    translator
    type
    url
    volume
    year
  }
  {}
  { label mark }

FUNCTION {bbl.colon}                {": "}
FUNCTION {bbl.comma}                {", "}
FUNCTION {bbl.dash}                 {" -- "}
FUNCTION {bbl.double.slash}         {" //"}
FUNCTION {bbl.period}               {". "}
FUNCTION {bbl.space}                {" "}

STRINGS { s t }
INTEGERS { output.state before.all mid.sentence after.sentence after.block }

FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #4 'after.block :=
}

FUNCTION {new.block}
{ output.state before.all =
    { skip$ }
    { after.block 'output.state := }
  if$
}

FUNCTION {new.sentence}
{ output.state after.block =
    { skip$ }
    { output.state before.all =
	{ skip$ }
	{ after.sentence 'output.state := }
      if$
    }
  if$
}

FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { output.state after.block =
	{ bbl.period * write$
	  newline$
	  "\newblock " write$
	}
	{ output.state before.all =
	    { write$ }
	    { bbl.period * " " * write$ }
	  if$
	}
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}

FUNCTION {output}
{ duplicate$ empty$
    { pop$ }
    { output.nonnull }
  if$
}

FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    { output.nonnull }
  if$
}

FUNCTION {output.bibitem}
{ newline$
  "\bibitem{" write$ cite$ write$ "}" write$
  newline$
  ""
  before.all 'output.state :=
}

FUNCTION {fin.entry}
{ bbl.period * write$
  newline$
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 辅助函数
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FUNCTION {not}                { { #0 } { #1 } if$ }
FUNCTION {and}                { { skip$ } { pop$ #0 } if$ }
FUNCTION {or}                 { { pop$ #1 } { skip$ } if$ }

FUNCTION {is.chinese}
{ lang empty$
    { #0 }
    { lang "zh" = { #1 } { #0 } if$ }
  if$
}

FUNCTION {is.online}
{ url empty$
    { doi empty$ { #0 } { #1 } if$ }
    { #1 }
  if$
}

FUNCTION {is.digit}
{ chr.to.int$
  duplicate$ "0" chr.to.int$ <
    { pop$ #0 }
    { "9" chr.to.int$ > { #0 } { #1 } if$ }
  if$
}

FUNCTION {is.number}
{ duplicate$ empty$ not swap$
  { duplicate$ empty$ not }
  { duplicate$ #1 #1 substring$ is.digit
      { #2 global.max$ substring$ }
      { pop$ pop$ #0 "" }
    if$
  }
  while$
  pop$
}

INTEGERS { i }
FUNCTION {strlen}
{ duplicate$ empty$
    { pop$ #0 }
    { #1 'i :=
      #0
      { not }
      { duplicate$ i #1 substring$
	"" = { #1 } { i #1 + 'i := #0 } if$
      }
      while$
      pop$ i #1 -
    }
  if$
}

FUNCTION {get.last.chr}
{ duplicate$ strlen
  duplicate$ #0 = { pop$ } { #1 substring$ } if$
}

FUNCTION {num.to.ordinal.en}
{ duplicate$ empty$
    { skip$ }
    { duplicate$ get.last.chr
      duplicate$ "1" =
	{ pop$ "st" }
	{ duplicate$ "2" =
	    { pop$ "nd" }
	    { "3" = { "rd" } { "th" } if$ }
	  if$
	}
      if$     
    }
  if$  
}

FUNCTION {remove.dots}
{ 's :=
  ""
  { s empty$ not }
  { s #1 #1 substring$
    s #2 global.max$ substring$ 's :=
    duplicate$ "." = { pop$ } { * } if$
  }
  while$
}


FUNCTION {bbl.anonymous.en}         {"Anon"}
FUNCTION {bbl.anonymous.zh}         {"佚名"}
FUNCTION {bbl.anonymous}
{ is.chinese
    { bbl.anonymous.zh }
    { bbl.anonymous.en }
  if$
}

FUNCTION {bbl.edition.en}           {"~ed"}
FUNCTION {bbl.edition.zh}           {"版"}
FUNCTION {bbl.edition}
{
  is.chinese
    { bbl.edition.zh }
    { bbl.edition.en }
  if$
}

FUNCTION {bbl.etal.en}              {"et al"}
FUNCTION {bbl.etal.zh}              {"等"}
FUNCTION {bbl.etal}
{ is.chinese
    { bbl.etal.zh }
    { bbl.etal.en }
  if$
}

FUNCTION {bbl.no.address.en}        {"[S.l.]"}
FUNCTION {bbl.no.address.zh}        {"[出版地不详]"}
FUNCTION {bbl.no.address}
{ is.chinese
    { bbl.no.address.zh }
    { bbl.no.address.en }
  if$
}

FUNCTION {bbl.no.publisher.en}      {"[s.n.]"}
FUNCTION {bbl.no.publisher.zh}      {"[出版者不详]"}
FUNCTION {bbl.no.publisher}
{ is.chinese
    { bbl.no.publisher.zh }
    { bbl.no.publisher.en }
  if$
}

FUNCTION {bbl.translate.en}         {"~trans"}
FUNCTION {bbl.translate.zh}         {"译"}
FUNCTION {bbl.translate}
{ is.chinese
    { bbl.translate.zh }
    { bbl.translate.en }
  if$
}

FUNCTION {bbl.volume.en}            {"Vol~"}
FUNCTION {bbl.volume.zh}            {"卷"}
FUNCTION {bbl.volume}
{ is.chinese
    { bbl.volume.zh }
    { bbl.volume.en }
  if$
}

FUNCTION {add.brace}                { "{" swap$ * "}" *}
FUNCTION {add.bracket}              { "(" swap$ * ")" *}
FUNCTION {add.squarebracket}        { "[" swap$ * "]" *}

FUNCTION {set.mark}
{ 'mark :=
  is.online
    { mark "/OL" * 'mark := }
    { media empty$ { skip$ } { mark "/" * media * 'mark := } if$ }
  if$
}

FUNCTION {contain.dash}
{ #0 swap$
  { duplicate$ empty$ not }
  { duplicate$ #1 #1 substring$ "-" =
      { pop$ pop$ #1 "" }
      { #2 global.max$ substring$ }
    if$
  }
  while$
  pop$
}

%% TODO: correct it
FUNCTION {extract.before.first.dash}
{ duplicate$ duplicate$ strlen swap$
  duplicate$ empty$
  { not }
  { duplicate$ #1 #1 substring$ "-" =
	  { #1 }
	  { #2 global.max$ substring$
	    duplicate$ empty$
	  }
	if$
  }
  while$
  strlen -
  #1 swap$ substring$
}

FUNCTION {extract.after.last.dash}
{ duplicate$ contain.dash
    { #2 global.max$ substring$
      { duplicate$ contain.dash }
      { #2 global.max$ substring$ }
      while$
    }
    { pop$ "" }
  if$
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 格式化信息输出
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
INTEGERS { nameindex namesleft }

FUNCTION {format.names}
{ 's :=
  #1 'nameindex :=
  s num.names$ 'namesleft :=
  { namesleft #0 > nameindex #4 < and }
  { s nameindex "{jj}{vv~}{ ll{ }}{ f{ }}" format.name$ 't :=
    t "u" change.case$ 't :=
    nameindex #1 >
      { namesleft #1 >
	  { bbl.comma * t * }
	  { t "others" =
	      { bbl.comma * bbl.etal * }
	      { bbl.comma * t * }
	    if$
	  }
	if$
	nameindex #3 = namesleft #1 > and
	  { bbl.comma * bbl.etal * }
	  { skip$ }
	if$
      }
      { t }
    if$
    nameindex #1 + 'nameindex :=
    namesleft #1 - 'namesleft :=
  }
  while$
  remove.dots
}

FUNCTION {format.authors}
{ author empty$
    { "" }
    { author format.names }
  if$
}

FUNCTION {format.editors}
{ editor empty$
    { "" }
    { editor format.names }
  if$
}

FUNCTION {format.mark}   { mark add.squarebracket }

FUNCTION {format.full.title}
{ series empty$
    { volume empty$
	{ title }
	{ title bbl.colon * bbl.volume * volume * }
      if$
    }
    { volume empty$
	{ series bbl.colon * title * }
	{ series bbl.comma * bbl.volume * volume * bbl.colon * title * }
      if$
    }
  if$
}

FUNCTION {format.journal}
{ journal empty$
    { "" }
    { journal }
  if$
}

%% volume(number)
FUNCTION {format.volume.number.pages}
{ volume empty$
    { "" }
    { volume }
  if$
  number empty$
    { "" * }
    { number add.bracket * }
  if$
  pages empty$
    { "" * }
    { bbl.colon * pages * }
  if$
}

FUNCTION {format.translator}
{ translator empty$
    { "" }
    { translator format.names
      translator num.names$ #3 >
	{ bbl.translate * }
	{ bbl.comma * bbl.translate * }
      if$
    }
  if$
}

FUNCTION {format.edition}
{ edition empty$
    { "" }
    { edition duplicate$ is.number
	{ is.chinese
	    { bbl.edition.zh * }
	    { num.to.ordinal.en * bbl.edition.en * }
	  if$
	}
	{ skip$ }
      if$
      "\mbox{" swap$ * "}" *
    }
  if$
}

FUNCTION {format.address}
{ address empty$
    { bbl.no.address }
    { address }
  if$
}

FUNCTION {format.publisher}
{ publisher empty$
    { bbl.no.publisher }
    { publisher }
  if$
}

FUNCTION {format.address.publisher}
{ format.address duplicate$ empty$
    { skip$ }
    { bbl.colon * }
  if$
  format.publisher *
}

FUNCTION {format.year}
{ year empty$ { "" } { year } if$
}

FUNCTION {format.pages}
{ pages empty$
    { "" }
    { bbl.colon pages * }
  if$
}

FUNCTION {format.citedate}
{ citedate empty$
    { "" }
    { citedate add.squarebracket }
  if$
}

FUNCTION {format.year.pages.citedate}
{ format.pages 's :=
  format.citedate 't :=
  year empty$
    { "" }
    { year s empty$
	{ skip$ }
  	{ s * }
      if$
      t empty$
  	{ skip$ }
  	{ t *  }
      if$
    }  
  if$
}

FUNCTION {format.url}
{ url empty$
    { "" }
    { "\url{" url * "}" * }
  if$
}

FUNCTION {format.doi}
{ doi empty$
    { "" }
    { "\doi{" doi * "}" * }
  if$
}

FUNCTION {format.school}
{ school empty$
    { "" }
    { school }
  if$
}

FUNCTION {format.address.school}
{ format.address duplicate$ empty$
    { skip$ }
    { bbl.colon *}
  if$
  format.school *
}

FUNCTION {format.url.or.doi}
{ format.url duplicate$ empty$
    { pop$ format.doi }
    { skip$ }
  if$
}

FUNCTION {format.series.volume.title}
{ series empty$
    { volume empty$
	{ title }
	{ title bbl.colon * bbl.volume * volume * }
      if$
    }
    { volume empty$
	{ series bbl.colon * title * }
	{ series bbl.comma * bbl.volume * volume * bbl.colon * title * }
      if$
    }
  if$
}

FUNCTION {format.series.volume.title.mark}
{ format.series.volume.title
  format.mark *
}
FUNCTION {format.title.mark}
{ title format.mark *
}
FUNCTION {format.full.title.mark}
{ format.full.title format.mark *
}

FUNCTION {format.series.volume.booktitle}
{ series empty$
    { volume empty$
	{ booktitle }
	{ booktitle bbl.colon * bbl.volume * volume * }
      if$
    }
    { volume empty$
	{ series bbl.colon * booktitle * }
	{ series bbl.comma * bbl.volume * volume *
	  bbl.colon * booktitle *
	}
      if$
    }
  if$
}

FUNCTION {format.inbook.title}
{ format.title.mark bbl.double.slash *
  format.translator duplicate$ empty$
    { pop$ }
    { * bbl.period * }
  if$
  format.editors *
}

FUNCTION {get.journal.first.year.vol.num}
{ year extract.before.first.dash
  volume empty$
    { skip$ }
    { bbl.comma *
      volume extract.before.first.dash *      
    }
  if$
  number empty$
    { skip$ }
    { number extract.before.first.dash
      add.bracket *
    }
  if$
}

FUNCTION {get.journal.last.year.vol.num}
{ year extract.after.last.dash duplicate$ empty$
    { skip$ }
    { bbl.dash swap$ * }
  if$
  volume empty$
    { skip$ }
    { bbl.comma *
      volume extract.after.last.dash *
    }
  if$
  number empty$
    { skip$ }
    { number extract.after.last.dash
      add.bracket *
    }
  if$
}

FUNCTION {format.journal.year.vol.num}
{ get.journal.first.year.vol.num
  year contain.dash
    { get.journal.last.year.vol.num * }
    { skip$ }
  if$

}

FUNCTION {format.year.range}
{ year contain.dash
    { year extract.before.first.dash
      bbl.dash *
      year extract.after.last.dash *
    }
    { year }
  if$
}

FUNCTION {format.techreport.title.mark}
{ title title empty$
    { "techreport title is empty" warning$ }
    { number empty$
	{ skip$ }
	{ bbl.colon *
	  number *
	}
      if$
      mark add.squarebracket *
    }
  if$
}

FUNCTION {format.address.institution}
{ address empty$
    { bbl.no.address }
    { address }
  if$
  bbl.colon *
  institution empty$
    { bbl.no.publisher * }
    { institution * }
  if$
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 参考文献类型辅助函数定义
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FUNCTION {book.core}
{ output.bibitem
  author empty$
    { format.editors "author and editor" output.check }
    { format.authors  output.nonnull }
  if$
  new.block
  format.series.volume.title.mark "title" output.check
  new.block
  format.translator output
  new.block
  format.edition output
  new.block
  publisher empty$
    { skip$ }
    { format.address.publisher
      "address and publisher" output.check
    }
  if$
  format.year.pages.citedate "year" output.check
  new.block
  format.url.or.doi output
  fin.entry
}

FUNCTION {inbook.core}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.inbook.title "title" output.check
  new.block
  format.series.volume.booktitle "booktitle" output.check
  new.block
  format.edition output
  publisher empty$
    { skip$ }
    { format.address.publisher
      "address and publisher" output.check
    }
  if$
  format.year.pages.citedate "year" output.check
  new.block
  format.url.or.doi output
  fin.entry
}

FUNCTION {thesis.core}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title.mark "title" output.check
  new.block
  format.address.school "address and school" output.check
  format.year.pages.citedate "year" output.check
  new.block
  format.url.or.doi output
  fin.entry
}

FUNCTION {journal.core}
{ output.bibitem
  format.editors "editor" output.check
  new.block
  format.title.mark "title" output.check
  new.block
  format.journal.year.vol.num "year" output.check
  new.block
  publisher empty$
    { skip$ }
    { format.address.publisher
      "address and publisher" output.check
    }
  if$
  format.year.range "year" output.check
  new.block
  format.url.or.doi output
  fin.entry
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 参考文献类型函数定义
%%
%% 该处的函数由 call.type$ 在 ITERATE 中循环调用
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FUNCTION {article}
{ "J" set.mark
  output.bibitem  
  format.authors "author" output.check
  new.block
  format.title.mark "title" output.check
  new.block
  format.journal "journal" output.check
  format.year "year" output.check
  format.volume.number.pages output
  new.block
  format.url.or.doi output
  fin.entry
}

FUNCTION {book}
{ "M" set.mark
  book.core
}

FUNCTION {collection}
{ "G" set.mark
  book.core
}

FUNCTION {inbook}
{ "M" set.mark
  inbook.core
}

FUNCTION {incollection}
{ "G" set.mark
  inbook.core
}

FUNCTION {inproceedings}
{ "C" set.mark
  inbook.core
}

FUNCTION {proceedings}
{ "C" set.mark
  output.bibitem
  format.editors "editor" output.check
  new.block
  format.series.volume.title.mark "title" output.check
  new.block
  format.translator output
  new.block
  format.edition output
  new.block
  publisher empty$
    { skip$ }
    { format.address.publisher
      "address and publisher" output.check
    }
  if$
  format.year.pages.citedate "year" output.check
  new.block
  format.url.or.doi output  
  fin.entry
}

FUNCTION {conference}
{ proceedings }

FUNCTION {mastersthesis}
{ "D" set.mark
  thesis.core
}

FUNCTION {phdthesis}
{ "D" set.mark
  thesis.core
}

FUNCTION {periodical}
{ "J" set.mark
  journal.core
}

FUNCTION {techreport}
{ "R" set.mark
  output.bibitem
  format.authors "author" output.check
  new.block
  format.techreport.title.mark "title" output.check
  new.block
  format.address.institution output
  format.year.pages.citedate output
  new.block
  format.url.or.doi output
  fin.entry
}

FUNCTION {standard}
{ "S" set.mark
  output.bibitem
  format.authors "authors" output.check
  new.block
  format.title.mark "title" output.check
  new.block
  format.translator output
  new.block
  format.edition output
  new.block
  publisher empty$
    { skip$ }    
    { format.address.publisher output }
  if$  
  format.year.pages.citedate "year" output.check
  new.block
  format.url.or.doi output
  fin.entry
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 文献管理的基本框架
%%
%% READ 读取参考文献数据库(*.bib)
%% call.type$ 针对每种类型的参考文献进行处理，需要定义对应的函数
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

STRINGS { longest.label }
INTEGERS { number.label longest.label.width }

FUNCTION {init.longest.label}
{ "" 'longest.label :=
  #1 'number.label :=
  #0 'longest.label.width :=
}

FUNCTION {longest.label.pass}
{ number.label int.to.str$ 'label :=
  number.label #1 + 'number.label :=
  label width$ longest.label.width >
    { label 'longest.label :=
      label width$ 'longest.label.width :=
    }
    { skip$ }
  if$
}

FUNCTION {begin.bib}
{ preamble$ empty$
    { skip$ }
    { preamble$ write$ newline$ }
  if$
  "\begin{thebibliography}{" longest.label * "}" *
  write$ newline$
}

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

READ

EXECUTE {init.longest.label}

ITERATE {longest.label.pass}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

EXECUTE {end.bib}
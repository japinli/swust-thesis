ENTRY
  { address
    author
    booktitle
    chapter
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

STRINGS { s t }

FUNCTION {output.nonnull}
{ write$
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
}

FUNCTION {fin.entry}
{ newline$
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

FUNCTION {bbl.colon}                {":"}
FUNCTION {bbl.comma}                {","}
FUNCTION {bbl.dash}                 {"--"}
FUNCTION {bbl.double.slash}         {" //"}
FUNCTION {bbl.period}               {". "}
FUNCTION {bbl.space}                {" "}

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 格式化信息输出
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
INTEGERS { nameindex namesleft }

FUNCTION {format.names}
{ 's :=
  #1 'nameindex :=
  s num.names$ 'namesleft :=
  { namesleft #0 > nameindex #4 < and }
  { s nameindex "{vv~}{ ll{ }}{ f{ }}{, jj}" format.name$ 't :=
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

FUNCTION {format.mark}   { mark add.squarebracket }

FUNCTION {format.translator}
{ translator empty$
    { "" }
    { translator format.names
      translator num.names$ #3 >
	{ bbl.translate * }
	{ bbl.comma * bbl.translate * }
      if$
      bbl.period *
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
      "\mbox{" swap$ * "}" * bbl.period *
    }
  if$
}

FUNCTION {format.address}
{ address empty$
    { bbl.period bbl.no.address * }
    { bbl.period address * }
  if$
}

FUNCTION {format.publisher}
{ publisher empty$
    { bbl.colon bbl.no.publisher * }
    { bbl.colon publisher * }
  if$
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 参考文献类型函数定义
%%
%% 该处的函数由 call.type$ 在 ITERATE 中循环调用
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FUNCTION {book}
{ output.bibitem
  author empty$
    { format.editors bbl.period * "author and editor" output.check }
    { format.authors bbl.period * output }
  if$
  newline$ "\newblock "
  format.full.title * "title" output.check
  "M" set.mark format.mark "mark" output.check bbl.period output
  format.translator output
  format.edition output
  publisher empty$
    { skip$ }
    { format.address "address" output.check
      format.publisher "publisher" output.check
    }
  if$
  
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

ITERATE {call.type$}

EXECUTE {end.bib}
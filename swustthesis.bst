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
{ write$ newline$
}

FUNCTION {output}
{ duplicate$ empty$
    { skip$ }
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

FUNCTION {bbl.comma}                {","}
FUNCTION {bbl.colon}                {":"}
FUNCTION {bbl.etal.en}              {", et al"}
FUNCTION {bbl.etal.zh}              {"等"}
FUNCTION {bbl.etal}
{ is.chinese
    { bbl.etal.zh }
    { bbl.etal.en }
  if$
}

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 参考文献类型函数定义
%%
%% 该处的函数由 call.type$ 在 ITERATE 中循环调用
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FUNCTION {book}
{ output.bibitem
  format.authors add.period$ "author" output.check
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
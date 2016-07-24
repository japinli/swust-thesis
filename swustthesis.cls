\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{swustthesis}[2016/06/11 v0.0.1 SWUST thesis template]

\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=swust@opt,prefix=swust@opt@,setkeys=\kvsetkeys}
\DeclareBoolOption[false]{doctor}
\DeclareBoolOption[false]{master}
\DeclareBoolOption[false]{bachelor}

\SetupKeyvalOptions{family=swust@page,prefix=swust@page@,setkeys=\kvsetkeys}
\DeclareBoolOption[false]{oneside}
\DeclareBoolOption[false]{openany}
\DeclareComplementaryOption{twoside}{oneside}
\DeclareComplementaryOption{openright}{openany}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexbook}}

\ProcessKeyvalOptions{swust@opt}

% TODO: Add English thesis name.
\ifswust@opt@bachelor
	\newcommand{\swust@thesis@name}{西南科技大学博士论文}
        \swust@opt@bachelortrue
\else
	\ifswust@opt@master
		\newcommand{\swust@thesis@name}{西南科技大学硕士论文}
                \swust@opt@mastertrue
        \else
        	\newcommand{\swust@thesis@name}{西南科技大学本科生毕业论文}
                \swust@opt@doctortrue
                \swust@page@onesidetrue
        \fi
\fi

\ifswust@page@openany
	\PassOptionsToClass{openany}{ctexbook}
\fi

\ifswust@page@oneside
	\PassOptionsToClass{oneside}{ctexbook}
\fi

\LoadClass[a4paper, UTF8, zihao=-4]{ctexbook}

\def\swust@define@term#1{
  \expandafter\gdef\csname #1\endcsname##1{
    \expandafter\gdef\csname swust@#1\endcsname{##1}
  }
  \csname #1\endcsname{}
}

\swust@define@term{title}
\swust@define@term{author}
\swust@define@term{date}
\swust@define@term{studentid}

\setmainfont{Times New Roman}
\setsansfont{Arial}
\setmonofont{Courier New}

\newCJKfontfamily{\hwxk}{STXingkai}

\RequirePackage{hyperref}
\hypersetup{
  CJKbookmarks=true,
  bookmarksopen=true,
  bookmarksnumbered=true,
  bookmarksopenlevel=1,
  pdfborder=0 0 0,
  unicode=true,
  linktoc=all,
  allcolors=black,
  colorlinks=true,
}

\RequirePackage{geometry}
\ifswust@opt@doctor
	\geometry{
	  paper=a4paper,
          top=3.0cm,bottom=3.0cm,
          left=3.0cm,right=2.5cm,
          headheight=2.0cm,footskip=1.0cm,
	}
\else
	\geometry{
	  paper=a4paper,
          paperwidth=21.0cm,paperheight=29.7cm,
          top=3.0cm,bottom=2.5cm,
          left=2.6cm,right=2.6cm,
          bindingoffset=0.0cm,
          headheight=2.0cm,footskip=0.75cm,
        }
\fi


\RequirePackage[pagestyles]{titlesec}

\newcommand{\swust@header}{\swust@thesis@name}
\newcommand{\swust@header@size}{\zihao{5}}
\ifswust@opt@doctor
	\newcommand{\swust@header@font}{\hwxk}
\else
        \newcommand{\swust@header@font}{\songti}
\fi

\newpagestyle{front}[\swust@header@size\swust@header@font]{
  \ifswust@opt@doctor
  	\sethead{}{\swust@header}{\thepage}
  	\renewcommand{\makeheadrule}{
  	  \makebox[0pt][l]{\rule[-.3\baselineskip]{\linewidth}{.5pt}}
  	  \rule[-.5\baselineskip]{\linewidth}{2pt}
  	}
  \else
        \sethead[][\swust@header][]{}{\chaptertitle}{}
        \setfoot[\thepage][][]{}{}{\thepage}
  	\renewcommand{\makeheadrule}{
  	  \makebox[0pt][l]{\rule[-.3\baselineskip]{\linewidth}{.5pt}}
  	  \rule[-.4\baselineskip]{\linewidth}{.5pt}
  	}        
        \setfootrule{.5pt}
  \fi
}

\newpagestyle{main}[\swust@header@size\swust@header@font]{
  \ifswust@opt@doctor  	
  	\sethead{}{\swust@header}{}
  	\setfoot{}{\thepage}{}
  	\renewcommand{\makeheadrule}{
  	  \makebox[0pt][l]{\rule[-.3\baselineskip]{\linewidth}{.5pt}}
  	  \rule[-.5\baselineskip]{\linewidth}{2pt}
  	}
  \else  	
        \sethead[][\swust@header][]{}{\chaptertitle}{}
        \setfoot[\thepage][][]{}{}{\thepage}
        \renewcommand{\makeheadrule}{
  	  \makebox[0pt][l]{\rule[-.3\baselineskip]{\linewidth}{.5pt}}
  	  \rule[-.4\baselineskip]{\linewidth}{.5pt}
  	}
        \setfootrule{.5pt}
  \fi
}

\renewcommand{\frontmatter}{
  \if@openright\cleardoublepage\else\clearpage\fi
  \@mainmatterfalse
  \pagenumbering{Roman}
  \pagestyle{front}
}

\renewcommand{\mainmatter}{
  \if@openright\cleardoublepage\else\clearpage\fi
  \@mainmattertrue
  \pagenumbering{arabic}
  \pagestyle{main}
}

\renewcommand{\chapter}{
  \if@openright\cleardoublepage\else\clearpage\fi
  \global\@topnum\z@
  \@afterindenttrue
  \secdef\@chapter\@schapter
}
\ifswust@opt@doctor
\ctexset{
  chapter       = {
    name        = {第,章},
    number      = \thechapter,
    format      = \centering\zihao{-2}\heiti,
    beforeskip  = 2ex,
    afterskip   = 1ex,
  },
  section       = {
    format      = \raggedright\zihao{4}\heiti,
    beforeskip  = 1ex,
    afterskip   = .5ex,
  },
  subsection    = {
    format      = \raggedright\zihao{-4}\songti,
    beforeskip  = .5ex,
    afterskip   = 0ex,
  },
  subsubsection = {
    format      = \raggedright\zihao{-4}\songti,
    beforeskip  = 0ex,
    afterskip   = 0ex,
  },
}
\else

\ctexset{
  chapter       = {
    name        = {},
    number      = \thechapter,
    format      = \centering\zihao{3},
    beforeskip  = 2ex,
    afterskip   = 1ex,
  },
  section       = {
    format      = \raggedright\zihao{-3},
    beforeskip  = 1ex,
    afterskip   = .5ex,
  },
  subsection    = {
    format      = \raggedright\zihao{4},
    beforeskip  = .5ex,
    afterskip   = 0ex,
  },
  subsubsection = {
    format      = \raggedright\zihao{-4},
    beforeskip  = 0ex,
    afterskip   = 0ex,
  },
}
\fi

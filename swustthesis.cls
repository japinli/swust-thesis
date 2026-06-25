%%
%% This is file `swustthesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% swustthesis.dtx  (with options: `class')
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
\NeedsTeXFormat{LaTeX2e}[2005/12/01]
\ProvidesClass{swustthesis}
    [2016/08/21 v0.0.2 SWUST Thesis Template]
\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=swust@opt,prefix=swust@opt@,setkeys=\kvsetkeys}
\DeclareBoolOption[false]{bachelor}
\DeclareBoolOption[false]{master}
\DeclareBoolOption[false]{doctor}
\DeclareBoolOption[false]{pdf}
\DeclareComplementaryOption{print}{pdf}
\SetupKeyvalOptions{family=swust@pae,prefix=swust@page@,setkeys=\kvsetkeys}
\DeclareBoolOption[false]{oneside}
\DeclareComplementaryOption{twoside}{oneside}
\DeclareBoolOption[false]{openany}
\DeclareComplementaryOption{openright}{openany}
\DeclareBoolOption[true]{pageouter}
\DeclareComplementaryOption{pagecenter}{pageouter}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexbook}}
%\PassOptionsToPackage{super,square,sort&compress}{natbib}
\ProcessKeyvalOptions{swust@opt}
\ifswust@opt@master\relax\else
  \ifswust@opt@doctor\relax\else
    \swust@opt@bachelortrue
  \fi
\fi
\ifswust@opt@bachelor
    \swust@page@onesidetrue
    \swust@page@pageouterfalse
\fi
\ifswust@opt@pdf
    \swust@page@onesidetrue
    \swust@page@pageouterfalse
\fi
\ifswust@page@openany
    \PassOptionsToClass{openany}{ctexbook}
\fi
\ifswust@page@oneside
    \PassOptionsToClass{oneside}{ctexbook}
\fi
\LoadClass[a4paper,UTF8,zihao=-4,punct=quanjiao,space=auto]{ctexbook}
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
  pdfborder= 0 0 0,
  unicode=true,
  linktoc=all,
  allcolors=black,
  colorlinks=true,
}
\newcommand{\zhspace}[1][1]{\hspace{#1\ccwd}}
\newcommand{\swust@underline}[2][6em]{
  \hskip1pt\underline{\hb@xt@ #1{\hss#2\hss}}\hskip3pt\relax
}
\def\swust@define@term#1{
  \expandafter\gdef\csname #1\endcsname##1{
    \expandafter\gdef\csname swust@#1\endcsname{##1}
  }
  \csname #1\endcsname{}
}
\swust@define@term{zhtitle}                  % 中文论文标题
\swust@define@term{entitle}                  % 英文论文标题
\swust@define@term{zhdegree}                 % 中文学位类型
\swust@define@term{endegree}                 % 英文学位类型
\swust@define@term{zhauthor}                 % 作者中文姓名
\swust@define@term{enauthor}                 % 作者英文姓名
\swust@define@term{zhadvisor}                % 指导教师中文姓名
\swust@define@term{enadvisor}                % 指导教师英文姓名
\swust@define@term{zhextadvisor}             % 校外指导教师中文姓名
\swust@define@term{enextadvisor}             % 校外指导教师英文姓名
\swust@define@term{zhacademy}                % 学院中文名
\swust@define@term{enacademy}                % 学院英文名
\swust@define@term{zhmajor}                  % 专业中文名
\swust@define@term{enmajor}                  % 专业英文名
\swust@define@term{zhdate}                   % 中文答辩日期
\swust@define@term{endate}                   % 英文答辩日期
\swust@define@term{stuid}                    % 学生学号
\swust@define@term{classified}               % 分类号
\swust@define@term{udc}                      % UDC编号
\swust@define@term{secret}                   % 密级
\RequirePackage{geometry}
\ifswust@opt@bachelor
  \geometry{
    paper=a4paper,
    paperwidth=21.0cm,paperheight=29.7cm,
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
    headheight=2.0cm,footskip=1.25cm,
  }
\fi
\RequirePackage[pagestyles]{titlesec}
\ifswust@opt@doctor
  \newcommand{\swust@zh@thesis@name}{西南科技大学博士学位论文}
  \newcommand{\swust@en@thesis@name}{A Dissertation of Southwest
    University of Science and Technology for the Degree of Master}
\else
  \ifswust@opt@master
    \newcommand{\swust@zh@thesis@name}{西南科技大学硕士学位论文}
    \newcommand{\swust@en@thesis@name}{A Dissertation of Southwest
      University of Science and Technology for the Degree of Master}
  \else
    \newcommand{\swust@zh@thesis@name}{西南科技大学本科毕业论文}
    \newcommand{\swust@en@thesis@name}{A Thesis Submitted to Southwest University
        of Scienceand Technology for the Degree of Bachelor}
  \fi
\fi
\newcommand{\swust@header@title}{\swust@zh@thesis@name}
\newcommand{\swust@header@size}{\zihao{5}}
\ifswust@opt@bachelor
  \newcommand{\swust@header@font}{\hwxk}
\else
  \newcommand{\swust@header@font}{\songti}
\fi
\newpagestyle{front}[\swust@header@size\swust@header@font]{
  \ifswust@opt@bachelor
    \sethead{}{\swust@header@title}{\thepage}
    \renewcommand{\makeheadrule}{
      \makebox[0pt][l]{\rule[-.3\baselineskip]{\linewidth}{.5pt}}
      \rule[-.5\baselineskip]{\linewidth}{2pt}
    }
  \else
    \sethead[][\swust@header@title][]{}{\chaptertitle}{}
    \setfoot[][\thepage][]{}{\thepage}{}
    \renewcommand{\makeheadrule}{
      \makebox[0pt][l]{\rule[-.3\baselineskip]{\linewidth}{.5pt}}
      \rule[-.4\baselineskip]{\linewidth}{.5pt}
    }
    \renewcommand{\makefootrule}{%
      \hfil % 在线条左侧插入弹性间距
      \rule[.7\baselineskip]{.25\linewidth}{.5pt}%
      \hfil % 在线条右侧插入弹性间距
    }
  \fi
}
\newpagestyle{main}[\swust@header@size\swust@header@font]{
  \ifswust@opt@bachelor
    \sethead{}{\swust@header@title}{}
    \setfoot{}{\thepage}{}
    \renewcommand{\makeheadrule}{
      \makebox[0pt][l]{\rule[-.3\baselineskip]{\linewidth}{.5pt}}
      \rule[-.5\baselineskip]{\linewidth}{2pt}
    }
  \else
    \sethead[][\swust@header@title][]{}{\chaptertitle}{}
    \setfoot[][\thepage][]{}{\thepage}{}
    \renewcommand{\makeheadrule}{
      \makebox[0pt][l]{\rule[-.3\baselineskip]{\linewidth}{.5pt}}
      \rule[-.4\baselineskip]{\linewidth}{.5pt}
    }
    \renewcommand{\makefootrule}{%
      \hfil % 在线条左侧插入弹性间距
      \rule[.7\baselineskip]{.25\linewidth}{.5pt}%
      \hfil % 在线条右侧插入弹性间距
    }
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
\setcounter{secnumdepth}{4}
\ifswust@opt@bachelor
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
      format      = \bfseries\songti\zihao{3}\centering,
      fixskip     = true,
      beforeskip  = 2\normalbaselineskip,
      aftername   = \quad,
      afterskip   = 1\normalbaselineskip,
    },
    section       = {
      format      = \songti\zihao{-3}\raggedright,
      indent      = 0pt, % 明确顶格
      fixskip     = true,
      beforeskip  = 1\normalbaselineskip,
      aftername   = \quad,
      afterskip   = 0.5\normalbaselineskip,
    },
    subsection    = {
      format      = \songti\zihao{4}\raggedright,
      fixskip     = true,
      beforeskip  = 1\normalbaselineskip,
      aftername   = \quad,
      afterskip   = 0\normalbaselineskip,
    },
    subsubsection = {
      format      = \songti\zihao{-4}\raggedright,
      fixskip     = true,
      beforeskip  = 0ex,
      aftername   = \quad,
      afterskip   = 0ex,
    },
  }
\fi
\newcommand{\swust@pdf@contentsname}{目录}
\let\swust@save@tableofcontents=\tableofcontents
\renewcommand{\tableofcontents}{
  \if@openright\cleardoublepage\else\clearpage\fi
  \pdfbookmark[0]{\swust@pdf@contentsname}{swusttoc}
  \swust@save@tableofcontents
}
\renewcommand{\contentsname}{目\zhspace 录}
\RequirePackage{titletoc}
\newcommand{\swust@toc@leaders}{\titlerule*[.5pc]{$\cdot$}}
\newcommand{\swust@chap@font}{\heiti}
\newcommand{\swust@chap@size}{\zihao{-4}}
\newcommand{\swust@sect@font}{\songti}
\newcommand{\swust@sect@size}{\zihao{-4}}
\newcommand{\swust@subs@font}{\songti}
\newcommand{\swust@subs@size}{\zihao{-4}}
\newcommand{\swust@chap@toc@indent}{0bp}
\newcommand{\swust@sect@toc@indent}{2\ccwd}
\newcommand{\swust@subs@toc@indent}{4\ccwd}
\titlecontents{chapter}
              [\swust@chap@toc@indent]
              {\swust@chap@size\swust@chap@font}
              {\thecontentslabel\hspace*{.5em}}
              {}{\swust@toc@leaders\contentspage}
\titlecontents{section}
              [\swust@sect@toc@indent]
              {\swust@sect@size\swust@sect@font}
              {\thecontentslabel\hspace*{.5em}}
              {}{\swust@toc@leaders\contentspage}
\titlecontents{subsection}
              [\swust@subs@toc@indent]
              {\swust@subs@size\swust@subs@font}
              {\thecontentslabel\hspace*{.5em}}
              {}{\swust@toc@leaders\contentspage}
\newcommand{\swust@declare@text}{
  本人郑重声明：所呈交的学位论文是我个人在导师的指导下进行的研究工作及取
  得的研究成果。尽我所知，除了文中特别加以标注和致谢的地方外，论文中不包含其
  他人已经发表或撰写过的研究成功。与我一同工作的同志对本研究所做的任何贡献均
  已在论文中坐了明确的说明，并表示了感谢。本人依法享有和承担由此论文所产生的
  权利和责任。
}
\newcommand{\swust@warranty@text}{
  本学位论文作者完全了解学校有关保存、使用学位论文的规定，即：研究生在西
  南科技大学学习和工作期间论文工作的知识产权单位属于西南科技大学。同意授权西
  南科技大学保留并向国家有关部门或机构送交该论文的印刷本和电子版本，允许该论
  文被查阅和借阅。同意授权西南科技大学可以将本学位论文的全部或部分内容编入有
  关数据库进行检索，可以采用影印、缩印、扫描或数字化等其他复制手段保存和汇编
  本学位论文。保密论文在解密后遵守此规定。
}
\newcommand{\swust@make@statement}{
  \pdfbookmark[0]{声明}{statement}
  \vspace*{.5cm}
  \begin{center}
    \heiti\zihao{-2}\textbf{学位论文独创性声明}
  \end{center}
  \vskip .5cm
  \par\swust@declare@text
  \begin{flushright}
  \vskip .5cm
  论文作者签名：\makebox[5em]{}
  日期：\makebox[3em]{}年\makebox[2em]{}月\makebox[2em]{}日
  \end{flushright}
  \vskip .5cm
  \begin{center}
    \heiti\zihao{-2}\textbf{学位论文版权使用授权声明}
  \end{center}
  \vskip .5cm
  \par\swust@warranty@text
  \begin{flushright}
  \vskip .5cm
  论文作者签名：\makebox[5em]{}
  日期：\makebox[3em]{}年\makebox[2em]{}月\makebox[2em]{}日
  \vskip .5cm
  指导教师签名：\makebox[5em]{}
  日期：\makebox[3em]{}年\makebox[2em]{}月\makebox[2em]{}日
  \end{flushright}
}
\renewcommand{\maketitle}{
  \newgeometry{
    top=3cm,bottom=3cm,
    left=3cm,right=2.5cm,
    headheight=2cm, footskip=.5cm,
  }
  \pagestyle{empty}
  \pdfbookmark[0]{封面}{titlepage}
  \swust@maketitle
  \restoregeometry
}
\newcommand{\swust@zh@titlepage}{
  \begin{titlepage}
    \vspace*{1cm}
    \centering
    \songti\zihao{4}
    \begin{tabular}{rp{7cm}rl}
      分类号： & \swust@classified & 学校代码：& 10619         \\
         UDC： & \swust@udc        &     密级：& \swust@secret \\
    \end{tabular}
    \vskip 2cm
    \zihao{-2}\textbf{\swust@zh@thesis@name}
    \vskip .5cm
    \zihao{4}\songti\swust@zhdegree
    \vskip 2cm
    \zihao{2}\heiti\swust@zhtitle
    \vskip 2cm
    \zihao{3}\songti\swust@zhauthor
    \vskip 4cm
    \zihao{4}\songti
    \begin{tabular}{ll}
      \makebox[12em][s]{学科（专业）或领域名称：} & \swust@zhmajor      \\
      \makebox[12em][s]{指导教师姓名、职称：}     & \swust@zhadvisor    \\
      \makebox[12em][s]{校外指导教师姓名、职称：} & \swust@zhextadvisor \\
      \makebox[12em][s]{学生所属学院：}           & \swust@zhacademy    \\
      \makebox[12em][s]{论文答辩日期：}           & \swust@zhdate       \\
    \end{tabular}
  \end{titlepage}
}
\newcommand{\swust@en@titlepage}{
  \begin{titlepage}
    \vspace*{1cm}
    \centering
    \zihao{3}\swust@en@thesis@name
    \vskip .5cm
    \zihao{-4}\swust@endegree
    \vskip 2cm
    \zihao{-2}\swust@entitle
    \vskip 5cm
    \zihao{-3}
    \begin{tabular}{ll}
      Candidate: &  \swust@enauthor  \\
      Supervisor: & \swust@enadvisor \\
    \end{tabular}
    \vskip 6cm
    \zihao{-4}
    \swust@endate
  \end{titlepage}
}
\ifswust@opt@bachelor
  \newcommand{\swust@maketitle}{
    \begin{titlepage}
      \vspace*{1cm}
      \begin{minipage}{3cm}
        \includegraphics[width=3cm]{figures/swust_logo_fig}
      \end{minipage}
      \begin{minipage}{4cm}
        \begin{tabular}{c}
          \includegraphics[width=9cm]{figures/swust_logo_text}    \\
          \zihao{3}Southwest University of Science and Technology \\
        \end{tabular}
      \end{minipage}

      \centering
      \vspace{2cm}
      \heiti\zihao{-0}{本科毕业设计（论文）} \\
      \vspace{3cm}
      \zihao{2}\swust@zhtitle\\
      \vspace{3cm}
      \zihao{-3}
      \begin{tabular}{cc}
        \makebox[4em][s]{学院名称} & \swust@underline[16em]{\swust@zhacademy}  \\
        \makebox[4em][s]{专业名称} & \swust@underline[16em]{\swust@zhmajor}    \\
        \makebox[4em][s]{学生姓名} & \swust@underline[16em]{\swust@zhauthor}   \\
        \makebox[4em][s]{学号}     & \swust@underline[16em]{\swust@stuid}      \\
        \makebox[4em][s]{指导教师} & \swust@underline[16em]{\swust@zhadvisor}  \\
      \end{tabular}\\
      \vspace{3cm}
      \swust@zhdate
    \end{titlepage}
  }
\else
  \newcommand{\swust@maketitle}{
    \begin{titlepage}
      \vspace*{2cm}
      \centering
      \zihao{-2}\textbf{\swust@zh@thesis@name}
      \vskip .5cm
      \songti\zihao{-4}\swust@zhdegree
      \vskip 3cm
      \heiti\zihao{2}\swust@zhtitle
      \vskip 4cm
      \songti\zihao{3}\swust@zhauthor
      \vskip 0cm
      \swust@stuid
      \vskip 7cm
      \zihao{-4}\swust@zhdate
    \end{titlepage}
    \swust@zh@titlepage\clearpage
    \swust@en@titlepage\clearpage
    \swust@make@statement\clearpage
  }
\fi
\ifswust@opt@bachelor
  \newenvironment{zhabstract}{
    \begin{center}
      \vspace*{2ex}
      \pdfbookmark[0]{摘要}{zhabstract}
      \zihao{-1}\heiti\swust@zhtitle
      \vspace{1ex}
    \end{center}

    {
      \noindent\zihao{-4}\heiti 摘要：
    }
  }{}
\else
  \newenvironment{zhabstract}{
    \chapter[摘要]{摘\zhspace 要}
    \vspace*{3ex}
  }{}
\fi
\ifswust@opt@bachelor
  \newenvironment{enabstract}{
    \newpage
    \begin{center}
      \vspace*{2ex}
      \pdfbookmark[0]{Abstract}{enabstract}
      \zihao{-1}\textbf{\swust@entitle}
      \vspace{1ex}
    \end{center}

    \noindent\zihao{-4}\textbf{Abstract: }
  }{}
\else
  \newenvironment{enabstract}{
    \chapter[Abstract]{ABSTRACT}
    \vspace*{3ex}
    \setlength{\parindent}{0pt}
    \ignorespaces
  }{
    \ignorespacesafterend
  }
\fi
\ifswust@opt@bachelor
  \newcommand{\zhkeywords}[2][\zihao{-4}]{
    \par\phantom{关键词}\par\noindent
    {
      #1{\heiti 关键词: }#2
    }
  }
\else
  \newcommand{\zhkeywords}[2][\zihao{5}]{
    {
      \par\noindent \\
      \noindent #1\textbf{关键词：#2}
    }
  }
\fi
\ifswust@opt@bachelor
  \newcommand{\enkeywords}[2][\zihao{-4}]{
    \par\phantom{keywords}\par\noindent
    {
      #1\textbf{Key words: }#2
    }
  }
\else
  \newcommand{\enkeywords}[2][\zihao{5}]{
    {
      \par\noindent \\
      \noindent #1\textbf{KEY WORDS: #2}
    }
  }
\fi

\ifswust@opt@bachelor
\else
  \newcommand{\entypedisseration}[2][\zihao{5}]{
    {
      \noindent \\
      \noindent #1\textbf{TYPE OF DISSERTATION: #2}

      \noindent
      a. Theoretical Research; b. Application Fundamentals;
      c. Application Research; d. Research Report;
      e. Design Report; f. Case Study; g. Investigation Report;
      h. Product Development; i. Engineering Design;
      j. Engineering/Project Management; k. Others
    }
  }
  \newcommand{\zhtypedisseration}[2][\zihao{5}]{
    {
      \noindent\\
      \noindent #1\textbf{论文类型：XXXXX(下列类型十选一)}

      \noindent
      a.理论研究；b.应用基础；c.应用研究；d.研究报告；e.设计报告；
      f.案例分析；g.调研报告；h.产品研发；i.工程设计；j.工程/项目管理；
      k.其他
    }
  }
\fi

\RequirePackage{ccaption}
\RequirePackage{subcaption}
\DeclareCaptionFont{mycaptionfont}{\zihao{5}\songti}
\captionsetup{
  textfont      = mycaptionfont, % 将标题文本设置为 'mycaptionfont' 的样式
  labelfont     = mycaptionfont, % 将“图/表”标签也设置为相同样式（可选）
  justification = centering,     % 居中
  labelsep      = space,         % 分隔符
  skip          = 0.5\baselineskip,
}

\captionsetup[figure]{
  skip = 0.2\baselineskip,   %  标题与上方图片主体的距离
}

\RequirePackage{amsmath}
\numberwithin{table}{chapter}
\numberwithin{figure}{chapter}
\renewcommand{\thetable}{\thechapter-\arabic{table}}
\renewcommand{\thefigure}{\thechapter-\arabic{figure}}
\renewcommand{\theequation}{\thechapter-\arabic{equation}}
% 修改公式后面的样式，默认为 (2-1)，下面的命令修改为 [2-1]
%\renewcommand{\tagform@}[1]{\maketag@@@{[#1]}}
\RequirePackage{graphicx}
\graphicspath{{./}{figures/}}

\setlength{\intextsep}{0.5\baselineskip}
%\setlength{\textfloatsep}{0.5\baselineskip}
%\setlength{\intextsep}{6pt plus 2pt minus 2pt}     % 如果你用了 [h] 或 [H] 强制就地放置
\setlength{\textfloatsep}{6pt plus 2pt minus 2pt}  % 如果图片自然漂浮在页顶/页底
\setlength{\belowcaptionskip}{-0.5\baselineskip}

\newenvironment{acknowledgements}{
  \chapter[致谢]{致\zhspace 谢}
}{}
\newenvironment{publications}{
  \chapter{攻读学位期间取得的研究成果}
}{}

% ==================== 1. 加载必要的表格宏包 ====================
\RequirePackage{booktabs}
\RequirePackage{tabularx}
\RequirePackage{longtable} % 引入长表格宏包
\RequirePackage{etoolbox} % 提供环境前置钩子
\RequirePackage{ltablex}


% ==================== 2. 固化线粗（1.5磅与1磅） ====================
\setlength{\heavyrulewidth}{1.5pt} % 上下边线固定为 1.5 磅
\setlength{\lightrulewidth}{1.0pt} % 表内主线/辅助线固定为 1.0 磅
\setlength{\cmidrulewidth}{1.0pt}  % \cmidrule 辅助线同样固定为 1.0 磅

% ==================== 3. 自动化字号控制（五号字） ====================
% 使用 \BeforeBeginEnvironment 钩子，确保只要用户调用 table 环境，
% 内部字体就会自动切换为五号字（\zihao{5}），无需用户手动输入。
\BeforeBeginEnvironment{table}{\zihao{5}}
% 1. 确保 longtable 内部同样默认自动使用五号字
\BeforeBeginEnvironment{longtable}{
  \zihao{5}
  \centering
  \setlength{\LTcapwidth}{\linewidth}
}

\RequirePackage{tabularray}
\RequirePackage{diagbox} % 绘制带斜线的表头
\RequirePackage{xcolor}  % 如果你的标题需要颜色，保持加载

% 全局锁定主标题的所有文本属性（包括标签和文字）为五号字
\DeclareTblrTemplate{caption-tag}{default}{表~\thetable~}
\DeclareTblrTemplate{caption-sep}{default}{~}
\DeclareTblrTemplate{caption-text}{default}{\InsertTblrText{caption}}
\DeclareTblrTemplate{conthead-text}{default}{续}
\DefTblrTemplate{contfoot}{default}{} % 清除长表格底部的“Continued on next page”
\SetTblrStyle{caption-tag}{font=\zihao{5}\songti}
\SetTblrStyle{caption-sep}{font=\zihao{5}\songti}
\SetTblrStyle{caption-text}{font=\zihao{5}\songti}
\SetTblrStyle{conthead-text}{font=\zihao{5}\songti}

\DeclareTblrTemplate{capcont}{default}{
  \centering
  \UseTblrTemplate{conthead-text}{default}%
  \UseTblrTemplate{caption-tag}{default}%
  \UseTblrTemplate{caption-sep}{default}%
  \UseTblrTemplate{caption-text}{default}\\
}

\SetTblrInner[tblr, longtblr]{
  hline{1,Z} = {1.5pt},    % 顶线和底线 1.5pt
  hline{2}   = {1.0pt},    % 表头线 1.0pt
  rowhead    = 1,          % 黄金参数：指定前 1 行作为表头，跨页时会自动在后续页重复它！
  width      = \linewidth, % 强行锁定表格与正文文字绝对齐宽
  cells      = {font = \zihao{5}\songti},          % 全局默认：五号宋体
  row{1}     = {font = \zihao{5}\songti\bfseries}, % 表头：五号宋体加粗
}

\SetTblrOuter{
  headsep = {\normalbaselineskip},
  footsep = {0},
  presep  = {0.5\baselineskip},
  postsep = {0.5\baselineskip},
}

\SetTblrOuter[longtblr]{
  presep  = 0.5\baselineskip,
  postsep = 0.5\baselineskip,
}

\RequirePackage{enumitem}

% --- [规范 (4)] 注释（脚注）按页重新编号 ①, ②, ③ ---
\RequirePackage{pifont} % 提供带圈数字 ①②③
\RequirePackage[perpage]{footmisc} % 强制脚注每页自动清零，从①重新开始

% ==================== 精细调整页面脚注横线 ====================
\renewcommand{\footnoterule}{%
  \kern -3pt                % 1. 线条上方的垂直间距（微调，防止压到正文）
  \hrule width 0.4\textwidth depth 0pt height 0.4pt % 2. 控制线条长度和粗细
  \kern 2.6pt               % 3. 线条下方的垂直间距（线条到脚注文字的距离）
}
% 重写底层脚注编号标签，将其全面改为中文带圈数字
\renewcommand{\thefootnote}{\ding{\numexpr191+\value{footnote}\relax}}
\renewcommand{\@makefntext}[1]{%
  \noindent                    % 缩进
  \kern 0.5em                  % 插入缩进间距，不需要的话就注释掉
  \textnormal{\thefootnote}    % 正常大小、正常字体的脚注编号（剥离上标环境）
  \kern 0.5em                  % 脚注编号和后面文本之间的微小黄金间距
  #1                           % 读入后面的正文文字（如“脚注示例”）
}

% ==============================================================================

\RequirePackage[most]{tcolorbox}
\tcbuselibrary{skins,xparse}

% ==================== BibLaTeX 参考文献列表 ====================
\RequirePackage[
  backend=biber,       % 必须使用现代化的 biber 编译器（支持 Unicode 中文）
  style=gb7714-2015,   % 加载 GB/T 7714-2025 官方样式
  gbalign=left,        % 序号靠左对齐，后面文字自动对齐
  gbnamefmt=lowercase, % 保持英文作者姓名的西文规范
  gbpub=true,          % 自动开启出版项、保存地等补全提示
]{biblatex}
% 调整参考文献列表的整体字号（如规范要求通常为五号或小五号宋体）
\renewcommand{\bibfont}{\songti\zihao{5}}

% 精细调整条目之间的垂直行间距（取消默认的过大空隙）
\setlength{\itemsep}{3pt plus 1pt minus 1pt}
\setlength{\parsep}{0pt}

\setlength{\biblabelsep}{0.5ex}

% 一篇文献如被多次引用，页码标注在文中上角标“[ ]”之后（如：[1]32、[1]256）
\renewcommand{\pagescite}[2]{\cite{#1}\textsuperscript{#2}}

% ==============================================================================

\endinput
%%
%% End of file `swustthesis.cls'.

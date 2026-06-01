local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local snpt = {}

snpt[#snpt + 1] = s(
  { trig = "jlreq", name = "Preamble for jlreq" },
  fmt(
    [=[
% jlreq preamble

%%%%% packages %%%%%
% --- jlreq ---
% font
% ja
\usepackage{luatexja-fontspec}
\usepackage[hiragino-pro,deluxe]{luatexja-preset}
% eng
\usepackage[LGR,T2A,T1]{fontenc}
\usepackage{tgheros}
\usepackage{lmodern}

% basics
\usepackage[unicode,hidelinks,pdfusetitle]{hyperref}

% cref, figures
\usepackage{amsmath}
\usepackage{cleveref}
\crefname{figure}{Fig.}{Figs.}
\Crefname{figure}{Fig.}{Figs.}
\usepackage{caption}
\captionsetup[figure]{name=Fig., labelsep=space}

% box/frame
% - https://nalab.mind.meiji.ac.jp/~mk/labo/tex/how-to-waku.pdf
\usepackage{ascmac} % \begin{screen}, \begin{itembox}{見出し}, \begin{itembox}[l]{見出し}, \begin{shadebox}
% tcolorbox for boxed theorems
\usepackage{tcolorbox}
\tcbuselibrary{theorems, skins, breakable}
% framed
\usepackage{framed}
\definecolor{shadecolor}{gray}{0.85}
% \begin{oframed} 文 \end{oframed}
% \begin{shaded} 文 \end{shaded}

% Increase list depth limit to avoid "Too deeply nested" error
\usepackage{enumitem}
\setlistdepth{15}

% --- agnostic ---
% typeface, ref: https://mathlandscape.com/latex-mathcal
\usepackage{bm} % \boldsymbol → \bm
\usepackage{mathrsfs} % 花文字 \mathscr

% basics
\usepackage{amsfonts}
\usepackage{amscd}
\usepackage{amssymb}
\usepackage{amsthm}
\usepackage{graphicx}
\usepackage{fancyhdr}
\usepackage{wrapstuff}
\usepackage{wrapfig}
\usepackage{setspace}
\usepackage{color}
\usepackage{xcolor}
\usepackage{ulem} % \uline, \uuline, \uwave, \sout, \xout, \dashuline, \dotuline

\usepackage{physics}
% \qty() , \qty|| ,\norm{} など ...... カッコ
% \vb{} ...... 太字のベクトル
% 数式数式  \qq{テキスト}  数式数式
% \dd[指数]{x} ...... dx
% \dv{x} ............ d/dx
% \pdv{x} ........... ∂/∂x
% \dv{f}{x} ......... df/dx
% \pdv{f}{x} ........ ∂f/∂x
% \mqty(a&b\\c&d) , \mqty|| 行列・行列式
% \mqty{\imat{n}} ...... 単位行列
% \mqty{\dmat[0]{n}} ... 対角行列
% \mqty{\xmat*{a}{m}{n}} ... {a_mn}行列

\usepackage{multicol} % n段組み
%\begin{multicols}{段数} 文章 \end{multicols}

% file split
\usepackage{subfiles} % \subfile: parentのpreambleがchildに反映される
% the docmute conflicts with bibtex
% \usepackage{docmute} % \input: childで個別のpreambleを設定可能

% tikz
\usepackage{tikz}
\usepackage{colortbl}
\usepackage{tikz-cd}
\usepackage{tikz-3dplot}
\usepackage{pgfplots}
\pgfplotsset{compat=1.12}
\usetikzlibrary{arrows.meta, positioning, calc}

% code
\usepackage{listings,jvlisting} % Display code
\lstset{
  frame=single,
  numbers=left,
  tabsize=4,
  basicstyle=\ttfamily,
  numberstyle=\scriptsize,
  commentstyle={\small\ttfamily \color[gray]{.5}},
}
\newcommand{\code}[1]{\texttt{#1}}

% dummy text
\usepackage{lipsum} % \lipsum[1-5]

%%%%% layout / style %%%%%
% jlreq ref: https://mathlandscape.com/latex-margin
\usepackage[margin=25truemm]{geometry}
% \usepackage[twoside,top=25truemm,bottom=20truemm,inner=30truemm,outer=20truemm]{geometry}

% TOC
\setcounter{tocdepth}{4}

%%%%% custom commands %%%%%
% --- jlreq ---
% Theorem environments
\theoremstyle{definition}

% Simple
% \newtheorem{thm}{Thm.}
% \newtheorem{dfn}[thm]{Def.}
% \newtheorem{prop}[thm]{Prop.}
% \newtheorem{lem}[thm]{Lem.}
% \newtheorem{cor}[thm]{Cor.}
% \newtheorem{rem}[thm]{Rem.}
% \newtheorem*{thm*}{Thm.}
% \newtheorem*{dfn*}{Def.}
% \newtheorem*{prop*}{Prop.}
% \newtheorem*{lem*}{Lem.}
% \newtheorem*{cor*}{Cor.}
% \newtheorem*{rem*}{Rem.}

% Gray background
% Ref:
% - https://qiita.com/_loki_roki/items/2217c911941b2fda4260
% - https://note.com/totomin/n/n0b02d6539728
% - (https://qiita.com/rityo_masu/items/5ef248024b294d72799a)
% Examples:
% \begin{thm}{タイトル名}{label-id}
%   定理の内容
% \end{thm}
% タイトルなし
% \begin{dfn}{}{my-def}
%   定義の内容
% \end{dfn}
% オプションを使って背景色を変更
% \begin{thm}[colback=red!10]{重要な定理}{important}
%   特別な定理
% \end{thm}
% % 枠線の色を変更
% \begin{prop}[borderline west={2pt}{0pt}{blue}]{命題}{my-prop}
%   命題の内容
% \end{prop}
\newtcolorbox[auto counter, number within=section, crefname={Thm.}{Thms.}]{thm}[3][]{
  enhanced,
  breakable=true,
  fonttitle=\bfseries,
  coltitle=black,
  title=Thm.~\thetcbcounter~\ifx\relax#2\relax\else（#2）\fi,
  colback=black!5, colframe=black!5,
  borderline west={2pt}{0pt}{black},
  #1,
  label=thm:#3
}
\newtcolorbox[auto counter, use counter from=thm, crefname={Def.}{Defs.}]{dfn}[3][]{
  enhanced,
  breakable=true,
  fonttitle=\bfseries,
  coltitle=black,
  title=Def.~\thetcbcounter~\ifx\relax#2\relax\else（#2）\fi,
  colback=black!5, colframe=black!5,
  borderline west={2pt}{0pt}{black},
  #1,
  label=thm:#3
}
\newtcolorbox[auto counter, use counter from=thm, crefname={Prop.}{Props.}]{prop}[3][]{
  enhanced,
  breakable=true,
  fonttitle=\bfseries,
  coltitle=black,
  title=Prop.~\thetcbcounter~\ifx\relax#2\relax\else（#2）\fi,
  colback=black!5, colframe=black!5,
  borderline west={2pt}{0pt}{black},
  #1,
  label=thm:#3
}
\newtcolorbox[auto counter, use counter from=thm, crefname={Lem.}{Lems.}]{lem}[3][]{
  enhanced,
  breakable=true,
  fonttitle=\bfseries,
  coltitle=black,
  title=Lem.~\thetcbcounter~\ifx\relax#2\relax\else（#2）\fi,
  colback=black!5, colframe=black!5,
  borderline west={2pt}{0pt}{black},
  #1,
  label=thm:#3
}
\newtcolorbox[auto counter, use counter from=thm, crefname={Cor.}{Cors.}]{cor}[3][]{
  enhanced,
  breakable=true,
  fonttitle=\bfseries,
  coltitle=black,
  title=Cor.~\thetcbcounter~\ifx\relax#2\relax\else（#2）\fi,
  colback=black!5, colframe=black!5,
  borderline west={2pt}{0pt}{black},
  #1,
  label=thm:#3
}
\newtcolorbox[auto counter, use counter from=thm, crefname={Rem.}{Rems.}]{rem}[3][]{
  empty,
  breakable=true,
  fonttitle=\bfseries,
  coltitle=black,
  title=Rem.~\thetcbcounter~\ifx\relax#2\relax\else（#2）\fi,
  borderline west={1pt}{0pt}{black},
  #1,
  label=thm:#3
}
\newtcolorbox[auto counter, use counter from=thm, crefname={Ex.}{Exs.}]{exa}[3][]{
  empty,
  breakable=true,
  fonttitle=\bfseries,
  coltitle=black,
  title=Ex.~\thetcbcounter~\ifx\relax#2\relax\else（#2）\fi,
  borderline west={1pt}{0pt}{black},
  #1,
  label=thm:#3
}

% Problem (conflicts with the beamer)
\newcounter{problemnum}
\newcounter{subproblemnum}
\makeatletter
\newenvironment{problem}[1][]{
  \setcounter{subproblemnum}{0}
  \ifx\relax#1\relax
  \refstepcounter{problemnum}
  \else
  \setcounter{problemnum}{#1}
  \fi
  \ifnum \value{problemnum}>>1 \vspace{\baselineskip}\fi
  \normalfont
  \list{
    \textbf{\theproblemnum}\@addpunct{.}
  }{
    \leftmargin=1em
    \labelwidth=0pt
    \itemindent=-1em
    \listparindent=0pt
  }
\item\relax\ignorespaces
}{\endlist}
\makeatother
\newcommand{\subproblem}{
  \par
  \noindent \textbf{(\refstepcounter{subproblemnum}\thesubproblemnum)}
}

% Proof/Answer
\renewcommand{\proofname}{Proof}
\makeatletter
\renewenvironment{proof}[1][\proofname]{\par
  \pushQED{\qed}
  \normalfont \topsep6\p@\@plus6\p@\relax
  \list{
    \textbf{#1}\@addpunct{.}
  }{
    \leftmargin=1em
    \labelwidth=0pt
    \itemindent=-1em
    \listparindent=0pt
  }
\item\relax\ignorespaces
}{\popQED\endtrivlist}
\makeatother

% memo
\newenvironment{memo}[1][メモ]{
  \begin{itembox}[l]{\uline{#1}}
  }{
  \end{itembox}
}

% --- agnostic ---
% todos
% ex. \todo{あとで参考文献を追加する}
\newcommand{\todo}[1]{\textcolor{green!70!black}{\textbf{TODO: }#1}}
\newcommand{\must}[1]{\textcolor{blue}{\textbf{MUST: }#1}}
\newcommand{\fixme}[1]{\textcolor{red}{\textbf{FIXME: }#1}}
\newcommand{\xxx}[1]{\textcolor{magenta}{\textbf{XXX: }#1}}
% \newcommand{\todo}[1]{}
% \newcommand{\must}[1]{}
% \newcommand{\fixme}[1]{}
% \newcommand{\xxx}[1]{}

%%%%% some fixes %%%%%
% --- jlreq ---
% reportクラスを使用するとき
% \makeatletter
% \providecommand{\@chapapp}{第}
% \makeatother

%%%%% aliases %%%%%
\newcommand{\wto}{\overset{w}{\rightharpoonup}} % weak convergence
\newcommand{\wsto}{\overset{w \ast}{\rightharpoonup}} % weak* convergence
\newcommand{\ncto}{\overset{nc}{\to}} % norm convergence
\DeclareMathOperator{\PSL}{PSL}
\DeclareMathOperator{\length}{Leg}
\DeclareMathOperator{\uhp}{\mathfrak{h}}
]=],
    {},
    { delimiters = "<>" }
  )
)

snpt[#snpt + 1] = s(
  { trig = "main", name = "Main file" },
  fmt(
    [=[
\documentclass[
  paper=a4paper,
  jlreq_notes,
]{jlreq}

% \documentclass[
%   % aspectratio=169,
% ]{beamer}

\input{preamble.tex}

\title{harisenbon}
\author{ramen}
\date{\today}

\begin{document}

\maketitle

\pagenumbering{roman}
\tableofcontents
\clearpage
\pagenumbering{arabic}

\subfile{script/sections/0_introduction}

\subfile{script/sections/1_upper_half_plane}

\subfile{script/sections/2_gauss_bonnet}

\clearpage

\bibliography{reference}
% https://mathlandscape.com/latex-bibstyles/#toc2
\bibliographystyle{junsrt}
\nocite{*}

\end{document}
]=],
    {},
    { delimiters = "<>" }
  )
)

snpt[#snpt + 1] = s(
  { trig = "beamer", name = "Preamble for beamer" },
  fmt(
    [=[
% beamer preamble

%%%%% packages %%%%%
% --- beamer ---
% font refs:
% - https://qiita.com/alpaca-honke/items/bc2ba5a8a68ba5eb3b5a
% - https://qiita.com/sekky0816/items/60196f28da97eb181edc
% ja
\usepackage{luatexja}
\usepackage[hiragino-pro,deluxe]{luatexja-preset}
\renewcommand{\kanjifamilydefault}{\gtdefault}% 既定をゴシック体に
\usefonttheme{professionalfonts}

% figures
\usepackage{caption}
\captionsetup[figure]{name=図, labelsep=space}

% basics
\usepackage{amsmath} % jlreq側のcleverefとの読み込み順の都合でここに書く

% --- agnostic ---
% typeface, ref: https://mathlandscape.com/latex-mathcal
\usepackage{bm} % \boldsymbol ->> \bm
\usepackage{mathrsfs} % 花文字 \mathscr

% basics
\usepackage{amsfonts}
\usepackage{amscd}
\usepackage{amssymb}
\usepackage{amsthm}
\usepackage{graphicx}
\usepackage{fancyhdr}
\usepackage{wrapstuff}
\usepackage{wrapfig}
\usepackage{setspace}
\usepackage{color}
\usepackage{xcolor}
\usepackage{ulem} % \uline, \uuline, \uwave, \sout, \xout, \dashuline, \dotuline

\usepackage{physics}
% \qty() , \qty|| ,\norm{} など ...... カッコ
% \vb{} ...... 太字のベクトル
% 数式数式  \qq{テキスト}  数式数式
% \dd[指数]{x} ...... dx
% \dv{x} ............ d/dx
% \pdv{x} ........... ∂/∂x
% \dv{f}{x} ......... df/dx
% \pdv{f}{x} ........ ∂f/∂x
% \mqty(a&b\\c&d) , \mqty|| 行列・行列式
% \mqty{\imat{n}} ...... 単位行列
% \mqty{\dmat[0]{n}} ... 対角行列
% \mqty{\xmat*{a}{m}{n}} ... {a_mn}行列

\usepackage{multicol} % n段組み
%\begin{multicols}{段数} 文章 \end{multicols}

% file split
\usepackage{subfiles} % \subfile: parentのpreambleがchildに反映される
% the docmute conflicts with bibtex
% \usepackage{docmute} % \input: childで個別のpreambleを設定可能

% tikz
\usepackage{tikz}
\usepackage{colortbl}
\usepackage{tikz-cd}
\usepackage{tikz-3dplot}
\usepackage{pgfplots}
\pgfplotsset{compat=1.12}
\usetikzlibrary{arrows.meta, positioning, calc}

% code
\usepackage{listings,jvlisting} % Display code
\lstset{
  frame=single,
  numbers=left,
  tabsize=4,
  basicstyle=\ttfamily,
  numberstyle=\scriptsize,
  commentstyle={\small\ttfamily \color[gray]{.5}},
}
\newcommand{\code}[1]{\texttt{#1}}

% dummy text
\usepackage{lipsum} % \lipsum[1-5]

%%%%% layout / style %%%%%
% Theme refs:
% - https://qiita.com/hiterm/items/70cbb488e7a87cd9e228
% - https://www.y-misc.org/tex/command/beamer-theme.html
% - https://deic.uab.cat/~iblanes/beamer_gallery/index_by_theme.html
% - https://qiita.com/sekky0816/items/60196f28da97eb181edc
% - https://qiita.com/birdwatcher/items/5dd8a5f453bdc0c6940e
\usetheme{Antibes}
% Antibesで、frame titleの上のセクション情報を削除
% ref: https://zenn.dev/__leopardus__/articles/c9f7951d4696ab
\setbeamertemplate{headline}{}

\usecolortheme{orchid}
\useinnertheme{rectangles} % itemize, enumerateを四角にする
\setbeamertemplate{items}[circle] % itemizeは丸を使用する
\setbeamertemplate{navigation symbols}{} % ナビゲーションバー非表示
\setbeamerfont{frametitle}{size=\Large, series=\bfseries}
\setbeamertemplate{footline}[page number]
% ref: https://latex-beamer.com/tutorials/beamer-font/
\setbeamerfont{footline}{size=\normalsize}

%%%%% custom commands %%%%%
% --- beamer ---
% Theorem environments
% ref: https://ayapin-film.sakura.ne.jp/LaTeX/Slides/colors.pdf
% 共通の番号
\newcounter{thm}
\setcounter{thm}{0}

% 定理・命題・補題・系・定義 (block)
\newenvironment{thm}[1][]{\refstepcounter{thm}
\begin{block}{定理 \thethm\ifx\relax#1\relax\else\ (#1)\fi}}{
\end{block}}
\newenvironment{thm*}[1][]{
\begin{block}{定理\ifx\relax#1\relax\else\ (#1)\fi}}{
\end{block}}

\newenvironment{prop}[1][]{\refstepcounter{thm}
\begin{block}{命題 \thethm\ifx\relax#1\relax\else\ (#1)\fi}}{
\end{block}}
\newenvironment{prop*}[1][]{
\begin{block}{命題\ifx\relax#1\relax\else\ (#1)\fi}}{
\end{block}}

\newenvironment{lem}[1][]{\refstepcounter{thm}
\begin{block}{補題 \thethm\ifx\relax#1\relax\else\ (#1)\fi}}{
\end{block}}
\newenvironment{lem*}[1][]{
\begin{block}{補題\ifx\relax#1\relax\else\ (#1)\fi}}{
\end{block}}

\newenvironment{cor}[1][]{\refstepcounter{thm}
\begin{block}{系 \thethm\ifx\relax#1\relax\else\ (#1)\fi}}{
\end{block}}
\newenvironment{cor*}[1][]{
\begin{block}{系\ifx\relax#1\relax\else\ (#1)\fi}}{
\end{block}}

\newenvironment{dfn}[1][]{\refstepcounter{thm}
\begin{block}{定義 \thethm\ifx\relax#1\relax\else\ (#1)\fi}}{
\end{block}}
\newenvironment{dfn*}[1][]{
\begin{block}{定義\ifx\relax#1\relax\else\ (#1)\fi}}{
\end{block}}

% 定義・例 (example block)
\newenvironment{exa}[1][]{\refstepcounter{thm}
\begin{exampleblock}{例 \thethm\ifx\relax#1\relax\else\ (#1)\fi}}{
\end{exampleblock}}
\newenvironment{exa*}[1][]{
\begin{exampleblock}{例\ifx\relax#1\relax\else\ (#1)\fi}}{
\end{exampleblock}}

% 注意 (alert block)
\newenvironment{rem}[1][]{\refstepcounter{thm}
\begin{alertblock}{注意 \thethm\ifx\relax#1\relax\else\ (#1)\fi}}{
\end{alertblock}}
\newenvironment{rem*}[1][]{
\begin{alertblock}{注意\ifx\relax#1\relax\else\ (#1)\fi}}{
\end{alertblock}}

% plain block
\newenvironment{plainblock}[1][]{
  \begin{block}{#1}
  \begin{verbatim}
}{
  \end{verbatim}
  \end{block}
}

% --- agnostic ---
% todos
% ex. \todo{あとで参考文献を追加する}
% \newcommand{\todo}[1]{\textcolor{green!70!black}{\textbf{TODO: }#1}}
% \newcommand{\must}[1]{\textcolor{blue}{\textbf{MUST: }#1}}
% \newcommand{\fixme}[1]{\textcolor{red}{\textbf{FIXME: }#1}}
% \newcommand{\xxx}[1]{\textcolor{magenta}{\textbf{XXX: }#1}}
\newcommand{\todo}[1]{}
\newcommand{\must}[1]{}
\newcommand{\fixme}[1]{}
\newcommand{\xxx}[1]{}

%%%%% aliases %%%%%
\newcommand{\wto}{\overset{w}{\rightharpoonup}} % weak convergence
\newcommand{\wsto}{\overset{w \ast}{\rightharpoonup}} % weak* convergence
\newcommand{\ncto}{\overset{nc}{\to}} % norm convergence
\DeclareMathOperator{\PSL}{PSL}
\DeclareMathOperator{\length}{Leg}
\DeclareMathOperator{\uhp}{\mathfrak{h}}
]=],
    {},
    { delimiters = "<>" }
  )
)

return snpt

%% foefyp.cls Jan 03 2020 version 1.0
%%
%% This is the unofficial MMU thesis LaTeX class for undergraduate
%% students of Multimedia University, Cyberjaya. It is created
%% according to http://foe.mmu.edu.my/v3/main/undergrad/fyp_report_guidelines.html
%%
%% Made by Chia Jason and Chai Yee Ting
%% Faculty of Engineering 2019/20
%% maintainer: Chia Jason (chia_jason96@live.com)
%%
%% This work is Strongly inspired and guided by
%% Ms/Dr. Lim Lian Tze's MMU PostGrad Thesis

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mmuthesis}[LaTeX2e class for MMU FoE FYP Thesis v1.0. Copyright (c) 2020 Chia Jason and Chai Yee Ting (chia\_jason96@live.com)]

\LoadClass[12pt,a4paper,oneside]{memoir}
\RequirePackage{textcomp}

%%%%%%%%%%%%
% Page layout
%
% Margins: T - 20mm; B - 40mm; L - 40mm; R - 25mm
% No running headers.
% Running footers are 15mm from bottom edge of paper
% i.e. (40 - 15)mm = 25mm from bottom edge of typeblock.
%%%%%%%%%%%%
\settrimmedsize{297mm}{210mm}{*}
\setlrmarginsandblock{40mm}{25mm}{*}
\setulmarginsandblock{20mm}{40mm}{*}
\setheadfoot{\baselineskip}{25mm}
\addtolength\footskip{-6pt}
\pagestyle{plain}
\makeevenfoot{plain}{}{\fontsize{10pt}{12pt}\selectfont\thepage}{}
\makeoddfoot{plain}{}{\fontsize{10pt}{12pt}\selectfont\thepage}{}
\checkandfixthelayout

%%%%%%%%%%%%
% Simulate MS Windows fonts
% Invoking Helvetica and Times
% NOT Courier because, well, I hate it.
%
% TODO: TeX Gyre fonts + Math Times Pro with "altfonts" option
%%%%%%%%%%%%
\RequirePackage[T1]{fontenc}
\RequirePackage{helvet}
\RequirePackage{mathptmx}
%\RequirePackage{courier}
\renewcommand\ttdefault{lmvtt}

%%%%%%%%%%%%
% Line and paragraph spacing
% - 1.5 spacing for normal text (but need to tweak to exactly simulate Word
% - Leave one line between paragraphs
% - 12.7mm paragraph indent
%%%%%%%%%%%%
%\OnehalfSpacing
\DisemulatePackage{setspace}
\RequirePackage{setspace}
\setstretch{1.5}
\abnormalparskip{1.5\onelineskip}
\setlength\parindent{12.7mm}
\RequirePackage{etoolbox}
\patchcmd{\quote}{\rightmargin}{\leftmargin 20mm \rightmargin}{}{}
\patchcmd{\quotation}{\rightmargin}{\leftmargin 20mm \rightmargin}{}{}
\checkandfixthelayout

%%%%%%%%%%%%
% Footnotes
% - Font size = 8pt = \tiny for 12pt body font in memoir
% - Double spacing between footnotes
%%%%%%%%%%%%
\renewcommand{\foottextfont}{\tiny}
\setlength\footnotesep{\onelineskip}
% But they should all be endnotes!!
\RequirePackage{endnotes}
\renewcommand\enotesize{\tiny}
%\let\footnote=\endnote
\renewcommand\enoteheading{\chapter{\notesname}\mbox{}\vskip-4\onelineskip}
\renewcommand\enoteformat{\rightskip\z@ \leftskip\z@ \parindent=1.8em
  \leavevmode\llap{\makebox[1.8em][l]{\theenmark.}}}

% This package allows pdf bookmarking
\RequirePackage[breaklinks,pdfborder={0 0 0},bookmarksopen,bookmarksnumbered,pdfprintscaling=None]{hyperref}
\addtoiargdef\author{}{\hypersetup{pdfauthor={\theauthor}}}
\addtoiargdef\title{}{\hypersetup{pdftitle={\thetitle}}}

%%%%%%%%%%%%
% The Acknowledgements (typeset like chapter?)
%%%%%%%%%%%%
\newcommand{\acknowledgements}[1]{\chapter{Acknowledgements}\vskip-\onelineskip #1}
\newcommand{\acknowlfromfile}[1]{\acknowledgements{\input{#1}}\clearpage}

%%%%%%%%%%%%
% 10pt = \footnotesize for backmatter
% And add a PDF bookmark
%%%%%%%%%%%%
\cftinsertcode{narrowertoc}{\setlength\cftbeforechapterskip{.75em}}
\patchcommand{\frontmatter}{}{\ifpdf\pdfbookmark[-1]{Front Matter}{front}\fi}
\patchcommand{\mainmatter}{}{\ifpdf\pdfbookmark[-1]{Main Chapters}{main}\fi}
\patchcommand{\backmatter}{}{\footnotesize%
\cftinserthook{toc}{narrowertoc}%
\ifpdf\pdfbookmark[-1]{Back Matter}{back}\fi}

% CHAPTER DEFINITIONS
\let\orichapter\chapter
\renewcommand\chapter{\@ifstar{\mystarchap}{\mychap}}
\newcommand\mychap[1]{\orichapter[\texorpdfstring{\MakeUppercase{#1}}{#1}]{#1}}
\newcommand\mystarchap[1]{\orichapter*{#1}}

%%%%%%%%%%%%
% Chapter headings (Edited 3 Jan 2020) Chia Jason
%%%%%%%%%%%%
% Define fronmatter chapter style (heading centered
\makechapterstyle{frontmatter}{
	\renewcommand\chapterheadstart{\normalsize\vskip\beforechapskip}
	\setlength\beforechapskip{0pt}
	%\setlength\midchapskip{2\onelineskip}
	\setlength\midchapskip{\onelineskip}
	\setlength\afterchapskip{2\onelineskip minus \onelineskip}
	%\setlength\afterchapskip{\onelineskip}
	\renewcommand*\chapnamefont{\normalsize\bfseries}
	\renewcommand*\chapnumfont{\normalsize\bfseries\centering}
	\renewcommand*\chaptitlefont{\normalsize\bfseries\centering}
	\renewcommand{\printchaptername}{{\chapnamefont\MakeUppercase{\chaptername}}}
	%\renewcommand*{\afterchapternum}{\vskip\midchapskip}
	\renewcommand*{\afterchapternum}{\qquad}
	\renewcommand*{\printchaptertitle}[1]{{\chaptitlefont\MakeUppercase{##1}\par}}
}
% Define main matter, heading flushed left
\makechapterstyle{mainmatter}{
	\renewcommand\chapterheadstart{\normalsize\vskip\beforechapskip}
	\setlength\beforechapskip{0pt}
	%\setlength\midchapskip{2\onelineskip}
	%\setlength\midchapskip{\onelineskip}
	%\setlength\midchapskip{0pt}
	%\setlength\afterchapskip{2\onelineskip minus \onelineskip}
	%\setlength\afterchapskip{\onelineskip}
	\setlength\afterchapskip{0pt}
	\renewcommand*\chapnamefont{\normalsize\bfseries}
	\renewcommand*\chapnumfont{\normalsize\bfseries}
	\renewcommand*\chaptitlefont{\normalsize\bfseries}
	\renewcommand{\printchaptername}{{\chapnamefont\MakeUppercase{\chaptername}}}
	%\renewcommand*{\afterchapternum}{\vskip\midchapskip}
	\renewcommand*{\afterchapternum}{\qquad}
	\renewcommand*{\printchaptertitle}[1]{{\chaptitlefont\MakeUppercase{##1}\par}}
}
\let\oldfrontmatter\frontmatter
\renewcommand{\frontmatter}{\chapterstyle{frontmatter}\oldfrontmatter}
\let\oldmainmatter\mainmatter
\renewcommand{\mainmatter}{\chapterstyle{mainmatter}\oldmainmatter}
\let\oldbackmatter\backmatter
\renewcommand{\backmatter}{\chapterstyle{backmatter}\oldbackmatter}

% TOC, LOF, LOT heading defines
\renewcommand*\contentsname{\texorpdfstring{TABLE OF CONTENTS}{Table of Contents}}
\renewcommand*\listtablename{\texorpdfstring{LIST OF TABLES}{List of Tables}}
\renewcommand*\listfigurename{\texorpdfstring{LIST OF FIGURES}{List of Figures}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LESS EDIT BEYOND THIS LINE %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%
% The Copyright page
%%%%%%%%%%%%

% Housekeeping stuff
\def\theauthor{\textbf{!INSERT AUTHOR!}}
\def\thetitle{\textbf{!INSERT TITLE!}}
\def\@mtsubmissionmonth{\textbf{!INSERT MONTH!}}
\def\@mtsubmissionyear{\textbf{!INSERT YEAR!}}
\def\@mtfaculty{\textbf{!INSERT FACULTY!}}
\def\@mtdegree{\textbf{!INSERT DEGREE!}}
\def\@mtsid{\textbf{!INSERT STUDENT ID!}}
\def\@mtdate{\textbf{!INSERT DECLARATION DATE!}}

% Housekeeping
\newcommand{\submissionyear}[1]{\def\@mtsubmissionyear{#1}}
\newcommand{\submissionmonth}[1]{\def\@mtsubmissionmonth{#1}}
\newcommand{\faculty}[1]{\def\@mtfaculty{#1}}
\newcommand{\degree}[1]{\def\@mtdegree{#1}}
\newcommand{\studentID}[1]{\def\@mtsid{#1}}
\newcommand{\declareDate}[1]{\def\@mtddate{#1}}

%%%%%%%%%%%%
% Sectional headings
%%%%%%%%%%%%
\setsecnumdepth{subsubsection}
\setsecheadstyle{\normalsize\bfseries}
%\setbeforesecskip{2.5ex plus 1ex minus .2ex}
\setbeforesecskip{\onelineskip}
%\setaftersecskip{0.1ex plus .2ex}
%\setaftersecskip{1em plus .2ex minus .2ex}
\setaftersecskip{\onelineskip}
\setsubsecheadstyle{\normalsize\bfseries}
%\setbeforesubsecskip{2.5ex plus .1ex minus .2ex}
\setbeforesubsecskip{\onelineskip}
%\setaftersubsecskip{0.1ex plus .2ex}
%\setaftersubsecskip{1em plus .2ex minus .2ex}
\setaftersubsecskip{\onelineskip}
\setsubsubsecheadstyle{\normalsize\itshape}
%\setbeforesubsubsecskip{1.5ex plus 1ex minus .2ex}
\setbeforesubsubsecskip{\onelineskip}
\renewcommand\thesubsubsection{\thesubsection\space(\alph{subsubsection})}
\setsubsubsecheadstyle{\normalsize\itshape}
%\setbeforesubsubsecskip{2.5ex plus .2ex minus .2ex}
\setbeforesubsubsecskip{\onelineskip}
%\setaftersubsubsecskip{0.1ex plus .2ex}
%\setaftersubsubsecskip{1em plus .1ex minus .2ex}
\setaftersubsubsecskip{\onelineskip}

\newcommand{\copyrightpage}{\hspace{1em}%
\phantomsection%
\ifpdf\pdfbookmark{Copyright Page}{copyright}\fi%
% Edit: Removed copyrightfrom TOC - Jason
%\cftaddtitleline{toc}{chapter}{COPYRIGHT PAGE}{\thepage}%
\begin{vplace}[1]
\fontsize{14pt}{16pt}\selectfont %The copyright of this thesis belongs to the author under the terms of the Copyright Act 1987 as qualified by Regulation 4(1) of the Multimedia University Intellectual Property Regulations. Due acknowledgement shall always be made of the use of any material contained in, or derived from, this thesis.\par\vskip\onelineskip%
%{\raggedleft%
%\begin{tabular}{@{}r@{ }l@{}}
%\textcopyright & \theauthor, \@mtsubmissionyear\\
%& All rights reserved
%\end{tabular}%
%\par}
\setlength{\parindent}{0pt}
\textcopyright \@mtsubmissionyear{} Universiti Telekom Sdn.\ Bhd. ALL RIGHTS RESERVED.\par
Copyright of this report belongs to Universiti Telekom Sdn. Bhd. as qualified by Regulation 7.2 (c) of the Multimedia University Intellectual Property and Commercialisation Policy. No part of this publication may be reproduced, stored in or introduced into a retrieval system, or transmitted in any form or by any means (electronic, mechanical, photocopying, recording, or otherwise), or for any purpose, without the express written permission of Universiti Telekom Sdn. Bhd. Due acknowledgement shall always be made of the use of any material contained in, or derived from, this report.
\end{vplace}\clearpage%
}

%%%%%%%%%%%%
% The Abstract
%%%%%%%%%%%%
\abstractintoc
\renewcommand*\abstractname{\texorpdfstring{ABSTRACT}{Abstract}}
\renewcommand*\absnamepos{center}
%\setlength\abstitleskip{0pt}
\setlength\abstitleskip{-\onelineskip}
\renewcommand\abstractnamefont{\normalsize\bfseries}
\renewcommand\abstracttextfont{\normalsize}
\setlength\absleftindent{0pt}
\setlength\absrightindent{0pt}
\newcommand{\abstractfromfile}[1]{\begin{abstract}\input{#1}\end{abstract}}

%%%%%%%%%%%%%
% Algorithms
%%%%%%%%%%%%%
\RequirePackage{algorithm}
\RequirePackage{algpseudocode}
\RequirePackage{caption}
\DeclareCaptionFormat{algorithm}{\vspace{0ex}{%
   \parbox[c][1.75em][c]{\textwidth}{#1#2\hspace{1em}#3}}\par}%\rule{\linewidth}{0.5pt}}
\captionsetup[algorithm]{format=algorithm}
%caption size change here
\captionsetup[figure]{font={scriptsize,bf}}
\captionsetup[table]{font={scriptsize,bf},position=top}
\AtBeginEnvironment{algorithmic}{\setstretch{1.5}}

%%%%%%%%%%%%
% The Cover and Title page
%%%%%%%%%%%%
\newcommand{\makecoverandtitlepage}{%
\ignorespaces
\changepage{-40mm}{-15mm}{15mm}{0em}{0em}{40mm}{0em}{0em}{0em}

%\changepage{-40mm}{-15mm}{15mm}{0em}{0em}{40mm}{0em}{0em}{0em}
%\begin{titlingpage}
%\centering\SingleSpacing%
%\renewcommand\ttdefault{lmtt}%
%\fontfamily{phv}\fontseries{mc}%\LARGE%
%\fontsize{18pt}{20pt}
%\selectfont%
%\MakeUppercase{\thetitle}\par%
%\vfill%
%\MakeUppercase{\theauthor}\par%
%\vfill%
%\MakeUppercase{\@mtdegree}\par%
%MULTIMEDIA UNIVERSITY\par%
%\MakeUppercase{\@mtsubmissionmonth}\ \@mtsubmissionyear\par%
%\end{titlingpage}%
%\clearpage
%\hspace{1em}\thispagestyle{empty}\clearpage%%Hack to insert blank page

{\centering\thispagestyle{empty}\setcounter{page}{1}%
{\SingleSpacing\LARGE\MakeUppercase{\thetitle}\par}%
\vfill%
{\setstretch{2} BY\\%
{\fontsize{16pt}{18pt}\selectfont\MakeUppercase{\theauthor}}\\\par}%
\vfill%
{\setstretch{2} THESIS SUBMITTED IN FULFILMENT OF THE\\%
REQUIREMENT FOR THE DEGREE OF\\%
\MakeUppercase{\@mtdegree}\\%
in the\\%
\@mtfaculty\par}%
\vfill%
{\SingleSpacing\fontsize{16pt}{18pt}\selectfont MULTIMEDIA UNIVERSITY\\%
MALAYSIA}\\[1em]%
\@mtsubmissionmonth\ \@mtsubmissionyear%\\[3em]%
\par\clearpage}%
%\changepage{20mm}{15mm}{-15mm}{0em}{0em}{-20mm}{0em}{0em}{0em}%
\changepage{40mm}{15mm}{-15mm}{0em}{0em}{-40mm}{0em}{0em}{0em}
\renewcommand\ttdefault{lmvtt}%
}

%%%%%%%%%%%%
% The Declaration page
% Original by Lim Lian Tze
% Edited for FoE Final Year Thesis by Chia Jason
%%%%%%%%%%%%
\newcommand{\declarationpage}{%
\chapter{Declaration}\vskip-\onelineskip
I hereby declare that this work has been done by myself and no portion of the work contained in this report has been submitted in support of any application for any other degree or qualification of this or any other university or institute of learning.
\\[1\onelineskip]
I also declare that pursuant to the provisions of the Copyright Act 1987, I have not engaged in any unauthorised act of copying or reproducing or attempt to copy / reproduce or cause to copy / reproduce or permit the copying / reproducing or the sharing and / or downloading of any copyrighted material or an attempt to do so whether by use of the University’s facilities or outside networks / facilities whether in hard copy or soft copy format, of any material protected under the provisions of sections 3 and 7 of the Act whether for payment or otherwise save as specifically provided for therein. This shall include but not be limited to any lecture notes, course packs, thesis, text books, exam questions, any works of authorship fixed in any tangible medium of expression whether provided by the University or otherwise.
\\[1\onelineskip]
I hereby further declare that in the event of any infringement of the provisions of the Act whether knowingly or unknowingly the University shall not be liable for the same in any manner whatsoever and undertakes to indemnify and keep indemnified the University against all such claims and actions.
\\[2\onelineskip]
Signature: \newlength\siglinelength
\settowidth{\siglinelength}{\bfseries\normalsize\theauthor\theauthor}
\noindent\rule{\siglinelength}{.6pt}\\
Name: {\normalsize\theauthor}\\
Student ID: {\normalsize\@mtsid}\\
Date: {\normalsize\@mtddate}\\\par\clearpage
}

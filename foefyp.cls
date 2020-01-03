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
\ProvidesClass{mmuthesis}[LaTeX2e class for MMU FoE FYP Thesis v1.0. Copyright (c) 2020 Chia Jason and Chai Yee Ting (chia_jason96@live.com)]

\LoadClass[12pt,a4paper,oneside]{memoir}
\RequirePackage{textcomp}

\newcommand{\submissionyear}[1]{\def\@mtsubmissionyear{#1}}
\newcommand{\submissionmonth}[1]{\def\@mtsubmissionmonth{#1}}
\newcommand{\faculty}[1]{\def\@mtfaculty{#1}}
\newcommand{\degree}[1]{\def\@mtdegree{#1}}

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

\RequirePackage[breaklinks,pdfborder={0 0 0},bookmarksopen,bookmarksnumbered,pdfprintscaling=None]{hyperref}
\addtoiargdef\author{}{\hypersetup{pdfauthor={\theauthor}}}
\addtoiargdef\title{}{\hypersetup{pdftitle={\thetitle}}}

%%%%%%%%%%%%
% 10pt = \footnotesize for backmatter
% And add a PDF bookmark
%%%%%%%%%%%%
\cftinsertcode{narrowertoc}{\setlength\cftbeforechapterskip{.75em}}

\patchcommand{\backmatter}{}{\footnotesize%
\cftinserthook{toc}{narrowertoc}%
\renewcommand\chapter{\@ifstar{\mystarchap}{\mychap}}
\ifpdf\pdfbookmark[-1]{Back Matter}{back}\fi}
\patchcommand{\frontmatter}{}{\ifpdf\pdfbookmark[-1]{Front Matter}{front}\fi}
\patchcommand{\mainmatter}{}{\ifpdf\pdfbookmark[-1]{Main Chapters}{main}\fi}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PAGES DEFINITIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%
% The Copyright page
%%%%%%%%%%%%
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

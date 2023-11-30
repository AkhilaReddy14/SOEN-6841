%======================================================================================
% Article Document Class for LaTeX2e
% This document class loads article class
% It is a class file: chart.cls
% Use it as \documentclass[options]{chart}



%**************************************************************************************

% IMPORTANT POINTS:

%*************************************************************************************
% This class can also be used without the article template
% It works with LaTeX, PDFLaTeX, XeLaTeX and LuaLaTeX
% Report to author if you find some errors in this file
% You are allowed to distribute this copy in any form without author  
% permission
% You are not allowed to change the name of the class file
% Your suggestions will be highly appreciated
%====================================================================================

%********************* New class: chart.cls*************************************
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{chart}[2020/05/01 v1.0 
A typographic style for nice-looking article]
\typeout{Document Class 'chart' v1.0 <01 May 20>}

%**************************Class options*********************************************
\newif\if@onecolumn
\newif\if@twocolumn

\DeclareOption{onecolumn}{\@twocolumnfalse}
\DeclareOption{twocolumn}{\@twocolumntrue}  
\DeclareOption{final}{\setlength\overfullrule{0pt}}

\def\@@ptsize{10pt} % default size
\DeclareOption{10pt}{\def\@@ptsize{10pt}}
\DeclareOption{11pt}{\def\@@ptsize{11pt}}
\DeclareOption{12pt}{\def\@@ptsize{12pt}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ExecuteOptions{a4paper,oneside,onecolumn,final}

\ProcessOptions\relax 
\LoadClass[11pt, a4paper]{article}

%*************************Important packages**************************************
\RequirePackage[T1]{fontenc}
\RequirePackage{amsmath,amsfonts,amssymb}
\RequirePackage{microtype}
\RequirePackage{xcolor}  
\RequirePackage[title]{appendix}
\RequirePackage[nottoc,notlot,notlof]{tocbibind}
\RequirePackage[bottom]{footmisc} 
\RequirePackage{graphicx} 
\RequirePackage[labelfont=bf,font=small]{caption}
\RequirePackage[labelfont=bf,font=small]{subcaption}  
\captionsetup[table]{skip=3pt}
\RequirePackage{booktabs}
\RequirePackage[margin=2cm]{geometry}
\RequirePackage{mdframed}
\newcommand{\abscolor}[2][linecolor=black]{%
\mdfsetup{leftline=false,rightline=false, #1, #2}
}  

\def\linespacing[#1]{\gdef\baselinestretch{#1}}

%*********************************Title setting*************************************** 
\def\address#1{\gdef\@address{#1}}
\global\let\@address\@empty

\def\Email#1{\gdef\@Email{\href{mailto:#1}{Email: {\color{blue}#1}}}}
\global\let\@Email\@empty
 
\def\chcopyright[#1]{\gdef\@chcopyright{#1}}
\def\@chcopyright{%
Copyright\,\textcopyright\,\@date \ by \@author. All rights reserved.
}

\def\corresauth[#1]{\textsuperscript{#1}}   
\newenvironment{frontmatter}{}{\maketitle}

\def\@maketitle{%		 	
	 \raggedright \linespacing[1]  		  	  
 	   {\Large \bfseries \color{blue!20!red} \@title\par}	   				
		\vspace{0.5\baselineskip}	
		
		{\bfseries\large \@author\par}	     
	    \vspace{.25\baselineskip} 
	    
	     {\normalsize\@address \par}
	     
	     \ifx\@Email\@empty\else
	    {\footnotetext{\@Email}\par}
	  	  \fi 
	  	   
	   \ifx\@Email\@empty\else			
       \footnotetext{\itshape \@chcopyright} 
       \fi  
}

%*************************Abstract and keywords**************************************
\abscolor{backgroundcolor=gray!10} 
\renewenvironment{abstract}[1][ABSTRACT]  
{\vspace{-0.25\baselineskip}\linespacing[1]\noindent\begin{mdframed}		
{\bfseries #1:\space}\small}{\end{mdframed}\vspace{-0.25\baselineskip}} 

\newenvironment{keywords}[1][KEYWORDS]{%
\linespacing[1]
\vspace{\baselineskip}\noindent{\bfseries #1:\space}\raggedright\small}{}

\everydisplay{%
	\abovedisplayskip \baselinestretch\abovedisplayskip%
	\belowdisplayskip \abovedisplayskip%
	\abovedisplayshortskip \baselinestretch\abovedisplayshortskip%
	\belowdisplayshortskip  \baselinestretch\belowdisplayshortskip
}

%*******************************Makecontents****************************************
% 
%*********************************Symbol list***************************************
%\RequirePackage[intoc,refpage]{nomencl}
%\newcommand*{\abbreviations}[2][4cm]{%	
%	\renewcommand*{\nomname}{#2}%		
%	\printnomenclature[#1]	
%	}
%\newcommand{\nm}[2]{\nomenclature{#1}{#2}}

\RequirePackage{longtable}
\newenvironment{symbols}[1][Abbreviations]{%	 
\noindent\section*{#1}}{}

\newcommand{\abbrev}[2]{ 
	#1:~   #2   
}

%**************************Reference and citation styles****************************
\@ifundefined{@citestyle}{\gdef\@citestyle{numbers}}{}
\InputIfFileExists{\jobname.ch}{}{}
\RequirePackage[\@citestyle]{natbib}

\newwrite{\splwrite}
\immediate\openout\splwrite=\jobname.ch
\def\citestyle[#1]{\def\next{#1}\write\splwrite{%
		\string\g@addto@macro\string\@citestyle{%
			,\expandafter\strip@prefix\meaning\next}}}
\setlength{\bibsep}{3pt} 
\renewcommand{\bibfont}{\linespacing[1]\small}

\newcommand{\refstyle}[1]{\bibliographystyle{#1}} 
   
%******************************Sections setting*************************************
\setcounter{secnumdepth}{3}
\renewcommand{\@seccntformat}[1]{\csname the#1\endcsname.~~}
\renewcommand{\section}{\@startsection {section}{1}{\z@}%
	{16\p@ \@plus 6\p@ \@minus 3\p@}%
	{9\p@ \@plus 6\p@ \@minus 3\p@}%
	{\large\bfseries}}
 
\renewcommand{\subsection}{\@startsection{subsection}{2}{\z@}%
	{12\p@ \@plus 6\p@ \@minus 3\p@}%
	{3\p@ \@plus 6\p@ \@minus 3\p@}%
	{\normalfont\normalsize\itshape}}

\renewcommand{\subsubsection}{\@startsection{subsubsection}{3}{\z@}%
	{10\p@ \@plus 6\p@ \@minus 3\p@}%
	{\p@}%
	{\normalfont\normalsize\itshape}}

\renewcommand{\paragraph}{\@startsection{paragraph}{4}{\z@}%
	{8\p@ \@plus 6\p@ \@minus 3\p@}%
	{-6\p@}%
	{\normalsize\bfseries}}

\renewcommand{\subparagraph}{\@startsection{subparagraph}{5}{\parindent}%
	{8\p@ \@plus 6\p@ \@minus 3\p@}%
	{-6\p@}%
	{\normalsize\bfseries}}

\let\chparagraph=\paragraph
\renewcommand{\paragraph}[1]{\chparagraph{#1.}}
\let\chsubparagraph=\subparagraph
\renewcommand{\subparagraph}[1]{\chsubparagraph{#1.}}
%for removing indentation of 1st paragraph of each section
\let\@afterindenttrue\@afterindentfalse  

%******************************Two-column math************************************
\RequirePackage{cuted}
\newenvironment{widetext}{%
	\begin{strip}\hrulefill
	}{%
		\hrulefill\end{strip}
}

\newenvironment{widetext*}{%
	\begin{strip}}{%
	\end{strip}
}

%***************************Some other packages*********************************** 
\RequirePackage[linkcolor=red,colorlinks,citecolor=blue]{hyperref}
\RequirePackage{cleveref} 
\crefname{equation}{Eq.}{Eqs.} 
\crefname{figure}{Fig.}{Figs.}       
\crefname{table}{Table}{Tables}  
\crefname{section}{Section}{Sections}
\crefname{appendix}{Appendix}{Appendices}
 
%**********************************Other settings**********************************
\brokenpenalty=10000             % No broken words across columns/pages
\clubpenalty=10000               % To remove orphan (single line at bottom of page)
\widowpenalty=10000	             % and widow (single line at top of page)
\interfootnotelinepenalty=9999   % Almost never break footnotes 	

\setlength{\textfloatsep}{12pt plus 1pt minus 2pt}
%\renewcommand\topfraction{.9}
%\renewcommand{\textfraction}{0.35}
%\renewcommand\floatpagefraction{0.8}

\setlength{\parskip}{0\p@}
\setlength{\columnsep}{12\p@}
\setlength{\columnseprule}{0\p@}

\pagestyle{plain}
\pagenumbering{arabic}
\sloppy
\raggedbottom

\linespacing[1.33]

\endinput

% File \tex{chart.cls} ends here.
%===================================================================================




















%%
%%  Journal of Networking and Network Applications.cls
%% V1.0
%% 2020/01/24
%% see https://iecscience.org/journals/J-NaNA
%% for current contact information.
%%
%% J-NaNA is a LaTeX class for authors of the Networking and Network Applications(NaNA) journals and conferences
%% The latest version of the J-NaNA package can be found at J-NaNA's site:
%% https://iecscience.org/journals/J-NaNA
%% 
%% 
%%
%% This is the original J-NaNA.cls version.






\ProvidesClass{NaNAtran}[2020/01/29 V1.0]

\NeedsTeXFormat{LaTeX2e}


\def\NaNAtransversionmajor{1}
\def\NaNAtransversionminor{8}



\def\@NaNAclspkgerror{\ClassError{NaNAtran}}


% These do nothing, but provide them like in article.cls
\newif\if@restonecol
\newif\if@titlepage


% class option conditionals
\newif\ifCLASSOPTIONonecolumn       \CLASSOPTIONonecolumnfalse
\newif\ifCLASSOPTIONtwocolumn       \CLASSOPTIONtwocolumntrue

\newif\ifCLASSOPTIONoneside         \CLASSOPTIONonesidetrue
\newif\ifCLASSOPTIONtwoside         \CLASSOPTIONtwosidefalse

\newif\ifCLASSOPTIONfinal           \CLASSOPTIONfinaltrue
\newif\ifCLASSOPTIONdraft           \CLASSOPTIONdraftfalse
\newif\ifCLASSOPTIONdraftcls        \CLASSOPTIONdraftclsfalse
\newif\ifCLASSOPTIONdraftclsnofoot  \CLASSOPTIONdraftclsnofootfalse

\newif\ifCLASSOPTIONpeerreview      \CLASSOPTIONpeerreviewfalse
\newif\ifCLASSOPTIONpeerreviewca    \CLASSOPTIONpeerreviewcafalse

\newif\ifCLASSOPTIONjournal         \CLASSOPTIONjournaltrue
\newif\ifCLASSOPTIONconference      \CLASSOPTIONconferencefalse
\newif\ifCLASSOPTIONtechnote        \CLASSOPTIONtechnotefalse

\newif\ifCLASSOPTIONnofonttune      \CLASSOPTIONnofonttunefalse

\newif\ifCLASSOPTIONcaptionsoff     \CLASSOPTIONcaptionsofffalse

\newif\ifCLASSOPTIONcomsoc          \CLASSOPTIONcomsocfalse
\newif\ifCLASSOPTIONcompsoc         \CLASSOPTIONcompsocfalse
\newif\ifCLASSOPTIONtransmag        \CLASSOPTIONtransmagfalse

\newif\ifCLASSOPTIONromanappendices \CLASSOPTIONromanappendicesfalse


% class info conditionals

% indicates if pdf (via pdflatex) output
\newif\ifCLASSINFOpdf               \CLASSINFOpdffalse


% V1.6b internal flag to show if using a4paper
\newif\if@NaNAusingAfourpaper       \@NaNAusingAfourpaperfalse
% V1.6b internal flag to show if using cspaper
\newif\if@NaNAusingcspaper          \@NaNAusingcspaperfalse


% NaNAtran class scratch pad registers
% dimen
\newdimen\@NaNAtrantmpdimenA
\newdimen\@NaNAtrantmpdimenB
\newdimen\@NaNAtrantmpdimenC
% count
\newcount\@NaNAtrantmpcountA
\newcount\@NaNAtrantmpcountB
\newcount\@NaNAtrantmpcountC
% token list
\newtoks\@NaNAtrantmptoksA

% we use \CLASSOPTIONpt so that we can ID the point size (even for 9pt docs)
% as well as LaTeX's \@ptsize to retain some compatability with some
% external packages
\def\@ptsize{0}
% LaTeX does not support 9pt, so we set \@ptsize to 0 - same as that of 10pt
\DeclareOption{9pt}{\def\CLASSOPTIONpt{9}\def\@ptsize{0}}
\DeclareOption{10pt}{\def\CLASSOPTIONpt{10}\def\@ptsize{0}}
\DeclareOption{11pt}{\def\CLASSOPTIONpt{11}\def\@ptsize{1}}
\DeclareOption{12pt}{\def\CLASSOPTIONpt{12}\def\@ptsize{2}}



\DeclareOption{letterpaper}{\setlength{\paperwidth}{8.5in}%
                            \setlength{\paperheight}{11in}%
                            \@NaNAusingAfourpaperfalse
                            \@NaNAusingcspaperfalse
                            \def\CLASSOPTIONpaper{letter}%
                            \def\CLASSINFOpaperwidth{8.5in}%
                            \def\CLASSINFOpaperheight{11in}}


\DeclareOption{a4paper}{\setlength{\paperwidth}{210mm}%
                        \setlength{\paperheight}{297mm}%
                        \@NaNAusingAfourpapertrue
                        \@NaNAusingcspaperfalse
                        \def\CLASSOPTIONpaper{a4}%
                        \def\CLASSINFOpaperwidth{210mm}%
                        \def\CLASSINFOpaperheight{297mm}}

% special paper option for compsoc journals
\DeclareOption{cspaper}{\setlength{\paperwidth}{7.875in}%
                        \setlength{\paperheight}{10.75in}%
                        \@NaNAusingcspapertrue
                        \@NaNAusingAfourpaperfalse
                        \def\CLASSOPTIONpaper{NaNAcs}%
                        \def\CLASSINFOpaperwidth{7.875in}%
                        \def\CLASSINFOpaperheight{10.75in}}

\DeclareOption{oneside}{\@twosidefalse\@mparswitchfalse
                        \CLASSOPTIONonesidetrue\CLASSOPTIONtwosidefalse}
\DeclareOption{twoside}{\@twosidetrue\@mparswitchtrue
                        \CLASSOPTIONtwosidetrue\CLASSOPTIONonesidefalse}

\DeclareOption{onecolumn}{\CLASSOPTIONonecolumntrue\CLASSOPTIONtwocolumnfalse}
\DeclareOption{twocolumn}{\CLASSOPTIONtwocolumntrue\CLASSOPTIONonecolumnfalse}

% If the user selects draft, then this class AND any packages
% will go into draft mode.
\DeclareOption{draft}{\CLASSOPTIONdrafttrue\CLASSOPTIONdraftclstrue
                      \CLASSOPTIONdraftclsnofootfalse} 
% draftcls is for a draft mode which will not affect any packages
% used by the document.
\DeclareOption{draftcls}{\CLASSOPTIONdraftfalse\CLASSOPTIONdraftclstrue
                         \CLASSOPTIONdraftclsnofootfalse} 
% draftclsnofoot is like draftcls, but without the footer.
\DeclareOption{draftclsnofoot}{\CLASSOPTIONdraftfalse\CLASSOPTIONdraftclstrue
                               \CLASSOPTIONdraftclsnofoottrue} 
\DeclareOption{final}{\CLASSOPTIONdraftfalse\CLASSOPTIONdraftclsfalse
                      \CLASSOPTIONdraftclsnofootfalse}

\DeclareOption{journal}{\CLASSOPTIONpeerreviewfalse\CLASSOPTIONpeerreviewcafalse
                        \CLASSOPTIONjournaltrue\CLASSOPTIONconferencefalse\CLASSOPTIONtechnotefalse}

\DeclareOption{conference}{\CLASSOPTIONpeerreviewfalse\CLASSOPTIONpeerreviewcafalse
                           \CLASSOPTIONjournalfalse\CLASSOPTIONconferencetrue\CLASSOPTIONtechnotefalse}

\DeclareOption{technote}{\CLASSOPTIONpeerreviewfalse\CLASSOPTIONpeerreviewcafalse
                         \CLASSOPTIONjournalfalse\CLASSOPTIONconferencefalse\CLASSOPTIONtechnotetrue}

\DeclareOption{peerreview}{\CLASSOPTIONpeerreviewtrue\CLASSOPTIONpeerreviewcafalse
                           \CLASSOPTIONjournalfalse\CLASSOPTIONconferencefalse\CLASSOPTIONtechnotefalse}

\DeclareOption{peerreviewca}{\CLASSOPTIONpeerreviewtrue\CLASSOPTIONpeerreviewcatrue
                             \CLASSOPTIONjournalfalse\CLASSOPTIONconferencefalse\CLASSOPTIONtechnotefalse}

\DeclareOption{nofonttune}{\CLASSOPTIONnofonttunetrue}

\DeclareOption{captionsoff}{\CLASSOPTIONcaptionsofftrue}

\DeclareOption{comsoc}{\CLASSOPTIONcomsoctrue\CLASSOPTIONcompsocfalse\CLASSOPTIONtransmagfalse}

\DeclareOption{compsoc}{\CLASSOPTIONcomsocfalse\CLASSOPTIONcompsoctrue\CLASSOPTIONtransmagfalse}

\DeclareOption{transmag}{\CLASSOPTIONtransmagtrue\CLASSOPTIONcomsocfalse\CLASSOPTIONcompsocfalse}

\DeclareOption{romanappendices}{\CLASSOPTIONromanappendicestrue}


% default to US letter paper, 10pt, twocolumn, one sided, final, journal
\ExecuteOptions{letterpaper,10pt,twocolumn,oneside,final,journal}
% overrride these defaults per user requests
\ProcessOptions



%% -- Command Argument Scanning Support Functions --

% Sets the category codes for punctuation to their normal values.
% For local use with argument scanning.
\def\NaNAnormalcatcodespunct{\catcode`\!=12 \catcode`\,=12 \catcode`\:=12
\catcode`\;=12 \catcode`\`=12 \catcode`\'=12 \catcode`\"=12 \catcode`\.=12
\catcode`\/=12 \catcode`\?=12 \catcode`\*=12 \catcode`\+=12 \catcode`\-=12
\catcode`\<=12 \catcode`\>=12 \catcode`\(=12 \catcode`\)=12 \catcode`\[=12
\catcode`\]=12 \catcode`\==12 \catcode`\|=12}
% Sets the category codes for numbers to their normal values.
% For local use with argument scanning.
\def\NaNAnormalcatcodesnum{\catcode`\0=12 \catcode`\1=12 \catcode`\2=12
\catcode`\3=12 \catcode`\4=12 \catcode`\5=12 \catcode`\6=12 \catcode`\7=12
\catcode`\8=12 \catcode`\9=12}
% combined action of \NaNAnormalcatcodespunct and \NaNAnormalcatcodesnum
\def\NaNAnormalcatcodes{\NaNAnormalcatcodespunct\NaNAnormalcatcodesnum}


% usage: \@NaNAextracttoken*{}
% \@NaNAextracttoken fully expands its argument (which it then stores in
% \@NaNAextracttokenarg) via \edef and then the meaning of the first
% nonbrace (but including the empty group) token found is assigned via \let
% to \@NaNAextractedtoken as well as stored in the macro
% \@NaNAextractedtokenmacro. Tokens that would otherwise be discarded during
% the acquisition of the first are stored in \@NaNAextractedtokensdiscarded,
% however their original relative brace nesting depths are not guaranteed to
% be preserved.
% If the argument is empty, or if a first nonbrace token does not exist (or
% is an empty group), \@NaNAextractedtoken will be \relax and
% \@NaNAextractedtokenmacro and \@NaNAextractedtokensdiscarded will be empty.
%
% For example:
% \@NaNAextracttoken{{{ab}{cd}}{{ef}g}}
% results in:
%
% \@NaNAextracttokenarg          ==> a macro containing {{ab}{cd}}{{ef}g}
% \@NaNAextractedtoken           ==> the letter a
% \@NaNAextractedtokenmacro      ==> a macro containing a
% \@NaNAextractedtokensdiscarded ==> a macro containing bcd{ef}g
%
% the *-star form, \@NaNAextracttoken*, does not expand its argument
% contents during processing.
\def\@NaNAextracttoken{\@ifstar{\let\@NaNAextracttokendef=\def\@@NaNAextracttoken}{\let\@NaNAextracttokendef=\edef\@@NaNAextracttoken}}

\def\@@NaNAextracttoken#1{\@NaNAextracttokendef\@NaNAextracttokenarg{#1}\relax
\def\@NaNAextractedtokensdiscarded{}\relax % initialize to empty
% if the macro is unchanged after being acquired as a single undelimited argument
% with anything after it being stripped off as a delimited argument
% we know we have one token without any enclosing braces. loop until this is true.
\let\@NaNAextracttokencurgroup\@NaNAextracttokenarg
\loop
  % trap case of an empty argument as this would cause a problem with
  % \@@@NaNAextracttoken's first (nondelimited) argument acquisition
  \ifx\@NaNAextracttokencurgroup\@empty
    \def\@NaNAextractedtokenmacro{}\relax
  \else
    \expandafter\@@@NaNAextracttoken\@NaNAextracttokencurgroup\@NaNAgeneralsequenceDELIMITER\relax
  \fi
  \ifx\@NaNAextractedtokenmacro\@NaNAextracttokencurgroup
  \else
    \let\@NaNAextracttokencurgroup=\@NaNAextractedtokenmacro
\repeat
% we can safely do a \let= here because there should be at most one token
% the relax is needed to handle the case of no token found
\expandafter\let\expandafter\@NaNAextractedtoken\@NaNAextractedtokenmacro\relax}

\def\@@@NaNAextracttoken#1#2\@NaNAgeneralsequenceDELIMITER{\def\@NaNAextractedtokenmacro{#1}\relax
\def\@@NaNAextractedtokensdiscarded{#2}\expandafter\expandafter\expandafter\def\expandafter\expandafter\expandafter
\@NaNAextractedtokensdiscarded\expandafter\expandafter\expandafter
{\expandafter\@@NaNAextractedtokensdiscarded\@NaNAextractedtokensdiscarded}}
%%
%% -- End of Command Argument Scanning Support Functions --



% Computer Society conditional execution command
\long\def\@NaNAcompsoconly#1{\relax\ifCLASSOPTIONcompsoc\relax#1\relax\fi\relax}
% inverse
\long\def\@NaNAnotcompsoconly#1{\relax\ifCLASSOPTIONcompsoc\else\relax#1\relax\fi\relax}
% compsoc conference
\long\def\@NaNAcompsocconfonly#1{\relax\ifCLASSOPTIONcompsoc\ifCLASSOPTIONconference\relax#1\relax\fi\fi\relax}
% compsoc not conference
\long\def\@NaNAcompsocnotconfonly#1{\relax\ifCLASSOPTIONcompsoc\ifCLASSOPTIONconference\else\relax#1\relax\fi\fi\relax}


% comsoc verify that newtxmath, mtpro2, mt11p or mathtime has been loaded
\def\@NaNAcomsocverifymathfont{\typeout{-- Verifying Times compatible math font.}\relax
  \@ifpackageloaded{newtxmath}{\typeout{-- newtxmath loaded, OK.}}{\@@NaNAcomsocverifymathfont}}
\def\@@NaNAcomsocverifymathfont{\@ifpackageloaded{mtpro2}{\typeout{-- mtpro2 loaded, OK.}}{\@@@NaNAcomsocverifymathfont}}
\def\@@@NaNAcomsocverifymathfont{\@ifpackageloaded{mt11p}{\typeout{-- mt11p2 loaded, OK.}}{\@@@@NaNAcomsocverifymathfont}}
\def\@@@@NaNAcomsocverifymathfont{\@ifpackageloaded{mathtime}{\typeout{-- mathtime loaded, OK.}}{\@NaNAcomsocenforcemathfont}}

% comsoc, if a Times math font was not loaded by user, enforce it
\def\@NaNAcomsocenforcemathfont{\typeout{** Times compatible math font not found, forcing.}\relax
\IfFileExists{newtxmath.sty}{\typeout{-- Found newtxmath, loading.}\RequirePackage{newtxmath}}{\@@NaNAcomsocenforcemathfont}}
\def\@@NaNAcomsocenforcemathfont{\IfFileExists{mtpro2.sty}{\typeout{-- Found mtpro2, loading.}\RequirePackage{mtpro2}}{\@@@NaNAcomsocenforcemathfont}}
\def\@@@NaNAcomsocenforcemathfont{\IfFileExists{mt11p.sty}{\typeout{-- Found mt11p, loading.}\RequirePackage{mt11p}}{\@@@@NaNAcomsocenforcemathfont}}
\def\@@@@NaNAcomsocenforcemathfont{\IfFileExists{mathtime.sty}{\typeout{-- Found mathtime, loading.}\RequirePackage{mathtime}}{\@@@@@NaNAcomsocenforcemathfont}}
% if no acceptable Times math font package found, error with newtxmath requirement
\def\@@@@@NaNAcomsocenforcemathfont{\typeout{** No Times compatible math font package found. newtxmath is required.}\RequirePackage{newtxmath}}


\ifCLASSOPTIONcomsoc
  % ensure that if newtxmath is used, the cmintegrals option is also invoked
  \PassOptionsToPackage{cmintegrals}{newtxmath}
  % comsoc requires a Times like math font
  % ensure this requirement is satisfied at document start
  \AtBeginDocument{\@NaNAcomsocverifymathfont}
\fi




\renewcommand{\sfdefault}{phv}
\renewcommand{\rmdefault}{ptm}
\renewcommand{\ttdefault}{pcr}


\@NaNAcompsocnotconfonly{\renewcommand{\rmdefault}{ppl}}

% enable the selected main text font
\normalfont\selectfont


\ifCLASSOPTIONcomsoc
  \typeout{-- Using NaNA Communications Society mode.}
\fi

\ifCLASSOPTIONcompsoc
  \typeout{-- Using NaNA Computer Society mode.}
\fi



\def\@NaNAconsolenoticeconference{\typeout{}%
\typeout{** Conference Paper **}%
\typeout{Before submitting the final camera ready copy, remember to:}%
\typeout{}%
\typeout{ 1. Manually equalize the lengths of two columns on the last page}%
\typeout{ of your paper;}%
\typeout{}%
\typeout{ 2. Ensure that any PostScript and/or PDF output post-processing}%
\typeout{ uses only Type 1 fonts and that every step in the generation}%
\typeout{ process uses the appropriate paper size.}%
\typeout{}}


% we can send console reminder messages to the user here
\AtEndDocument{\ifCLASSOPTIONconference\@NaNAconsolenoticeconference\fi}


% warn about the use of single column other than for draft mode
\ifCLASSOPTIONtwocolumn\else%
  \ifCLASSOPTIONdraftcls\else%
   \typeout{** ATTENTION: Single column mode is not typically used with NaNA publications.}%
  \fi%
\fi



{\@ifundefined{pdfoutput}{\AtBeginDvi{\special{papersize=\CLASSINFOpaperwidth,\CLASSINFOpaperheight}}}{%
% pdfoutput is defined and not equal to \relax
% check for pdfpageheight existence just in case someone sets pdfoutput
% under non-pdflatex. If exists, set them regardless of value of \pdfoutput.
\@ifundefined{pdfpageheight}{\relax}{\global\pdfpagewidth\paperwidth
\global\pdfpageheight\paperheight}%
% if using \pdfoutput=0 under pdflatex, send dvips papersize special
\ifcase\pdfoutput
\AtBeginDvi{\special{papersize=\CLASSINFOpaperwidth,\CLASSINFOpaperheight}}%
\else
% we are using pdf output, set CLASSINFOpdf flag
\global\CLASSINFOpdftrue
\fi}}

% let the user know the selected papersize
\typeout{-- Using \CLASSINFOpaperwidth\space x \CLASSINFOpaperheight\space
(\CLASSOPTIONpaper)\space paper.}

\ifCLASSINFOpdf
\typeout{-- Using PDF output.}
\else
\typeout{-- Using DVI output.}
\fi





% pointsize values
% used with ifx to determine the document's normal size
\def\@NaNAptsizenine{9}
\def\@NaNAptsizeten{10}
\def\@NaNAptsizeeleven{11}
\def\@NaNAptsizetwelve{12}




\newdimen\@NaNAnormalsizeunitybaselineskip
\@NaNAnormalsizeunitybaselineskip\baselineskip






% 9pt option defaults
\ifx\CLASSOPTIONpt\@NaNAptsizenine
\typeout{-- This is a 9 point document.}
\def\normalsize{\@setfontsize{\normalsize}{9}{11.0476pt}}
\setlength{\@NaNAnormalsizeunitybaselineskip}{11.0476pt}
\normalsize
\abovedisplayskip 1.5ex plus 3pt minus 1pt
\belowdisplayskip \abovedisplayskip
\abovedisplayshortskip 0pt plus 3pt
\belowdisplayshortskip 1.5ex plus 3pt minus 1pt
\def\small{\@setfontsize{\small}{8.5}{10pt}}
\def\footnotesize{\@setfontsize{\footnotesize}{8}{9pt}}
\def\scriptsize{\@setfontsize{\scriptsize}{7}{8pt}}
\def\tiny{\@setfontsize{\tiny}{5}{6pt}}
% sublargesize is the same as large - 10pt
\def\sublargesize{\@setfontsize{\sublargesize}{10}{12pt}}
\def\large{\@setfontsize{\large}{10}{12pt}}
\def\Large{\@setfontsize{\Large}{12}{14pt}}
\def\LARGE{\@setfontsize{\LARGE}{14}{17pt}}
\def\huge{\@setfontsize{\huge}{17}{20pt}}
\def\Huge{\@setfontsize{\Huge}{20}{24pt}}
\fi
%
% 10pt option defaults
\ifx\CLASSOPTIONpt\@NaNAptsizeten
\typeout{-- This is a 10 point document.}
\def\normalsize{\@setfontsize{\normalsize}{10}{12.00pt}}
\setlength{\@NaNAnormalsizeunitybaselineskip}{12pt}
\normalsize
\abovedisplayskip 1.5ex plus 4pt minus 2pt
\belowdisplayskip \abovedisplayskip
\abovedisplayshortskip 0pt plus 4pt
\belowdisplayshortskip 1.5ex plus 4pt minus 2pt
\def\small{\@setfontsize{\small}{9}{10pt}}
\def\footnotesize{\@setfontsize{\footnotesize}{8}{9pt}}
\def\scriptsize{\@setfontsize{\scriptsize}{7}{8pt}}
\def\tiny{\@setfontsize{\tiny}{5}{6pt}}
% sublargesize is a tad smaller than large - 11pt
\def\sublargesize{\@setfontsize{\sublargesize}{11}{13.4pt}}
\def\large{\@setfontsize{\large}{12}{14pt}}
\def\Large{\@setfontsize{\Large}{14}{17pt}}
\def\LARGE{\@setfontsize{\LARGE}{17}{20pt}}
\def\huge{\@setfontsize{\huge}{20}{24pt}}
\def\Huge{\@setfontsize{\Huge}{24}{28pt}}
\fi
%
% 11pt option defaults
\ifx\CLASSOPTIONpt\@NaNAptsizeeleven
\typeout{-- This is an 11 point document.}
\def\normalsize{\@setfontsize{\normalsize}{11}{13.3846pt}}
\setlength{\@NaNAnormalsizeunitybaselineskip}{13.3846pt}
\normalsize
\abovedisplayskip 1.5ex plus 5pt minus 3pt
\belowdisplayskip \abovedisplayskip
\abovedisplayshortskip 0pt plus 5pt
\belowdisplayshortskip 1.5ex plus 5pt minus 3pt
\def\small{\@setfontsize{\small}{10}{12pt}}
\def\footnotesize{\@setfontsize{\footnotesize}{9}{10.5pt}}
\def\scriptsize{\@setfontsize{\scriptsize}{8}{9pt}}
\def\tiny{\@setfontsize{\tiny}{6}{7pt}}
% sublargesize is the same as large - 12pt
\def\sublargesize{\@setfontsize{\sublargesize}{12}{14pt}}
\def\large{\@setfontsize{\large}{12}{14pt}}
\def\Large{\@setfontsize{\Large}{14}{17pt}}
\def\LARGE{\@setfontsize{\LARGE}{17}{20pt}}
\def\huge{\@setfontsize{\huge}{20}{24pt}}
\def\Huge{\@setfontsize{\Huge}{24}{28pt}}
\fi
%
% 12pt option defaults
\ifx\CLASSOPTIONpt\@NaNAptsizetwelve
\typeout{-- This is a 12 point document.}
\def\normalsize{\@setfontsize{\normalsize}{12}{13.92pt}}
\setlength{\@NaNAnormalsizeunitybaselineskip}{13.92pt}
\normalsize
\abovedisplayskip 1.5ex plus 6pt minus 4pt
\belowdisplayskip \abovedisplayskip
\abovedisplayshortskip 0pt plus 6pt
\belowdisplayshortskip 1.5ex plus 6pt minus 4pt
\def\small{\@setfontsize{\small}{10}{12pt}}
\def\footnotesize{\@setfontsize{\footnotesize}{9}{10.5pt}}
\def\scriptsize{\@setfontsize{\scriptsize}{8}{9pt}}
\def\tiny{\@setfontsize{\tiny}{6}{7pt}}
% sublargesize is the same as large - 14pt
\def\sublargesize{\@setfontsize{\sublargesize}{14}{17pt}}
\def\large{\@setfontsize{\large}{14}{17pt}}
\def\Large{\@setfontsize{\Large}{17}{20pt}}
\def\LARGE{\@setfontsize{\LARGE}{20}{24pt}}
\def\huge{\@setfontsize{\huge}{22}{26pt}}
\def\Huge{\@setfontsize{\Huge}{24}{28pt}}
\fi




% compsoc font sizes use bp "Postscript" point units (1/72in) 
% rather than the traditional pt (1/72.27)
\ifCLASSOPTIONcompsoc
% -- compsoc defaults --
% ** will override some of these values later **
% 9pt
\ifx\CLASSOPTIONpt\@NaNAptsizenine
\def\normalsize{\@setfontsize{\normalsize}{9bp}{11bp}}
\setlength{\@NaNAnormalsizeunitybaselineskip}{11bp}
\normalsize
\abovedisplayskip 1.5ex plus 3bp minus 1bp
\belowdisplayskip \abovedisplayskip
\abovedisplayshortskip 0bp plus 3bp
\belowdisplayshortskip 1.5ex plus 3bp minus 1bp
\def\small{\@setfontsize{\small}{8.5bp}{10bp}}
\def\footnotesize{\@setfontsize{\footnotesize}{8bp}{9bp}}
\def\scriptsize{\@setfontsize{\scriptsize}{7bp}{8bp}}
\def\tiny{\@setfontsize{\tiny}{5bp}{6bp}}
% sublargesize is the same as large - 10bp
\def\sublargesize{\@setfontsize{\sublargesize}{10bp}{12bp}}
\def\large{\@setfontsize{\large}{10bp}{12bp}}
\def\Large{\@setfontsize{\Large}{12bp}{14bp}}
\def\LARGE{\@setfontsize{\LARGE}{14bp}{17bp}}
\def\huge{\@setfontsize{\huge}{17bp}{20bp}}
\def\Huge{\@setfontsize{\Huge}{20bp}{24bp}}
\fi
%
% 10pt
\ifx\CLASSOPTIONpt\@NaNAptsizeten
\def\normalsize{\@setfontsize{\normalsize}{10bp}{12bp}}
\setlength{\@NaNAnormalsizeunitybaselineskip}{12bp}
\normalsize
\abovedisplayskip 1.5ex plus 4bp minus 2bp
\belowdisplayskip \abovedisplayskip
\abovedisplayshortskip 0pt plus 4bp
\belowdisplayshortskip 1.5ex plus 4bp minus 2bp
\def\small{\@setfontsize{\small}{9bp}{10bp}}
\def\footnotesize{\@setfontsize{\footnotesize}{8bp}{9bp}}
\def\scriptsize{\@setfontsize{\scriptsize}{7bp}{8bp}}
\def\tiny{\@setfontsize{\tiny}{5bp}{6bp}}
% sublargesize is a tad smaller than large - 11bp
\def\sublargesize{\@setfontsize{\sublargesize}{11bp}{13.5bp}}
\def\large{\@setfontsize{\large}{12bp}{14bp}}
\def\Large{\@setfontsize{\Large}{14bp}{17bp}}
\def\LARGE{\@setfontsize{\LARGE}{17bp}{20bp}}
\def\huge{\@setfontsize{\huge}{20bp}{24bp}}
\def\Huge{\@setfontsize{\Huge}{24bp}{28bp}}
\fi
%
% 11pt
\ifx\CLASSOPTIONpt\@NaNAptsizeeleven
\def\normalsize{\@setfontsize{\normalsize}{11bp}{13.5bp}}
\setlength{\@NaNAnormalsizeunitybaselineskip}{13.5bp}
\normalsize
\abovedisplayskip 1.5ex plus 5bp minus 3bp
\belowdisplayskip \abovedisplayskip
\abovedisplayshortskip 0pt plus 5bp
\belowdisplayshortskip 1.5ex plus 5bp minus 3bp
\def\small{\@setfontsize{\small}{10bp}{12bp}}
\def\footnotesize{\@setfontsize{\footnotesize}{9bp}{10.5bp}}
\def\scriptsize{\@setfontsize{\scriptsize}{8bp}{9bp}}
\def\tiny{\@setfontsize{\tiny}{6bp}{7bp}}
% sublargesize is the same as large - 12bp
\def\sublargesize{\@setfontsize{\sublargesize}{12bp}{14bp}}
\def\large{\@setfontsize{\large}{12bp}{14bp}}
\def\Large{\@setfontsize{\Large}{14bp}{17bp}}
\def\LARGE{\@setfontsize{\LARGE}{17bp}{20bp}}
\def\huge{\@setfontsize{\huge}{20bp}{24bp}}
\def\Huge{\@setfontsize{\Huge}{24bp}{28bp}}
\fi
%
% 12pt
\ifx\CLASSOPTIONpt\@NaNAptsizetwelve
\def\normalsize{\@setfontsize{\normalsize}{12bp}{14bp}}%
\setlength{\@NaNAnormalsizeunitybaselineskip}{14bp}%
\normalsize
\abovedisplayskip 1.5ex plus 6bp minus 4bp
\belowdisplayskip \abovedisplayskip
\abovedisplayshortskip 0pt plus 6bp
\belowdisplayshortskip 1.5ex plus 6bp minus 4bp
\def\small{\@setfontsize{\small}{10bp}{12bp}}
\def\footnotesize{\@setfontsize{\footnotesize}{9bp}{10.5bp}}
\def\scriptsize{\@setfontsize{\scriptsize}{8bp}{9bp}}
\def\tiny{\@setfontsize{\tiny}{6bp}{7bp}}
% sublargesize is the same as large - 14bp
\def\sublargesize{\@setfontsize{\sublargesize}{14bp}{17bp}}
\def\large{\@setfontsize{\large}{14bp}{17bp}}
\def\Large{\@setfontsize{\Large}{17bp}{20bp}}
\def\LARGE{\@setfontsize{\LARGE}{20bp}{24bp}}
\def\huge{\@setfontsize{\huge}{22bp}{26bp}}
\def\Huge{\@setfontsize{\Huge}{24bp}{28bp}}
\fi
%
% -- override defaults: compsoc journals use special normalsizes --
\ifCLASSOPTIONconference
% 
% compsoc conferences
% 9pt
\ifx\CLASSOPTIONpt\@NaNAptsizenine
\def\normalsize{\@setfontsize{\normalsize}{9bp}{10.8bp}}
\setlength{\@NaNAnormalsizeunitybaselineskip}{10.8bp}
\normalsize
\abovedisplayskip 1.5ex plus 3bp minus 1bp
\belowdisplayskip \abovedisplayskip
\abovedisplayshortskip 0bp plus 3bp
\belowdisplayshortskip 1.5ex plus 3bp minus 1bp
\fi
% 10pt
\ifx\CLASSOPTIONpt\@NaNAptsizeten
\def\normalsize{\@setfontsize{\normalsize}{10bp}{11.2bp}}
\setlength{\@NaNAnormalsizeunitybaselineskip}{11.2bp}
\normalsize
\abovedisplayskip 1.5ex plus 4bp minus 2bp
\belowdisplayskip \abovedisplayskip
\abovedisplayshortskip 0pt plus 4bp
\belowdisplayshortskip 1.5ex plus 4bp minus 2bp
\fi
% 11pt
\ifx\CLASSOPTIONpt\@NaNAptsizeeleven
\def\normalsize{\@setfontsize{\normalsize}{11bp}{13.2bp}}
\setlength{\@NaNAnormalsizeunitybaselineskip}{13.2bp}
\normalsize
\abovedisplayskip 1.5ex plus 5bp minus 3bp
\belowdisplayskip \abovedisplayskip
\abovedisplayshortskip 0pt plus 5bp
\belowdisplayshortskip 1.5ex plus 5bp minus 3bp
\fi
% 12pt
\ifx\CLASSOPTIONpt\@NaNAptsizetwelve
\def\normalsize{\@setfontsize{\normalsize}{12bp}{14.4bp}}
\setlength{\@NaNAnormalsizeunitybaselineskip}{14.4bp}
\normalsize
\abovedisplayskip 1.5ex plus 6bp minus 4bp
\belowdisplayskip \abovedisplayskip
\abovedisplayshortskip 0pt plus 6bp
\belowdisplayshortskip 1.5ex plus 6bp minus 4bp
\fi
% 
% compsoc nonconferences
\else
% 9pt
\ifx\CLASSOPTIONpt\@NaNAptsizenine
\def\normalsize{\@setfontsize{\normalsize}{9bp}{10.8bp}}
\setlength{\@NaNAnormalsizeunitybaselineskip}{10.8bp}
\normalsize
\abovedisplayskip 1.5ex plus 3bp minus 1bp
\belowdisplayskip \abovedisplayskip
\abovedisplayshortskip 0bp plus 3bp
\belowdisplayshortskip 1.5ex plus 3bp minus 1bp
\fi
% 10pt
\ifx\CLASSOPTIONpt\@NaNAptsizeten
% the official spec is 9.5bp with 11.4bp leading for 10pt,
% but measurements of proofs suggest upto 11.723bp leading
% here we'll use 11.54bp which gives 61 lines per column
% with the standard compsoc margins
\def\normalsize{\@setfontsize{\normalsize}{9.5bp}{11.54bp}}
\setlength{\@NaNAnormalsizeunitybaselineskip}{11.54bp}
\normalsize
\abovedisplayskip 1.5ex plus 4bp minus 2bp
\belowdisplayskip \abovedisplayskip
\abovedisplayshortskip 0pt plus 4bp
\belowdisplayshortskip 1.5ex plus 4bp minus 2bp
\fi
% 11pt
\ifx\CLASSOPTIONpt\@NaNAptsizeeleven
\def\normalsize{\@setfontsize{\normalsize}{11bp}{13.2bp}}
\setlength{\@NaNAnormalsizeunitybaselineskip}{13.2bp}
\normalsize
\abovedisplayskip 1.5ex plus 5bp minus 3bp
\belowdisplayskip \abovedisplayskip
\abovedisplayshortskip 0pt plus 5bp
\belowdisplayshortskip 1.5ex plus 5bp minus 3bp
\fi
% 12pt
\ifx\CLASSOPTIONpt\@NaNAptsizetwelve
\def\normalsize{\@setfontsize{\normalsize}{12bp}{14.4bp}}
\setlength{\@NaNAnormalsizeunitybaselineskip}{14.4bp}
\normalsize
\abovedisplayskip 1.5ex plus 6bp minus 4bp
\belowdisplayskip \abovedisplayskip
\abovedisplayshortskip 0pt plus 6bp
\belowdisplayshortskip 1.5ex plus 6bp minus 4bp
\fi
\fi\fi





\def\fontsubfuzz{1.7bp}


% warn the user in case they forget to use the 9pt option with
% technote
\ifCLASSOPTIONtechnote%
 \ifx\CLASSOPTIONpt\@NaNAptsizenine\else%
  \typeout{** ATTENTION: Technotes are normally 9pt documents.}%
 \fi%
\fi




\def\@NaNAstringptm{ptm} % Times Roman family
\def\@NaNAstringppl{ppl} % Palatino Roman family
\def\@NaNAstringphv{phv} % Helvetica Sans Serif family
\def\@NaNAstringpcr{pcr} % Courier typewriter family
\def\@NaNAstringcmtt{cmtt} % Computer Modern typewriter family
\DeclareTextCommandDefault{\textunderscore}{\leavevmode
\ifx\f@family\@NaNAstringpcr\string_\else
\ifx\f@family\@NaNAstringcmtt\string_\else
\ifx\f@family\@NaNAstringptm\kern 0em\vbox{\hrule\@width 0.5em\@height 0.5pt\kern -0.3ex}\else
\ifx\f@family\@NaNAstringppl\kern 0em\vbox{\hrule\@width 0.5em\@height 0.5pt\kern -0.3ex}\else
\ifx\f@family\@NaNAstringphv\kern -0.03em\vbox{\hrule\@width 0.62em\@height 0.52pt\kern -0.33ex}\kern -0.03em\else
\kern 0.09em\vbox{\hrule\@width 0.6em\@height 0.44pt\kern -0.63pt\kern -0.42ex}\kern 0.09em\fi\fi\fi\fi\fi\relax}





\def\baselinestretch{1}
\ifCLASSOPTIONdraftcls
  \def\baselinestretch{1.5}% default baselinestretch for draft modes
\fi 


% process CLASSINPUT baselinestretch
\ifx\CLASSINPUTbaselinestretch\@NaNAundefined
\else
  \edef\baselinestretch{\CLASSINPUTbaselinestretch} % user CLASSINPUT override
  \typeout{** ATTENTION: Overriding \string\baselinestretch\space to
           \baselinestretch\space via \string\CLASSINPUT.}
\fi

\small\normalsize % make \baselinestretch take affect




% store the normalsize baselineskip
\newdimen\CLASSINFOnormalsizebaselineskip
\CLASSINFOnormalsizebaselineskip=\baselineskip\relax
% and the normalsize unity (baselinestretch=1) baselineskip
% we could save a register by giving the user access to
% \@NaNAnormalsizeunitybaselineskip. However, let's protect
% its read only internal status
\newdimen\CLASSINFOnormalsizeunitybaselineskip
\CLASSINFOnormalsizeunitybaselineskip=\@NaNAnormalsizeunitybaselineskip\relax
% store the nominal value of jot
\newdimen\NaNAnormaljot
\NaNAnormaljot=0.25\baselineskip\relax

% set \jot
\jot=\NaNAnormaljot\relax





% However, the NaNA allows for a more generous range which reduces the need
% for hyphenation, especially for two column text. Furthermore, the NaNA
% tends to use a little bit more nominal space between the words.
% The NaNA's interword spacing percentages appear to be:
% 35% nominal
% 23% minimum
% 50% maximum
% (They may even be using a tad more for the largest fonts such as 24pt.)
% 
% for bold text, the NaNA increases the spacing a little more:
% 37.5% nominal
% 23% minimum
% 55% maximum

% here are the interword spacing ratios we'll use
% for medium (normal weight)
\def\@NaNAinterspaceratioM{0.35}
\def\@NaNAinterspaceMINratioM{0.23}
\def\@NaNAinterspaceMAXratioM{0.50}

% for bold
\def\@NaNAinterspaceratioB{0.375}
\def\@NaNAinterspaceMINratioB{0.23}
\def\@NaNAinterspaceMAXratioB{0.55}


% compsoc nonconference papers use Palatino,
% tweak settings to better match the proofs
\ifCLASSOPTIONcompsoc
\ifCLASSOPTIONconference\else
% for medium (normal weight)
\def\@NaNAinterspaceratioM{0.28}
\def\@NaNAinterspaceMINratioM{0.21}
\def\@NaNAinterspaceMAXratioM{0.47}
% for bold
\def\@NaNAinterspaceratioB{0.305}
\def\@NaNAinterspaceMINratioB{0.21}
\def\@NaNAinterspaceMAXratioB{0.52}
\fi\fi


% command to revise the interword spacing for the current font under TeX:
% \fontdimen2 = nominal interword space
% \fontdimen3 = interword stretch
% \fontdimen4 = interword shrink
% since all changes to the \fontdimen are global, we can enclose these commands
% in braces to confine any font attribute or length changes
\def\@@@NaNAsetfontdimens#1#2#3{{%
\setlength{\@NaNAtrantmpdimenB}{\f@size pt}% grab the font size in pt, could use 1em instead.
\setlength{\@NaNAtrantmpdimenA}{#1\@NaNAtrantmpdimenB}%
\fontdimen2\font=\@NaNAtrantmpdimenA\relax
\addtolength{\@NaNAtrantmpdimenA}{-#2\@NaNAtrantmpdimenB}%
\fontdimen3\font=-\@NaNAtrantmpdimenA\relax
\setlength{\@NaNAtrantmpdimenA}{#1\@NaNAtrantmpdimenB}%
\addtolength{\@NaNAtrantmpdimenA}{-#3\@NaNAtrantmpdimenB}%
\fontdimen4\font=\@NaNAtrantmpdimenA\relax}}

% revise the interword spacing for each font weight
\def\@@NaNAsetfontdimens{{%
\mdseries
\@@@NaNAsetfontdimens{\@NaNAinterspaceratioM}{\@NaNAinterspaceMAXratioM}{\@NaNAinterspaceMINratioM}%
\bfseries
\@@@NaNAsetfontdimens{\@NaNAinterspaceratioB}{\@NaNAinterspaceMAXratioB}{\@NaNAinterspaceMINratioB}%
}}

% revise the interword spacing for each font shape
% \slshape is not often used for NaNA work and is not altered here. The \scshape caps are
% already a tad too large in the free LaTeX fonts (as compared to what the NaNA uses) so we
% won't alter these either.
\def\@NaNAsetfontdimens{{%
\normalfont
\@@NaNAsetfontdimens
\normalfont\itshape
\@@NaNAsetfontdimens
}}

% command to revise the interword spacing for each font size (and shape
% and weight). Only the \rmfamily is done here as \ttfamily uses a 
% fixed spacing and \sffamily is not used as the main text of NaNA papers.
\def\@NaNAtunefonts{{\selectfont\rmfamily
\tiny\@NaNAsetfontdimens
\scriptsize\@NaNAsetfontdimens
\footnotesize\@NaNAsetfontdimens
\small\@NaNAsetfontdimens
\normalsize\@NaNAsetfontdimens
\sublargesize\@NaNAsetfontdimens
\large\@NaNAsetfontdimens
\LARGE\@NaNAsetfontdimens
\huge\@NaNAsetfontdimens
\Huge\@NaNAsetfontdimens}}

% if the nofonttune class option is not given, revise the interword spacing
% now - in case NaNAtran makes any default length measurements, and make
% sure all the default fonts are loaded
\ifCLASSOPTIONnofonttune\else
\@NaNAtunefonts
\fi

% and again at the start of the document in case the user loaded different fonts
\AtBeginDocument{\ifCLASSOPTIONnofonttune\else\@NaNAtunefonts\fi}





% -- V1.8a page setup commands --

% The default sample text for calculating margins
% Note that NaNA publications use \scriptsize for headers and footers.
\def\NaNAdefaultsampletext{\normalfont\normalsize gT}
\def\NaNAdefaultheadersampletext{\normalfont\scriptsize T}% NaNA headers default to uppercase
\def\NaNAdefaultfootersampletext{\normalfont\scriptsize gT}



% usage: \NaNAsettextwidth{inner margin}{outer margin}
% Sets \textwidth to allow the specified inner and outer margins
% for the current \paperwidth.
\def\NaNAsettextwidth#1#2{\@NaNAtrantmpdimenA\paperwidth
\@NaNAtrantmpdimenB#1\relax
\advance\@NaNAtrantmpdimenA by -\@NaNAtrantmpdimenB
\@NaNAtrantmpdimenB#2\relax
\advance\@NaNAtrantmpdimenA by -\@NaNAtrantmpdimenB
\textwidth\@NaNAtrantmpdimenA}




\def\NaNAsetsidemargin#1#2{\@NaNAtrantmpdimenA #2\relax
\@NaNAextracttoken{#1}\relax
% check for mode errors
\ifx\@NaNAextractedtokenmacro\@empty
  \@NaNAclspkgerror{Empty mode type in \string\NaNAsetsidemargin\space (line \the\inputlineno).\MessageBreak
  Defaulting to `i'}{Valid modes for \string\NaNAsetsidemargin\space are: i, o, c and a.}\relax
  \let\@NaNAextractedtoken=i\relax
  \def\@NaNAextractedtokenmacro{i}\relax
\else
  \ifx\@NaNAextractedtokensdiscarded\@empty\else
    \typeout{** WARNING: \string\NaNAsetsidemargin\space mode specifiers after the first in `\@NaNAextracttokenarg' ignored (line \the\inputlineno).}\relax
  \fi
\fi
% handle each mode
\if\@NaNAextractedtoken a\relax
  \advance\oddsidemargin by \@NaNAtrantmpdimenA\relax
\else
\if\@NaNAextractedtoken c\relax
  \oddsidemargin\paperwidth
  \advance\oddsidemargin by -\textwidth
  \divide\oddsidemargin by 2\relax
  \advance\oddsidemargin by -1in\relax
  \advance\oddsidemargin by \@NaNAtrantmpdimenA\relax
\else
\if\@NaNAextractedtoken o\relax
  \oddsidemargin\paperwidth
  \advance\oddsidemargin by -\textwidth
  \advance\oddsidemargin by -\@NaNAtrantmpdimenA
  \advance\oddsidemargin by -1in\relax
\else
  \if\@NaNAextractedtoken i\relax
  \else
    \@NaNAclspkgerror{Unknown mode type `\@NaNAextractedtokenmacro' in \string\NaNAsetsidemargin\space (line \the\inputlineno).\MessageBreak
    Defaulting to `i'}%
    {Valid modes for \string\NaNAsetsidemargin\space are: i, o, c  and a.}%
  \fi
  \oddsidemargin\@NaNAtrantmpdimenA
  \advance\oddsidemargin by -1in\relax
\fi\fi\fi
% odd and even side margins both mean "inner" for single sided pages
\evensidemargin\oddsidemargin
% but are mirrors of each other when twosided is in effect
\if@twoside
  \evensidemargin\paperwidth
  \advance\evensidemargin by -\textwidth
  \advance\evensidemargin by -\oddsidemargin
  % have to compensate for both the builtin 1in LaTex offset
  % and the fact we already subtracted this offset from \oddsidemargin
  \advance\evensidemargin -2in\relax
\fi}



% usage: \NaNAsettextheight[sample text]{top text margin}{bottom text margin}
% Sets \textheight based on the specified top margin and bottom margin.
% Takes into consideration \paperheight, \topskip, and (by default) the
% the actual height and depth of the \NaNAdefaultsampletext text. 
\def\NaNAsettextheight{\@ifnextchar [{\@NaNAsettextheight}{\@NaNAsettextheight[\NaNAdefaultsampletext]}}
\def\@NaNAsettextheight[#1]#2#3{\textheight\paperheight\relax
  \@NaNAtrantmpdimenA #2\relax
  \advance \textheight by -\@NaNAtrantmpdimenA% subtract top margin
  \@NaNAtrantmpdimenA #3\relax
  \advance \textheight by -\@NaNAtrantmpdimenA% subtract bottom margin
  \advance \textheight by \topskip% add \topskip
  % subtract off everything above the top, and below the bottom, baselines
  \settoheight{\@NaNAtrantmpdimenA}{\begingroup #1\relax\relax\relax\endgroup}\relax
  \advance \textheight by -\@NaNAtrantmpdimenA
  \settodepth{\@NaNAtrantmpdimenA}{\begingroup #1\relax\relax\relax\endgroup}\relax
  \advance \textheight by -\@NaNAtrantmpdimenA}



\newdimen\NaNAquantizedlength
\NaNAquantizedlength 0sp\relax
\newdimen\NaNAquantizedlengthdiff
\NaNAquantizedlengthdiff 0sp\relax
\def\NaNAquantizedlengthint{0}

% usage: \NaNAquantizelength{mode: d, c, i}{base unit}{length}
% Sets the length \NaNAquantizedlength to be an integer multiple of the given
% (nonzero) base unit such that \NaNAquantizedlength approximates the given
% length.
% \NaNAquantizedlengthdiff is a length equal to the difference between the
% \NaNAquantizedlength and the given length.
% \NaNAquantizedlengthint is a macro containing the integer number of base units
% in \NaNAquantizedlength.
% i.e., \NaNAquantizedlength =  \NaNAquantizedlengthint * base unit
% The mode determines how \NaNAquantizedlength is quantized:
% d = always decrease (always round down \NaNAquantizeint)
% c = use the closest match
% i = always increase (always round up \NaNAquantizeint)
% In anycase, if the given length is already quantized,
% \NaNAquantizedlengthdiff will be set to zero.
\def\NaNAquantizelength#1#2#3{\begingroup
% work in isolation so as not to externally disturb the \@NaNAtrantmp
% variables
% load the argument values indirectly via \NaNAquantizedlengthdiff
% in case the user refers to our \@NaNAtrantmpdimenX, \NaNAquantizedlength,
% etc. in the arguments. we also will work with these as counters,
% i.e., in sp units
% A has the base unit
\NaNAquantizedlengthdiff #2\relax\relax\relax\relax
\@NaNAtrantmpcountA\NaNAquantizedlengthdiff
% B has the input length
\NaNAquantizedlengthdiff #3\relax\relax\relax\relax
\@NaNAtrantmpcountB\NaNAquantizedlengthdiff
\@NaNAtrantmpdimenA\the\@NaNAtrantmpcountA sp\relax
\@NaNAtrantmpdimenB\the\@NaNAtrantmpcountB sp\relax
% \@NaNAtrantmpcountC will have the quantized int
% \NaNAquantizedlength will have the quantized length
% \@NaNAtrantmpdimenC will have the quantized diff
% initialize them to zero as this is what will be
% exported if an error occurs
\@NaNAtrantmpcountC 0\relax
\NaNAquantizedlength 0sp\relax
\@NaNAtrantmpdimenC 0sp\relax
% extract mode
\@NaNAextracttoken{#1}\relax
% check for mode errors
\ifx\@NaNAextractedtokenmacro\@empty
  \@NaNAclspkgerror{Empty mode type in \string\NaNAquantizelength\space (line \the\inputlineno).\MessageBreak
  Defaulting to `d'}{Valid modes for \string\NaNAquantizelength\space are: d, c and i.}\relax
  \let\@NaNAextractedtoken=d\relax
  \def\@NaNAextractedtokenmacro{d}\relax
\else
  \ifx\@NaNAextractedtokensdiscarded\@empty\else
    \typeout{** WARNING: \string\NaNAquantizelength\space mode specifiers after the first in `\@NaNAextracttokenarg' ignored (line \the\inputlineno).}\relax
  \fi
\fi
% check for base unit is zero error
\ifnum\@NaNAtrantmpcountA=0\relax
\@NaNAclspkgerror{Base unit is zero in \string\NaNAquantizelength\space (line \the\inputlineno).\MessageBreak
  \string\NaNAquantizedlength\space and \string\NaNAquantizedlengthdiff\space are set to zero}{Division by zero is not allowed.}\relax
\else% base unit is nonzero
  % \@NaNAtrantmpcountC carries the number of integer units
  % in the quantized length (integer length \ base)
  \@NaNAtrantmpcountC\@NaNAtrantmpcountB\relax
  \divide\@NaNAtrantmpcountC by \@NaNAtrantmpcountA\relax
  % \NaNAquantizedlength has the (rounded down) quantized length
  % = base * int
  \NaNAquantizedlength\@NaNAtrantmpdimenA\relax
  \multiply\NaNAquantizedlength by \@NaNAtrantmpcountC\relax
  % \@NaNAtrantmpdimenC has the difference
  % = quantized length - length
  \@NaNAtrantmpdimenC\NaNAquantizedlength\relax
  \advance\@NaNAtrantmpdimenC by -\@NaNAtrantmpdimenB\relax
  % trap special case of length being already quantized
  % to avoid a roundup under i option
  \ifdim\@NaNAtrantmpdimenC=0sp\relax
  \else % length not is already quantized
    % set dimenA to carry the upper quantized (absolute value) difference:
    % quantizedlength + base - length
    \advance\@NaNAtrantmpdimenA by \NaNAquantizedlength\relax
    \advance\@NaNAtrantmpdimenA by -\@NaNAtrantmpdimenB\relax
    % set dimenB to carry the lower quantized (absolute value) difference:
    % length - quantizedlength
    \advance\@NaNAtrantmpdimenB by -\NaNAquantizedlength\relax
    % handle each mode
    \if\@NaNAextractedtoken c\relax
      % compare upper and lower amounts, select upper if lower > upper
      \ifdim\@NaNAtrantmpdimenB>\@NaNAtrantmpdimenA\relax
        % use upper
        \advance\NaNAquantizedlength by \the\@NaNAtrantmpcountA sp\relax
        \advance\@NaNAtrantmpcountC by 1\relax
        \@NaNAtrantmpdimenC\@NaNAtrantmpdimenA
      \else% <=. uselower
        % no need to do anything for lower, use output values already setup
      \fi
    \else% not mode c
    \if\@NaNAextractedtoken i\relax
      % always round up under i mode
      \advance\NaNAquantizedlength by \the\@NaNAtrantmpcountA sp\relax
      \advance\@NaNAtrantmpcountC by 1\relax
      \@NaNAtrantmpdimenC\@NaNAtrantmpdimenA
    \else
      \if\@NaNAextractedtoken d\relax
      \else
        \@NaNAclspkgerror{Unknown mode type `\@NaNAextractedtokenmacro' in \string\NaNAquantizelength\space (line \the\inputlineno).\MessageBreak
        Defaulting to `d'}%
        {Valid modes for \string\NaNAquantizelength\space are: d, c, and i.}\relax
      \fi % if d
      % no need to do anything for d, use output values already setup
    \fi\fi % if i, c
  \fi % if length is already quantized
\fi% if base unit is zero
% globally assign the results to macros we use here to escape the enclosing
% group without needing to call \global on any of the \@NaNAtrantmp variables.
% \@NaNAtrantmpcountC has the quantized int
% \NaNAquantizedlength has the quantized length
% \@NaNAtrantmpdimenC has the quantized diff
\xdef\@NaNAquantizedlengthintmacro{\the\@NaNAtrantmpcountC}\relax
\@NaNAtrantmpcountC\NaNAquantizedlength\relax
\xdef\@NaNAquantizedlengthmacro{\the\@NaNAtrantmpcountC}\relax
\@NaNAtrantmpcountC\@NaNAtrantmpdimenC\relax
\xdef\@NaNAquantizedlengthdiffmacro{\the\@NaNAtrantmpcountC}\relax
\endgroup
% locally assign the outputs here from the macros
\expandafter\NaNAquantizedlength\@NaNAquantizedlengthmacro sp\relax
\expandafter\NaNAquantizedlengthdiff\@NaNAquantizedlengthdiffmacro sp\relax
\edef\NaNAquantizedlengthint{\@NaNAquantizedlengthintmacro}\relax}



\newdimen\NaNAquantizedtextheightdiff
\NaNAquantizedtextheightdiff 0sp\relax

% usage: \NaNAquantizetextheight[base unit]{mode: d, c, i}
% Sets \textheight to be an integer multiple of the current \baselineskip
% (or the optionally specified base unit) plus the first (\topskip) line.
% \NaNAquantizedtextheightdiff is a length equal to the difference between
% the new quantized and original \textheight.
% \NaNAquantizedtextheightlpc is a macro containing the integer number of
% lines per column under the quantized \textheight. i.e.,
% \textheight = \NaNAquantizedtextheightlpc * \baselineskip + \topskip
% The mode determines how \textheight is quantized:
% d = always decrease (always round down the number of lines per column)
% c = use the closest match
% i = always increase (always round up the number of lines per column)
% In anycase, if \textheight is already quantized, it will remain unchanged,
% and \NaNAquantizedtextheightdiff will be set to zero.
% Depends on: \NaNAquantizelength
\def\NaNAquantizetextheight{\@ifnextchar [{\@NaNAquantizetextheight}{\@NaNAquantizetextheight[\baselineskip]}}
\def\@NaNAquantizetextheight[#1]#2{\begingroup
% use our \NaNAquantizedtextheightdiff as a scratch pad
% we need to subtract off \topskip before quantization
\NaNAquantizedtextheightdiff\textheight
\advance\NaNAquantizedtextheightdiff by -\topskip\relax
\NaNAquantizelength{#2}{#1}{\NaNAquantizedtextheightdiff}
% add back \topskip line
\advance\NaNAquantizedlength by \topskip
\@NaNAtrantmpcountC\NaNAquantizedlengthint\relax
\advance\@NaNAtrantmpcountC by 1\relax
% globally assign the results to macros we use here to escape the enclosing
% group without needing to call \global on any of the \@NaNAtrantmp variables.
\xdef\@NaNAquantizedtextheightlpcmacro{\the\@NaNAtrantmpcountC}\relax
\@NaNAtrantmpcountC\NaNAquantizedlength\relax
\xdef\@NaNAquantizedtextheightmacro{\the\@NaNAtrantmpcountC}\relax
\@NaNAtrantmpcountC\NaNAquantizedlengthdiff\relax
\xdef\@NaNAquantizedtextheightdiffmacro{\the\@NaNAtrantmpcountC}\relax
\endgroup
% locally assign the outputs here from the macros
\textheight\@NaNAquantizedtextheightmacro sp\relax
\NaNAquantizedtextheightdiff\@NaNAquantizedtextheightdiffmacro sp\relax
\edef\NaNAquantizedtextheightlpc{\@NaNAquantizedtextheightlpcmacro}}



% usage: \NaNAsettopmargin[sample text]{mode: t, b, c, a, q}{margin/offset}
% Sets \topmargin based on the specified vertical margin.
% Takes into consideration the base 1in offset, \headheight, \headsep,
% \topskip, and (by default) the the actual height (or, for the bottom, depth)
% of the \NaNAdefaultsampletext text.
% The available modes are:
% t = top margin
% b = bottom margin
% c = vertically centered, with the given offset
% a = adjust the vertical margins using the given offset
% q = adjust the margins using \NaNAquantizedtextheightdiff and the given offset
% For the offsets, positive values increase the top margin.
% \headheight, \headsep, \topskip and \textheight should be set properly for the
% given margins before calling this function.
\def\NaNAsettopmargin{\@ifnextchar [{\@NaNAsettopmargin}{\@NaNAsettopmargin[\NaNAdefaultsampletext]}}
\def\@NaNAsettopmargin[#1]#2#3{\@NaNAtrantmpdimenA #3\relax
\@NaNAextracttoken{#2}\relax
% check for mode errors
\ifx\@NaNAextractedtokenmacro\@empty
  \@NaNAclspkgerror{Empty mode type in \string\NaNAsettopmargin\space (line \the\inputlineno).\MessageBreak
  Defaulting to `t'}{Valid modes for \string\NaNAsettopmargin\space are: t, b, c, a and q.}\relax
  \let\@NaNAextractedtoken=t\relax
  \def\@NaNAextractedtokenmacro{t}\relax
\else
  \ifx\@NaNAextractedtokensdiscarded\@empty\else
    \typeout{** WARNING: \string\NaNAsettopmargin\space mode specifiers after the first in `\@NaNAextracttokenarg' ignored (line \the\inputlineno).}\relax
  \fi
\fi
% handle each mode
\if\@NaNAextractedtoken a\relax
  \advance\topmargin by \@NaNAtrantmpdimenA\relax
\else
\if\@NaNAextractedtoken q\relax
  % we need to adjust by half the \NaNAquantizedtextheightdiff value
  \@NaNAtrantmpdimenB\NaNAquantizedtextheightdiff\relax
  \divide\@NaNAtrantmpdimenB by 2\relax
  % a positive \NaNAquantizedtextheightdiff means we need to reduce \topmargin
  % because \textheight has been lenghtened
  \advance\topmargin by -\@NaNAtrantmpdimenB\relax
  \advance\topmargin by \@NaNAtrantmpdimenA\relax
\else
\if\@NaNAextractedtoken c\relax
  \topmargin\paperheight
  \advance\topmargin by -\textheight
  % \textheight includes \topskip, but we should not count topskip whitespace here, backout
  \advance \topmargin by \topskip
  \settoheight{\@NaNAtrantmpdimenB}{\begingroup #1\relax\relax\relax\endgroup}\relax
  \advance\topmargin by -\@NaNAtrantmpdimenB\relax
  \settodepth{\@NaNAtrantmpdimenB}{\begingroup #1\relax\relax\relax\endgroup}\relax
  \advance\topmargin by -\@NaNAtrantmpdimenB\relax
  \divide\topmargin by 2\relax
  \advance\topmargin by \@NaNAtrantmpdimenA\relax
\else
\if\@NaNAextractedtoken b\relax
  \topmargin\paperheight
  \advance\topmargin by -\textheight
  % \textheight includes \topskip, but we should not count topskip whitespace here, backout
  \advance \topmargin by \topskip
  \settodepth{\@NaNAtrantmpdimenB}{\begingroup #1\relax\relax\relax\endgroup}\relax
  \advance\topmargin by -\@NaNAtrantmpdimenB\relax
  \advance\topmargin by -\@NaNAtrantmpdimenA\relax
\else
  \if\@NaNAextractedtoken t\relax
  \else
    \@NaNAclspkgerror{Unknown mode type `\@NaNAextractedtokenmacro' in \string\NaNAsettopmargin\space (line \the\inputlineno).\MessageBreak
    Defaulting to `t'}%
    {Valid modes for \string\NaNAsettopmargin\space are: t, b, c, a and q.}\relax
  \fi
  \topmargin\@NaNAtrantmpdimenA\relax
  \settoheight{\@NaNAtrantmpdimenB}{\begingroup #1\relax\relax\relax\endgroup}\relax
  \advance\topmargin by \@NaNAtrantmpdimenB\relax
\fi\fi % if t, b, c
% convert desired top margin into actual \topmargin
% this is not done for the q or a modes because they are only adjustments
\advance \topmargin by -\topskip
\advance \topmargin by -1in
\advance \topmargin by -\headheight
\advance \topmargin by -\headsep
\fi\fi % if q, a
}



% usage: \NaNAsetheadermargin[header sample][text sample]{mode: t, b, c, a}{margin/offset}
% Differentially adjusts \topmargin and \headsep (such that their sum is unchanged)
% based on the specified header margin.
% Takes into consideration the base 1in offset, \headheight, \topskip, and (by default)
% the actual height (or depth) of the \NaNAdefaultheadersampletext and
% \NaNAdefaultsampletext text.
% The available modes are:
% t = top margin (top of the header text to the top of the page)
% b = bottom margin (bottom of the header text to the top of the main text)
% c = vertically centered between the main text and the top of the page,
%     with the given offset
% a = adjust the vertical position using the given offset
% For the offsets, positive values move the header downward.
% \headheight, \headsep, \topskip and \topmargin should be set properly before
% calling this function.
\def\NaNAsetheadermargin{\@ifnextchar [{\@NaNAsetheadermargin}{\@NaNAsetheadermargin[\NaNAdefaultheadersampletext]}}
\def\@NaNAsetheadermargin[#1]{\@ifnextchar [{\@@NaNAsetheadermargin[#1]}{\@@NaNAsetheadermargin[#1][\NaNAdefaultsampletext]}}
\def\@@NaNAsetheadermargin[#1][#2]#3#4{\@NaNAtrantmpdimenA #4\relax
\@NaNAextracttoken{#3}\relax
% check for mode errors
\ifx\@NaNAextractedtokenmacro\@empty
  \@NaNAclspkgerror{Empty mode type in \string\NaNAsetheadermargin\space (line \the\inputlineno).\MessageBreak
  Defaulting to `t'}{Valid modes for \string\NaNAsetheadermargin\space are: t, b, c, and a.}\relax
  \let\@NaNAextractedtoken=t\relax
  \def\@NaNAextractedtokenmacro{t}\relax
\else
  \ifx\@NaNAextractedtokensdiscarded\@empty\else
    \typeout{** WARNING: \string\NaNAsetheadermargin\space mode specifiers after the first in `\@NaNAextracttokenarg' ignored (line \the\inputlineno).}\relax
  \fi
\fi
% handle each mode
\if\@NaNAextractedtoken a\relax
  % No need to do anything here and can pass through the adjustment
  % value as is. The end adjustment of \topmargin and \headsep will
  % do all that is needed
\else
\if\@NaNAextractedtoken c\relax
  % get the bottom margin
  \@NaNAtrantmpdimenB\headsep\relax
  \settodepth{\@NaNAtrantmpdimenC}{\begingroup #1\relax\relax\relax\endgroup}\relax
  \advance\@NaNAtrantmpdimenB by -\@NaNAtrantmpdimenC
  \advance\@NaNAtrantmpdimenB by \topskip
  \settoheight{\@NaNAtrantmpdimenC}{\begingroup #2\relax\relax\relax\endgroup}\relax
  \advance\@NaNAtrantmpdimenB by -\@NaNAtrantmpdimenC
  % at this point \@NaNAtrantmpdimenB has the actual header bottom margin
  % subtract from it the top header margin
  \advance\@NaNAtrantmpdimenB -1in\relax % take into consideration the system 1in offset of the top margin
  \advance\@NaNAtrantmpdimenB by -\topmargin
  \advance\@NaNAtrantmpdimenB by -\headheight
  \settoheight{\@NaNAtrantmpdimenC}{\begingroup #1\relax\relax\relax\endgroup}\relax
  \advance\@NaNAtrantmpdimenB by \@NaNAtrantmpdimenC
  % at this point \@NaNAtrantmpdimenB has the difference between the bottom and top margins
  % we need to adjust by half this amount to center the header
  \divide\@NaNAtrantmpdimenB by 2\relax
  % and add to offset
  \advance\@NaNAtrantmpdimenA by \@NaNAtrantmpdimenB
\else
\if\@NaNAextractedtoken b\relax
  \@NaNAtrantmpdimenB\headsep\relax
  \settodepth{\@NaNAtrantmpdimenC}{\begingroup #1\relax\relax\relax\endgroup}\relax
  \advance\@NaNAtrantmpdimenB by -\@NaNAtrantmpdimenC
  \advance\@NaNAtrantmpdimenB by \topskip
  \settoheight{\@NaNAtrantmpdimenC}{\begingroup #2\relax\relax\relax\endgroup}\relax
  \advance\@NaNAtrantmpdimenB by -\@NaNAtrantmpdimenC
  % at this point \@NaNAtrantmpdimenB has the actual header bottom margin
  % get the difference between the actual and the desired
  \advance\@NaNAtrantmpdimenB by -\@NaNAtrantmpdimenA
  \@NaNAtrantmpdimenA\@NaNAtrantmpdimenB
\else
  \if\@NaNAextractedtoken t\relax
  \else
    \@NaNAclspkgerror{Unknown mode type `\@NaNAextractedtokenmacro' in \string\NaNAsetheadermargin\space (line \the\inputlineno).\MessageBreak
    Defaulting to `t'}%
    {Valid modes for \string\NaNAsetheadermargin\space are: t, b, c and a.}\relax
  \fi
  \@NaNAtrantmpdimenB 1in\relax % take into consideration the system 1in offset of the top margin
  \advance\@NaNAtrantmpdimenB by \topmargin
  \advance\@NaNAtrantmpdimenB by \headheight
  \settoheight{\@NaNAtrantmpdimenC}{\begingroup #1\relax\relax\relax\endgroup}\relax
  \advance\@NaNAtrantmpdimenB by -\@NaNAtrantmpdimenC
  % at this point \@NaNAtrantmpdimenB has the actual header top margin
  % get the difference between the desired and the actual
  \advance\@NaNAtrantmpdimenA by -\@NaNAtrantmpdimenB
\fi\fi % if t, b, c
\fi % if a
% advance \topmargin by the needed amount and reduce \headsep by the same
% so as not to disturb the location of the main text
\advance\topmargin by \@NaNAtrantmpdimenA\relax
\advance\headsep by -\@NaNAtrantmpdimenA\relax
}



% usage: \NaNAsetfootermargin[footer sample][text sample]{mode: t, b, c, a}{margin/offset}
% Adjusts \footskip based on the specified footer margin.
% Takes into consideration the base 1in offset, \paperheight, \headheight,
% \headsep, \textheight and (by default) the actual height (or depth) of the
% \NaNAdefaultfootersampletext and \NaNAdefaultsampletext text.
% The available modes are:
% t = top margin (top of the footer text to the bottom of the main text)
% b = bottom margin (bottom of the footer text to the bottom of page)
% c = vertically centered between the main text and the bottom of the page,
%     with the given offset
% a = adjust the vertical position using the given offset
% For the offsets, positive values move the footer downward.
% \headheight, \headsep, \topskip, \topmargin, and \textheight should be set
% properly before calling this function.
\def\NaNAsetfootermargin{\@ifnextchar [{\@NaNAsetfootermargin}{\@NaNAsetfootermargin[\NaNAdefaultfootersampletext]}}
\def\@NaNAsetfootermargin[#1]{\@ifnextchar [{\@@NaNAsetfootermargin[#1]}{\@@NaNAsetfootermargin[#1][\NaNAdefaultsampletext]}}
\def\@@NaNAsetfootermargin[#1][#2]#3#4{\@NaNAtrantmpdimenA #4\relax
\@NaNAextracttoken{#3}\relax
% check for mode errors
\ifx\@NaNAextractedtokenmacro\@empty
  \@NaNAclspkgerror{Empty mode type in \string\NaNAsetfootermargin\space (line \the\inputlineno).\MessageBreak
  Defaulting to `t'}{Valid modes for \string\NaNAsetfootermargin\space are: t, b, c, and a.}\relax
  \let\@NaNAextractedtoken=t\relax
  \def\@NaNAextractedtokenmacro{t}\relax
\else
  \ifx\@NaNAextractedtokensdiscarded\@empty\else
    \typeout{** WARNING: \string\NaNAsetfootermargin\space mode specifiers after the first in `\@NaNAextracttokenarg' ignored (line \the\inputlineno).}\relax
  \fi
\fi
% handle each mode
\if\@NaNAextractedtoken a\relax
  % No need to do anything here and can pass through the adjustment
  % value as is. The end adjustment of \footskip will do all that
  % is needed
\else
\if\@NaNAextractedtoken c\relax
  % calculate the bottom margin
  \@NaNAtrantmpdimenB 1in\relax % system 1in offset
  \advance\@NaNAtrantmpdimenB\topmargin\relax
  \advance\@NaNAtrantmpdimenB\headheight\relax
  \advance\@NaNAtrantmpdimenB\headsep\relax
  \advance\@NaNAtrantmpdimenB\textheight\relax
  \advance\@NaNAtrantmpdimenB\footskip\relax
  \settodepth{\@NaNAtrantmpdimenC}{\begingroup #1\relax\relax\relax\endgroup}\relax
  \advance\@NaNAtrantmpdimenC by \@NaNAtrantmpdimenB
  \@NaNAtrantmpdimenB\paperheight
  \advance\@NaNAtrantmpdimenB by -\@NaNAtrantmpdimenC
  % at this point \@NaNAtrantmpdimenB has the actual footer bottom margin
  % now subtract off the footer top margin
  \advance\@NaNAtrantmpdimenB -\footskip\relax
  \settodepth{\@NaNAtrantmpdimenC}{\begingroup #2\relax\relax\relax\endgroup}\relax
  \advance\@NaNAtrantmpdimenB by \@NaNAtrantmpdimenC
  \settoheight{\@NaNAtrantmpdimenC}{\begingroup #1\relax\relax\relax\endgroup}\relax
  \advance\@NaNAtrantmpdimenB by \@NaNAtrantmpdimenC
  % at this point \@NaNAtrantmpdimenB has the difference between the bottom
  % and top footer margins
  % our adjustment must be half this value to center the footer
  \divide\@NaNAtrantmpdimenB by 2\relax
  % add to the offset
  \advance\@NaNAtrantmpdimenA by \@NaNAtrantmpdimenB
\else
\if\@NaNAextractedtoken b\relax
  % calculate the bottom margin
  \@NaNAtrantmpdimenB 1in\relax % system 1in offset
  \advance\@NaNAtrantmpdimenB\topmargin\relax
  \advance\@NaNAtrantmpdimenB\headheight\relax
  \advance\@NaNAtrantmpdimenB\headsep\relax
  \advance\@NaNAtrantmpdimenB\textheight\relax
  \advance\@NaNAtrantmpdimenB\footskip\relax
  \settodepth{\@NaNAtrantmpdimenC}{\begingroup #1\relax\relax\relax\endgroup}\relax
  \advance\@NaNAtrantmpdimenC by \@NaNAtrantmpdimenB
  \@NaNAtrantmpdimenB\paperheight
  \advance\@NaNAtrantmpdimenB by -\@NaNAtrantmpdimenC
  % at this point \@NaNAtrantmpdimenB has the actual footer bottom margin
  % get the difference between the actual and the desired
  \advance\@NaNAtrantmpdimenB by -\@NaNAtrantmpdimenA
  \@NaNAtrantmpdimenA\@NaNAtrantmpdimenB
\else
  \if\@NaNAextractedtoken t\relax
  \else
    \@NaNAclspkgerror{Unknown mode type `\@NaNAextractedtokenmacro' in \string\NaNAsetfootermargin\space (line \the\inputlineno).\MessageBreak
    Defaulting to `t'}%
    {Valid modes for \string\NaNAsetfootermargin\space are: t, b, c and a.}\relax
  \fi
  \@NaNAtrantmpdimenB\footskip\relax
  \settodepth{\@NaNAtrantmpdimenC}{\begingroup #2\relax\relax\relax\endgroup}\relax
  \advance\@NaNAtrantmpdimenB by -\@NaNAtrantmpdimenC
  \settoheight{\@NaNAtrantmpdimenC}{\begingroup #1\relax\relax\relax\endgroup}\relax
  \advance\@NaNAtrantmpdimenB by -\@NaNAtrantmpdimenC
  % at this point \@NaNAtrantmpdimenB has the actual footer top margin
  % get the difference between the desired and the actual
  \advance\@NaNAtrantmpdimenA by -\@NaNAtrantmpdimenB
\fi\fi % if t, b, c
\fi % if a
% advance \footskip by the needed amount
\advance\footskip by \@NaNAtrantmpdimenA\relax
}

% -- End V1.8a page setup commands --





% V1.6
% LaTeX is a little to quick to use hyphenations
% So, we increase the penalty for their use and raise
% the badness level that triggers an underfull hbox
% warning. The author may still have to tweak things,
% but the appearance will be much better "right out
% of the box" than that under V1.5 and prior.
% TeX default is 50
\hyphenpenalty=750
\ifCLASSOPTIONcompsoc
\hyphenpenalty 500
\fi
% If we didn't adjust the interword spacing, 2200 might be better.
% The TeX default is 1000
\hbadness=1350
% The NaNA does not use extra spacing after punctuation
\frenchspacing

% V1.7 increase this a tad to discourage equation breaks
\binoppenalty=1000 % default 700
\relpenalty=800     % default 500

% v1.8a increase these to discourage widows and orphans
\clubpenalty=1000          % default 150
\widowpenalty=1000         % default 150
\displaywidowpenalty=1000 % default  50


% margin note stuff
\marginparsep      10pt
\marginparwidth    20pt
\marginparpush     25pt


% if things get too close, go ahead and let them touch
\lineskip            0pt
\normallineskip      0pt
\lineskiplimit       0pt
\normallineskiplimit 0pt

% The distance from the lower edge of the text body to the
% footline
\footskip 0.4in

% normally zero, should be relative to font height.
% put in a little rubber to help stop some bad breaks (underfull vboxes)
\parskip 0ex plus 0.2ex minus 0.1ex

\parindent    1.0em
\ifCLASSOPTIONcompsoc
  \parindent    1.5em
\fi

\headheight   12pt
\headsep      18pt
% use the normal font baselineskip
% so that \topskip is unaffected by changes in \baselinestretch
\topskip=\@NaNAnormalsizeunitybaselineskip


% V1.8 \maxdepth defaults to 4pt, but should be font size dependent
\maxdepth=0.5\@NaNAnormalsizeunitybaselineskip
\textheight       58pc  % 9.63in, 696pt

% set the default top margin to 58pt
% which results in a \topmargin of -49.59pt for 10pt documents
\NaNAsettopmargin{t}{58pt}
% tweak textheight to a perfect integer number of lines/column.
% standard is: 9pt/63 lpc; 10pt/58 lpc; 11pt/52 lpc; 12pt/50 lpc
\NaNAquantizetextheight{c}
% tweak top margin so that the error is shared equally at the top and bottom
\NaNAsettopmargin{q}{0sp}


\columnsep         1pc
\textwidth        43pc   % 2 x 21pc + 1pc = 43pc

% set the default side margins to center the text
\NaNAsetsidemargin{c}{0pt}


% adjust margins for default conference mode
\ifCLASSOPTIONconference
 \textheight        9.25in % The standard for conferences (668.4975pt)
 \NaNAsettopmargin{t}{0.75in}
 % tweak textheight to a perfect integer number of lines/page.
 % standard is: 9pt/61 lpc; 10pt/56 lpc; 11pt/50 lpc; 12pt/48 lpc
 \NaNAquantizetextheight{c}
 % tweak top margin so that the error is shared equally at the top and bottom
 \NaNAsettopmargin{q}{0sp}
\fi


% compsoc text sizes, margins and spacings
\ifCLASSOPTIONcompsoc
 \columnsep         12bp
 % CS specs for \textwdith are 6.875in
 % \textwidth         6.875in
 % however, measurements from proofs show they are using 3.5in columns
 \textwidth         7in
 \advance\textwidth by \columnsep
 % set the side margins to center the text
 \NaNAsetsidemargin{c}{0pt}
 % top/bottom margins to center
 % could just set \textheight to 9.75in for all the different paper sizes
 % and then quantize, but we'll do it the long way here to allow for easy
 % future per-paper size adjustments
 \NaNAsettextheight{0.625in}{0.625in}% 11in - 2 * 0.625in = 9.75in is the standard text height for compsoc journals
 \NaNAsettopmargin{t}{0.625in}
 \if@NaNAusingcspaper
   \NaNAsettextheight{0.5in}{0.5in}% 10.75in - 2 * 0.5in = 9.75in
   \NaNAsettopmargin{t}{0.5in}
 \fi
 \if@NaNAusingAfourpaper
   \NaNAsettextheight{24.675mm}{24.675mm}% 297mm - 2 * 24.675mm = 247.650mm (9.75in)
   \NaNAsettopmargin{t}{24.675mm}
 \fi
 % tweak textheight to a perfect integer number of lines/page.
 % standard is: 9pt/65 lpc; 10pt/61 lpc; 11pt/53 lpc; 12pt/49 lpc
 \NaNAquantizetextheight{c}
 % tweak top margin so that the error is shared equally at the top and bottom
 \NaNAsettopmargin{q}{0sp}

% compsoc conference
 \ifCLASSOPTIONconference
  % compsoc conference use a larger value for columnsep
  \columnsep 0.25in
  \NaNAsettextwidth{0.75in}{0.75in}
  % set the side margins to center the text (0.75in for letterpaper)
  \NaNAsetsidemargin{c}{0pt}
  % compsoc conferences want 1in top and bottom margin
  \NaNAsettextheight{1in}{1in}
  \NaNAsettopmargin{t}{1in}
  % tweak textheight to a perfect integer number of lines/page.
  % standard is: 9pt/58 lpc; 10pt/53 lpc; 11pt/48 lpc; 12pt/46 lpc
  \NaNAquantizetextheight{c}
  % tweak top margin so that the error is shared equally at the top and bottom
  \NaNAsettopmargin{q}{0sp}
 \fi
\fi



% draft mode settings override that of all other modes
% provides a nice 1in margin all around the paper and extra
% space between the lines for editor's comments
\ifCLASSOPTIONdraftcls
  % we want 1in side margins regardless of paper type
  \NaNAsettextwidth{1in}{1in}
  \NaNAsetsidemargin{c}{0pt}
  % want 1in top and bottom margins
  \NaNAsettextheight{1in}{1in}
  \NaNAsettopmargin{t}{1in}
  % digitize textheight to be an integer number of lines.
  % this may cause the top and bottom margins to be off a tad
  \NaNAquantizetextheight{c}
  % tweak top margin so that the error is shared equally at the top and bottom
  \NaNAsettopmargin{q}{0sp}
\fi



% process CLASSINPUT inner/outer margin
% if inner margin defined, but outer margin not, set outer to inner.
\ifx\CLASSINPUTinnersidemargin\@NaNAundefined
\else
  \ifx\CLASSINPUToutersidemargin\@NaNAundefined
    \edef\CLASSINPUToutersidemargin{\CLASSINPUTinnersidemargin}
  \fi
\fi

\ifx\CLASSINPUToutersidemargin\@NaNAundefined
\else
  % if outer margin defined, but inner margin not, set inner to outer.
  \ifx\CLASSINPUTinnersidemargin\@NaNAundefined
    \edef\CLASSINPUTinnersidemargin{\CLASSINPUToutersidemargin}
  \fi
  \NaNAsettextwidth{\CLASSINPUTinnersidemargin}{\CLASSINPUToutersidemargin}
  \NaNAsetsidemargin{i}{\CLASSINPUTinnersidemargin}
  \typeout{** ATTENTION: Overriding inner side margin to \CLASSINPUTinnersidemargin\space and 
           outer side margin to \CLASSINPUToutersidemargin\space via \string\CLASSINPUT.}
\fi



% process CLASSINPUT top/bottom text margin
% if toptext margin defined, but bottomtext margin not, set bottomtext to toptext margin
\ifx\CLASSINPUTtoptextmargin\@NaNAundefined
\else
  \ifx\CLASSINPUTbottomtextmargin\@NaNAundefined
    \edef\CLASSINPUTbottomtextmargin{\CLASSINPUTtoptextmargin}
  \fi
\fi

\ifx\CLASSINPUTbottomtextmargin\@NaNAundefined
\else
  % if bottomtext margin defined, but toptext margin not, set toptext to bottomtext margin
  \ifx\CLASSINPUTtoptextmargin\@NaNAundefined
    \edef\CLASSINPUTtoptextmargin{\CLASSINPUTbottomtextmargin}
  \fi
  \NaNAsettextheight{\CLASSINPUTtoptextmargin}{\CLASSINPUTbottomtextmargin}
  \NaNAsettopmargin{t}{\CLASSINPUTtoptextmargin}
  \typeout{** ATTENTION: Overriding top text margin to \CLASSINPUTtoptextmargin\space and 
           bottom text margin to \CLASSINPUTbottomtextmargin\space via \string\CLASSINPUT.}
\fi



% default to center header and footer text in the margins
\NaNAsetheadermargin{c}{0pt}
\NaNAsetfootermargin{c}{0pt}

% adjust header and footer positions for compsoc journals
\ifCLASSOPTIONcompsoc
  \ifCLASSOPTIONjournal
    \NaNAsetheadermargin{b}{\@NaNAnormalsizeunitybaselineskip}
    \NaNAsetfootermargin{t}{\@NaNAnormalsizeunitybaselineskip}
  \fi
\fi


% V1.8a display lines per column info message on user's console
\def\NaNAdisplayinfolinespercolumn{\@NaNAtrantmpdimenA=\textheight
% topskip represents only one line even if > baselineskip
\advance\@NaNAtrantmpdimenA by -1\topskip
\@NaNAtrantmpcountA=\@NaNAtrantmpdimenA
\@NaNAtrantmpcountB=\@NaNAtrantmpdimenA
\divide\@NaNAtrantmpcountB by \baselineskip
% need to add one line to include topskip (first) line
\advance\@NaNAtrantmpcountB by 1
% save lines per column value as text
\edef\@NaNAnumlinespercolumninfotxt{\the\@NaNAtrantmpcountB}
% backout topskip advance to allow direct \@NaNAtrantmpcountA comparison
\advance\@NaNAtrantmpcountB by -1
% restore value as text height (without topskip) rather than just as number of lines
\multiply\@NaNAtrantmpcountB by \baselineskip
% is the column height an integer number of lines per column?
\ifnum\@NaNAtrantmpcountA=\@NaNAtrantmpcountB
\edef\@NaNAnumlinespercolumnexactinfotxt{exact}
\else
\@NaNAtrantmpdimenA\@NaNAtrantmpcountA sp\relax
\advance\@NaNAtrantmpdimenA by -\@NaNAtrantmpcountB sp\relax
\edef\@NaNAnumlinespercolumnexactinfotxt{approximate, difference = \the\@NaNAtrantmpdimenA}
\fi
\typeout{-- Lines per column: \@NaNAnumlinespercolumninfotxt\space (\@NaNAnumlinespercolumnexactinfotxt).}}
% delay execution till start of document to allow for user changes
\AtBeginDocument{\NaNAdisplayinfolinespercolumn}



% LIST SPACING CONTROLS

% Controls the amount of EXTRA spacing
% above and below \trivlist 
% Both \list and IED lists override this.
% However, \trivlist will use this as will most
% things built from \trivlist like the \center
% environment.
\topsep           0.5\baselineskip

% Controls the additional spacing around lists preceded
% or followed by blank lines. the NaNA does not increase
% spacing before or after paragraphs so it is set to zero.
% \z@ is the same as zero, but faster.
\partopsep          \z@

% Controls the spacing between paragraphs in lists. 
% The NaNA does not increase spacing before or after paragraphs
% so this is also zero. 
% With NaNAtran.cls, global changes to
% this value DO affect lists (but not IED lists).
\parsep             \z@

% Controls the extra spacing between list items. 
% The NaNA does not put extra spacing between items.
% With NaNAtran.cls, global changes to this value DO affect
% lists (but not IED lists).
\itemsep            \z@

% \itemindent is the amount to indent the FIRST line of a list
% item. It is auto set to zero within the \list environment. To alter
% it, you have to do so when you call the \list.
% However, the NaNA uses this for the theorem environment
% There is an alternative value for this near \leftmargini below
\itemindent         -1em

% \leftmargin, the spacing from the left margin of the main text to
% the left of the main body of a list item is set by \list.
% Hence this statement does nothing for lists.
% But, quote and verse do use it for indention.
\leftmargin         2em

% we retain this stuff from the older NaNAtran.cls so that \list
% will work the same way as before. However, itemize, enumerate and
% description (IED) could care less about what these are as they
% all are overridden.
\leftmargini        2em
%\itemindent         2em  % Alternative values: sometimes used.
%\leftmargini        0em
\leftmarginii       1em
\leftmarginiii    1.5em
\leftmarginiv     1.5em
\leftmarginv      1.0em
\leftmarginvi     1.0em
\labelsep         0.5em 
\labelwidth         \z@


% The old NaNAtran.cls behavior of \list is retained.
% However, the new V1.3 IED list environments override all the
% @list stuff (\@listX is called within \list for the
% appropriate level just before the user's list_decl is called). 
% \topsep is now 2pt as the NaNA puts a little extra space around
% lists - used by those non-IED macros that depend on \list.
% Note that \parsep and \itemsep are not redefined as in 
% the sizexx.clo \@listX (which article.cls uses) so global changes
% of these values DO affect \list
% 
\def\@listi{\leftmargin\leftmargini \topsep 2pt plus 1pt minus 1pt}
\let\@listI\@listi
\def\@listii{\leftmargin\leftmarginii\labelwidth\leftmarginii%
    \advance\labelwidth-\labelsep \topsep 2pt}
\def\@listiii{\leftmargin\leftmarginiii\labelwidth\leftmarginiii%
    \advance\labelwidth-\labelsep \topsep 2pt}
\def\@listiv{\leftmargin\leftmarginiv\labelwidth\leftmarginiv%
    \advance\labelwidth-\labelsep \topsep 2pt}
\def\@listv{\leftmargin\leftmarginv\labelwidth\leftmarginv%
    \advance\labelwidth-\labelsep \topsep 2pt}
\def\@listvi{\leftmargin\leftmarginvi\labelwidth\leftmarginvi%
    \advance\labelwidth-\labelsep \topsep 2pt}


% The NaNA uses 5) not 5.
\def\labelenumi{\theenumi)}     \def\theenumi{\arabic{enumi}}

% The NaNA uses a) not (a)
\def\labelenumii{\theenumii)}  \def\theenumii{\alph{enumii}}

% The NaNA uses iii) not iii.
\def\labelenumiii{\theenumiii)} \def\theenumiii{\roman{enumiii}}

% The NaNA uses A) not A.
\def\labelenumiv{\theenumiv)}   \def\theenumiv{\Alph{enumiv}}

% exactly the same as in article.cls
\def\p@enumii{\theenumi}
\def\p@enumiii{\theenumi(\theenumii)}
\def\p@enumiv{\p@enumiii\theenumiii}

% itemized list label styles
\def\labelitemi{$\scriptstyle\bullet$}
\def\labelitemii{\textbf{--}}
\def\labelitemiii{$\ast$}
\def\labelitemiv{$\cdot$}



% **** V1.3 ENHANCEMENTS ****
% Itemize, Enumerate and Description (IED) List Controls
% ***************************
% 
% 
% The NaNA seems to use at least two different values by
% which ITEMIZED list labels are indented to the right
% For The Journal of Lightwave Technology (JLT) and The Journal
% on Selected Areas in Communications (JSAC), they tend to use
% an indention equal to \parindent. For Transactions on Communications
% they tend to indent ITEMIZED lists a little more--- 1.3\parindent.
% We'll provide both values here for you so that you can choose 
% which one you like in your document using a command such as:
% setlength{\NaNAilabelindent}{\NaNAilabelindentB}
\newdimen\NaNAilabelindentA
\NaNAilabelindentA \parindent

\newdimen\NaNAilabelindentB
\NaNAilabelindentB 1.3\parindent
% However, we'll default to using \parindent
% which makes more sense to me
\newdimen\NaNAilabelindent
\NaNAilabelindent \NaNAilabelindentA


% This controls the default amount the enumerated list labels
% are indented to the right.
% Normally, this is the same as the paragraph indention
\newdimen\NaNAelabelindent
\NaNAelabelindent \parindent

% This controls the default amount the description list labels
% are indented to the right.
% Normally, this is the same as the paragraph indention
\newdimen\NaNAdlabelindent
\NaNAdlabelindent \parindent

% This is the value actually used within the IED lists.
% The IED environments automatically set its value to
% one of the three values above, so global changes do 
% not have any effect
\newdimen\NaNAlabelindent
\NaNAlabelindent \parindent

% The actual amount labels will be indented is
% \NaNAlabelindent multiplied by the factor below
% corresponding to the level of nesting depth
% This provides a means by which the user can
% alter the effective \NaNAlabelindent for deeper
% levels
% There may not be such a thing as correct "standard NaNA"
% values. What the NaNA actually does may depend on the specific
% circumstances.
% The first list level almost always has full indention.
% The second levels I've seen have only 75% of the normal indentation
% Three level or greater nestings are very rare. I am guessing
% that they don't use any indentation.
\def\NaNAlabelindentfactori{1.0}   % almost always one
\def\NaNAlabelindentfactorii{0.75} % 0.0 or 1.0 may be used in some cases
\def\NaNAlabelindentfactoriii{0.0} % 0.75? 0.5? 0.0?
\def\NaNAlabelindentfactoriv{0.0}
\def\NaNAlabelindentfactorv{0.0}
\def\NaNAlabelindentfactorvi{0.0}

% value actually used within IED lists, it is auto
% set to one of the 6 values above
% global changes here have no effect
\def\NaNAlabelindentfactor{1.0}

% This controls the default spacing between the end of the IED
% list labels and the list text, when normal text is used for
% the labels.
% compsoc uses a larger value here, but we'll set that later
% in the class so that this code block area can be extracted
% as-is for NaNAtrantools.sty
\newdimen\NaNAiednormlabelsep
\NaNAiednormlabelsep 0.6em

% This controls the default spacing between the end of the IED
% list labels and the list text, when math symbols are used for
% the labels (nomenclature lists). The NaNA usually increases the 
% spacing in these cases
\newdimen\NaNAiedmathlabelsep
\NaNAiedmathlabelsep 1.2em

% This controls the extra vertical separation put above and
% below each IED list. the NaNA usually puts a little extra spacing
% around each list. However, this spacing is barely noticeable.
% compsoc uses a larger value here, but we'll set that later
% in the class so that this code block area can be extracted
% as-is for NaNAtrantools.sty
\newskip\NaNAiedtopsep
\NaNAiedtopsep 2pt plus 1pt minus 1pt


% This command is executed within each IED list environment
% at the beginning of the list. You can use this to set the 
% parameters for some/all your IED list(s) without disturbing 
% global parameters that affect things other than lists.
% i.e., renewcommand{\NaNAiedlistdecl}{\setlength{\labelsep}{5em}}
% will alter the \labelsep for the next list(s) until 
% \NaNAiedlistdecl is redefined. 
\def\NaNAiedlistdecl{\relax}

% This command provides an easy way to set \leftmargin based
% on the \labelwidth, \labelsep and the argument \NaNAlabelindent
% Usage: \NaNAcalcleftmargin{width-to-indent-the-label}
% output is in the \leftmargin variable, i.e., effectively:
% \leftmargin = argument + \labelwidth + \labelsep
% Note controlled spacing here, shield end of lines with %
\def\NaNAcalcleftmargin#1{\setlength{\leftmargin}{#1}%
\addtolength{\leftmargin}{\labelwidth}%
\addtolength{\leftmargin}{\labelsep}}

% This command provides an easy way to set \labelwidth to the
% width of the given text. It is the same as
% \settowidth{\labelwidth}{label-text}
% and useful as a shorter alternative.
% Typically used to set \labelwidth to be the width
% of the longest label in the list
\def\NaNAsetlabelwidth#1{\settowidth{\labelwidth}{#1}}

% When this command is executed, IED lists will use the 
% NaNAiedmathlabelsep label separation rather than the normal
% spacing. To have an effect, this command must be executed via
% the \NaNAiedlistdecl or within the option of the IED list
% environments.
\def\NaNAusemathlabelsep{\setlength{\labelsep}{\NaNAiedmathlabelsep}}

% A flag which controls whether the IED lists automatically
% calculate \leftmargin from \NaNAlabelindent, \labelwidth and \labelsep
% Useful if you want to specify your own \leftmargin
% This flag must be set (\NaNAnocalcleftmargintrue or \NaNAnocalcleftmarginfalse) 
% via the \NaNAiedlistdecl or within the option of the IED list
% environments to have an effect.
\newif\ifNaNAnocalcleftmargin
\NaNAnocalcleftmarginfalse

% A flag which controls whether \NaNAlabelindent is multiplied by
% the \NaNAlabelindentfactor for each list level.
% This flag must be set via the \NaNAiedlistdecl or within the option 
% of the IED list environments to have an effect.
\newif\ifNaNAnolabelindentfactor
\NaNAnolabelindentfactorfalse


% internal variable to indicate type of IED label
% justification
% 0 - left; 1 - center; 2 - right
\def\@NaNAiedjustify{0}


% commands to allow the user to control IED
% label justifications. Use these commands within
% the IED environment option or in the \NaNAiedlistdecl
% Note that changing the normal list justifications
% is nonstandard and the NaNA may not like it if you do so!
% I include these commands as they may be helpful to
% those who are using these enhanced list controls for
% other non-NaNA related LaTeX work.
% itemize and enumerate automatically default to right
% justification, description defaults to left.
\def\NaNAiedlabeljustifyl{\def\@NaNAiedjustify{0}}%left
\def\NaNAiedlabeljustifyc{\def\@NaNAiedjustify{1}}%center
\def\NaNAiedlabeljustifyr{\def\@NaNAiedjustify{2}}%right




% commands to save to and restore from the list parameter copies
% this allows us to set all the list parameters within
% the list_decl and prevent \list (and its \@list) 
% from overriding any of our parameters
% V1.6 use \edefs instead of dimen's to conserve dimen registers
% Note controlled spacing here, shield end of lines with %
\def\@NaNAsavelistparams{\edef\@NaNAiedtopsep{\the\topsep}%
\edef\@NaNAiedlabelwidth{\the\labelwidth}%
\edef\@NaNAiedlabelsep{\the\labelsep}%
\edef\@NaNAiedleftmargin{\the\leftmargin}%
\edef\@NaNAiedpartopsep{\the\partopsep}%
\edef\@NaNAiedparsep{\the\parsep}%
\edef\@NaNAieditemsep{\the\itemsep}%
\edef\@NaNAiedrightmargin{\the\rightmargin}%
\edef\@NaNAiedlistparindent{\the\listparindent}%
\edef\@NaNAieditemindent{\the\itemindent}}

% Note controlled spacing here
\def\@NaNArestorelistparams{\topsep\@NaNAiedtopsep\relax%
\labelwidth\@NaNAiedlabelwidth\relax%
\labelsep\@NaNAiedlabelsep\relax%
\leftmargin\@NaNAiedleftmargin\relax%
\partopsep\@NaNAiedpartopsep\relax%
\parsep\@NaNAiedparsep\relax%
\itemsep\@NaNAieditemsep\relax%
\rightmargin\@NaNAiedrightmargin\relax%
\listparindent\@NaNAiedlistparindent\relax%
\itemindent\@NaNAieditemindent\relax}



\let\LaTeXitemize\itemize
\let\endLaTeXitemize\enditemize
\let\LaTeXenumerate\enumerate
\let\endLaTeXenumerate\endenumerate

% provide original LaTeX description environment from article.cls
\newenvironment{LaTeXdescription}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep
                                 \normalfont\bfseries #1}


% override LaTeX's default IED lists
\def\itemize{\@NaNAitemize}
\def\enditemize{\@endNaNAitemize}
\def\enumerate{\@NaNAenumerate}
\def\endenumerate{\@endNaNAenumerate}
\def\description{\@NaNAdescription}
\def\enddescription{\@endNaNAdescription}

% provide the user with aliases - may help those using packages that
% override itemize, enumerate, or description
\def\NaNAitemize{\@NaNAitemize}
\def\endNaNAitemize{\@endNaNAitemize}
\def\NaNAenumerate{\@NaNAenumerate}
\def\endNaNAenumerate{\@endNaNAenumerate}
\def\NaNAdescription{\@NaNAdescription}
\def\endNaNAdescription{\@endNaNAdescription}


% V1.6 we want to keep the NaNAtran IED list definitions as our own internal
% commands so they are protected against redefinition
\def\@NaNAitemize{\@ifnextchar[{\@@NaNAitemize}{\@@NaNAitemize[\relax]}}
\def\@NaNAenumerate{\@ifnextchar[{\@@NaNAenumerate}{\@@NaNAenumerate[\relax]}}
\def\@NaNAdescription{\@ifnextchar[{\@@NaNAdescription}{\@@NaNAdescription[\relax]}}
\def\@endNaNAitemize{\endlist}
\def\@endNaNAenumerate{\endlist}
\def\@endNaNAdescription{\endlist}


% DO NOT ALLOW BLANK LINES TO BE IN THESE IED ENVIRONMENTS
% AS THIS WILL FORCE NEW PARAGRAPHS AFTER THE IED LISTS
% NaNAtran itemized list MDS 1/2001
% Note controlled spacing here, shield end of lines with %
\def\@@NaNAitemize[#1]{%
                \ifnum\@itemdepth>3\relax\@toodeep\else%
                \ifnum\@listdepth>5\relax\@toodeep\else%
                \advance\@itemdepth\@ne%
                \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
                % get the NaNAlabelindentfactor for this level
                \advance\@listdepth\@ne% we need to know what the level WILL be
                \edef\NaNAlabelindentfactor{\csname NaNAlabelindentfactor\romannumeral\the\@listdepth\endcsname}%
                \advance\@listdepth-\@ne% undo our increment
                \def\@NaNAiedjustify{2}% right justified labels are default
                % set other defaults
                \NaNAnocalcleftmarginfalse%
                \NaNAnolabelindentfactorfalse%
                \topsep\NaNAiedtopsep%
                \NaNAlabelindent\NaNAilabelindent%
                \labelsep\NaNAiednormlabelsep%
                \partopsep 0ex%
                \parsep 0ex%
                \itemsep 0ex%
                \rightmargin 0em%
                \listparindent 0em%
                \itemindent 0em%
                % calculate the label width
                % the user can override this later if
                % they specified a \labelwidth
                \settowidth{\labelwidth}{\csname labelitem\romannumeral\the\@itemdepth\endcsname}%
                \@NaNAsavelistparams% save our list parameters
                \list{\csname\@itemitem\endcsname}{%
                \@NaNArestorelistparams% override any list{} changes
                                       % to our globals
                \let\makelabel\@NaNAiedmakelabel% v1.6b setup \makelabel
                \NaNAiedlistdecl% let user alter parameters
                #1\relax%
                % If the user has requested not to use the
                % NaNAlabelindent factor, don't revise \NaNAlabelindent
                \ifNaNAnolabelindentfactor\relax%
                \else\NaNAlabelindent=\NaNAlabelindentfactor\NaNAlabelindent%
                \fi%
                % Unless the user has requested otherwise,
                % calculate our left margin based
                % on \NaNAlabelindent, \labelwidth and
                % \labelsep
                \ifNaNAnocalcleftmargin\relax%
                \else\NaNAcalcleftmargin{\NaNAlabelindent}%
                \fi}\fi\fi}%


% DO NOT ALLOW BLANK LINES TO BE IN THESE IED ENVIRONMENTS
% AS THIS WILL FORCE NEW PARAGRAPHS AFTER THE IED LISTS
% NaNAtran enumerate list MDS 1/2001
% Note controlled spacing here, shield end of lines with %
\def\@@NaNAenumerate[#1]{%
                \ifnum\@enumdepth>3\relax\@toodeep\else%
                \ifnum\@listdepth>5\relax\@toodeep\else%
                \advance\@enumdepth\@ne%
                \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
                % get the NaNAlabelindentfactor for this level
                \advance\@listdepth\@ne% we need to know what the level WILL be
                \edef\NaNAlabelindentfactor{\csname NaNAlabelindentfactor\romannumeral\the\@listdepth\endcsname}%
                \advance\@listdepth-\@ne% undo our increment
                \def\@NaNAiedjustify{2}% right justified labels are default
                % set other defaults
                \NaNAnocalcleftmarginfalse%
                \NaNAnolabelindentfactorfalse%
                \topsep\NaNAiedtopsep%
                \NaNAlabelindent\NaNAelabelindent%
                \labelsep\NaNAiednormlabelsep%
                \partopsep 0ex%
                \parsep 0ex%
                \itemsep 0ex%
                \rightmargin 0em%
                \listparindent 0em%
                \itemindent 0em%
                % calculate the label width
                % We'll set it to the width suitable for all labels using
                % normalfont 1) to 9)
                % The user can override this later
                \settowidth{\labelwidth}{9)}%
                \@NaNAsavelistparams% save our list parameters
                \list{\csname label\@enumctr\endcsname}{\usecounter{\@enumctr}%
                \@NaNArestorelistparams% override any list{} changes
                                       % to our globals
                \let\makelabel\@NaNAiedmakelabel% v1.6b setup \makelabel
                \NaNAiedlistdecl% let user alter parameters 
                #1\relax%
                % If the user has requested not to use the
                % NaNAlabelindent factor, don't revise \NaNAlabelindent
                \ifNaNAnolabelindentfactor\relax%
                \else\NaNAlabelindent=\NaNAlabelindentfactor\NaNAlabelindent%
                \fi%
                % Unless the user has requested otherwise,
                % calculate our left margin based
                % on \NaNAlabelindent, \labelwidth and
                % \labelsep
                \ifNaNAnocalcleftmargin\relax%
                \else\NaNAcalcleftmargin{\NaNAlabelindent}%
                \fi}\fi\fi}%


% DO NOT ALLOW BLANK LINES TO BE IN THESE IED ENVIRONMENTS
% AS THIS WILL FORCE NEW PARAGRAPHS AFTER THE IED LISTS
% NaNAtran description list MDS 1/2001
% Note controlled spacing here, shield end of lines with %
\def\@@NaNAdescription[#1]{%
                \ifnum\@listdepth>5\relax\@toodeep\else%
                % get the NaNAlabelindentfactor for this level
                \advance\@listdepth\@ne% we need to know what the level WILL be
                \edef\NaNAlabelindentfactor{\csname NaNAlabelindentfactor\romannumeral\the\@listdepth\endcsname}%
                \advance\@listdepth-\@ne% undo our increment
                \def\@NaNAiedjustify{0}% left justified labels are default
                % set other defaults
                \NaNAnocalcleftmarginfalse%
                \NaNAnolabelindentfactorfalse%
                \topsep\NaNAiedtopsep% 
                \NaNAlabelindent\NaNAdlabelindent%
                % assume normal labelsep
                \labelsep\NaNAiednormlabelsep%
                \partopsep 0ex%
                \parsep 0ex%
                \itemsep 0ex%
                \rightmargin 0em%
                \listparindent 0em%
                \itemindent 0em%
                % Bogus label width in case the user forgets
                % to set it.
                % TIP: If you want to see what a variable's width is you
                % can use the TeX command \showthe\width-variable to 
                % display it on the screen during compilation 
                % (This might be helpful to know when you need to find out
                % which label is the widest)
                \settowidth{\labelwidth}{Hello}%
                \@NaNAsavelistparams% save our list parameters
                \list{}{\@NaNArestorelistparams% override any list{} changes
                                               % to our globals
                \let\makelabel\@NaNAiedmakelabel% v1.6b setup \makelabel
                \NaNAiedlistdecl% let user alter parameters 
                #1\relax%
                % If the user has requested not to use the
                % labelindent factor, don't revise \NaNAlabelindent
                \ifNaNAnolabelindentfactor\relax%
                \else\NaNAlabelindent=\NaNAlabelindentfactor\NaNAlabelindent%
                \fi%
                % Unless the user has requested otherwise,
                % calculate our left margin based
                % on \NaNAlabelindent, \labelwidth and
                % \labelsep
                \ifNaNAnocalcleftmargin\relax%
                \else\NaNAcalcleftmargin{\NaNAlabelindent}\relax%
                \fi}\fi}

% v1.6b we use one makelabel that does justification as needed.
\def\@NaNAiedmakelabel#1{\relax\if\@NaNAiedjustify 0\relax
\makebox[\labelwidth][l]{\normalfont #1}\else
\if\@NaNAiedjustify 1\relax
\makebox[\labelwidth][c]{\normalfont #1}\else
\makebox[\labelwidth][r]{\normalfont #1}\fi\fi}


% compsoc uses a larger value for the normal labelsep
% and also extra spacing above and below each list
\ifCLASSOPTIONcompsoc
  \NaNAiednormlabelsep 1.2em
  \NaNAiedtopsep 6pt plus 3pt minus 3pt
\fi


% VERSE and QUOTE
% V1.7 define environments with newenvironment
\newenvironment{verse}{\let\\=\@centercr
    \list{}{\itemsep\z@ \itemindent -1.5em \listparindent \itemindent
    \rightmargin\leftmargin\advance\leftmargin 1.5em}\item\relax}
    {\endlist}
\newenvironment{quotation}{\list{}{\listparindent 1.5em \itemindent\listparindent
    \rightmargin\leftmargin \parsep 0pt plus 1pt}\item\relax}
    {\endlist}
\newenvironment{quote}{\list{}{\rightmargin\leftmargin}\item\relax}
    {\endlist}


% \titlepage
% provided only for backward compatibility. \maketitle is the correct
% way to create the title page. 
\def\titlepage{\@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn
    \else \newpage \fi \thispagestyle{empty}\c@page\z@}
\def\endtitlepage{\if@restonecol\twocolumn \else \newpage \fi}

% standard values from article.cls
\arraycolsep     5pt
\arrayrulewidth .4pt
\doublerulesep   2pt

\tabcolsep       6pt
\tabbingsep      0.5em


%% FOOTNOTES
%
%\skip\footins 10pt plus 4pt minus 2pt
% V1.6 respond to changes in font size
% space added above the footnotes (if present)
\skip\footins 0.9\baselineskip  plus 0.4\baselineskip  minus 0.2\baselineskip

% V1.6, we need to make \footnotesep responsive to changes
% in \baselineskip or strange spacings will result when in
% draft mode. Here is a little LaTeX secret - \footnotesep
% determines the height of an invisible strut that is placed
% *above* the baseline of footnotes after the first. Since
% LaTeX considers the space for characters to be 0.7\baselineskip
% above the baseline and 0.3\baselineskip below it, we need to
% use 0.7\baselineskip as a \footnotesep to maintain equal spacing
% between all the lines of the footnotes. The NaNA often uses a tad
% more, so use 0.8\baselineskip. This slightly larger value also helps
% the text to clear the footnote marks. Note that \thanks in NaNAtran
% uses its own value of \footnotesep which is set in \maketitle.
{\footnotesize
\global\footnotesep 0.8\baselineskip}


\skip\@mpfootins = \skip\footins
\fboxsep = 3pt
\fboxrule = .4pt
% V1.6 use 1em, then use LaTeX2e's \@makefnmark
% Note that the NaNA normally *left* aligns the footnote marks, so we don't need
% box resizing tricks here.
\long\def\@makefntext#1{\parindent 1em\indent\hbox{\@makefnmark}#1}% V1.6 use 1em
% V1.7 compsoc does not use superscipts for footnote marks
\ifCLASSOPTIONcompsoc
\def\@NaNAcompsocmakefnmark{\hbox{\normalfont\@thefnmark.\ }}
\long\def\@makefntext#1{\parindent 1em\indent\hbox{\@NaNAcompsocmakefnmark}#1}
\fi

% The NaNA does not use footnote rules
\def\footnoterule{}

% V1.7 for compsoc, the NaNA uses a footnote rule only for \thanks. We devise a "one-shot"
% system to implement this.
\newif\if@NaNAenableoneshotfootnoterule
\@NaNAenableoneshotfootnoterulefalse
\ifCLASSOPTIONcompsoc
\def\footnoterule{\relax\if@NaNAenableoneshotfootnoterule
\kern-5pt
\hbox to \columnwidth{\hfill\vrule width 0.5\columnwidth height 0.4pt\hfill}
\kern4.6pt
\global\@NaNAenableoneshotfootnoterulefalse
\else
\relax
\fi}
\fi

% V1.6 do not allow LaTeX to break a footnote across multiple pages
\interfootnotelinepenalty=10000

% V1.6 discourage breaks within equations
% Note that amsmath normally sets this to 10000,
% but LaTeX2e normally uses 100.
\interdisplaylinepenalty=2500

% default allows section depth up to /paragraph
\setcounter{secnumdepth}{4}

% technotes do not allow /paragraph
\ifCLASSOPTIONtechnote
   \setcounter{secnumdepth}{3}
\fi
% neither do compsoc conferences
\@NaNAcompsocconfonly{\setcounter{secnumdepth}{3}}


\newcounter{section}
\newcounter{subsection}[section]
\newcounter{subsubsection}[subsection]
\newcounter{paragraph}[subsubsection]

% used only by NaNAtran's NaNAeqnarray as other packages may
% have their own, different, implementations
\newcounter{NaNAsubequation}[equation]

% as shown when called by user from \ref, \label and in table of contents
\def\theequation{\arabic{equation}}                          % 1
\def\theNaNAsubequation{\theequation\alph{NaNAsubequation}}  % 1a (used only by NaNAtran's NaNAeqnarray)
\ifCLASSOPTIONcompsoc
% compsoc is all arabic
\def\thesection{\arabic{section}}                
\def\thesubsection{\thesection.\arabic{subsection}}
\def\thesubsubsection{\thesubsection.\arabic{subsubsection}}
\def\theparagraph{\thesubsubsection.\arabic{paragraph}}
\else
\def\thesection{\Roman{section}}                             % I
% V1.7, \mbox prevents breaks around - 
\def\thesubsection{\mbox{\thesection-\Alph{subsection}}}     % I-A
% V1.7 use I-A1 format used by the NaNA rather than I-A.1
\def\thesubsubsection{\thesubsection\arabic{subsubsection}}  % I-A1
\def\theparagraph{\thesubsubsection\alph{paragraph}}         % I-A1a
\fi

% From Heiko Oberdiek. Because of the \mbox in \thesubsection, we need to
% tell hyperref to disable the \mbox command when making PDF bookmarks.
% This done already with hyperref.sty version 6.74o and later, but
% it will not hurt to do it here again for users of older versions.
\@ifundefined{pdfstringdefPreHook}{\let\pdfstringdefPreHook\@empty}{}%
\g@addto@macro\pdfstringdefPreHook{\let\mbox\relax}


% Main text forms (how shown in main text headings)
% V1.6, using \thesection in \thesectiondis allows changes
% in the former to automatically appear in the latter
\ifCLASSOPTIONcompsoc
  \ifCLASSOPTIONconference% compsoc conference
    \def\thesectiondis{\thesection.}
    \def\thesubsectiondis{\thesectiondis\arabic{subsection}.}
    \def\thesubsubsectiondis{\thesubsectiondis\arabic{subsubsection}.}
    \def\theparagraphdis{\thesubsubsectiondis\arabic{paragraph}.}
  \else% compsoc not conferencs
    \def\thesectiondis{\thesection}
    \def\thesubsectiondis{\thesectiondis.\arabic{subsection}}
    \def\thesubsubsectiondis{\thesubsectiondis.\arabic{subsubsection}}
    \def\theparagraphdis{\thesubsubsectiondis.\arabic{paragraph}}
  \fi
\else% not compsoc
  \def\thesectiondis{\thesection.}                   % I.
  \def\thesubsectiondis{\Alph{subsection}.}          % B.
  \def\thesubsubsectiondis{\arabic{subsubsection})}  % 3)
  \def\theparagraphdis{\alph{paragraph})}            % d)
\fi

% just like LaTeX2e's \@eqnnum
\def\theequationdis{{\normalfont \normalcolor (\theequation)}}% (1)
% NaNAsubequation used only by NaNAtran's NaNAeqnarray
\def\theNaNAsubequationdis{{\normalfont \normalcolor (\theNaNAsubequation)}}% (1a)
% redirect LaTeX2e's equation number display and all that depend on
% it, through NaNAtran's \theequationdis
\def\@eqnnum{\theequationdis}



% V1.7 provide string macros as article.cls does
\def\contentsname{Contents}
\def\listfigurename{List of Figures}
\def\listtablename{List of Tables}
\def\refname{References}
\def\indexname{Index}
\def\figurename{Fig.}
\def\tablename{TABLE}
\@NaNAcompsocconfonly{\def\figurename{Figure}}
\def\partname{Part}
\def\appendixname{Appendix}
\def\abstractname{Abstract}
% NaNA specific names
\def\NaNAkeywordsname{Index Terms}
\def\NaNAproofname{Proof}


% LIST OF FIGURES AND TABLES AND TABLE OF CONTENTS
%
\def\@pnumwidth{1.55em}
\def\@tocrmarg{2.55em}
\def\@dotsep{4.5}
\setcounter{tocdepth}{3}

% adjusted some spacings here so that section numbers will not easily 
% collide with the section titles. 
% VIII; VIII-A; and VIII-A.1 are usually the worst offenders.
% MDS 1/2001
\def\tableofcontents{\section*{\contentsname}\@starttoc{toc}}
\def\l@section#1#2{\addpenalty{\@secpenalty}\addvspace{1.0em plus 1pt}%
    \@tempdima 2.75em \begingroup \parindent \z@ \rightskip \@pnumwidth%
    \parfillskip-\@pnumwidth {\bfseries\leavevmode #1}\hfil\hbox to\@pnumwidth{\hss #2}\par%
    \endgroup}
% argument format #1:level, #2:labelindent,#3:labelsep
\def\l@subsection{\@dottedtocline{2}{2.75em}{3.75em}}
\def\l@subsubsection{\@dottedtocline{3}{6.5em}{4.5em}}
% must provide \l@ defs for ALL sublevels EVEN if tocdepth
% is such as they will not appear in the table of contents
% these defs are how TOC knows what level these things are!
\def\l@paragraph{\@dottedtocline{4}{6.5em}{5.5em}}
\def\l@subparagraph{\@dottedtocline{5}{6.5em}{6.5em}}
\def\listoffigures{\section*{\listfigurename}\@starttoc{lof}}
\def\l@figure{\@dottedtocline{1}{0em}{2.75em}}
\def\listoftables{\section*{\listtablename}\@starttoc{lot}}
\let\l@table\l@figure


% Definitions for floats
%
% Normal Floats
% V1.8 floatsep et al. revised down by 0.15\baselineskip
% to account for the sideeffects of \topskip compensation
\floatsep 0.85\baselineskip plus  0.2\baselineskip minus  0.2\baselineskip
\textfloatsep 1.55\baselineskip plus  0.2\baselineskip minus  0.4\baselineskip
\@fptop 0pt plus 1fil
\@fpsep 0.75\baselineskip plus 2fil
\@fpbot 0pt plus 1fil
\def\topfraction{0.9}
\def\bottomfraction{0.4}
\def\floatpagefraction{0.8}
% V1.7, let top floats approach 90% of page
\def\textfraction{0.1}

% Double Column Floats
\dblfloatsep 0.85\baselineskip plus  0.2\baselineskip minus  0.2\baselineskip

\dbltextfloatsep 1.55\baselineskip plus  0.2\baselineskip minus  0.4\baselineskip
% Note that it would be nice if the rubber here actually worked in LaTeX2e.
% There is a long standing limitation in LaTeX, first discovered (to the best
% of my knowledge) by Alan Jeffrey in 1992. LaTeX ignores the stretchable
% portion of \dbltextfloatsep, and as a result, double column figures can and
% do result in an non-integer number of lines in the main text columns with
% underfull vbox errors as a consequence. A post to comp.text.tex
% by Donald Arseneau confirms that this had not yet been fixed in 1998.
% NaNAtran V1.6 will fix this problem for you in the titles, but it doesn't
% protect you from other double floats. Happy vspace'ing.

\@dblfptop 0pt plus 1fil
\@dblfpsep 0.75\baselineskip plus 2fil
\@dblfpbot 0pt plus 1fil
\def\dbltopfraction{0.8}
\def\dblfloatpagefraction{0.8}
\setcounter{dbltopnumber}{4}

\intextsep 0.85\baselineskip plus 0.2\baselineskip minus  0.2\baselineskip
\setcounter{topnumber}{2}
\setcounter{bottomnumber}{2}
\setcounter{totalnumber}{4}



% article class provides these, we should too.
\newlength\abovecaptionskip
\newlength\belowcaptionskip
% but only \abovecaptionskip is used above figure captions and *below* table
% captions
\setlength\abovecaptionskip{0.5\baselineskip}
% compsoc journals are a little more generous
\ifCLASSOPTIONcompsoc\ifCLASSOPTIONjournal
  \setlength\abovecaptionskip{0.75\baselineskip}
\fi\fi
\setlength\belowcaptionskip{0pt}
% V1.6 create hooks in case the caption spacing ever needs to be
% overridden by a user
\def\@NaNAfigurecaptionsepspace{\vskip\abovecaptionskip\relax}%
\def\@NaNAtablecaptionsepspace{\vskip\abovecaptionskip\relax}%


% 1.6b revise caption system so that \@makecaption uses two arguments
% as with LaTeX2e. Otherwise, there will be problems when using hyperref.
\def\@NaNAtablestring{table}


% V1.8 compensate for \topskip so top of top figures align with tops of the first lines of main text
% here we calculate a space equal to the amount \topskip exceeds the main text height
% we hook in at \@floatboxreset
\def\@NaNAfiguretopskipspace{\ifdim\prevdepth=-1000pt\relax
\setlength{\@NaNAtrantmpdimenA}{1\topskip}\relax
\addtolength{\@NaNAtrantmpdimenA}{-0.7\@NaNAnormalsizeunitybaselineskip}\relax
\vspace*{\@NaNAtrantmpdimenA}\fi}
% V1.8 compensate for \topskip at the top of top tables so caption text is on main text baseline
% use a strut set on the caption baseline within \@makecaption
\def\@NaNAtabletopskipstrut{\ifdim\prevdepth=-1000pt\rule{0pt}{\topskip}\fi}
% the \ifdim\prevdepth checks are always expected to be true for NaNA style float caption ordering
% because top of figure content and top of captions in tables is the first thing on the vertical
% list of these floats
% thanks to Donald Arseneau for his 2000/11/11 post "Re: caption hacking" with info on this topic.


\ifCLASSOPTIONcompsoc
% V1.7 compsoc \@makecaption
\ifCLASSOPTIONconference% compsoc conference
\long\def\@makecaption#1#2{%
% test if is a for a figure or table
\ifx\@captype\@NaNAtablestring%
% if a table, do table caption
\footnotesize\bgroup\par\centering\@NaNAtabletopskipstrut{\normalfont\footnotesize {#1.}\nobreakspace\scshape #2}\par\addvspace{0.5\baselineskip}\egroup%
\@NaNAtablecaptionsepspace
% if not a table, format it as a figure
\else
\@NaNAfigurecaptionsepspace
\setbox\@tempboxa\hbox{\normalfont\footnotesize {#1.}\nobreakspace #2}%
\ifdim \wd\@tempboxa >\hsize%
% if caption is longer than a line, let it wrap around
\setbox\@tempboxa\hbox{\normalfont\footnotesize {#1.}\nobreakspace}%
\parbox[t]{\hsize}{\normalfont\footnotesize \noindent\unhbox\@tempboxa#2}%
% if caption is shorter than a line, center
\else%
\hbox to\hsize{\normalfont\footnotesize\hfil\box\@tempboxa\hfil}%
\fi\fi}
%
\else% nonconference compsoc
\long\def\@makecaption#1#2{%
% test if is a for a figure or table
\ifx\@captype\@NaNAtablestring%
% if a table, do table caption
\footnotesize\bgroup\par\centering\@NaNAtabletopskipstrut{\normalfont\sffamily\footnotesize #1}\\{\normalfont\sffamily\footnotesize #2}\par\addvspace{0.5\baselineskip}\egroup%
\@NaNAtablecaptionsepspace
% if not a table, format it as a figure
\else
\@NaNAfigurecaptionsepspace
\setbox\@tempboxa\hbox{\normalfont\sffamily\footnotesize {#1.}\nobreakspace #2}%
\ifdim \wd\@tempboxa >\hsize%
% if caption is longer than a line, let it wrap around
\setbox\@tempboxa\hbox{\normalfont\sffamily\footnotesize {#1.}\nobreakspace}%
\parbox[t]{\hsize}{\normalfont\sffamily\footnotesize \noindent\unhbox\@tempboxa#2}%
% if caption is shorter than a line, left justify
\else%
\hbox to\hsize{\normalfont\sffamily\footnotesize\box\@tempboxa\hfil}%
\fi\fi}
\fi
%
\else% traditional noncompsoc \@makecaption
\long\def\@makecaption#1#2{%
% test if is a for a figure or table
\ifx\@captype\@NaNAtablestring%
% if a table, do table caption
\footnotesize\bgroup\par\centering\@NaNAtabletopskipstrut{\normalfont\footnotesize #1}\\{\normalfont\footnotesize\scshape #2}\par\addvspace{0.5\baselineskip}\egroup%
\@NaNAtablecaptionsepspace
% if not a table, format it as a figure
\else
\@NaNAfigurecaptionsepspace
% 3/2001 use footnotesize, not small; use two nonbreaking spaces, not one
\setbox\@tempboxa\hbox{\normalfont\footnotesize {#1.}\nobreakspace\nobreakspace #2}%
\ifdim \wd\@tempboxa >\hsize%
% if caption is longer than a line, let it wrap around
\setbox\@tempboxa\hbox{\normalfont\footnotesize {#1.}\nobreakspace\nobreakspace}%
\parbox[t]{\hsize}{\normalfont\footnotesize\noindent\unhbox\@tempboxa#2}%
% if caption is shorter than a line, center if conference, left justify otherwise
\else%
\ifCLASSOPTIONconference \hbox to\hsize{\normalfont\footnotesize\hfil\box\@tempboxa\hfil}%
\else \hbox to\hsize{\normalfont\footnotesize\box\@tempboxa\hfil}%
\fi\fi\fi}
\fi



% V1.7 disable captions class option, do so in a way that retains operation of \label
% within \caption
\ifCLASSOPTIONcaptionsoff
\long\def\@makecaption#1#2{\vspace*{2em}\footnotesize\bgroup\par\addvspace{0.5\baselineskip}\centering{\footnotesize #1}\par\addvspace{0.5\baselineskip}\egroup%
\let\@NaNAtemporiglabeldefsave\label
\let\@NaNAtemplabelargsave\relax
\def\label##1{\gdef\@NaNAtemplabelargsave{##1}}%
\setbox\@tempboxa\hbox{#2}%
\let\label\@NaNAtemporiglabeldefsave
\ifx\@NaNAtemplabelargsave\relax\else\label{\@NaNAtemplabelargsave}\fi}
\fi


% V1.7 define end environments with \def not \let so as to work OK with
% preview-latex
\newcounter{figure}
\def\thefigure{\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename\nobreakspace\thefigure}
% V1.8 within figures add \@NaNAfiguretopskipspace compensation to LaTeX2e's \@floatboxreset
\def\figure{\def\@floatboxreset{\reset@font\normalsize\@setminipage\@NaNAfiguretopskipspace}\@float{figure}}
\def\endfigure{\end@float}
% V1.8 also add \@NaNAfiguretopskipspace compensation to \figure*
\@namedef{figure*}{\def\@floatboxreset{\reset@font\normalsize\@setminipage\@NaNAfiguretopskipspace}\@dblfloat{figure}}
\@namedef{endfigure*}{\end@dblfloat}

\newcounter{table}
\ifCLASSOPTIONcompsoc
\def\thetable{\arabic{table}}
\else
\def\thetable{\@Roman\c@table}
\fi
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename\nobreakspace\thetable}
% V1.6 The NaNA uses 8pt text for tables
% within tables alter LaTeX2e's \@floatboxreset to use \footnotesize
\def\table{\def\@floatboxreset{\reset@font\footnotesize\@setminipage}\@float{table}}
\def\endtable{\end@float}
% v1.6b double column tables need to default to footnotesize as well.
\@namedef{table*}{\def\@floatboxreset{\reset@font\footnotesize\@setminipage}\@dblfloat{table}}
\@namedef{endtable*}{\end@dblfloat}




%% -- Command Argument Scanning Support Functions --
%% V1.8a 

% usage: \@NaNAstripouterbraces*{}
% \@NaNAstripouterbraces fully expands its argument (which it then stores
% in \@NaNAstripouterbracesarg) via \edef, then removes any outer enclosing
% braces, and finally stores the result in the macro
% \@NaNAstrippedouterbraces.
%
% For example:
% \@NaNAstripouterbraces{{{{ab}c}}}
% results in:
%
% \@NaNAstripouterbracesarg ==> a macro containing {{{ab}c}}
% \@NaNAstrippedouterbraces ==> a macro containing {ab}c
%
% the *-star form,\@NaNAstripouterbraces*, does not expand the argument
% contents during processing
\def\@NaNAstripouterbraces{\@ifstar{\let\@NaNAstripouterbracesdef=\def\@@NaNAstripouterbraces}{\let\@NaNAstripouterbracesdef=\edef\@@NaNAstripouterbraces}}

\def\@@NaNAstripouterbraces#1{\@NaNAstripouterbracesdef\@NaNAstripouterbracesarg{#1}\relax
% If the macro is unchanged after being acquired as a single delimited
% argument, we know we have one sequence of tokens without any enclosing
% braces. Loop until this is true.
\loop
  \expandafter\@@@NaNAstripouterbraces\@NaNAstripouterbracesarg\@NaNAgeneralsequenceDELIMITER
\ifx\@NaNAstrippedouterbraces\@NaNAstripouterbracesarg
\else
  \let\@NaNAstripouterbracesarg\@NaNAstrippedouterbraces
\repeat}

\def\@@@NaNAstripouterbraces#1\@NaNAgeneralsequenceDELIMITER{\def\@NaNAstrippedouterbraces{#1}}



% usage: \@NaNAextractgroup*{}
% \@NaNAextractgroup fully expands its argument (which it then stores in
% \@NaNAextractgrouparg) via \edef and then assigns the first "brace group"
% of tokens to the macro \@NaNAextractedgroup.
% The remaining groups, if any, are stored in the macro
% \@NaNAextractedgroupremain. If the argument does not contain the requisite
% groups, the respective macros will be defined to be empty.
% There is an asymmetry in that \@NaNAextractedgroup is stripped of its first
% outer grouping while \@NaNAextractedgroupremain retains even the outer
% grouping (if present) that originally identified it as a group.
%
% For example:
% \@NaNAextractgroup{{{ab}}{c{de}}}
% results in:
%
% \@NaNAextractgrouparg       ==> a macro containing {{ab}}{c{de}}
% \@NaNAextractedgroup        ==> a macro containing {ab}
% \@NaNAextractedgroupremain  ==> a macro containing {c{de}}
%
% The *-star form, \@NaNAextractgroup*, does not expand its argument
% contents during processing.
\def\@NaNAextractgroup{\@ifstar{\let\@NaNAextractgroupdef=\def\@@NaNAextractgroup}{\let\@NaNAextractgroupdef=\edef\@@NaNAextractgroup}}

\def\@@NaNAextractgroup#1{\@NaNAextractgroupdef\@NaNAextractgrouparg{#1}\relax
% trap the case of an empty extracted group as this would cause problems with
% \@NaNAextractgroupremain's argument acquisition
\ifx\@NaNAextractgrouparg\@empty
  \def\@NaNAextractedgroup{}\relax
  \def\@NaNAextractedgroupremain{}\relax
\else
  % We have to use some dirty tricks here. We want to insert {} around
  % whatever remains after the first group so that TeX's argument scanner
  % will preserve any originally enclosing braces as well as provide an
  % empty argument to acquire even if there isn't a second group.
  % In this first of two dirty tricks, we put a } at the end of the structure
  % we are going to extract from. The \ifnum0=`{\fi keeps TeX happy to allow
  % what would otherwise be an unbalanced macro definition for
  % \@@NaNAextractgroup to be acceptable to it.
  \ifnum0=`{\fi\expandafter\@NaNAextractgroupremain\@NaNAextractgrouparg}\relax
\fi}

% In the second part of the dirty tricks, we insert a leading { right after
% the first group is acquired, but before the remainder is. Again, the
% \ifnum0=`}\fi keeps TeX happy during definition time, but will disappear
% during run time.
\def\@NaNAextractgroupremain#1{\def\@NaNAextractedgroup{#1}\expandafter\@@NaNAextractgroupremain\expandafter{\ifnum0=`}\fi}

\def\@@NaNAextractgroupremain#1{\def\@NaNAextractedgroupremain{#1}}



% \@NaNAextracttoken relocated at top because margin setting commands rely on it



% usage: \@NaNAextracttokengroups*{}
% \@NaNAextracttokengroups fully expands its argument (which it then stores
% in \@NaNAextracttokengroupsarg) and then assigns the first "brace group" of
% tokens (with the outermost braces removed) to the macro
% \@NaNAextractedfirstgroup.
% The meaning of the first nonbrace (but including the empty group) token
% within this first group is assigned via \let to \@NaNAextractedfirsttoken
% as well as stored in the macro \@NaNAextractedfirsttokenmacro. If a first
% nonbrace token does not exist (or is an empty group), these will be \relax
% and empty, respectively.  Tokens that would otherwise be discarded during
% the acquisition of the first token in the first group are stored in
% \@NaNAextractedfirsttokensdiscarded, however their original relative brace
% nesting depths are not guaranteed to be preserved.
% The first group within this first group is stored in the macro
% \@NaNAextractedfirstfirstgroup.
% Likewise for the next group after the first: \@NaNAextractednextgroup,
% \@NaNAextractednextfirstgroup, \@NaNAextractednextgroupfirsttoken,
% \@NaNAextractednextgroupfirsttokenmacro, and 
% \@NaNAextractednextfirsttokensdiscarded.
% All tokens/groups after the first group, including any enclosing braces,
% are stored in the macro \@NaNAextractedafterfirstgroupremain which will
% be empty if none exist.
%
% For example:
% \@NaNAextracttokengroups{{{ab}{cd}}{{ef}g}}
% will result in:
%
% \@NaNAextracttokengroupsarg             ==> a macro containing {{ab}{cd}}{{ef}g}
% \@NaNAextractedfirstgroup               ==> a macro containing {ab}{cd}
% \@NaNAextractedafterfirstgroupremain    ==> a macro containing {{ef}g}
% \@NaNAextractedfirsttoken               ==> the letter a
% \@NaNAextractedfirsttokenmacro          ==> a macro containing a
% \@NaNAextractedfirsttokensdiscarded     ==> a macro containing bcd
% \@NaNAextractedfirstfirstgroup          ==> a macro containing ab
% \@NaNAextractednextgroup                ==> a macro containing {ef}g
% \@NaNAextractednextfirsttoken           ==> the letter e
% \@NaNAextractednextfirsttokenmacro      ==> a macro containing e
% \@NaNAextractednextfirsttokensdiscarded ==> a macro containing fg
% \@NaNAextractednextfirstgroup           ==> a macro containing ef
%
% If given an empty argument, \@NaNAextractedfirsttoken and
% \@NaNAextractednextfirsttoken will be set to \relax
% and all the macros will be empty.
% the *-star form, \@NaNAextracttokengroups*, does not expand its argument
% contents during processing.
%
% Depends on: \@NaNAextractgroup, \@NaNAextracttoken
\def\@NaNAextracttokengroups{\@ifstar{\let\@NaNAextracttokengroupsdef=\def\@@NaNAextracttokengroups}{\let\@NaNAextracttokengroupsdef=\edef\@@NaNAextracttokengroups}}
\def\@@NaNAextracttokengroups#1{\@NaNAextracttokengroupsdef\@NaNAextracttokengroupsarg{#1}\relax
% begin extraction, these functions are safe with empty arguments
% first group
\expandafter\@NaNAextractgroup\expandafter*\expandafter{\@NaNAextracttokengroupsarg}\relax
\let\@NaNAextractedfirstgroup\@NaNAextractedgroup
\let\@NaNAextractedafterfirstgroupremain\@NaNAextractedgroupremain
\expandafter\@NaNAextracttoken\expandafter*\expandafter{\@NaNAextractedfirstgroup}\relax
\let\@NaNAextractedfirsttoken\@NaNAextractedtoken
\let\@NaNAextractedfirsttokenmacro\@NaNAextractedtokenmacro
\let\@NaNAextractedfirsttokensdiscarded\@NaNAextractedtokensdiscarded
% first first group
\expandafter\@NaNAextractgroup\expandafter*\expandafter{\@NaNAextractedfirstgroup}\relax
\let\@NaNAextractedfirstfirstgroup\@NaNAextractedgroup
% next group
\expandafter\@NaNAextractgroup\expandafter*\expandafter{\@NaNAextractedafterfirstgroupremain}\relax
\let\@NaNAextractednextgroup\@NaNAextractedgroup
\expandafter\@NaNAextracttoken\expandafter*\expandafter{\@NaNAextractednextgroup}\relax
\let\@NaNAextractednextfirsttoken\@NaNAextractedtoken
\let\@NaNAextractednextfirsttokenmacro\@NaNAextractedtokenmacro
\let\@NaNAextractednextfirsttokensdiscarded\@NaNAextractedtokensdiscarded
% next first group
\expandafter\@NaNAextractgroup\expandafter*\expandafter{\@NaNAextractednextgroup}\relax
\let\@NaNAextractednextfirstgroup\@NaNAextractedgroup}


%% -- End of Command Argument Scanning Support Functions --




%%
%% START OF NaNAeqnarray DEFINITIONS
%%
%% Inspired by the concepts, examples, and previous works of LaTeX 
%% coders and developers such as Donald Arseneau, Fred Bartlett, 
%% David Carlisle, Tony Liu, Frank Mittelbach, Piet van Oostrum, 
%% Roland Winkler and Mark Wooding.
%% I don't make the claim that my work here is even near their calibre. ;)


\newif\if@NaNAeqnarrayboxnojot% flag to indicate if the environment was called as the star form
\@NaNAeqnarrayboxnojotfalse

\newif\if@advanceNaNAeqncolcnt% tracks if the environment should advance the col counter
% allows a way to make an \NaNAeqnarraybox that can be used within an \NaNAeqnarray
% used by NaNAeqnarraymulticol so that it can work properly in both
\@advanceNaNAeqncolcnttrue

\newcount\@NaNAeqnnumcols % tracks how many NaNAeqnarray cols are defined
\newcount\@NaNAeqncolcnt  % tracks how many NaNAeqnarray cols the user actually used


% The default math style used by the columns
\def\NaNAeqnarraymathstyle{\displaystyle}
% The default text style used by the columns
% default to using the current font
\def\NaNAeqnarraytextstyle{\relax}

% like the iedlistdecl but for \NaNAeqnarray
\def\NaNAeqnarraydecl{\relax}
\def\NaNAeqnarrayboxdecl{\relax}



% V1.8 flags to indicate that equation numbering is to persist
\newif\if@NaNAeqnumpersist%
\@NaNAeqnumpersistfalse
\newif\if@NaNAsubeqnumpersist%
\@NaNAsubeqnumpersistfalse
%
% V1.8 flags to indicate if (sub)equation number of last line was preadvanced
\newif\if@NaNAeqnumpreadv%
\@NaNAeqnumpreadvfalse
\newif\if@NaNAsubeqnumpreadv%
\@NaNAsubeqnumpreadvfalse

\newcount\@NaNAsubeqnnumrollback% saves previous value of NaNAsubequation number in case we need to restore it

% \yesnumber is the opposite of \nonumber
% a novel concept with the same def as the equationarray package
% However, we give NaNA versions too since some LaTeX packages such as 
% the MDWtools mathenv.sty redefine \nonumber to something else.
% This command is intended for use in non-NaNAeqnarray math environments
\providecommand{\yesnumber}{\global\@eqnswtrue}


% NaNAyes/nonumber 
% V1.8 add persistant * forms
% These commands can alter the type of equation an NaNAeqnarray line is.
\def\NaNAyesnumber{\@ifstar{\global\@NaNAeqnumpersisttrue\global\@NaNAsubeqnumpersistfalse\@NaNAyesnumber}{\@NaNAyesnumber}}

\def\@NaNAyesnumber{\global\@eqnswtrue
\if@NaNAeqnarrayISinner% alter counters and label only inside an NaNAeqnarray
\ifnum\c@NaNAsubequation>0\relax
   \stepcounter{equation}\setcounter{NaNAsubequation}{0}\gdef\@currentlabel{\p@equation\theequation}\relax
   \gdef\@currentHref{\@NaNAtheHrefequation}% setup hyperref label
\fi
% even if we reached this eqn num via a preadv, it is legit now
\global\@NaNAeqnumpreadvfalse\global\@NaNAsubeqnumpreadvfalse
\fi}

\def\NaNAnonumber{\@ifstar{\global\@NaNAeqnumpersistfalse\global\@NaNAsubeqnumpersistfalse\global\@eqnswfalse}{\global\@eqnswfalse}}


\def\NaNAyessubnumber{\@ifstar{\global\@NaNAsubeqnumpersisttrue\@NaNAyessubnumber}{\@NaNAyessubnumber}}
%
\def\@NaNAyessubnumber{\if@NaNAeqnarrayISinner% alter counters and label only inside an NaNAeqnarray
  \ifnum\c@NaNAsubequation>0\relax% if it already is a subequation, we are good to go as-is
  \else% if we are a regular equation we have to watch out for two cases
    \if@NaNAeqnumpreadv% if this equation is the result of a preadvance, backout and bump the sub eqnnum
       \global\advance\c@equation\m@ne\global\c@NaNAsubequation=\@NaNAsubeqnnumrollback\addtocounter{NaNAsubequation}{1}\relax
    \else% non-preadvanced equations just need initialization of their sub eqnnum
       \setcounter{NaNAsubequation}{1}\relax
    \fi
  \fi% fi already is subequation
  \gdef\@currentlabel{\p@NaNAsubequation\theNaNAsubequation}\relax
  \gdef\@currentHref{\@NaNAtheHrefsubequation}% setup hyperref label
  \global\@NaNAeqnumpreadvfalse\global\@NaNAsubeqnumpreadvfalse% no longer a preadv anymore
  \global\@eqnswtrue
\fi}


\def\NaNAnosubnumber{\@ifstar{\global\@NaNAsubeqnumpersistfalse\@NaNAnosubnumber}{\@NaNAnosubnumber}}
%
\def\@NaNAnosubnumber{\if@NaNAeqnarrayISinner% alter counters and label only inside an NaNAeqnarray
  \if@eqnsw % we do nothing unless we know we will display because we play with the counters here
    % if it currently is a subequation, bump up to the next equation number and turn off the subequation
    \ifnum\c@NaNAsubequation>0\relax\addtocounter{equation}{1}\setcounter{NaNAsubequation}{0}\relax
    \fi
    \global\@NaNAeqnumpreadvfalse\global\@NaNAsubeqnumpreadvfalse% no longer a preadv anymore
    \gdef\@currentlabel{\p@equation\theequation}\relax
    \gdef\@currentHref{\@NaNAtheHrefequation}% setup hyperref label
  \fi
\fi}



% allows users to "push away" equations that get too close to the equation numbers
\def\NaNAeqnarraynumspace{\hphantom{\ifnum\c@NaNAsubequation>0\relax\theNaNAsubequationdis\else\theequationdis\fi}}

% provides a way to span multiple columns within NaNAeqnarray environments
% will consider \if@advanceNaNAeqncolcnt before globally advancing the
% column counter - so as to work within \NaNAeqnarraybox
% usage: \NaNAeqnarraymulticol{number cols. to span}{col type}{cell text}
\long\def\NaNAeqnarraymulticol#1#2#3{\multispan{#1}\relax
% check if column is defined for the precolumn definition
% We have to be careful here because TeX scans for & even within an \iffalse
% where it does not expand macros. So, if we used only one \ifx and a #3
% appeared in the false branch and the user inserted another alignment
% structure that uses & in the \NaNAeqnarraymulticol{}, TeX will not see that
% there is an inner alignment in the false branch yet still will see any &
% there and will think that they apply to the outer alignment resulting in an
% incomplete \ifx error.
% So, here we use separate checks for the pre and post parts in order to keep
% the #3 outside of all conditionals.
\relax\expandafter\ifx\csname @NaNAeqnarraycolDEF#2\endcsname\@NaNAeqnarraycolisdefined\relax
\csname @NaNAeqnarraycolPRE#2\endcsname
\else% if not, error and use default type
\@NaNAclspkgerror{Invalid column type "#2" in \string\NaNAeqnarraymulticol.\MessageBreak
Using a default centering column instead}%
{You must define NaNAeqnarray column types before use.}%
\csname @NaNAeqnarraycolPRE@NaNAdefault\endcsname
\fi
% The ten \relax are to help prevent misleading error messages in case a user
% accidently inserted a macro that tries to acquire additional arguments.
#3\relax\relax\relax\relax\relax\relax\relax\relax\relax\relax
% check if column is defined for the postcolumn definition
\expandafter\ifx\csname @NaNAeqnarraycolDEF#2\endcsname\@NaNAeqnarraycolisdefined\relax
\csname @NaNAeqnarraycolPOST#2\endcsname
\else% if not, use the default type
\csname @NaNAeqnarraycolPOST@NaNAdefault\endcsname
\fi
% advance column counter only if the NaNAeqnarray environment wants it
\if@advanceNaNAeqncolcnt\global\advance\@NaNAeqncolcnt by #1\relax\fi}

% like \omit, but maintains track of the column counter for \NaNAeqnarray
\def\NaNAeqnarrayomit{\omit\if@advanceNaNAeqncolcnt\global\advance\@NaNAeqncolcnt by 1\relax\fi}


% provides a way to define a letter referenced column type
% usage: \NaNAeqnarraydefcol{col. type letter/name}{pre insertion text}{post insertion text}
\def\NaNAeqnarraydefcol#1#2#3{\expandafter\def\csname @NaNAeqnarraycolPRE#1\endcsname{#2}%
\expandafter\def\csname @NaNAeqnarraycolPOST#1\endcsname{#3}%
\expandafter\def\csname @NaNAeqnarraycolDEF#1\endcsname{1}}


% provides a way to define a numerically referenced inter-column glue types
% usage: \NaNAeqnarraydefcolsep{col. glue number}{glue definition}
\def\NaNAeqnarraydefcolsep#1#2{\expandafter\def\csname @NaNAeqnarraycolSEP\romannumeral #1\endcsname{#2}%
\expandafter\def\csname @NaNAeqnarraycolSEPDEF\romannumeral #1\endcsname{1}}


\def\@NaNAeqnarraycolisdefined{1}% just a macro for 1, used for checking undefined column types


% expands and appends the given argument to the \@NaNAtrantmptoksA token list
% used to build up the \halign preamble
\def\@NaNAappendtoksA#1{\edef\@@NaNAappendtoksA{\@NaNAtrantmptoksA={\the\@NaNAtrantmptoksA #1}}%
\@@NaNAappendtoksA}

% also appends to \@NaNAtrantmptoksA, but does not expand the argument
% uses \toks8 as a scratchpad register
\def\@NaNAappendNOEXPANDtoksA#1{\toks8={#1}%
\edef\@@NaNAappendNOEXPANDtoksA{\@NaNAtrantmptoksA={\the\@NaNAtrantmptoksA\the\toks8}}%
\@@NaNAappendNOEXPANDtoksA}

% define some common column types for the user
% math
\NaNAeqnarraydefcol{l}{$\NaNAeqnarraymathstyle}{$\hfil}
\NaNAeqnarraydefcol{c}{\hfil$\NaNAeqnarraymathstyle}{$\hfil}
\NaNAeqnarraydefcol{r}{\hfil$\NaNAeqnarraymathstyle}{$}
\NaNAeqnarraydefcol{L}{$\NaNAeqnarraymathstyle{}}{{}$\hfil}
\NaNAeqnarraydefcol{C}{\hfil$\NaNAeqnarraymathstyle{}}{{}$\hfil}
\NaNAeqnarraydefcol{R}{\hfil$\NaNAeqnarraymathstyle{}}{{}$}
% text
\NaNAeqnarraydefcol{s}{\NaNAeqnarraytextstyle}{\hfil}
\NaNAeqnarraydefcol{t}{\hfil\NaNAeqnarraytextstyle}{\hfil}
\NaNAeqnarraydefcol{u}{\hfil\NaNAeqnarraytextstyle}{}

% vertical rules
\NaNAeqnarraydefcol{v}{}{\vrule width\arrayrulewidth}
\NaNAeqnarraydefcol{vv}{\vrule width\arrayrulewidth\hfil}{\hfil\vrule width\arrayrulewidth}
\NaNAeqnarraydefcol{V}{}{\vrule width\arrayrulewidth\hskip\doublerulesep\vrule width\arrayrulewidth}
\NaNAeqnarraydefcol{VV}{\vrule width\arrayrulewidth\hskip\doublerulesep\vrule width\arrayrulewidth\hfil}%
{\hfil\vrule width\arrayrulewidth\hskip\doublerulesep\vrule width\arrayrulewidth}

% horizontal rules
\NaNAeqnarraydefcol{h}{}{\leaders\hrule height\arrayrulewidth\hfil}
\NaNAeqnarraydefcol{H}{}{\leaders\vbox{\hrule width\arrayrulewidth\vskip\doublerulesep\hrule width\arrayrulewidth}\hfil}

% plain
\NaNAeqnarraydefcol{x}{}{}
\NaNAeqnarraydefcol{X}{$}{$}

% the default column type to use in the event a column type is not defined
\NaNAeqnarraydefcol{@NaNAdefault}{\hfil$\NaNAeqnarraymathstyle}{$\hfil}


% a zero tabskip (used for "-" col types)
\def\@NaNAeqnarraycolSEPzero{0pt plus 0pt minus 0pt}
% a centering tabskip (used for "+" col types)
\def\@NaNAeqnarraycolSEPcenter{1000pt plus 0pt minus 1000pt}

% top level default tabskip glues for the start, end, and inter-column
% may be reset within environments not always at the top level, e.g., \NaNAeqnarraybox
\edef\@NaNAeqnarraycolSEPdefaultstart{\@NaNAeqnarraycolSEPcenter}% default start glue
\edef\@NaNAeqnarraycolSEPdefaultend{\@NaNAeqnarraycolSEPcenter}% default end glue
\edef\@NaNAeqnarraycolSEPdefaultmid{\@NaNAeqnarraycolSEPzero}% default inter-column glue



% creates a vertical rule that extends from the bottom to the top a a cell
% Provided in case other packages redefine \vline some other way.
% usage: \NaNAeqnarrayvrule[rule thickness]
% If no argument is provided, \arrayrulewidth will be used for the rule thickness. 
\newcommand\NaNAeqnarrayvrule[1][\arrayrulewidth]{\vrule\@width#1\relax}

% creates a blank separator row
% usage: \NaNAeqnarrayseprow[separation length][font size commands]
% default is \NaNAeqnarrayseprow[0.25\normalbaselineskip][\relax]
% blank arguments inherit the default values
% uses \skip5 as a scratch register - calls \@NaNAeqnarraystrutsize which uses more scratch registers
\def\NaNAeqnarrayseprow{\relax\@ifnextchar[{\@NaNAeqnarrayseprow}{\@NaNAeqnarrayseprow[0.25\normalbaselineskip]}}
\def\@NaNAeqnarrayseprow[#1]{\relax\@ifnextchar[{\@@NaNAeqnarrayseprow[#1]}{\@@NaNAeqnarrayseprow[#1][\relax]}}
\def\@@NaNAeqnarrayseprow[#1][#2]{\def\@NaNAeqnarrayseprowARGONE{#1}%
\ifx\@NaNAeqnarrayseprowARGONE\@empty%
% get the skip value, based on the font commands
% use skip5 because \NaNAeqnarraystrutsize uses \skip0, \skip2, \skip3
% assign within a bogus box to confine the font changes
{\setbox0=\hbox{#2\relax\global\skip5=0.25\normalbaselineskip}}%
\else%
{\setbox0=\hbox{#2\relax\global\skip5=#1}}%
\fi%
\@NaNAeqnarrayhoptolastcolumn\NaNAeqnarraystrutsize{\skip5}{0pt}[\relax]\relax}

% creates a blank separator row, but omits all the column templates
% usage: \NaNAeqnarrayseprowcut[separation length][font size commands]
% default is \NaNAeqnarrayseprowcut[0.25\normalbaselineskip][\relax]
% blank arguments inherit the default values
% uses \skip5 as a scratch register - calls \@NaNAeqnarraystrutsize which uses more scratch registers
\def\NaNAeqnarrayseprowcut{\multispan{\@NaNAeqnnumcols}\relax% span all the cols
% advance column counter only if the NaNAeqnarray environment wants it
\if@advanceNaNAeqncolcnt\global\advance\@NaNAeqncolcnt by \@NaNAeqnnumcols\relax\fi%
\@ifnextchar[{\@NaNAeqnarrayseprowcut}{\@NaNAeqnarrayseprowcut[0.25\normalbaselineskip]}}
\def\@NaNAeqnarrayseprowcut[#1]{\relax\@ifnextchar[{\@@NaNAeqnarrayseprowcut[#1]}{\@@NaNAeqnarrayseprowcut[#1][\relax]}}
\def\@@NaNAeqnarrayseprowcut[#1][#2]{\def\@NaNAeqnarrayseprowARGONE{#1}%
\ifx\@NaNAeqnarrayseprowARGONE\@empty%
% get the skip value, based on the font commands
% use skip5 because \NaNAeqnarraystrutsize uses \skip0, \skip2, \skip3
% assign within a bogus box to confine the font changes
{\setbox0=\hbox{#2\relax\global\skip5=0.25\normalbaselineskip}}%
\else%
{\setbox0=\hbox{#2\relax\global\skip5=#1}}%
\fi%
\NaNAeqnarraystrutsize{\skip5}{0pt}[\relax]\relax}



% draws a single rule across all the columns optional
% argument determines the rule width, \arrayrulewidth is the default
% updates column counter as needed and turns off struts
% usage: \NaNAeqnarrayrulerow[rule line thickness]
\def\NaNAeqnarrayrulerow{\multispan{\@NaNAeqnnumcols}\relax% span all the cols
% advance column counter only if the NaNAeqnarray environment wants it
\if@advanceNaNAeqncolcnt\global\advance\@NaNAeqncolcnt by \@NaNAeqnnumcols\relax\fi%
\@ifnextchar[{\@NaNAeqnarrayrulerow}{\@NaNAeqnarrayrulerow[\arrayrulewidth]}}
\def\@NaNAeqnarrayrulerow[#1]{\leaders\hrule height#1\hfil\relax% put in our rule 
% turn off any struts
\NaNAeqnarraystrutsize{0pt}{0pt}[\relax]\relax}


% draws a double rule by using a single rule row, a separator row, and then
% another single rule row 
% first optional argument determines the rule thicknesses, \arrayrulewidth is the default
% second optional argument determines the rule spacing, \doublerulesep is the default
% usage: \NaNAeqnarraydblrulerow[rule line thickness][rule spacing]
\def\NaNAeqnarraydblrulerow{\multispan{\@NaNAeqnnumcols}\relax% span all the cols
% advance column counter only if the NaNAeqnarray environment wants it
\if@advanceNaNAeqncolcnt\global\advance\@NaNAeqncolcnt by \@NaNAeqnnumcols\relax\fi%
\@ifnextchar[{\@NaNAeqnarraydblrulerow}{\@NaNAeqnarraydblrulerow[\arrayrulewidth]}}
\def\@NaNAeqnarraydblrulerow[#1]{\relax\@ifnextchar[{\@@NaNAeqnarraydblrulerow[#1]}%
{\@@NaNAeqnarraydblrulerow[#1][\doublerulesep]}}
\def\@@NaNAeqnarraydblrulerow[#1][#2]{\def\@NaNAeqnarraydblrulerowARG{#1}%
% we allow the user to say \NaNAeqnarraydblrulerow[][]
\ifx\@NaNAeqnarraydblrulerowARG\@empty%
\@NaNAeqnarrayrulerow[\arrayrulewidth]%
\else%
\@NaNAeqnarrayrulerow[#1]\relax%
\fi%
\def\@NaNAeqnarraydblrulerowARG{#2}%
\ifx\@NaNAeqnarraydblrulerowARG\@empty%
\\\NaNAeqnarrayseprow[\doublerulesep][\relax]%
\else%
\\\NaNAeqnarrayseprow[#2][\relax]%
\fi%
\\\multispan{\@NaNAeqnnumcols}%
% advance column counter only if the NaNAeqnarray environment wants it
\if@advanceNaNAeqncolcnt\global\advance\@NaNAeqncolcnt by \@NaNAeqnnumcols\relax\fi%
\def\@NaNAeqnarraydblrulerowARG{#1}%
\ifx\@NaNAeqnarraydblrulerowARG\@empty%
\@NaNAeqnarrayrulerow[\arrayrulewidth]%
\else%
\@NaNAeqnarrayrulerow[#1]%
\fi%
}

% draws a double rule by using a single rule row, a separator (cutting) row, and then
% another single rule row 
% first optional argument determines the rule thicknesses, \arrayrulewidth is the default
% second optional argument determines the rule spacing, \doublerulesep is the default
% usage: \NaNAeqnarraydblrulerow[rule line thickness][rule spacing]
\def\NaNAeqnarraydblrulerowcut{\multispan{\@NaNAeqnnumcols}\relax% span all the cols
% advance column counter only if the NaNAeqnarray environment wants it
\if@advanceNaNAeqncolcnt\global\advance\@NaNAeqncolcnt by \@NaNAeqnnumcols\relax\fi%
\@ifnextchar[{\@NaNAeqnarraydblrulerowcut}{\@NaNAeqnarraydblrulerowcut[\arrayrulewidth]}}
\def\@NaNAeqnarraydblrulerowcut[#1]{\relax\@ifnextchar[{\@@NaNAeqnarraydblrulerowcut[#1]}%
{\@@NaNAeqnarraydblrulerowcut[#1][\doublerulesep]}}
\def\@@NaNAeqnarraydblrulerowcut[#1][#2]{\def\@NaNAeqnarraydblrulerowARG{#1}%
% we allow the user to say \NaNAeqnarraydblrulerow[][]
\ifx\@NaNAeqnarraydblrulerowARG\@empty%
\@NaNAeqnarrayrulerow[\arrayrulewidth]%
\else%
\@NaNAeqnarrayrulerow[#1]%
\fi%
\def\@NaNAeqnarraydblrulerowARG{#2}%
\ifx\@NaNAeqnarraydblrulerowARG\@empty%
\\\NaNAeqnarrayseprowcut[\doublerulesep][\relax]%
\else%
\\\NaNAeqnarrayseprowcut[#2][\relax]%
\fi%
\\\multispan{\@NaNAeqnnumcols}%
% advance column counter only if the NaNAeqnarray environment wants it
\if@advanceNaNAeqncolcnt\global\advance\@NaNAeqncolcnt by \@NaNAeqnnumcols\relax\fi%
\def\@NaNAeqnarraydblrulerowARG{#1}%
\ifx\@NaNAeqnarraydblrulerowARG\@empty%
\@NaNAeqnarrayrulerow[\arrayrulewidth]%
\else%
\@NaNAeqnarrayrulerow[#1]%
\fi%
}



% inserts a full row's worth of &'s
% relies on \@NaNAeqnnumcols to provide the correct number of columns
% uses \@NaNAtrantmptoksA, \count0 as scratch registers
\def\@NaNAeqnarrayhoptolastcolumn{\@NaNAtrantmptoksA={}\count0=1\relax%
\loop% add cols if the user did not use them all
\ifnum\count0<\@NaNAeqnnumcols\relax%
\@NaNAappendtoksA{&}%
\advance\count0 by 1\relax% update the col count
\repeat%
\the\@NaNAtrantmptoksA%execute the &'s
}



\newif\if@NaNAeqnarrayISinner % flag to indicate if we are within the lines
\@NaNAeqnarrayISinnerfalse    % of an NaNAeqnarray - after the NaNAeqnarraydecl

\edef\@NaNAeqnarrayTHEstrutheight{0pt} % height and depth of NaNAeqnarray struts
\edef\@NaNAeqnarrayTHEstrutdepth{0pt}

\edef\@NaNAeqnarrayTHEmasterstrutheight{0pt} % default height and depth of
\edef\@NaNAeqnarrayTHEmasterstrutdepth{0pt}  % struts within an NaNAeqnarray

\edef\@NaNAeqnarrayTHEmasterstrutHSAVE{0pt} % saved master strut height
\edef\@NaNAeqnarrayTHEmasterstrutDSAVE{0pt} % and depth

\newif\if@NaNAeqnarrayusemasterstrut % flag to indicate that the master strut value
\@NaNAeqnarrayusemasterstruttrue     % is to be used



% saves the strut height and depth of the master strut
\def\@NaNAeqnarraymasterstrutsave{\relax%
\expandafter\skip0=\@NaNAeqnarrayTHEmasterstrutheight\relax%
\expandafter\skip2=\@NaNAeqnarrayTHEmasterstrutdepth\relax%
% remove stretchability
\dimen0\skip0\relax%
\dimen2\skip2\relax%
% save values
\edef\@NaNAeqnarrayTHEmasterstrutHSAVE{\the\dimen0}%
\edef\@NaNAeqnarrayTHEmasterstrutDSAVE{\the\dimen2}}

% restores the strut height and depth of the master strut
\def\@NaNAeqnarraymasterstrutrestore{\relax%
\expandafter\skip0=\@NaNAeqnarrayTHEmasterstrutHSAVE\relax%
\expandafter\skip2=\@NaNAeqnarrayTHEmasterstrutDSAVE\relax%
% remove stretchability
\dimen0\skip0\relax%
\dimen2\skip2\relax%
% restore values
\edef\@NaNAeqnarrayTHEmasterstrutheight{\the\dimen0}%
\edef\@NaNAeqnarrayTHEmasterstrutdepth{\the\dimen2}}


% globally restores the strut height and depth to the 
% master values and sets the master strut flag to true
\def\@NaNAeqnarraystrutreset{\relax%
\expandafter\skip0=\@NaNAeqnarrayTHEmasterstrutheight\relax%
\expandafter\skip2=\@NaNAeqnarrayTHEmasterstrutdepth\relax%
% remove stretchability
\dimen0\skip0\relax%
\dimen2\skip2\relax%
% restore values
\xdef\@NaNAeqnarrayTHEstrutheight{\the\dimen0}%
\xdef\@NaNAeqnarrayTHEstrutdepth{\the\dimen2}%
\global\@NaNAeqnarrayusemasterstruttrue}


% if the master strut is not to be used, make the current
% values of \@NaNAeqnarrayTHEstrutheight, \@NaNAeqnarrayTHEstrutdepth
% and the use master strut flag, global
% this allows user strut commands issued in the last column to be carried
% into the isolation/strut column
\def\@NaNAeqnarrayglobalizestrutstatus{\relax%
\if@NaNAeqnarrayusemasterstrut\else%
\xdef\@NaNAeqnarrayTHEstrutheight{\@NaNAeqnarrayTHEstrutheight}%
\xdef\@NaNAeqnarrayTHEstrutdepth{\@NaNAeqnarrayTHEstrutdepth}%
\global\@NaNAeqnarrayusemasterstrutfalse%
\fi}



% usage: \NaNAeqnarraystrutsize{height}{depth}[font size commands]
% If called outside the lines of an NaNAeqnarray, sets the height
% and depth of both the master and local struts. If called inside
% an NaNAeqnarray line, sets the height and depth of the local strut
% only and sets the flag to indicate the use of the local strut
% values. If the height or depth is left blank, 0.7\normalbaselineskip
% and 0.3\normalbaselineskip will be used, respectively.
% The optional argument can be used to evaluate the lengths under
% a different font size and styles. If none is specified, the current
% font is used.
% uses scratch registers \skip0, \skip2, \skip3, \dimen0, \dimen2
\def\NaNAeqnarraystrutsize#1#2{\relax\@ifnextchar[{\@NaNAeqnarraystrutsize{#1}{#2}}{\@NaNAeqnarraystrutsize{#1}{#2}[\relax]}}
\def\@NaNAeqnarraystrutsize#1#2[#3]{\def\@NaNAeqnarraystrutsizeARG{#1}%
\ifx\@NaNAeqnarraystrutsizeARG\@empty%
{\setbox0=\hbox{#3\relax\global\skip3=0.7\normalbaselineskip}}%
\skip0=\skip3\relax%
\else% arg one present
{\setbox0=\hbox{#3\relax\global\skip3=#1\relax}}%
\skip0=\skip3\relax%
\fi% if null arg
\def\@NaNAeqnarraystrutsizeARG{#2}%
\ifx\@NaNAeqnarraystrutsizeARG\@empty%
{\setbox0=\hbox{#3\relax\global\skip3=0.3\normalbaselineskip}}%
\skip2=\skip3\relax%
\else% arg two present
{\setbox0=\hbox{#3\relax\global\skip3=#2\relax}}%
\skip2=\skip3\relax%
\fi% if null arg
% remove stretchability, just to be safe
\dimen0\skip0\relax%
\dimen2\skip2\relax%
% dimen0 = height, dimen2 = depth
\if@NaNAeqnarrayISinner% inner does not touch master strut size
\edef\@NaNAeqnarrayTHEstrutheight{\the\dimen0}%
\edef\@NaNAeqnarrayTHEstrutdepth{\the\dimen2}%
\@NaNAeqnarrayusemasterstrutfalse% do not use master
\else% outer, have to set master strut too
\edef\@NaNAeqnarrayTHEmasterstrutheight{\the\dimen0}%
\edef\@NaNAeqnarrayTHEmasterstrutdepth{\the\dimen2}%
\edef\@NaNAeqnarrayTHEstrutheight{\the\dimen0}%
\edef\@NaNAeqnarrayTHEstrutdepth{\the\dimen2}%
\@NaNAeqnarrayusemasterstruttrue% use master strut
\fi}


% usage: \NaNAeqnarraystrutsizeadd{added height}{added depth}[font size commands]
% If called outside the lines of an NaNAeqnarray, adds the given height
% and depth to both the master and local struts.
% If called inside an NaNAeqnarray line, adds the given height and depth
% to the local strut only and sets the flag to indicate the use 
% of the local strut values.
% In both cases, if a height or depth is left blank, 0pt is used instead.
% The optional argument can be used to evaluate the lengths under
% a different font size and styles. If none is specified, the current
% font is used.
% uses scratch registers \skip0, \skip2, \skip3, \dimen0, \dimen2
\def\NaNAeqnarraystrutsizeadd#1#2{\relax\@ifnextchar[{\@NaNAeqnarraystrutsizeadd{#1}{#2}}{\@NaNAeqnarraystrutsizeadd{#1}{#2}[\relax]}}
\def\@NaNAeqnarraystrutsizeadd#1#2[#3]{\def\@NaNAeqnarraystrutsizearg{#1}%
\ifx\@NaNAeqnarraystrutsizearg\@empty%
\skip0=0pt\relax%
\else% arg one present
{\setbox0=\hbox{#3\relax\global\skip3=#1}}%
\skip0=\skip3\relax%
\fi% if null arg
\def\@NaNAeqnarraystrutsizearg{#2}%
\ifx\@NaNAeqnarraystrutsizearg\@empty%
\skip2=0pt\relax%
\else% arg two present
{\setbox0=\hbox{#3\relax\global\skip3=#2}}%
\skip2=\skip3\relax%
\fi% if null arg
% remove stretchability, just to be safe
\dimen0\skip0\relax%
\dimen2\skip2\relax%
% dimen0 = height, dimen2 = depth
\if@NaNAeqnarrayISinner% inner does not touch master strut size
% get local strut size
\expandafter\skip0=\@NaNAeqnarrayTHEstrutheight\relax%
\expandafter\skip2=\@NaNAeqnarrayTHEstrutdepth\relax%
% add it to the user supplied values
\advance\dimen0 by \skip0\relax%
\advance\dimen2 by \skip2\relax%
% update the local strut size
\edef\@NaNAeqnarrayTHEstrutheight{\the\dimen0}%
\edef\@NaNAeqnarrayTHEstrutdepth{\the\dimen2}%
\@NaNAeqnarrayusemasterstrutfalse% do not use master
\else% outer, have to set master strut too
% get master strut size
\expandafter\skip0=\@NaNAeqnarrayTHEmasterstrutheight\relax%
\expandafter\skip2=\@NaNAeqnarrayTHEmasterstrutdepth\relax%
% add it to the user supplied values
\advance\dimen0 by \skip0\relax%
\advance\dimen2 by \skip2\relax%
% update the local and master strut sizes
\edef\@NaNAeqnarrayTHEmasterstrutheight{\the\dimen0}%
\edef\@NaNAeqnarrayTHEmasterstrutdepth{\the\dimen2}%
\edef\@NaNAeqnarrayTHEstrutheight{\the\dimen0}%
\edef\@NaNAeqnarrayTHEstrutdepth{\the\dimen2}%
\@NaNAeqnarrayusemasterstruttrue% use master strut
\fi}


% allow user a way to see the struts
\newif\ifNaNAvisiblestruts
\NaNAvisiblestrutsfalse

% inserts an invisible strut using the master or local strut values
% uses scratch registers \skip0, \skip2, \dimen0, \dimen2
\def\@NaNAeqnarrayinsertstrut{\relax%
\if@NaNAeqnarrayusemasterstrut
% get master strut size
\expandafter\skip0=\@NaNAeqnarrayTHEmasterstrutheight\relax%
\expandafter\skip2=\@NaNAeqnarrayTHEmasterstrutdepth\relax%
\else%
% get local strut size
\expandafter\skip0=\@NaNAeqnarrayTHEstrutheight\relax%
\expandafter\skip2=\@NaNAeqnarrayTHEstrutdepth\relax%
\fi%
% remove stretchability, probably not needed
\dimen0\skip0\relax%
\dimen2\skip2\relax%
% dimen0 = height, dimen2 = depth
% allow user to see struts if desired
\ifNaNAvisiblestruts%
\vrule width0.2pt height\dimen0 depth\dimen2\relax%
\else%
\vrule width0pt height\dimen0 depth\dimen2\relax\fi}


% creates an invisible strut, useable even outside \NaNAeqnarray
% if \NaNAvisiblestrutstrue, the strut will be visible and 0.2pt wide. 
% usage: \NaNAstrut[height][depth][font size commands]
% default is \NaNAstrut[0.7\normalbaselineskip][0.3\normalbaselineskip][\relax]
% blank arguments inherit the default values
% uses \dimen0, \dimen2, \skip0, \skip2
\def\NaNAstrut{\relax\@ifnextchar[{\@NaNAstrut}{\@NaNAstrut[0.7\normalbaselineskip]}}
\def\@NaNAstrut[#1]{\relax\@ifnextchar[{\@@NaNAstrut[#1]}{\@@NaNAstrut[#1][0.3\normalbaselineskip]}}
\def\@@NaNAstrut[#1][#2]{\relax\@ifnextchar[{\@@@NaNAstrut[#1][#2]}{\@@@NaNAstrut[#1][#2][\relax]}}
\def\@@@NaNAstrut[#1][#2][#3]{\mbox{#3\relax%
\def\@NaNAstrutARG{#1}%
\ifx\@NaNAstrutARG\@empty%
\skip0=0.7\normalbaselineskip\relax%
\else%
\skip0=#1\relax%
\fi%
\def\@NaNAstrutARG{#2}%
\ifx\@NaNAstrutARG\@empty%
\skip2=0.3\normalbaselineskip\relax%
\else%
\skip2=#2\relax%
\fi%
% remove stretchability, probably not needed
\dimen0\skip0\relax%
\dimen2\skip2\relax%
\ifNaNAvisiblestruts%
\vrule width0.2pt height\dimen0 depth\dimen2\relax%
\else%
\vrule width0.0pt height\dimen0 depth\dimen2\relax\fi}}


% enables strut mode by setting a default strut size and then zeroing the
% \baselineskip, \lineskip, \lineskiplimit and \jot
\def\NaNAeqnarraystrutmode{\NaNAeqnarraystrutsize{0.7\normalbaselineskip}{0.3\normalbaselineskip}[\relax]%
\baselineskip=0pt\lineskip=0pt\lineskiplimit=0pt\jot=0pt}


% equation and subequation forms to use to setup hyperref's \@currentHref
\def\@NaNAtheHrefequation{equation.\theHequation}
\def\@NaNAtheHrefsubequation{equation.\theHequation\alph{NaNAsubequation}}


\def\NaNAeqnarray{\@NaNAeqnumpersisttrue\@NaNAsubeqnumpersistfalse\@NaNAeqnarray}
\def\endNaNAeqnarray{\end@NaNAeqnarray}

\@namedef{NaNAeqnarray*}{\@NaNAeqnumpersistfalse\@NaNAsubeqnumpersistfalse\@NaNAeqnarray}
\@namedef{endNaNAeqnarray*}{\end@NaNAeqnarray}


% \NaNAeqnarray is an enhanced \eqnarray. 
% The star form defaults to not putting equation numbers at the end of each row.
% usage: \NaNAeqnarray[decl]{cols}
\def\@NaNAeqnarray{\relax\@ifnextchar[{\@@NaNAeqnarray}{\@@NaNAeqnarray[\relax]}}
% We have to be careful here to normalize catcodes just before acquiring the
% cols as that specification may contain punctuation which could be subject
% to document catcode changes.
\def\@@NaNAeqnarray[#1]{\begingroup\NaNAnormalcatcodes\@@@NaNAeqnarray[#1]}
\def\@@@NaNAeqnarray[#1]#2{\endgroup
   % default to showing the equation number or not based on whether or not
   % the star form was involked
   \if@NaNAeqnumpersist\global\@eqnswtrue
   \else% not the star form
   \global\@eqnswfalse
   \fi% if star form
   % provide a basic hyperref \theHequation if this has not already been setup (hyperref not loaded, or no section counter)
   \@ifundefined{theHequation}{\def\theHequation{\arabic{equation}}}{}\relax
   % provide dummy hyperref commands in case hyperref is not loaded
   \providecommand{\Hy@raisedlink}[1]{}\relax
   \providecommand{\hyper@anchorstart}[1]{}\relax
   \providecommand{\hyper@anchorend}{}\relax
   \providecommand{\@currentHref}{}\relax
   \@NaNAeqnumpreadvfalse% reset eqnpreadv flag
   \@NaNAsubeqnumpreadvfalse% reset subeqnpreadv flag
   \@NaNAeqnarrayISinnerfalse% not yet within the lines of the halign
   \@NaNAeqnarraystrutsize{0pt}{0pt}[\relax]% turn off struts by default
   \@NaNAeqnarrayusemasterstruttrue% use master strut till user asks otherwise
   \NaNAvisiblestrutsfalse% diagnostic mode defaults to off
   % no extra space unless the user specifically requests it
   \lineskip=0pt\relax
   \lineskiplimit=0pt\relax
   \baselineskip=\normalbaselineskip\relax%
   \jot=\NaNAnormaljot\relax%
   \mathsurround\z@\relax% no extra spacing around math
   \@advanceNaNAeqncolcnttrue% advance the col counter for each col the user uses, 
                             % used in \NaNAeqnarraymulticol and in the preamble build
   %V1.8 Here we preadvance to the next equation number.
   % If the user later wants a continued subequation, we can roll back.
   \global\@NaNAsubeqnnumrollback=\c@NaNAsubequation%
   \stepcounter{equation}\@NaNAeqnumpreadvtrue% advance equation counter before first line
   \setcounter{NaNAsubequation}{0}% no subequation yet
   \let\@NaNAcurrentlabelsave\@currentlabel% save current label as we later change it globally
   \let\@NaNAcurrentHrefsave\@currentHref% save current href label as we later change it globally
   \def\@currentlabel{\p@equation\theequation}% redefine the ref label
   \def\@currentHref{\@NaNAtheHrefequation}% setup hyperref label
   \NaNAeqnarraydecl\relax% allow a way for the user to make global overrides
   #1\relax% allow user to override defaults
   \let\\\@NaNAeqnarraycr% replace newline with one that can put in eqn. numbers
   \global\@NaNAeqncolcnt\z@% col. count = 0 for first line
   \@NaNAbuildpreamble{#2}\relax% build the preamble and put it into \@NaNAtrantmptoksA 
   % put in the column for the equation number
   \ifnum\@NaNAeqnnumcols>0\relax\@NaNAappendtoksA{&}\fi% col separator for those after the first
   \toks0={##}%
   % advance the \@NaNAeqncolcnt for the isolation col, this helps with error checking
   \@NaNAappendtoksA{\global\advance\@NaNAeqncolcnt by 1\relax}%
   % add the isolation column
   \@NaNAappendtoksA{\tabskip\z@skip\bgroup\the\toks0\egroup}%
   % advance the \@NaNAeqncolcnt for the equation number col, this helps with error checking
   \@NaNAappendtoksA{&\global\advance\@NaNAeqncolcnt by 1\relax}%
   % add the equation number col to the preamble
   \@NaNAappendtoksA{\tabskip\z@skip\hb@xt@\z@\bgroup\hss\the\toks0\egroup}%
   % note \@NaNAeqnnumcols does not count the equation col or isolation col
   % set the starting tabskip glue as determined by the preamble build
   \tabskip=\@NaNABPstartglue\relax
   % begin the display alignment
   \@NaNAeqnarrayISinnertrue% commands are now within the lines
   $$\everycr{}\halign to\displaywidth\bgroup
   % "exspand" the preamble
   \span\the\@NaNAtrantmptoksA\cr}

% enter isolation/strut column (or the next column if the user did not use
% every column), record the strut status, complete the columns, do the strut if needed,
% restore counters (to backout any equation setup for a next line that was never used)
% to their correct values and exit
\def\end@NaNAeqnarray{\@NaNAeqnarrayglobalizestrutstatus&\@@NaNAeqnarraycr\egroup
\if@NaNAsubeqnumpreadv\global\advance\c@NaNAsubequation\m@ne\fi
\if@NaNAeqnumpreadv\global\advance\c@equation\m@ne\global\c@NaNAsubequation=\@NaNAsubeqnnumrollback\fi
\global\let\@currentlabel\@NaNAcurrentlabelsave% restore current label
\global\let\@currentHref\@NaNAcurrentHrefsave% restore current href label
$$\@ignoretrue}


% NaNAeqnarray uses a modifed \\ instead of the plain \cr to
% end rows. This allows for things like \\*[vskip amount]
% These "cr" macros are modified versions of those for LaTeX2e's eqnarray
% the {\ifnum0=`} braces must be kept away from the last column to avoid
% altering spacing of its math, so we use & to advance to the next column
% as there is an isolation/strut column after the user's columns
\def\@NaNAeqnarraycr{\@NaNAeqnarrayglobalizestrutstatus&% save strut status and advance to next column
   {\ifnum0=`}\fi
   \@ifstar{%
      \global\@eqpen\@M\@NaNAeqnarrayYCR
   }{%
      \global\@eqpen\interdisplaylinepenalty \@NaNAeqnarrayYCR
   }%
}

\def\@NaNAeqnarrayYCR{\@testopt\@NaNAeqnarrayXCR\z@skip}

\def\@NaNAeqnarrayXCR[#1]{%
   \ifnum0=`{\fi}%
   \@@NaNAeqnarraycr
   \noalign{\penalty\@eqpen\vskip\jot\vskip #1\relax}}%

\def\@@NaNAeqnarraycr{\@NaNAtrantmptoksA={}% clear token register
    \advance\@NaNAeqncolcnt by -1\relax% adjust col count because of the isolation column
    \ifnum\@NaNAeqncolcnt>\@NaNAeqnnumcols\relax
    \@NaNAclspkgerror{Too many columns within the NaNAeqnarray\MessageBreak
                          environment}%
    {Use fewer \string &'s or put more columns in the NaNAeqnarray column\MessageBreak 
     specifications.}\relax%
    \else
    \loop% add cols if the user did not use them all
    \ifnum\@NaNAeqncolcnt<\@NaNAeqnnumcols\relax
    \@NaNAappendtoksA{&}%
    \advance\@NaNAeqncolcnt by 1\relax% update the col count
    \repeat
    % this number of &'s will take us the the isolation column
    \fi
    % execute the &'s
    \the\@NaNAtrantmptoksA%
    % handle the strut/isolation column
    \@NaNAeqnarrayinsertstrut% do the strut if needed
    \@NaNAeqnarraystrutreset% reset the strut system for next line or NaNAeqnarray
    &% and enter the equation number column
    \if@eqnsw% only if we display something
      \Hy@raisedlink{\hyper@anchorstart{\@currentHref}}% start a hyperref anchor
      \global\@NaNAeqnumpreadvfalse\relax% displaying an equation number means
      \global\@NaNAsubeqnumpreadvfalse\relax% the equation counters point to valid equations
      % V1.8 Here we setup the counters, currentlabel and status for what would be the *next*
      % equation line as would be the case under the current settings. However, there are two problems.
      % One problem is that there might not ever be a next line. The second problem is that the user
      % may later alter the meaning of a line with commands such as \NaNAyessubnumber. So, to handle
      % these cases we have to record the current values of the (sub)equation counters and revert back
      % to them if the next line is changed or never comes. The \if@NaNAeqnumpreadv, \if@NaNAsubeqnumpreadv
      % and \@NaNAsubeqnnumrollback stuff tracks this.
      % The logic to handle all this is surprisingly complex, but a nice feature of the approach here is
      % that the equation counters and labels remain valid for what the line would be unless a
      % \NaNAyessubnumber et al. later changes it. So, any hyperref links are always correct.
      \ifnum\c@NaNAsubequation>0\relax% handle subequation
         \theNaNAsubequationdis\relax
         \if@NaNAsubeqnumpersist% setup for default type of next line
            \stepcounter{NaNAsubequation}\global\@NaNAsubeqnumpreadvtrue\relax
            \gdef\@currentlabel{\p@NaNAsubequation\theNaNAsubequation}\relax
            \gdef\@currentHref{\@NaNAtheHrefsubequation}% setup hyperref label
         \else
             % if no subeqnum persist, go ahead and setup for a new equation number
             \global\@NaNAsubeqnnumrollback=\c@NaNAsubequation
             \stepcounter{equation}\global\@NaNAeqnumpreadvtrue\relax
             \setcounter{NaNAsubequation}{0}\gdef\@currentlabel{\p@equation\theequation}\relax
             \gdef\@currentHref{\@NaNAtheHrefequation}% setup hyperref label
         \fi
      \else% display a standard equation number
        \theequationdis\relax
        \setcounter{NaNAsubequation}{0}\relax% not really needed
        \if@NaNAsubeqnumpersist% setup for default type of next line
           % subequations that follow plain equations carry the same equation number e.g, 5, 5a rather than 5, 6a
           \stepcounter{NaNAsubequation}\global\@NaNAsubeqnumpreadvtrue\relax
           \gdef\@currentlabel{\p@NaNAsubequation\theNaNAsubequation}\relax
           \gdef\@currentHref{\@NaNAtheHrefsubequation}% setup hyperref label
         \else
             % if no subeqnum persist, go ahead and setup for a new equation number
             \global\@NaNAsubeqnnumrollback=\c@NaNAsubequation
             \stepcounter{equation}\global\@NaNAeqnumpreadvtrue\relax
             \setcounter{NaNAsubequation}{0}\gdef\@currentlabel{\p@equation\theequation}\relax
             \gdef\@currentHref{\@NaNAtheHrefequation}% setup hyperref label
         \fi
      \fi%
      \Hy@raisedlink{\hyper@anchorend}% end hyperref anchor
    \fi% fi only if we display something
    % reset the flags to indicate the default preferences of the display of equation numbers
    \if@NaNAeqnumpersist\global\@eqnswtrue\else\global\@eqnswfalse\fi
    \if@NaNAsubeqnumpersist\global\@eqnswtrue\fi% ditto for the subequation flag
    % reset the number of columns the user actually used
    \global\@NaNAeqncolcnt\z@\relax
    % the real end of the line
    \cr}





% \NaNAeqnarraybox is like \NaNAeqnarray except the box form puts everything
% inside a vtop, vbox, or vcenter box depending on the letter in the second
% optional argument (t,b,c). Vbox is the default. Unlike \NaNAeqnarray,
% equation numbers are not displayed and \NaNAeqnarraybox can be nested.
% \NaNAeqnarrayboxm is for math mode (like \array) and does not put the vbox
% within an hbox.
% \NaNAeqnarrayboxt is for text mode (like \tabular) and puts the vbox within
% a \hbox{$ $} construct.
% \NaNAeqnarraybox will auto detect whether to use \NaNAeqnarrayboxm or 
% \NaNAeqnarrayboxt depending on the math mode.
% The third optional argument specifies the width this box is to be set to -
% natural width is the default.
% The * forms do not add \jot line spacing
% usage: \NaNAeqnarraybox[decl][pos][width]{cols}
\def\NaNAeqnarrayboxm{\@NaNAeqnarrayboxnojotfalse\@NaNAeqnarrayboxHBOXSWfalse\@NaNAeqnarraybox}
\def\endNaNAeqnarrayboxm{\end@NaNAeqnarraybox}
\@namedef{NaNAeqnarrayboxm*}{\@NaNAeqnarrayboxnojottrue\@NaNAeqnarrayboxHBOXSWfalse\@NaNAeqnarraybox}
\@namedef{endNaNAeqnarrayboxm*}{\end@NaNAeqnarraybox}

\def\NaNAeqnarrayboxt{\@NaNAeqnarrayboxnojotfalse\@NaNAeqnarrayboxHBOXSWtrue\@NaNAeqnarraybox}
\def\endNaNAeqnarrayboxt{\end@NaNAeqnarraybox}
\@namedef{NaNAeqnarrayboxt*}{\@NaNAeqnarrayboxnojottrue\@NaNAeqnarrayboxHBOXSWtrue\@NaNAeqnarraybox}
\@namedef{endNaNAeqnarrayboxt*}{\end@NaNAeqnarraybox}

\def\NaNAeqnarraybox{\@NaNAeqnarrayboxnojotfalse\ifmmode\@NaNAeqnarrayboxHBOXSWfalse\else\@NaNAeqnarrayboxHBOXSWtrue\fi%
\@NaNAeqnarraybox}
\def\endNaNAeqnarraybox{\end@NaNAeqnarraybox}

\@namedef{NaNAeqnarraybox*}{\@NaNAeqnarrayboxnojottrue\ifmmode\@NaNAeqnarrayboxHBOXSWfalse\else\@NaNAeqnarrayboxHBOXSWtrue\fi%
\@NaNAeqnarraybox}
\@namedef{endNaNAeqnarraybox*}{\end@NaNAeqnarraybox}

% flag to indicate if the \NaNAeqnarraybox needs to put things into an hbox{$ $} 
% for \vcenter in non-math mode
\newif\if@NaNAeqnarrayboxHBOXSW%
\@NaNAeqnarrayboxHBOXSWfalse

\def\@NaNAeqnarraybox{\relax\@ifnextchar[{\@@NaNAeqnarraybox}{\@@NaNAeqnarraybox[\relax]}}
% We have to be careful here to normalize catcodes just before acquiring the
% cols as that specification may contain punctuation which could be subject
% to document catcode changes.
\def\@@NaNAeqnarraybox[#1]{\relax\begingroup\NaNAnormalcatcodes\@ifnextchar[{\@@@NaNAeqnarraybox[#1]}{\@@@NaNAeqnarraybox[#1][b]}}
\def\@@@NaNAeqnarraybox[#1][#2]{\relax\@ifnextchar[{\@@@@NaNAeqnarraybox[#1][#2]}{\@@@@NaNAeqnarraybox[#1][#2][\relax]}}

% #1 = decl; #2 = t,b,c; #3 = width, #4 = col specs
\def\@@@@NaNAeqnarraybox[#1][#2][#3]#4{\endgroup\@NaNAeqnarrayISinnerfalse % not yet within the lines of the halign
   \@NaNAeqnarraymasterstrutsave% save current master strut values
   \@NaNAeqnarraystrutsize{0pt}{0pt}[\relax]% turn off struts by default
   \@NaNAeqnarrayusemasterstruttrue% use master strut till user asks otherwise
   \NaNAvisiblestrutsfalse% diagnostic mode defaults to off
   % no extra space unless the user specifically requests it
   \lineskip=0pt\relax%
   \lineskiplimit=0pt\relax%
   \baselineskip=\normalbaselineskip\relax%
   \jot=\NaNAnormaljot\relax%
   \mathsurround\z@\relax% no extra spacing around math
   % the default end glues are zero for an \NaNAeqnarraybox
   \edef\@NaNAeqnarraycolSEPdefaultstart{\@NaNAeqnarraycolSEPzero}% default start glue
   \edef\@NaNAeqnarraycolSEPdefaultend{\@NaNAeqnarraycolSEPzero}% default end glue
   \edef\@NaNAeqnarraycolSEPdefaultmid{\@NaNAeqnarraycolSEPzero}% default inter-column glue
   \@advanceNaNAeqncolcntfalse% do not advance the col counter for each col the user uses, 
                              % used in \NaNAeqnarraymulticol and in the preamble build
   \NaNAeqnarrayboxdecl\relax% allow a way for the user to make global overrides
   #1\relax% allow user to override defaults
   \let\\\@NaNAeqnarrayboxcr% replace newline with one that allows optional spacing
   \@NaNAbuildpreamble{#4}\relax% build the preamble and put it into \@NaNAtrantmptoksA
   % add an isolation column to the preamble to stop \\'s {} from getting into the last col
   \ifnum\@NaNAeqnnumcols>0\relax\@NaNAappendtoksA{&}\fi% col separator for those after the first
   \toks0={##}%
   % add the isolation column to the preamble
   \@NaNAappendtoksA{\tabskip\z@skip\bgroup\the\toks0\egroup}% 
   % set the starting tabskip glue as determined by the preamble build
   \tabskip=\@NaNABPstartglue\relax
   % begin the alignment
   \everycr{}%
   % use only the very first token to determine the positioning
   \@NaNAextracttoken{#2}\relax
   \ifx\@NaNAextractedtokensdiscarded\@empty\else
     \typeout{** WARNING: NaNAeqnarraybox position specifiers after the first in `\@NaNAextracttokenarg' ignored (line \the\inputlineno).}\relax
   \fi
   % \@NaNAextractedtoken has the first token, the rest are ignored
   % if we need to put things into and hbox and go into math mode, do so now
   \if@NaNAeqnarrayboxHBOXSW \leavevmode \hbox \bgroup $\fi%
   % use the appropriate vbox type
   \if\@NaNAextractedtoken t\relax\vtop\else\if\@NaNAextractedtoken c\relax%
   \vcenter\else\vbox\fi\fi\bgroup%
   \@NaNAeqnarrayISinnertrue% commands are now within the lines
   \ifx#3\relax\halign\else\halign to #3\relax\fi%
   \bgroup
   % "exspand" the preamble
   \span\the\@NaNAtrantmptoksA\cr}

% carry strut status and enter the isolation/strut column, 
% exit from math mode if needed, and exit
\def\end@NaNAeqnarraybox{\@NaNAeqnarrayglobalizestrutstatus% carry strut status
&% enter isolation/strut column
\@NaNAeqnarrayinsertstrut% do strut if needed
\@NaNAeqnarraymasterstrutrestore% restore the previous master strut values
% reset the strut system for next NaNAeqnarray
% (sets local strut values back to previous master strut values)
\@NaNAeqnarraystrutreset%
% ensure last line, exit from halign, close vbox
\crcr\egroup\egroup%
% exit from math mode and close hbox if needed
\if@NaNAeqnarrayboxHBOXSW $\egroup\fi}



% NaNAeqnarraybox uses a modifed \\ instead of the plain \cr to
% end rows. This allows for things like \\[vskip amount]
% This "cr" macros are modified versions those for LaTeX2e's eqnarray
% For NaNAeqnarraybox, \\* is the same as \\
% the {\ifnum0=`} braces must be kept away from the last column to avoid
% altering spacing of its math, so we use & to advance to the isolation/strut column
% carry strut status into isolation/strut column
\def\@NaNAeqnarrayboxcr{\@NaNAeqnarrayglobalizestrutstatus% carry strut status
&% enter isolation/strut column
\@NaNAeqnarrayinsertstrut% do strut if needed
% reset the strut system for next line or NaNAeqnarray
\@NaNAeqnarraystrutreset%
{\ifnum0=`}\fi%
\@ifstar{\@NaNAeqnarrayboxYCR}{\@NaNAeqnarrayboxYCR}}

% test and setup the optional argument to \\[]
\def\@NaNAeqnarrayboxYCR{\@testopt\@NaNAeqnarrayboxXCR\z@skip}

% NaNAeqnarraybox does not automatically increase line spacing by \jot
\def\@NaNAeqnarrayboxXCR[#1]{\ifnum0=`{\fi}%
\cr\noalign{\if@NaNAeqnarrayboxnojot\else\vskip\jot\fi\vskip#1\relax}}



% usage: \@NaNAbuildpreamble{column specifiers}
% starts the halign preamble build 
% the assembled preamble is put in \@NaNAtrantmptoksA
\def\@NaNAbuildpreamble#1{\@NaNAtrantmptoksA={}% clear token register
\let\@NaNABPcurtype=u%current column type is not yet known
\let\@NaNABPprevtype=s%the previous column type was the start
\let\@NaNABPnexttype=u%next column type is not yet known
% ensure these are valid
\def\@NaNABPcurglue={0pt plus 0pt minus 0pt}%
\def\@NaNABPcurcolname{@NaNAdefault}% name of current column definition
% currently acquired numerically referenced glue
% use a name that is easier to remember
\let\@NaNABPcurnum=\@NaNAtrantmpcountA%
\@NaNABPcurnum=0%
% tracks number of columns in the preamble
\@NaNAeqnnumcols=0%
% record the default end glues
\edef\@NaNABPstartglue{\@NaNAeqnarraycolSEPdefaultstart}%
\edef\@NaNABPendglue{\@NaNAeqnarraycolSEPdefaultend}%
\edef\@NaNAedefMACRO{#1}\relax% fully expand the preamble to support macro containers
% now parse the user's column specifications
% \ignorespaces is used as a delimiter, need at least one trailing \relax because
% \@@NaNAbuildpreamble looks into the future 
\expandafter\@@NaNAbuildpreamble\@NaNAedefMACRO\ignorespaces\relax\relax}


% usage: \@@NaNAbuildpreamble{current column}{next column}
% parses and builds the halign preamble
\def\@@NaNAbuildpreamble#1#2{\let\@@nextNaNAbuildpreamble=\@@NaNAbuildpreamble%
% use only the very first token to check the end
\@NaNAextracttokengroups{#1}\relax
\ifx\@NaNAextractedfirsttoken\ignorespaces\let\@@nextNaNAbuildpreamble=\@@NaNAfinishpreamble\else%
% identify current and next token type
\@NaNAgetcoltype{#1}{\@NaNABPcurtype}{1}% current, error on invalid
\@NaNAgetcoltype{#2}{\@NaNABPnexttype}{0}% next, no error on invalid next
% if curtype is a glue, get the glue def
\if\@NaNABPcurtype g\@NaNAgetcurglue{#1}{\@NaNABPcurglue}\fi%
% if curtype is a column, get the column def and set the current column name
\if\@NaNABPcurtype c\@NaNAgetcurcol{#1}\fi%
% if curtype is a numeral, acquire the user defined glue
\if\@NaNABPcurtype n\@NaNAprocessNcol{#1}\fi%
% process the acquired glue 
\if\@NaNABPcurtype g\@NaNAprocessGcol\fi%
% process the acquired col 
\if\@NaNABPcurtype c\@NaNAprocessCcol\fi%
% ready prevtype for next col spec.
\let\@NaNABPprevtype=\@NaNABPcurtype%
% be sure and put back the future token(s) as a group
\fi\@@nextNaNAbuildpreamble{#2}}


% usage: \@@NaNAfinishpreamble{discarded}
% executed just after preamble build is completed
% warn about zero cols, and if prevtype type = u, put in end tabskip glue
% argument is not used
\def\@@NaNAfinishpreamble#1{\ifnum\@NaNAeqnnumcols<1\relax
\@NaNAclspkgerror{No column specifiers declared for NaNAeqnarray}%
{At least one column type must be declared for each NaNAeqnarray.}%
\fi%num cols less than 1
%if last type undefined, set default end tabskip glue
\if\@NaNABPprevtype u\@NaNAappendtoksA{\tabskip=\@NaNABPendglue}\fi}


% usage: \@NaNAgetcoltype{col specifier}{\output}{error more}
% Identify and return the column specifier's type code in the given
% \output macro:
% n = number
% g = glue (any other char in catagory 12)
% c = letter
% e = \ignorespaces (end of sequence)
% u = undefined
% error mode: 0 = no error message, 1 = error on invalid char
\def\@NaNAgetcoltype#1#2#3{%
% use only the very first token to determine the type
\@NaNAextracttoken{#1}\relax
% \@NaNAextractedtoken has the first token, the rest are discarded
\let#2=u\relax% assume invalid until know otherwise
\ifx\@NaNAextractedtoken\ignorespaces\let#2=e\else
\ifcat\@NaNAextractedtoken\relax\else% screen out control sequences
\if0\@NaNAextractedtoken\let#2=n\else
\if1\@NaNAextractedtoken\let#2=n\else
\if2\@NaNAextractedtoken\let#2=n\else
\if3\@NaNAextractedtoken\let#2=n\else
\if4\@NaNAextractedtoken\let#2=n\else
\if5\@NaNAextractedtoken\let#2=n\else
\if6\@NaNAextractedtoken\let#2=n\else
\if7\@NaNAextractedtoken\let#2=n\else
\if8\@NaNAextractedtoken\let#2=n\else
\if9\@NaNAextractedtoken\let#2=n\else
\ifcat,\@NaNAextractedtoken\let#2=g\relax
\else\ifcat a\@NaNAextractedtoken\let#2=c\relax\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi
\if#2u\relax
\if0\noexpand#3\relax\else\@NaNAclspkgerror{Invalid character in column specifications}%
{Only letters, numerals and certain other symbols are allowed \MessageBreak
as NaNAeqnarray column specifiers.}\fi\fi}


% usage: \@NaNAgetcurcol{col specifier}
% verify the letter referenced column exists
% and return its name in \@NaNABPcurcolname
% if column specifier is invalid, use the default column @NaNAdefault
\def\@NaNAgetcurcol#1{\expandafter\ifx\csname @NaNAeqnarraycolDEF#1\endcsname\@NaNAeqnarraycolisdefined%
\def\@NaNABPcurcolname{#1}\else% invalid column name
\@NaNAclspkgerror{Invalid column type "#1" in column specifications.\MessageBreak
Using a default centering column instead}%
{You must define NaNAeqnarray column types before use.}%
\def\@NaNABPcurcolname{@NaNAdefault}\fi}


% usage: \@NaNAgetcurglue{glue specifier}{\output}
% identify the predefined (punctuation) glue value
% and return it in the given output macro
\def\@NaNAgetcurglue#1#2{%
% ! = \! (neg small)  -0.16667em (-3/18 em)
% , = \, (small)       0.16667em ( 3/18 em)
% : = \: (med)         0.22222em ( 4/18 em)
% ; = \; (large)       0.27778em ( 5/18 em)
% ' = \quad            1em
% " = \qquad           2em
% . = 0.5\arraycolsep
% / = \arraycolsep
% ? = 2\arraycolsep
% * = 1fil
% + = \@NaNAeqnarraycolSEPcenter
% - = \@NaNAeqnarraycolSEPzero
% Note that all em values are referenced to the math font (textfont2) fontdimen6
% value for 1em.
% 
% use only the very first token to determine the type
\@NaNAextracttoken{#1}\relax
\ifx\@NaNAextractedtokensdiscarded\@empty\else
  \typeout{** WARNING: NaNAeqnarray predefined inter-column glue type specifiers after the first in `\@NaNAextracttokenarg' ignored (line \the\inputlineno).}\relax
\fi
% get the math font 1em value
% LaTeX2e's NFSS2 does not preload the fonts, but \NaNAeqnarray needs
% to gain access to the math (\textfont2) font's spacing parameters.
% So we create a bogus box here that uses the math font to ensure
% that \textfont2 is loaded and ready. If this is not done,
% the \textfont2 stuff here may not work.
% Thanks to Bernd Raichle for his 1997 post on this topic.
{\setbox0=\hbox{$\displaystyle\relax$}}%
% fontdimen6 has the width of 1em (a quad).
\@NaNAtrantmpdimenA=\fontdimen6\textfont2\relax%
% identify the glue value based on the first token
% we discard anything after the first
\if!\@NaNAextractedtoken\@NaNAtrantmpdimenA=-0.16667\@NaNAtrantmpdimenA\edef#2{\the\@NaNAtrantmpdimenA}\else
\if,\@NaNAextractedtoken\@NaNAtrantmpdimenA=0.16667\@NaNAtrantmpdimenA\edef#2{\the\@NaNAtrantmpdimenA}\else
\if:\@NaNAextractedtoken\@NaNAtrantmpdimenA=0.22222\@NaNAtrantmpdimenA\edef#2{\the\@NaNAtrantmpdimenA}\else
\if;\@NaNAextractedtoken\@NaNAtrantmpdimenA=0.27778\@NaNAtrantmpdimenA\edef#2{\the\@NaNAtrantmpdimenA}\else
\if'\@NaNAextractedtoken\@NaNAtrantmpdimenA=1\@NaNAtrantmpdimenA\edef#2{\the\@NaNAtrantmpdimenA}\else
\if"\@NaNAextractedtoken\@NaNAtrantmpdimenA=2\@NaNAtrantmpdimenA\edef#2{\the\@NaNAtrantmpdimenA}\else
\if.\@NaNAextractedtoken\@NaNAtrantmpdimenA=0.5\arraycolsep\edef#2{\the\@NaNAtrantmpdimenA}\else
\if/\@NaNAextractedtoken\edef#2{\the\arraycolsep}\else
\if?\@NaNAextractedtoken\@NaNAtrantmpdimenA=2\arraycolsep\edef#2{\the\@NaNAtrantmpdimenA}\else
\if *\@NaNAextractedtoken\edef#2{0pt plus 1fil minus 0pt}\else
\if+\@NaNAextractedtoken\edef#2{\@NaNAeqnarraycolSEPcenter}\else
\if-\@NaNAextractedtoken\edef#2{\@NaNAeqnarraycolSEPzero}\else
\edef#2{\@NaNAeqnarraycolSEPzero}%
\@NaNAclspkgerror{Invalid predefined inter-column glue type "#1" in\MessageBreak
column specifications. Using a default value of\MessageBreak
0pt instead}%
{Only !,:;'"./?*+ and - are valid predefined glue types in the\MessageBreak 
NaNAeqnarray column specifications.}\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi}


% usage: \@NaNAprocessNcol{digit}
% process a numerical digit from the column specification
% and look up the corresponding user defined glue value
% can transform current type from n to g or a as the user defined glue is acquired
\def\@NaNAprocessNcol#1{\if\@NaNABPprevtype g%
\@NaNAclspkgerror{Back-to-back inter-column glue specifiers in column\MessageBreak
specifications. Ignoring consecutive glue specifiers\MessageBreak
after the first}%
{You cannot have two or more glue types next to each other\MessageBreak 
in the NaNAeqnarray column specifications.}%
\let\@NaNABPcurtype=a% abort this glue, future digits will be discarded
\@NaNABPcurnum=0\relax%
\else% if we previously aborted a glue
\if\@NaNABPprevtype a\@NaNABPcurnum=0\let\@NaNABPcurtype=a%maintain digit abortion
\else%acquire this number
% save the previous type before the numerical digits started
\if\@NaNABPprevtype n\else\let\@NaNABPprevsavedtype=\@NaNABPprevtype\fi%
\multiply\@NaNABPcurnum by 10\relax%
\advance\@NaNABPcurnum by #1\relax% add in number, \relax is needed to stop TeX's number scan
\if\@NaNABPnexttype n\else%close acquisition
\expandafter\ifx\csname @NaNAeqnarraycolSEPDEF\expandafter\romannumeral\number\@NaNABPcurnum\endcsname\@NaNAeqnarraycolisdefined%
\edef\@NaNABPcurglue{\csname @NaNAeqnarraycolSEP\expandafter\romannumeral\number\@NaNABPcurnum\endcsname}%
\else%user glue not defined
\@NaNAclspkgerror{Invalid user defined inter-column glue type "\number\@NaNABPcurnum" in\MessageBreak
column specifications. Using a default value of\MessageBreak
0pt instead}%
{You must define all NaNAeqnarray numerical inter-column glue types via\MessageBreak
\string\NaNAeqnarraydefcolsep \space before they are used in column specifications.}%
\edef\@NaNABPcurglue{\@NaNAeqnarraycolSEPzero}%
\fi% glue defined or not
\let\@NaNABPcurtype=g% change the type to reflect the acquired glue
\let\@NaNABPprevtype=\@NaNABPprevsavedtype% restore the prev type before this number glue
\@NaNABPcurnum=0\relax%ready for next acquisition
\fi%close acquisition, get glue
\fi%discard or acquire number
\fi%prevtype glue or not
}


% process an acquired glue
% add any acquired column/glue pair to the preamble
\def\@NaNAprocessGcol{\if\@NaNABPprevtype a\let\@NaNABPcurtype=a%maintain previous glue abortions
\else
% if this is the start glue, save it, but do nothing else 
% as this is not used in the preamble, but before
\if\@NaNABPprevtype s\edef\@NaNABPstartglue{\@NaNABPcurglue}%
\else%not the start glue
\if\@NaNABPprevtype g%ignore if back to back glues
\@NaNAclspkgerror{Back-to-back inter-column glue specifiers in column\MessageBreak
specifications. Ignoring consecutive glue specifiers\MessageBreak
after the first}%
{You cannot have two or more glue types next to each other\MessageBreak 
in the NaNAeqnarray column specifications.}%
\let\@NaNABPcurtype=a% abort this glue
\else% not a back to back glue
\if\@NaNABPprevtype c\relax% if the previoustype was a col, add column/glue pair to preamble
\ifnum\@NaNAeqnnumcols>0\relax\@NaNAappendtoksA{&}\fi
\toks0={##}%
% make preamble advance col counter if this environment needs this
\if@advanceNaNAeqncolcnt\@NaNAappendtoksA{\global\advance\@NaNAeqncolcnt by 1\relax}\fi
% insert the column defintion into the preamble, being careful not to expand
% the column definition
\@NaNAappendtoksA{\tabskip=\@NaNABPcurglue}%
\@NaNAappendNOEXPANDtoksA{\begingroup\csname @NaNAeqnarraycolPRE}%
\@NaNAappendtoksA{\@NaNABPcurcolname}%
\@NaNAappendNOEXPANDtoksA{\endcsname}%
\@NaNAappendtoksA{\the\toks0}%
\@NaNAappendNOEXPANDtoksA{\relax\relax\relax\relax\relax%
\relax\relax\relax\relax\relax\csname @NaNAeqnarraycolPOST}%
\@NaNAappendtoksA{\@NaNABPcurcolname}%
\@NaNAappendNOEXPANDtoksA{\endcsname\relax\relax\relax\relax\relax%
\relax\relax\relax\relax\relax\endgroup}%
\advance\@NaNAeqnnumcols by 1\relax%one more column in the preamble
\else% error: non-start glue with no pending column
\@NaNAclspkgerror{Inter-column glue specifier without a prior column\MessageBreak
type in the column specifications. Ignoring this glue\MessageBreak 
specifier}%
{Except for the first and last positions, glue can be placed only\MessageBreak
between column types.}%
\let\@NaNABPcurtype=a% abort this glue
\fi% previous was a column
\fi% back-to-back glues
\fi% is start column glue
\fi% prev type not a
}


% process an acquired letter referenced column and, if necessary, add it to the preamble
\def\@NaNAprocessCcol{\if\@NaNABPnexttype g\else
\if\@NaNABPnexttype n\else
% we have a column followed by something other than a glue (or numeral glue)
% so we must add this column to the preamble now
\ifnum\@NaNAeqnnumcols>0\relax\@NaNAappendtoksA{&}\fi%col separator for those after the first
\if\@NaNABPnexttype e\@NaNAappendtoksA{\tabskip=\@NaNABPendglue\relax}\else%put in end glue
\@NaNAappendtoksA{\tabskip=\@NaNAeqnarraycolSEPdefaultmid\relax}\fi% or default mid glue
\toks0={##}%
% make preamble advance col counter if this environment needs this
\if@advanceNaNAeqncolcnt\@NaNAappendtoksA{\global\advance\@NaNAeqncolcnt by 1\relax}\fi
% insert the column definition into the preamble, being careful not to expand
% the column definition
\@NaNAappendNOEXPANDtoksA{\begingroup\csname @NaNAeqnarraycolPRE}%
\@NaNAappendtoksA{\@NaNABPcurcolname}%
\@NaNAappendNOEXPANDtoksA{\endcsname}%
\@NaNAappendtoksA{\the\toks0}%
\@NaNAappendNOEXPANDtoksA{\relax\relax\relax\relax\relax%
\relax\relax\relax\relax\relax\csname @NaNAeqnarraycolPOST}%
\@NaNAappendtoksA{\@NaNABPcurcolname}%
\@NaNAappendNOEXPANDtoksA{\endcsname\relax\relax\relax\relax\relax%
\relax\relax\relax\relax\relax\endgroup}%
\advance\@NaNAeqnnumcols by 1\relax%one more column in the preamble
\fi%next type not numeral
\fi%next type not glue
}


%%
%% END OF NaNAeqnarray DEFINITIONS
%%





% set up the running headers and footers
%
% header and footer font and size specifications
\def\@NaNAheaderstyle{\normalfont\scriptsize}
\def\@NaNAfooterstyle{\normalfont\scriptsize}
%
% compsoc uses sans-serif headers and footers
\ifCLASSOPTIONcompsoc
  \def\@NaNAheaderstyle{\normalfont\sffamily\scriptsize}
  \def\@NaNAfooterstyle{\normalfont\sffamily\scriptsize}
\fi


% standard page style, ps@headings
\def\ps@headings{% default to standard twoside headers, no footers
% will change later if the mode requires otherwise
\def\@oddhead{\hbox{}\@NaNAheaderstyle\rightmark\hfil\thepage}\relax
\def\@evenhead{\@NaNAheaderstyle\thepage\hfil\leftmark\hbox{}}\relax
\let\@oddfoot\@empty
\let\@evenfoot\@empty
\ifCLASSOPTIONtechnote
  % technote twoside
  \def\@oddhead{\hbox{}\@NaNAheaderstyle\leftmark\hfil\thepage}\relax
  \def\@evenhead{\@NaNAheaderstyle\thepage\hfil\leftmark\hbox{}}\relax
\fi
\ifCLASSOPTIONdraftcls
  % draft footers
  \def\@oddfoot{\@NaNAfooterstyle\@date\hfil DRAFT}\relax
  \def\@evenfoot{\@NaNAfooterstyle DRAFT\hfil\@date}\relax
\fi
% oneside
\if@twoside\else
  % standard one side headers
  \def\@oddhead{\hbox{}\@NaNAheaderstyle\leftmark\hfil\thepage}\relax
  \let\@evenhead\@empty
  \ifCLASSOPTIONdraftcls
    % oneside draft footers
    \def\@oddfoot{\@NaNAfooterstyle\@date\hfil DRAFT}\relax
    \let\@evenfoot\@empty
  \fi
\fi
% turn off headers for conferences
\ifCLASSOPTIONconference
  \let\@oddhead\@empty
  \let\@evenhead\@empty
\fi
% turn off footers for draftclsnofoot
\ifCLASSOPTIONdraftclsnofoot
  \let\@oddfoot\@empty
  \let\@evenfoot\@empty
\fi}


% title page style, ps@NaNAtitlepagestyle
\def\ps@NaNAtitlepagestyle{% default title page headers, no footers
\def\@oddhead{\hbox{}\@NaNAheaderstyle\leftmark\hfil\thepage}\relax
\def\@evenhead{\@NaNAheaderstyle\thepage\hfil\leftmark\hbox{}}\relax
\let\@oddfoot\@empty
\let\@evenfoot\@empty
% will change later if the mode requires otherwise
\ifCLASSOPTIONdraftcls
  % draft footers
  \ifCLASSOPTIONdraftclsnofoot\else
    % but only if not draftclsnofoot
    \def\@oddfoot{\@NaNAfooterstyle\@date\hfil DRAFT}\relax
    \def\@evenfoot{\@NaNAfooterstyle DRAFT\hfil\@date}\relax
  \fi
\else
  % all nondraft mode footers
  \if@NaNAusingpubid
    % for title pages that are using a pubid
    % do not repeat pubid on the title page if using a peer review cover page
    \ifCLASSOPTIONpeerreview\else
      % for noncompsoc papers, the pubid uses footnotesize and
      % is at the same vertical position as where the last baseline would normally be
      \def\@oddfoot{\hbox{}\hss\@NaNAfooterstyle\footnotesize\raisebox{\footskip}[0pt][0pt]{\@NaNApubid}\hss\hbox{}}\relax
      \def\@evenfoot{\hbox{}\hss\@NaNAfooterstyle\footnotesize\raisebox{\footskip}[0pt][0pt]{\@NaNApubid}\hss\hbox{}}\relax
      \ifCLASSOPTIONcompsoc
        % for compsoc papers, the pubid is at the same vertical position as the normal footer
        \def\@oddfoot{\hbox{}\hss\@NaNAfooterstyle\raisebox{0pt}[0pt][0pt]{\@NaNApubid}\hss\hbox{}}\relax
        \def\@evenfoot{\hbox{}\hss\@NaNAfooterstyle\raisebox{0pt}[0pt][0pt]{\@NaNApubid}\hss\hbox{}}\relax
      \fi
    \fi
  \fi
\fi
% turn off headers for conferences
\ifCLASSOPTIONconference
  \let\@oddhead\@empty
  \let\@evenhead\@empty
\fi}


% peer review cover page style, ps@NaNApeerreviewcoverpagestyle
\def\ps@NaNApeerreviewcoverpagestyle{% default peer review cover no headers, no footers
\let\@oddhead\@empty
\let\@evenhead\@empty
\let\@oddfoot\@empty
\let\@evenfoot\@empty
% will change later if the mode requires otherwise
\ifCLASSOPTIONdraftcls
  % draft footers
  \ifCLASSOPTIONdraftclsnofoot\else
    % but only if not draftclsnofoot
    \def\@oddfoot{\@NaNAfooterstyle\@date\hfil DRAFT}\relax
    \def\@evenfoot{\@NaNAfooterstyle DRAFT\hfil\@date}\relax
  \fi
\else
  % all nondraft mode footers
  \if@NaNAusingpubid
    % for peer review cover pages that are using a pubid
    % for noncompsoc papers, the pubid uses footnotesize and
    % is at the same vertical position as where the last baseline would normally be
    \def\@oddfoot{\hbox{}\hss\@NaNAfooterstyle\footnotesize\raisebox{\footskip}[0pt][0pt]{\@NaNApubid}\hss\hbox{}}\relax
    \def\@evenfoot{\hbox{}\hss\@NaNAfooterstyle\footnotesize\raisebox{\footskip}[0pt][0pt]{\@NaNApubid}\hss\hbox{}}\relax
    \ifCLASSOPTIONcompsoc
      % for compsoc papers, the pubid is at the same vertical position as the normal footer
      \def\@oddfoot{\hbox{}\hss\@NaNAfooterstyle\raisebox{0pt}[0pt][0pt]{\@NaNApubid}\hss\hbox{}}\relax
      \def\@evenfoot{\hbox{}\hss\@NaNAfooterstyle\raisebox{0pt}[0pt][0pt]{\@NaNApubid}\hss\hbox{}}\relax
    \fi
  \fi
\fi}



%% Defines the command for putting the header.
%% Note that all the text is forced into uppercase, if you have some text
%% that needs to be in lower case, for instance et. al., then either manually
%% set \leftmark and \rightmark or use \MakeLowercase{et. al.} within the
%% arguments to \markboth.
%% V1.7b add \protect to work with Babel
\def\markboth#1#2{\def\leftmark{\MakeUppercase{\protect#1}}%
\def\rightmark{\MakeUppercase{\protect#2}}}

\def\today{\ifcase\month\or
    January\or February\or March\or April\or May\or June\or
    July\or August\or September\or October\or November\or December\fi
    \space\number\day, \number\year}




%% CITATION AND BIBLIOGRAPHY COMMANDS
%% 
%% V1.6 no longer supports the older, nonstandard \shortcite and \citename setup stuff
% 
% 
% Modify Latex2e \@citex to separate citations with "], ["
\def\@citex[#1]#2{%
  \let\@citea\@empty
  \@cite{\@for\@citeb:=#2\do
    {\@citea\def\@citea{], [}%
     \edef\@citeb{\expandafter\@firstofone\@citeb\@empty}%
     \if@filesw\immediate\write\@auxout{\string\citation{\@citeb}}\fi
     \@ifundefined{b@\@citeb}{\mbox{\reset@font\bfseries ?}%
       \G@refundefinedtrue
       \@latex@warning
         {Citation `\@citeb' on page \thepage \space undefined}}%
       {\hbox{\csname b@\@citeb\endcsname}}}}{#1}}

% V1.6 we create hooks for the optional use of Donald Arseneau's
% cite.sty package. cite.sty is "smart" and will notice that the
% following format controls are already defined and will not
% redefine them. The result will be the proper sorting of the
% citation numbers and auto detection of 3 or more entry "ranges" -
% all in NaNA style:  [1], [2], [5]--[7], [12]
% This also allows for an optional note, i.e., \cite[mynote]{..}.
% If the \cite with note has more than one reference, the note will
% be applied to the last of the listed references. It is generally
% desired that if a note is given, only one reference is listed in
% that \cite.
% Thanks to Mr. Arseneau for providing the required format arguments
% to produce the NaNA style.
\def\citepunct{], [}
\def\citedash{]--[}

% V1.7 default to using same font for urls made by url.sty
\AtBeginDocument{\csname url@samestyle\endcsname}

% V1.6 class files should always provide these
\def\newblock{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty
% V1.8b article.cls is now providing these too
% we do not use \@mkboth, nor alter the page style
\newenvironment{theindex}
               {\if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \twocolumn[\section*{\indexname}]%
                \parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \columnseprule \z@
                \columnsep 35\p@
                \let\item\@idxitem}
               {\if@restonecol\onecolumn\else\clearpage\fi}
\newcommand\@idxitem{\par\hangindent 40\p@}
\newcommand\subitem{\@idxitem \hspace*{20\p@}}
\newcommand\subsubitem{\@idxitem \hspace*{30\p@}}
\newcommand\indexspace{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}



% Provide support for the control entries of NaNAtran.bst V1.00 and later.
% V1.7 optional argument allows for a different aux file to be specified in
% order to handle multiple bibliographies. For example, with multibib.sty:
% \newcites{sec}{Secondary Literature}
% \bstctlcite[@auxoutsec]{BSTcontrolhak}
\def\bstctlcite{\@ifnextchar[{\@bstctlcite}{\@bstctlcite[@auxout]}}
\def\@bstctlcite[#1]#2{\@bsphack
  \@for\@citeb:=#2\do{%
    \edef\@citeb{\expandafter\@firstofone\@citeb}%
    \if@filesw\immediate\write\csname #1\endcsname{\string\citation{\@citeb}}\fi}%
  \@esphack}

% \NaNAnoauxwrite{} allows for citations that do not add to or affect
% the order of the existing citation list. Can be useful for \cite
% within \thanks{}.
\DeclareRobustCommand{\NaNAnoauxwrite}[1]{\relax
\if@filesw
\@fileswfalse
#1\relax\relax\relax\relax\relax
\@fileswtrue
\else
#1\relax\relax\relax\relax\relax
\fi}

% V1.6 provide a way for a user to execute a command just before 
% a given reference number - used to insert a \newpage to balance
% the columns on the last page
\edef\@NaNAtriggerrefnum{0}   % the default of zero means that
                              % the command is not executed
\def\@NaNAtriggercmd{\newpage}

% allow the user to alter the triggered command
\long\def\NaNAtriggercmd#1{\long\def\@NaNAtriggercmd{#1}}

% allow user a way to specify the reference number just before the
% command is executed
\def\NaNAtriggeratref#1{\@NaNAtrantmpcountA=#1%
\edef\@NaNAtriggerrefnum{\the\@NaNAtrantmpcountA}}%

% trigger command at the given reference
\def\@NaNAbibitemprefix{\@NaNAtrantmpcountA=\@NaNAtriggerrefnum\relax%
\advance\@NaNAtrantmpcountA by -1\relax%
\ifnum\c@enumiv=\@NaNAtrantmpcountA\relax\@NaNAtriggercmd\relax\fi}


\def\@biblabel#1{[#1]}

% compsoc journals and conferences left align the reference numbers
\@NaNAcompsoconly{\def\@biblabel#1{[#1]\hfill}}

% controls bib item spacing
\def\NaNAbibitemsep{0pt plus .5pt}

\@NaNAcompsocconfonly{\def\NaNAbibitemsep{0.5\baselineskip plus 0.25\baselineskip minus 0.25\baselineskip}}


\def\thebibliography#1{\section*{\refname}%
    \addcontentsline{toc}{section}{\refname}%
    % V1.6 add some rubber space here and provide a command trigger
    \footnotesize\vskip 0.3\baselineskip plus 0.1\baselineskip minus 0.1\baselineskip%
    \list{\@biblabel{\@arabic\c@enumiv}}%
    {\settowidth\labelwidth{\@biblabel{#1}}%
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep\relax
    \itemsep \NaNAbibitemsep\relax
    \usecounter{enumiv}%
    \let\p@enumiv\@empty
    \renewcommand\theenumiv{\@arabic\c@enumiv}}%
    \let\@NaNAlatexbibitem\bibitem%
    \def\bibitem{\@NaNAbibitemprefix\@NaNAlatexbibitem}%
\def\newblock{\hskip .11em plus .33em minus .07em}%
% originally:
%   \sloppy\clubpenalty4000\widowpenalty4000%
% by adding the \interlinepenalty here, we make it more
% difficult, but not impossible, for LaTeX to break within a reference.
% The NaNA almost never breaks a reference (but they do it more often with
% technotes). You may get an underfull vbox warning around the bibliography, 
% but the final result will be much more like what the NaNA will publish. 
% MDS 11/2000
\ifCLASSOPTIONtechnote\sloppy\clubpenalty4000\widowpenalty4000\interlinepenalty100%
\else\sloppy\clubpenalty4000\widowpenalty4000\interlinepenalty500\fi%
    \sfcode`\.=1000\relax}
\let\endthebibliography=\endlist




% TITLE PAGE COMMANDS
% 
% 
% \NaNAmembership is used to produce the sublargesize italic font used to indicate author 
% NaNA membership. compsoc uses a large size sans slant font
\def\NaNAmembership#1{{\@NaNAnotcompsoconly{\sublargesize}\normalfont\@NaNAcompsoconly{\sffamily}\textit{#1}}}
 

% \NaNAauthorrefmark{} produces a footnote type symbol to indicate author affiliation.
% When given an argument of 1 to 9, \NaNAauthorrefmark{} follows the standard LaTeX footnote
% symbol sequence convention. However, for arguments 10 and above, \NaNAauthorrefmark{} 
% reverts to using lower case roman numerals, so it cannot overflow. Do note that you 
% cannot use \footnotemark[] in place of \NaNAauthorrefmark{} within \author as the footnote
% symbols will have been turned off to prevent \thanks from creating footnote marks.
% \NaNAauthorrefmark{} produces a symbol that appears to LaTeX as having zero vertical
% height - this allows for a more compact line packing, but the user must ensure that
% the interline spacing is large enough to prevent \NaNAauthorrefmark{} from colliding
% with the text above.
% V1.7 make this a robust command
% V1.8 transmag uses an arabic author affiliation symbol
\ifCLASSOPTIONtransmag
\DeclareRobustCommand*{\NaNAauthorrefmark}[1]{\raisebox{0pt}[0pt][0pt]{\textsuperscript{\footnotesize #1}}}
\else
\DeclareRobustCommand*{\NaNAauthorrefmark}[1]{\raisebox{0pt}[0pt][0pt]{\textsuperscript{\footnotesize\ensuremath{\ifcase#1\or *\or \dagger\or \ddagger\or%
    \mathsection\or \mathparagraph\or \|\or **\or \dagger\dagger%
    \or \ddagger\ddagger \else\textsuperscript{\expandafter\romannumeral#1}\fi}}}}
\fi


% FONT CONTROLS AND SPACINGS FOR CONFERENCE MODE AUTHOR NAME AND AFFILIATION BLOCKS
% 
% The default font styles for the author name and affiliation blocks (confmode)
\def\@NaNAauthorblockNstyle{\normalfont\@NaNAcompsocnotconfonly{\sffamily}\sublargesize}
\def\@NaNAauthorblockAstyle{\normalfont\@NaNAcompsocnotconfonly{\sffamily}\@NaNAcompsocconfonly{\itshape}\normalsize}
% The default if the user does not use an author block
\def\@NaNAauthordefaulttextstyle{\normalfont\@NaNAcompsocnotconfonly{\sffamily}\sublargesize}

% adjustment spacing from title (or special paper notice) to author name blocks (confmode)
% can be negative
\def\@NaNAauthorblockconfadjspace{-0.25em}
% compsoc conferences need more space here
\@NaNAcompsocconfonly{\def\@NaNAauthorblockconfadjspace{0.75\@NaNAnormalsizeunitybaselineskip}}

% spacing between name and affiliation blocks (confmode)
% This can be negative.
% The NaNA doesn't want any added spacing here, but I will leave these
% controls in place in case they ever change their mind.
% Personally, I like 0.75ex.
%\def\@NaNAauthorblockNtopspace{0.75ex}
%\def\@NaNAauthorblockAtopspace{0.75ex}
\def\@NaNAauthorblockNtopspace{0.0ex}
\def\@NaNAauthorblockAtopspace{0.0ex}
\ifCLASSOPTIONtransmag
% transmag uses one line of space above first affiliation block
\def\@NaNAauthorblockAtopspace{1\@NaNAnormalsizeunitybaselineskip}
\fi

% baseline spacing within name and affiliation blocks (confmode)
% must be positive, spacings below certain values will make 
% the position of line of text sensitive to the contents of the
% line above it i.e., whether or not the prior line has descenders, 
% subscripts, etc. For this reason it is a good idea to keep
% these above 2.6ex
\def\@NaNAauthorblockNinterlinespace{2.6ex}
\def\@NaNAauthorblockAinterlinespace{2.75ex}

% This tracks the required strut size.
% See the \@NaNAauthorhalign command for the actual default value used.
\def\@NaNAauthorblockXinterlinespace{2.7ex}

% variables to retain font size and style across groups
% values given here have no effect as they will be overwritten later
\gdef\@NaNASAVESTATEfontsize{10}
\gdef\@NaNASAVESTATEfontbaselineskip{12}
\gdef\@NaNASAVESTATEfontencoding{OT1}
\gdef\@NaNASAVESTATEfontfamily{ptm}
\gdef\@NaNASAVESTATEfontseries{m}
\gdef\@NaNASAVESTATEfontshape{n}

% saves the current font attributes
\def\@NaNAcurfontSAVE{\global\let\@NaNASAVESTATEfontsize\f@size%
\global\let\@NaNASAVESTATEfontbaselineskip\f@baselineskip%
\global\let\@NaNASAVESTATEfontencoding\f@encoding%
\global\let\@NaNASAVESTATEfontfamily\f@family%
\global\let\@NaNASAVESTATEfontseries\f@series%
\global\let\@NaNASAVESTATEfontshape\f@shape}

% restores the saved font attributes
\def\@NaNAcurfontRESTORE{\fontsize{\@NaNASAVESTATEfontsize}{\@NaNASAVESTATEfontbaselineskip}%
\fontencoding{\@NaNASAVESTATEfontencoding}%
\fontfamily{\@NaNASAVESTATEfontfamily}%
\fontseries{\@NaNASAVESTATEfontseries}%
\fontshape{\@NaNASAVESTATEfontshape}%
\selectfont}


% variable to indicate if the current block is the first block in the column
\newif\if@NaNAprevauthorblockincol   \@NaNAprevauthorblockincolfalse


% the command places a strut with height and depth = \@NaNAauthorblockXinterlinespace
% we use this technique to have complete manual control over the spacing of the lines
% within the halign environment.
% We set the below baseline portion at 30%, the above
% baseline portion at 70% of the total length.
% Responds to changes in the document's \baselinestretch
\def\@NaNAauthorstrutrule{\@NaNAtrantmpdimenA\@NaNAauthorblockXinterlinespace%
\@NaNAtrantmpdimenA=\baselinestretch\@NaNAtrantmpdimenA%
\rule[-0.3\@NaNAtrantmpdimenA]{0pt}{\@NaNAtrantmpdimenA}}


% blocks to hold the authors' names and affilations. 
% Makes formatting easy for conferences
%
% use real definitions in conference mode
% name block
\def\NaNAauthorblockN#1{\relax\@NaNAauthorblockNstyle% set the default text style
\gdef\@NaNAauthorblockXinterlinespace{0pt}% disable strut for spacer row
% the \expandafter hides the \cr in conditional tex, see the array.sty docs
% for details, probably not needed here as the \cr is in a macro
% do a spacer row if needed
\if@NaNAprevauthorblockincol\expandafter\@NaNAauthorblockNtopspaceline\fi
\global\@NaNAprevauthorblockincoltrue% we now have a block in this column
%restore the correct strut value
\gdef\@NaNAauthorblockXinterlinespace{\@NaNAauthorblockNinterlinespace}%
% input the author names
#1%
% end the row if the user did not already
\crcr}
% spacer row for names
\def\@NaNAauthorblockNtopspaceline{\cr\noalign{\vskip\@NaNAauthorblockNtopspace}}
%
% affiliation block
\def\NaNAauthorblockA#1{\relax\@NaNAauthorblockAstyle% set the default text style
\gdef\@NaNAauthorblockXinterlinespace{0pt}%disable strut for spacer row
% the \expandafter hides the \cr in conditional tex, see the array.sty docs
% for details, probably not needed here as the \cr is in a macro
% do a spacer row if needed
\if@NaNAprevauthorblockincol\expandafter\@NaNAauthorblockAtopspaceline\fi
\global\@NaNAprevauthorblockincoltrue% we now have a block in this column
%restore the correct strut value
\gdef\@NaNAauthorblockXinterlinespace{\@NaNAauthorblockAinterlinespace}%
% input the author affiliations
#1%
% end the row if the user did not already
\crcr
% V1.8 transmag does not use any additional affiliation spacing after the first author
\ifCLASSOPTIONtransmag\gdef\@NaNAauthorblockAtopspace{0pt}\fi}

% spacer row for affiliations
\def\@NaNAauthorblockAtopspaceline{\cr\noalign{\vskip\@NaNAauthorblockAtopspace}}


% allow papers to compile even if author blocks are used in modes other
% than conference or peerreviewca. For such cases, we provide dummy blocks.
\ifCLASSOPTIONconference
\else
   \ifCLASSOPTIONpeerreviewca\else
      % not conference, peerreviewca or transmag mode
      \ifCLASSOPTIONtransmag\else
         \def\NaNAauthorblockN#1{#1}%
         \def\NaNAauthorblockA#1{#1}%
      \fi
   \fi
\fi



% we provide our own halign so as not to have to depend on tabular
\def\@NaNAauthorhalign{\@NaNAauthordefaulttextstyle% default text style
   \lineskip=0pt\relax% disable line spacing
   \lineskiplimit=0pt\relax%
   \baselineskip=0pt\relax%
   \@NaNAcurfontSAVE% save the current font
   \mathsurround\z@\relax% no extra spacing around math
   \let\\\@NaNAauthorhaligncr% replace newline with halign friendly one
   \tabskip=0pt\relax% no column spacing
   \everycr{}% ensure no problems here
   \@NaNAprevauthorblockincolfalse% no author blocks yet
   \def\@NaNAauthorblockXinterlinespace{2.7ex}% default interline space
   \vtop\bgroup%vtop box
   \halign\bgroup&\relax\hfil\@NaNAcurfontRESTORE\relax ##\relax
   \hfil\@NaNAcurfontSAVE\@NaNAauthorstrutrule\cr}

% ensure last line, exit from halign, close vbox
\def\end@NaNAauthorhalign{\crcr\egroup\egroup}

% handle bogus star form
\def\@NaNAauthorhaligncr{{\ifnum0=`}\fi\@ifstar{\@@NaNAauthorhaligncr}{\@@NaNAauthorhaligncr}}

% test and setup the optional argument to \\[]
\def\@@NaNAauthorhaligncr{\@testopt\@@@NaNAauthorhaligncr\z@skip}

% end the line and do the optional spacer
\def\@@@NaNAauthorhaligncr[#1]{\ifnum0=`{\fi}\cr\noalign{\vskip#1\relax}}



% flag to prevent multiple \and warning messages
\newif\if@NaNAWARNand
\@NaNAWARNandtrue

% if in conference or peerreviewca modes, we support the use of \and as \author is a
% tabular environment, otherwise we warn the user that \and is invalid
% outside of conference or peerreviewca modes.
\def\and{\relax} % provide a bogus \and that we will then override

\renewcommand{\and}[1][\relax]{\if@NaNAWARNand\typeout{** WARNING: \noexpand\and is valid only
                               when in conference or peerreviewca}\typeout{modes (line \the\inputlineno).}\fi\global\@NaNAWARNandfalse}

\ifCLASSOPTIONconference%
\renewcommand{\and}[1][\hfill]{\end{@NaNAauthorhalign}#1\begin{@NaNAauthorhalign}}%
\fi
\ifCLASSOPTIONpeerreviewca
\renewcommand{\and}[1][\hfill]{\end{@NaNAauthorhalign}#1\begin{@NaNAauthorhalign}}%
\fi
% V1.8 transmag uses conference author format
\ifCLASSOPTIONtransmag
\renewcommand{\and}[1][\hfill]{\end{@NaNAauthorhalign}#1\begin{@NaNAauthorhalign}}%
\fi

% page clearing command
% based on LaTeX2e's \cleardoublepage, but allows different page styles
% for the inserted blank pages
\def\@NaNAcleardoublepage#1{\clearpage\if@twoside\ifodd\c@page\else
\hbox{}\thispagestyle{#1}\newpage\if@twocolumn\hbox{}\thispagestyle{#1}\newpage\fi\fi\fi}

% V1.8b hooks to allow adjustment of space above title
\def\NaNAtitletopspace{0.5\baselineskip}
% an added extra amount to allow for adjustment/offset
\def\NaNAtitletopspaceextra{0pt}

% user command to invoke the title page
\def\maketitle{\par%
  \begingroup%
  \normalfont%
  \def\thefootnote{}%  the \thanks{} mark type is empty
  \def\footnotemark{}% and kill space from \thanks within author
  \let\@makefnmark\relax% V1.7, must *really* kill footnotemark to remove all \textsuperscript spacing as well.
  \footnotesize%       equal spacing between thanks lines
  \footnotesep 0.7\baselineskip%see global setting of \footnotesep for more info
  % V1.7 disable \thanks note indention for compsoc
  \@NaNAcompsoconly{\long\def\@makefntext##1{\parindent 1em\noindent\hbox{\@makefnmark}##1}}%
  \normalsize%
  \ifCLASSOPTIONpeerreview
     \newpage\global\@topnum\z@ \@maketitle\@NaNAstatictitlevskip\@NaNAaftertitletext%
     \thispagestyle{NaNApeerreviewcoverpagestyle}\@thanks%
  \else
     \if@twocolumn%
        \ifCLASSOPTIONtechnote%
           \newpage\global\@topnum\z@ \@maketitle\@NaNAstatictitlevskip\@NaNAaftertitletext%
        \else
           \twocolumn[{\NaNAquantizevspace{\@maketitle}[\NaNAquantizedisabletitlecmds]{0pt}[-\topskip]{\baselineskip}{\@NaNANORMtitlevspace}{\@NaNAMINtitlevspace}\@NaNAaftertitletext}]%
        \fi
     \else
        \newpage\global\@topnum\z@ \@maketitle\@NaNAstatictitlevskip\@NaNAaftertitletext%
     \fi
     \thispagestyle{NaNAtitlepagestyle}\@thanks%
  \fi
  % pullup page for pubid if used.
  \if@NaNAusingpubid
     \enlargethispage{-\@NaNApubidpullup}%
  \fi 
  \endgroup
  \setcounter{footnote}{0}\let\maketitle\relax\let\@maketitle\relax
  \gdef\@thanks{}%
  % v1.6b do not clear these as we will need the title again for peer review papers
  % \gdef\@author{}\gdef\@title{}%
  \let\thanks\relax}


% V1.8 parbox to format \@NaNAtitleabstractindextext
\long\def\@NaNAtitleabstractindextextbox#1{\parbox{1\textwidth}{#1}}
% V1.8 compsoc is partial width
\ifCLASSOPTIONcompsoc
% comparison with proofs suggests it's in the range of 92.1-92.3%
\long\def\@NaNAtitleabstractindextextbox#1{\parbox{0.922\textwidth}{\@NaNAcompsocnotconfonly{\rightskip\@flushglue\leftskip\z@skip}#1}}
\fi

% formats the Title, authors names, affiliations and special paper notice
% THIS IS A CONTROLLED SPACING COMMAND! Do not allow blank lines or unintentional
% spaces to enter the definition - use % at the end of each line
\def\@maketitle{\newpage
\bgroup\par\vskip\NaNAtitletopspace\vskip\NaNAtitletopspaceextra\centering%
\ifCLASSOPTIONtechnote% technotes, V1.8a abstract and index terms are not treated differently for compsoc technotes
   {\bfseries\large\@NaNAcompsoconly{\Large\sffamily}\@title\par}\vskip 1.3em{\lineskip .5em\@NaNAcompsoconly{\large\sffamily}\@author
   \@NaNAspecialpapernotice\par}\relax
\else% not a technote
   \vskip0.2em{\Huge\ifCLASSOPTIONtransmag\bfseries\LARGE\fi\@NaNAcompsoconly{\sffamily}\@NaNAcompsocconfonly{\normalfont\normalsize\vskip 2\@NaNAnormalsizeunitybaselineskip
   \bfseries\Large}\@NaNAcompsocnotconfonly{\vskip 0.75\@NaNAnormalsizeunitybaselineskip}\@title\par}\relax
   \@NaNAcompsocnotconfonly{\vskip 0.5\@NaNAnormalsizeunitybaselineskip}\vskip1.0em\par%
   % V1.6 handle \author differently if in conference mode
   \ifCLASSOPTIONconference%
      {\@NaNAspecialpapernotice\mbox{}\vskip\@NaNAauthorblockconfadjspace%
       \mbox{}\hfill\begin{@NaNAauthorhalign}\@author\end{@NaNAauthorhalign}\hfill\mbox{}\par}\relax
   \else% peerreviewca, peerreview or journal
      \ifCLASSOPTIONpeerreviewca
         % peerreviewca handles author names just like conference mode
         {\@NaNAcompsoconly{\sffamily}\@NaNAspecialpapernotice\mbox{}\vskip\@NaNAauthorblockconfadjspace%
          \mbox{}\hfill\begin{@NaNAauthorhalign}\@author\end{@NaNAauthorhalign}\hfill\mbox{}\par
          {\@NaNAcompsoconly{\vskip 1.5em\relax
           \@NaNAtitleabstractindextextbox{\@NaNAtitleabstractindextext}\par\noindent\hfill
           \NaNAcompsocdiamondline\hfill\hbox{}\par}}}\relax
      \else% journal, peerreview or transmag
         \ifCLASSOPTIONtransmag
            % transmag also handles author names just like conference mode
            % it also uses \@NaNAtitleabstractindextex, but with one line less
            % space above, and one more below
           {\@NaNAspecialpapernotice\mbox{}\vskip\@NaNAauthorblockconfadjspace%
            \mbox{}\hfill\begin{@NaNAauthorhalign}\@author\end{@NaNAauthorhalign}\hfill\mbox{}\par
           {\vspace{0.5\baselineskip}\relax\@NaNAtitleabstractindextextbox{\@NaNAtitleabstractindextext}\vspace{-1\baselineskip}\par}}\relax
         \else% journal or peerreview
           {\lineskip.5em\@NaNAcompsoconly{\sffamily}\sublargesize\@author\@NaNAspecialpapernotice\par
           {\@NaNAcompsoconly{\vskip 1.5em\relax
            \@NaNAtitleabstractindextextbox{\@NaNAtitleabstractindextext}\par\noindent\hfill
            \NaNAcompsocdiamondline\hfill\hbox{}\par}}}\relax
         \fi
      \fi
   \fi
\fi\par\addvspace{0.5\baselineskip}\egroup}


% V1.7 Computer Society "diamond line" which follows index terms for nonconference papers
% V1.8a full width diamond line for single column use
\def\@NaNAcompsocdiamondlinei{\vrule depth 0pt height 0.5pt width 4cm\nobreak\hspace{7.5pt}\nobreak
\raisebox{-3.5pt}{\fontfamily{pzd}\fontencoding{U}\fontseries{m}\fontshape{n}\fontsize{11}{12}\selectfont\char70}\nobreak
\hspace{7.5pt}\nobreak\vrule depth 0pt height 0.5pt width 4cm\relax}
% V1.8a narrower width diamond line for double column use
\def\@NaNAcompsocdiamondlineii{\vrule depth 0pt height 0.5pt width 2.5cm\nobreak\hspace{7.5pt}\nobreak
\raisebox{-3.5pt}{\fontfamily{pzd}\fontencoding{U}\fontseries{m}\fontshape{n}\fontsize{11}{12}\selectfont\char70}\nobreak
\hspace{7.5pt}\nobreak\vrule depth 0pt height 0.5pt width 2.5cm\relax}
% V1.8a bare core without rules to base a last resort on for very narrow linewidths
\def\@NaNAcompsocdiamondlineiii{\mbox{}\nobreak\hspace{7.5pt}\nobreak
\raisebox{-3.5pt}{\fontfamily{pzd}\fontencoding{U}\fontseries{m}\fontshape{n}\fontsize{11}{12}\selectfont\char70}\nobreak
\hspace{7.5pt}\nobreak\mbox{}\relax}

% V1.8a allow \NaNAcompsocdiamondline to adjust for different linewidths.
% Use \@NaNAcompsocdiamondlinei if its width is less than 0.66\linewidth (0.487 nominal for single column)
% if not, fall back to \@NaNAcompsocdiamondlineii if its width is less than 0.75\linewidth (0.659 nominal for double column)
% if all else fails, try to make a custom diamondline based on the abnormally narrow linewidth
\def\NaNAcompsocdiamondline{\settowidth{\@NaNAtrantmpdimenA}{\@NaNAcompsocdiamondlinei}\relax
\ifdim\@NaNAtrantmpdimenA<0.66\linewidth\relax\@NaNAcompsocdiamondlinei\relax
\else
\settowidth{\@NaNAtrantmpdimenA}{\@NaNAcompsocdiamondlineii}\relax
\ifdim\@NaNAtrantmpdimenA<0.75\linewidth\relax\@NaNAcompsocdiamondlineii\relax
\else
\settowidth{\@NaNAtrantmpdimenA}{\@NaNAcompsocdiamondlineiii}\relax
\@NaNAtrantmpdimenB=\linewidth\relax
\addtolength{\@NaNAtrantmpdimenB}{-1\@NaNAtrantmpdimenA}\relax
\vrule depth 0pt height 0.5pt width 0.33\@NaNAtrantmpdimenB\@NaNAcompsocdiamondlineiii\vrule depth 0pt height 0.5pt width 0.33\@NaNAtrantmpdimenB\relax
\fi\fi}


% V1.7 standard LateX2e \thanks, but with \itshape under compsoc. Also make it a \long\def
% We also need to trigger the one-shot footnote rule
\def\@NaNAtriggeroneshotfootnoterule{\global\@NaNAenableoneshotfootnoteruletrue}


\long\def\thanks#1{\footnotemark
    \protected@xdef\@thanks{\@thanks
        \protect\footnotetext[\the\c@footnote]{\@NaNAcompsoconly{\itshape
        \protect\@NaNAtriggeroneshotfootnoterule\relax}\ignorespaces#1}}}
\let\@thanks\@empty


% V1.7 allow \author to contain \par's. This is needed to allow \thanks to contain \par.
\long\def\author#1{\gdef\@author{#1}}


% in addition to setting up NaNAitemize, we need to remove a baselineskip space above and
% below it because \list's \pars introduce blank lines because of the footnote struts.
\def\@NaNAsetupcompsocitemizelist{\def\labelitemi{$\bullet$}%
\setlength{\NaNAlabelindent}{0pt}\setlength{\labelsep}{1.2em}\setlength{\parskip}{0pt}%
\setlength{\partopsep}{0pt}\setlength{\topsep}{0.5\baselineskip}\vspace{-1\baselineskip}\relax}


% flag for fake non-compsoc \NaNAcompsocthanksitem - prevents line break on very first item
\newif\if@NaNAbreakcompsocthanksitem \@NaNAbreakcompsocthanksitemfalse

\ifCLASSOPTIONcompsoc
% V1.7 compsoc bullet item \thanks
% also, we need to redefine this to destroy the argument in \NaNAquantizevspace
\long\def\NaNAcompsocitemizethanks#1{\relax\@NaNAbreakcompsocthanksitemfalse\footnotemark
    \protected@xdef\@thanks{\@thanks
        \protect\footnotetext[\the\c@footnote]{\itshape\protect\@NaNAtriggeroneshotfootnoterule
        {\let\NaNAiedlistdecl\relax\protect\begin{NaNAitemize}[\protect\@NaNAsetupcompsocitemizelist]\ignorespaces#1\relax
        \protect\end{NaNAitemize}}\protect\vspace{-1\baselineskip}}}}
\DeclareRobustCommand*{\NaNAcompsocthanksitem}{\item}
\else
% non-compsoc, allow for dual compilation via rerouting to normal \thanks
\long\def\NaNAcompsocitemizethanks#1{\thanks{#1}}
% redirect to "pseudo-par" \hfil\break\indent after swallowing [] from \NaNAcompsocthanksitem[]
\DeclareRobustCommand{\NaNAcompsocthanksitem}{\@ifnextchar [{\@NaNAthanksswallowoptionalarg}%
{\@NaNAthanksswallowoptionalarg[\relax]}}
% be sure and break only after first item, be sure and ignore spaces after optional argument
\def\@NaNAthanksswallowoptionalarg[#1]{\relax\if@NaNAbreakcompsocthanksitem\hfil\break
\indent\fi\@NaNAbreakcompsocthanksitemtrue\ignorespaces}
\fi


% V1.6b define the \NaNApeerreviewmaketitle as needed
\ifCLASSOPTIONpeerreview
\def\NaNApeerreviewmaketitle{\@NaNAcleardoublepage{empty}%
\ifCLASSOPTIONtwocolumn
\twocolumn[{\NaNAquantizevspace{\@NaNApeerreviewmaketitle}[\NaNAquantizedisabletitlecmds]{0pt}[-\topskip]{\baselineskip}{\@NaNANORMtitlevspace}{\@NaNAMINtitlevspace}}]
\else
\newpage\@NaNApeerreviewmaketitle\@NaNAstatictitlevskip
\fi
\thispagestyle{NaNAtitlepagestyle}}
\else
% \NaNApeerreviewmaketitle does nothing if peer review option has not been selected
\def\NaNApeerreviewmaketitle{\relax}
\fi

% peerreview formats the repeated title like the title in journal papers.
\def\@NaNApeerreviewmaketitle{\bgroup\par\addvspace{0.5\baselineskip}\centering\@NaNAcompsoconly{\sffamily}%
\normalfont\normalsize\vskip0.2em{\Huge\@title\par}\vskip1.0em\par
\par\addvspace{0.5\baselineskip}\egroup}



% V1.6 
% this is a static rubber spacer between the title/authors and the main text
% used for single column text, or when the title appears in the first column
% of two column text (technotes). 
\def\@NaNAstatictitlevskip{{\normalfont\normalsize
% adjust spacing to next text
% v1.6b handle peer review papers
\ifCLASSOPTIONpeerreview
% for peer review papers, the same value is used for both title pages
% regardless of the other paper modes
   \vskip 1\baselineskip plus 0.375\baselineskip minus 0.1875\baselineskip
\else
   \ifCLASSOPTIONconference% conference
      \vskip 1\baselineskip plus 0.375\baselineskip minus 0.1875\baselineskip%
   \else%
      \ifCLASSOPTIONtechnote% technote
         \vskip 1\baselineskip plus 0.375\baselineskip minus 0.1875\baselineskip%
      \else% journal uses more space
         \vskip 2.5\baselineskip plus 0.75\baselineskip minus 0.375\baselineskip%
      \fi
   \fi
\fi}}


% set the nominal and minimum values for the quantized title spacer
% the quantization algorithm will not allow the spacer size to
% become less than \@NaNAMINtitlevspace - instead it will be lengthened
% default to journal values
\def\@NaNANORMtitlevspace{2.5\baselineskip}
\def\@NaNAMINtitlevspace{2\baselineskip}
% conferences and technotes need tighter spacing
\ifCLASSOPTIONconference% conference
  \def\@NaNANORMtitlevspace{1\baselineskip}
  \def\@NaNAMINtitlevspace{0.75\baselineskip}
\fi
\ifCLASSOPTIONtechnote% technote
  \def\@NaNANORMtitlevspace{1\baselineskip}
  \def\@NaNAMINtitlevspace{0.75\baselineskip}
\fi


% V1.8a
\def\NaNAquantizevspace{\begingroup\@ifstar{\@NaNAquantizevspacestarformtrue\@NaNAquantizevspace}{\@NaNAquantizevspacestarformfalse\@NaNAquantizevspace}}
% \NaNAquantizevspace[output dimen register]{object}[object decl]
%                    {top baselineskip}
%                    [offset][prevdepth][lineskip limit][lineskip]
%                    {unit height}{nominal vspace}{minimum vspace}
%
% Calculates and creates the vspace needed to make the combined height with
% the given object an integer multiple of the given unit height. This command
% is more general than the older \@NaNAdynamictitlevspace it replaces.
%
% The star form has no effect at present, but is reserved for future use.
%
% If the optional argument [output dimen register] is given, the calculated
% vspace height is stored in the given output dimen (or skip) register
% and no other action is taken, otherwise the object followed by a vspace*
% of the appropriate height is evaluated/output.
%
% The optional object decl (declarations) is code that is evaluated just
% before the object's height is evaluated. Its intented purpose is to allow
% for the alteration or disabling of code within the object during internal
% height evaluation (e.g., \long\def\thanks#1{\relax} ).
% This special code is not invoked if/when the object is rendered at the end.
%
% The nominal vspace is the target value of the added vspace and the minimum
% vspace is the lower allowed limit. The vspacer will be the value that achieves
% integral overall height, in terms of the given unit height, that is closest
% to the nominal vspace and that is not less than the specified minimum vspace.
%
% The line spacing algorithm of TeX is somewhat involved and requires special
% care with regard to the first line of a vertical list (which is indicated
% when \prevdepth is -1000pt or less). top baselineskip specifies the
% baselineskip or topskip used prior to the object. If the height of the
% first line of the object is greater than the given top baselineskip, then
% the top baselineskip is subtracted from the height of the first line and
% that difference is considered along with the rest of the object height
% (because the object will be shifted down by an amount = 
% top line height - top baselineskip). Otherwise, the height of the first line
% of the object is ignored as far as the calculations are concerned.
% This algorithm is adequate for objects that appear at the top of a page
% (e.g., titles) where \topskip spacing is used.
%
% However, as explained on page 78 of the TeXbook, interline spacing is more
% complex when \baselineskip is being used (indicated by \prevdepth > 
% -1000pt). The four optional parameters offset, prevdepth, lineskip limit and
% lineskip are assumed to be equal to be 0pt, \prevdepth, \lineskiplimit and
% \lineskip, respectively, if they are omitted.
%
% The prevdepth is the depth of the line before the object, the lineskip limit
% specifies how close the top of the object can come to the bottom of the
% previous line before \baselineskip is ignored and \lineskip is inserted
% between the object and the line above it. Lineskip does not come into
% play unless the first line of the object is high enough to "get too close"
% (as specified by lineskiplimit) to the line before it. The the prevdepth,
% lineskip limit, and lineskip optional parameters are not needed for the
% first object/line on a page (i.e., prevdepth <= -1000pt) where the simplier
% \topskip spacing rules are in effect.
%
% Offset is a manual adjustment that is added to the height calculations of
% object irrespective of the value of \prevdepth. It is useful when the top
% baselineskip will result in a noninteger unit height object placement even
% if the object itself has integral height. e.g., a footnotesize baselineskip
% is used before the object, thus an offset of, say -3pt, can be given as a
% correction.

% Common combinations of these parameters include:
%
% top baselineskip:   (and default values for offset, prevdepth, etc.)
% \topskip            % for objects that appear at the top of a page
% \maxdimen           % always ignore the height of the top line
% 0pt                 % always consider any positive height of the top line
%
% for objects to appear inline in normal text:
% top baselineskip = \baselineskip
%
% set prevdepth = -1000pt and top baselineskip = 0pt to consider the
% overall height of the object without any other external skip
% consideration

\newif\if@NaNAquantizevspacestarform       % flag to indicate star form
\newif\if@NaNAquantizevspaceuseoutdimenreg % flag to indicate output dimen register is to be used
% Use our own private registers because the object could contain a
% structure that uses the existing tmp scratch pad registers
\newdimen\@NaNAquantizeheightA
\newdimen\@NaNAquantizeheightB
\newdimen\@NaNAquantizeheightC
\newdimen\@NaNAquantizeprevdepth % need to save this early as can change
\newcount\@NaNAquantizemultiple
\newbox\@NaNAquantizeboxA


\def\@NaNAquantizevspace{\@ifnextchar [{\@NaNAquantizevspaceuseoutdimenregtrue\@@NaNAquantizevspace}{\@NaNAquantizevspaceuseoutdimenregfalse\@@NaNAquantizevspace[]}}


\long\def\@@NaNAquantizevspace[#1]#2{\relax
% acquire and store
% #1 optional output dimen register
% #2 object
\edef\@NaNAquantizeoutdimenreg{#1}\relax
% allow for object specifications that contain parameters
\@NaNAtrantmptoksA={#2}\relax
\long\edef\@NaNAquantizeobject{\the\@NaNAtrantmptoksA}\relax
\@ifnextchar [{\@@@NaNAquantizevspace}{\@@@NaNAquantizevspace[\relax]}}

\long\def\@@@NaNAquantizevspace[#1]#2{\relax
% acquire and store
% [#1] optional object decl, is \relax if not given by user
% #2 top baselineskip
% allow for object decl specifications that have parameters
\@NaNAtrantmptoksA={#1}\relax
\long\edef\@NaNAquantizeobjectdecl{\the\@NaNAtrantmptoksA}\relax
\edef\@NaNAquantizetopbaselineskip{#2}\ivNaNAquantizevspace}

% acquire optional argument set and store
% [offset][prevdepth][lineskip limit][lineskip]
\def\ivNaNAquantizevspace{\@ifnextchar [{\@vNaNAquantizevspace}{\@vNaNAquantizevspace[0pt]}}
\def\@vNaNAquantizevspace[#1]{\edef\@NaNAquantizeoffset{#1}\@ifnextchar [{\@viNaNAquantizevspace}{\@viNaNAquantizevspace[\prevdepth]}}
\def\@viNaNAquantizevspace[#1]{\@NaNAquantizeprevdepth=#1\relax\@ifnextchar [{\@viiNaNAquantizevspace}{\@viiNaNAquantizevspace[\lineskiplimit]}}
\def\@viiNaNAquantizevspace[#1]{\edef\@NaNAquantizelineskiplimit{#1}\@ifnextchar [{\@viiiNaNAquantizevspace}{\@viiiNaNAquantizevspace[\lineskip]}}
\def\@viiiNaNAquantizevspace[#1]{\edef\@NaNAquantizelineskip{#1}\@ixNaNAquantizevspace}

% main routine
\def\@ixNaNAquantizevspace#1#2#3{\relax
\edef\@NaNAquantizeunitheight{#1}\relax
\edef\@NaNAquantizenomvspace{#2}\relax
\edef\@NaNAquantizeminvspace{#3}\relax
% \@NaNAquantizeoutdimenreg
% \@NaNAquantizeobject
% \@NaNAquantizeobjectdecl
% \@NaNAquantizetopbaselineskip
% \@NaNAquantizeoffset
% \@NaNAquantizeprevdepth
% \@NaNAquantizelineskiplimit
% \@NaNAquantizelineskip
% \@NaNAquantizeunitheight
% \@NaNAquantizenomvspace
% \@NaNAquantizeminvspace
% get overall height of object
\setbox\@NaNAquantizeboxA\vbox{\begingroup\@NaNAquantizeobjectdecl\@NaNAquantizeobject\relax\endgroup}\relax
\@NaNAquantizeheightA\ht\@NaNAquantizeboxA\relax
% get height of first line of object
\setbox\@NaNAquantizeboxA\vtop{\begingroup\@NaNAquantizeobjectdecl\@NaNAquantizeobject\relax\endgroup}\relax
\@NaNAquantizeheightB\ht\@NaNAquantizeboxA\relax
\ifdim\@NaNAquantizeprevdepth>-1000pt\relax % prevdepth > -1000pf means full baselineskip\lineskip rules in effect
% lineskip spacing rule takes effect if height of top line > baselineskip - prevdepth - lineskiplimit, 
% otherwise the baselineskip rule is in effect and the height of the first line does not matter at all.
\@NaNAquantizeheightC=\@NaNAquantizetopbaselineskip\relax
\advance\@NaNAquantizeheightC-\@NaNAquantizeprevdepth\relax
\advance\@NaNAquantizeheightC-\@NaNAquantizelineskiplimit\relax % this works even though \@NaNAquantizelineskiplimit is a macro because TeX allows --10pt notation
\ifdim\@NaNAquantizeheightB>\@NaNAquantizeheightC\relax
% lineskip spacing rule is in effect i.e., the object is going to be shifted down relative to the
% baselineskip set position by its top line height (already a part of the total height) + prevdepth + lineskip - baselineskip
\advance\@NaNAquantizeheightA\@NaNAquantizeprevdepth\relax
\advance\@NaNAquantizeheightA\@NaNAquantizelineskip\relax
\advance\@NaNAquantizeheightA-\@NaNAquantizetopbaselineskip\relax
\else
% height of first line <= \@NaNAquantizetopbaselineskip - \@NaNAquantizeprevdepth - \@NaNAquantizelineskiplimit
% standard baselineskip rules are in effect, so don't consider height of first line
\advance\@NaNAquantizeheightA-\@NaNAquantizeheightB\relax
\fi
%
\else % prevdepth <= -1000pt, simplier \topskip type rules in effect
\ifdim\@NaNAquantizeheightB>\@NaNAquantizetopbaselineskip
% height of top line (already included in the total height) in excess of
% baselineskip is the amount it will be downshifted
\advance\@NaNAquantizeheightA-\@NaNAquantizetopbaselineskip\relax
\else
% height of first line is irrelevant, remove it
\advance\@NaNAquantizeheightA-\@NaNAquantizeheightB\relax
\fi
\fi % prevdepth <= -1000pt
%
% adjust height for any manual offset
\advance\@NaNAquantizeheightA\@NaNAquantizeoffset\relax
% add in nominal spacer
\advance\@NaNAquantizeheightA\@NaNAquantizenomvspace\relax
% check for nonzero unitheight
\@NaNAquantizeheightB=\@NaNAquantizeunitheight\relax
\ifnum\@NaNAquantizeheightB=0\relax
\@NaNAclspkgerror{NaNAquantizevspace unit height cannot be zero. Assuming 10pt.}%
{Division by zero is not allowed.}
\@NaNAquantizeheightB=10pt\relax
\fi
% get integer number of lines
\@NaNAquantizemultiple=\@NaNAquantizeheightA\relax
\divide\@NaNAquantizemultiple\@NaNAquantizeheightB\relax
% set A to contain the excess height over the \@NaNAquantizemultiple of lines
% A = height - multiple*unitheight
\@NaNAquantizeheightC\@NaNAquantizeheightB\relax
\multiply\@NaNAquantizeheightC\@NaNAquantizemultiple\relax
\advance\@NaNAquantizeheightA-\@NaNAquantizeheightC\relax
% set B to contain the height short of \@NaNAquantizemultiple+1 of lines
% B = unitheight - A
\advance\@NaNAquantizeheightB-\@NaNAquantizeheightA\relax
% choose A or B based on which is closer
\@NaNAquantizeheightC\@NaNAquantizenomvspace\relax
\ifdim\@NaNAquantizeheightA<\@NaNAquantizeheightB\relax
% C = nomvspace - A, go with lower
\advance\@NaNAquantizeheightC-\@NaNAquantizeheightA\relax
\else
% C = nomvspace + B, go with upper
\advance\@NaNAquantizeheightC\@NaNAquantizeheightB\relax
\fi
% if violate lower bound, use next integer bound
\ifdim\@NaNAquantizeheightC<\@NaNAquantizeminvspace\relax
% A + B = unitheight
\advance\@NaNAquantizeheightC\@NaNAquantizeheightA\relax
\advance\@NaNAquantizeheightC\@NaNAquantizeheightB\relax
\fi
% export object and spacer outside of group
\global\let\@NaNAquantizeobjectout\@NaNAquantizeobject\relax
\global\@NaNAquantizeheightC\@NaNAquantizeheightC\relax
\endgroup
\if@NaNAquantizevspaceuseoutdimenreg
\@NaNAquantizeoutdimenreg=\@NaNAquantizeheightC\relax
\else
\@NaNAquantizeobjectout\relax
\vskip\@NaNAquantizeheightC\relax
\fi}


% user command to disable all global assignments, possible use within object decl
\def\NaNAquantizedisableglobal{\let\global\relax
\let\gdef\def
\let\xdef\edef}
% user command to allow for the disabling of \thanks and other commands, possible use within object decl
\def\NaNAquantizedisabletitlecmds{\long\def\thanks##1{\relax}\relax
\long\def\NaNAcompsocitemizethanks##1{\relax}\def\newpage{\relax}}





% V1.6
% we allow the user access to the last part of the title area
% useful in emergencies such as when a different spacing is needed
% This text is NOT compensated for in the dynamic sizer.
\let\@NaNAaftertitletext=\relax
\long\def\NaNAaftertitletext#1{\def\@NaNAaftertitletext{#1}}


% V1.7 provide a way for users to enter abstract and keywords
% into the onecolumn title are. This text is compensated for
% in the dynamic sizer.
\let\@NaNAtitleabstractindextext=\relax
\long\def\NaNAtitleabstractindextext#1{\def\@NaNAtitleabstractindextext{#1}}

% V1.7 provide a way for users to get the \@NaNAtitleabstractindextext if
% not in compsoc or transmag journal mode - this way abstract and keywords
% can still be placed in their conventional position if not in those modes.
\def\NaNAdisplaynontitleabstractindextext{%
% display for all conference formats
\ifCLASSOPTIONconference\@NaNAtitleabstractindextext\relax
\else% non-conferences
  % V1.8a display for all technotes
  \ifCLASSOPTIONtechnote\@NaNAtitleabstractindextext\relax
  % V1.8a add diamond line after abstract and index terms for compsoc technotes
  \@NaNAcompsoconly{\noindent\hfill\NaNAcompsocdiamondline\hfill\hbox{}\par}\relax
  \else % non-conferences and non-technotes
    \ifCLASSOPTIONcompsoc% display if not compsoc and not transmag
    \else
      \ifCLASSOPTIONtransmag
      \else% not compsoc journal nor transmag journal
         \@NaNAtitleabstractindextext\relax
      \fi
    \fi
  \fi
\fi}


% command to allow alteration of baselinestretch, but only if the current
% baselineskip is unity. Used to tweak the compsoc abstract and keywords line spacing.
\def\@NaNAtweakunitybaselinestretch#1{{\def\baselinestretch{1}\selectfont
\global\@tempskipa\baselineskip}\ifnum\@tempskipa=\baselineskip%
\def\baselinestretch{#1}\selectfont\fi\relax}


% abstract and keywords are in \small, except 
% for 9pt docs in which they are in \footnotesize
% Because 9pt docs use an 8pt footnotesize, \small
% becomes a rather awkward 8.5pt
\def\@NaNAabskeysecsize{\small}
\ifx\CLASSOPTIONpt\@NaNAptsizenine
 \def\@NaNAabskeysecsize{\footnotesize}
\fi

% compsoc journals use \footnotesize, compsoc conferences use normalsize
\@NaNAcompsoconly{\def\@NaNAabskeysecsize{\footnotesize}}
\@NaNAcompsocconfonly{\def\@NaNAabskeysecsize{\small}}


% V1.6 have abstract and keywords strip leading spaces, pars and newlines
% so that spacing is more tightly controlled.
\def\abstract{\normalfont
    \if@twocolumn
      \@NaNAabskeysecsize\bfseries\textit{\abstractname}---\relax
    \else
      \bgroup\par\addvspace{0.5\baselineskip}\centering\vspace{-1.78ex}\@NaNAabskeysecsize\textbf{\abstractname}\par\addvspace{0.5\baselineskip}\egroup\quotation\@NaNAabskeysecsize
    \fi\@NaNAgobbleleadPARNLSP}
% V1.6 The NaNA wants only 1 pica from end of abstract to introduction heading when in 
% conference mode (the heading already has this much above it)
\def\endabstract{\relax\ifCLASSOPTIONconference\vspace{0ex}\else\vspace{1.34ex}\fi\par\if@twocolumn\else\endquotation\fi
    \normalfont\normalsize}

\def\NaNAkeywords{\normalfont
    \if@twocolumn
      \@NaNAabskeysecsize\bfseries\textit{\NaNAkeywordsname}---\relax
    \else
      \bgroup\par\addvspace{0.5\baselineskip}\centering\@NaNAabskeysecsize\textbf{\NaNAkeywordsname}\par\addvspace{0.5\baselineskip}\egroup\quotation\@NaNAabskeysecsize
    \fi\@NaNAgobbleleadPARNLSP}
\def\endNaNAkeywords{\relax\ifCLASSOPTIONtechnote\vspace{1.34ex}\else\vspace{0.67ex}\fi
    \par\if@twocolumn\else\endquotation\fi%
    \normalfont\normalsize}

% V1.7 compsoc keywords index terms
\ifCLASSOPTIONcompsoc
  \ifCLASSOPTIONconference% compsoc conference
\def\abstract{\normalfont\@NaNAtweakunitybaselinestretch{1.15}\bfseries
    \if@twocolumn
      \@NaNAabskeysecsize\noindent\textit{\abstractname}---\relax
    \else
      \bgroup\par\addvspace{0.5\baselineskip}\centering\vspace{-1.78ex}\@NaNAabskeysecsize\textbf{\abstractname}\par\addvspace{0.5\baselineskip}\egroup\quotation\@NaNAabskeysecsize%
    \fi\@NaNAgobbleleadPARNLSP}
\def\NaNAkeywords{\normalfont\@NaNAtweakunitybaselinestretch{1.15}\bfseries
    \if@twocolumn
      \@NaNAabskeysecsize\vskip 0.5\baselineskip plus 0.25\baselineskip minus 0.25\baselineskip\noindent
      \textit{\NaNAkeywordsname}---\relax
    \else
      \bgroup\par\addvspace{0.5\baselineskip}\centering\@NaNAabskeysecsize\textbf{\NaNAkeywordsname}\par\addvspace{0.5\baselineskip}\egroup\quotation\@NaNAabskeysecsize%
    \fi\@NaNAgobbleleadPARNLSP}
  \else% compsoc not conference
\def\abstract{\normalfont\@NaNAtweakunitybaselinestretch{1.15}\sffamily
    \if@twocolumn
      \@NaNAabskeysecsize\noindent\textbf{\abstractname}---\relax
    \else
      \bgroup\par\addvspace{0.5\baselineskip}\centering\vspace{-1.78ex}\@NaNAabskeysecsize\textbf{\abstractname}\par\addvspace{0.5\baselineskip}\egroup\quotation\@NaNAabskeysecsize%
    \fi\@NaNAgobbleleadPARNLSP}
\def\NaNAkeywords{\normalfont\@NaNAtweakunitybaselinestretch{1.15}\sffamily
    \if@twocolumn
      \@NaNAabskeysecsize\vskip 0.5\baselineskip plus 0.25\baselineskip minus 0.25\baselineskip\noindent
      \textbf{\NaNAkeywordsname}---\relax
    \else
      \bgroup\par\addvspace{0.5\baselineskip}\centering\@NaNAabskeysecsize\textbf{\NaNAkeywordsname}\par\addvspace{0.5\baselineskip}\egroup\quotation\@NaNAabskeysecsize%
    \fi\@NaNAgobbleleadPARNLSP}
  \fi
\fi

% V1.8 transmag keywords index terms
% no abstract name, use indentation
\ifCLASSOPTIONtransmag
\def\abstract{\normalfont\parindent 1em\relax
    \if@twocolumn
      \@NaNAabskeysecsize\bfseries\indent
    \else
      \bgroup\par\addvspace{0.5\baselineskip}\centering\vspace{-1.78ex}\@NaNAabskeysecsize
      \textbf{\abstractname}\par\addvspace{0.5\baselineskip}\egroup\quotation\@NaNAabskeysecsize
    \fi\@NaNAgobbleleadPARNLSP}

\def\NaNAkeywords{\normalfont\parindent 1em\relax
    \if@twocolumn
      \@NaNAabskeysecsize\vspace{1\baselineskip}\bfseries\indent\textit{\NaNAkeywordsname}---\relax
    \else
      \bgroup\par\vspace{1\baselineskip}\centering\@NaNAabskeysecsize
      \textbf{\NaNAkeywordsname}\par\addvspace{0.5\baselineskip}\egroup\quotation\@NaNAabskeysecsize
    \fi\@NaNAgobbleleadPARNLSP}
\fi



% gobbles all leading \, \\ and \par, upon finding first token that
% is not a \ , \\ or a \par, it ceases and returns that token
% 
% used to strip leading \, \\ and \par from the input
% so that such things in the beginning of an environment will not
% affect the formatting of the text
\long\def\@NaNAgobbleleadPARNLSP#1{\let\@NaNAswallowthistoken=0%
\let\@NaNAgobbleleadPARNLSPtoken#1%
\let\@NaNAgobbleleadPARtoken=\par%
\let\@NaNAgobbleleadNLtoken=\\%
\let\@NaNAgobbleleadSPtoken=\ %
\def\@NaNAgobbleleadSPMACRO{\ }%
\ifx\@NaNAgobbleleadPARNLSPtoken\@NaNAgobbleleadPARtoken%
\let\@NaNAswallowthistoken=1%
\fi%
\ifx\@NaNAgobbleleadPARNLSPtoken\@NaNAgobbleleadNLtoken%
\let\@NaNAswallowthistoken=1%
\fi%
\ifx\@NaNAgobbleleadPARNLSPtoken\@NaNAgobbleleadSPtoken%
\let\@NaNAswallowthistoken=1%
\fi%
% a control space will come in as a macro
% when it is the last one on a line
\ifx\@NaNAgobbleleadPARNLSPtoken\@NaNAgobbleleadSPMACRO%
\let\@NaNAswallowthistoken=1%
\fi%
% if we have to swallow this token, do so and taste the next one
% else spit it out and stop gobbling
\ifx\@NaNAswallowthistoken 1\let\@NaNAnextgobbleleadPARNLSP=\@NaNAgobbleleadPARNLSP\else%
\let\@NaNAnextgobbleleadPARNLSP=#1\fi%
\@NaNAnextgobbleleadPARNLSP}%




% TITLING OF SECTIONS
\def\@NaNAsectpunct{:\ \,}  % Punctuation after run-in section heading  (headings which are
                            % part of the paragraphs), need little bit more than a single space
                            % spacing from section number to title
% compsoc conferences use regular period/space punctuation
\ifCLASSOPTIONcompsoc
\ifCLASSOPTIONconference
\def\@NaNAsectpunct{.\ }
\fi\fi


\def\@seccntformat#1{\csname the#1dis\endcsname\hskip 0.5em\relax}

\ifCLASSOPTIONcompsoc
% compsoc journals need extra spacing
\ifCLASSOPTIONconference\else
\def\@seccntformat#1{\csname the#1dis\endcsname\hskip 1em\relax}
\fi\fi

%v1.7 put {} after #6 to allow for some types of user font control
%and use \@@par rather than \par
\def\@sect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
     \let\@svsec\@empty
  \else
     \refstepcounter{#1}%
     % load section label and spacer into \@svsec
     \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi%
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@% tempskipa determines whether is treated as a high
     \begingroup #6{\relax% or low level heading
      \noindent % subsections are NOT indented
       % print top level headings. \@svsec is label, #8 is heading title
       % The NaNA does not block indent the section title text, it flows like normal
       {\hskip #3\relax\@svsec}{\interlinepenalty \@M #8\@@par}}%
     \endgroup
     \addcontentsline{toc}{#1}{\ifnum #2>\c@secnumdepth\relax\else
               \protect\numberline{\csname the#1\endcsname}\fi#7}%
  \else % printout low level headings
     % svsechd seems to swallow the trailing space, protect it with \mbox{}
     % got rid of sectionmark stuff
     \def\@svsechd{#6{\hskip #3\relax\@svsec #8\@NaNAsectpunct\mbox{}}%
     \addcontentsline{toc}{#1}{\ifnum #2>\c@secnumdepth\relax\else
               \protect\numberline{\csname the#1\endcsname}\fi#7}}%
  \fi%skip down
  \@xsect{#5}}


% section* handler
%v1.7 put {} after #4 to allow for some types of user font control
%and use \@@par rather than \par
\def\@ssect#1#2#3#4#5{\@tempskipa #3\relax
  \ifdim \@tempskipa>\z@
     %\begingroup #4\@hangfrom{\hskip #1}{\interlinepenalty \@M #5\par}\endgroup
     % The NaNA does not block indent the section title text, it flows like normal
     \begingroup \noindent #4{\relax{\hskip #1}{\interlinepenalty \@M #5\@@par}}\endgroup
  % svsechd swallows the trailing space, protect it with \mbox{}
  \else \def\@svsechd{#4{\hskip #1\relax #5\@NaNAsectpunct\mbox{}}}\fi
  \@xsect{#3}}


%% SECTION heading spacing and font
%%
% arguments are: #1 - sectiontype name
% (for \@sect)   #2 - section level
%                #3 - section heading indent
%                #4 - top separation (absolute value used, neg indicates not to indent main text)
%                     If negative, make stretch parts negative too!
%                #5 - (absolute value used) positive: bottom separation after heading,
%                      negative: amount to indent main text after heading
%                Both #4 and #5 negative means to indent main text and use negative top separation
%                #6 - font control
% You've got to have \normalfont\normalsize in the font specs below to prevent
% trouble when you do something like:
% \section{Note}{\ttfamily TT-TEXT} is known to ... 
% The NaNA sometimes REALLY stretches the area before a section
% heading by up to about 0.5in. However, it may not be a good
% idea to let LaTeX have quite this much rubber.
\ifCLASSOPTIONconference%
% The NaNA wants section heading spacing to decrease for conference mode
\def\section{\@startsection{section}{1}{\z@}{1.5ex plus 1.5ex minus 0.5ex}%
{0.7ex plus 1ex minus 0ex}{\normalfont\normalsize\centering\scshape}}%
\def\subsection{\@startsection{subsection}{2}{\z@}{1.5ex plus 1.5ex minus 0.5ex}%
{0.7ex plus .5ex minus 0ex}{\normalfont\normalsize\itshape}}%
\else % for journals
\def\section{\@startsection{section}{1}{\z@}{3.0ex plus 1.5ex minus 1.5ex}% V1.6 3.0ex from 3.5ex
{0.7ex plus 1ex minus 0ex}{\normalfont\normalsize\centering\scshape}}%
\def\subsection{\@startsection{subsection}{2}{\z@}{3.5ex plus 1.5ex minus 1.5ex}%
{0.7ex plus .5ex minus 0ex}{\normalfont\normalsize\itshape}}%
\fi

% for both journals and conferences
% decided to put in a little rubber above the section, might help somebody
\def\subsubsection{\@startsection{subsubsection}{3}{\parindent}{0ex plus 0.1ex minus 0.1ex}%
{0ex}{\normalfont\normalsize\itshape}}%
\def\paragraph{\@startsection{paragraph}{4}{2\parindent}{0ex plus 0.1ex minus 0.1ex}%
{0ex}{\normalfont\normalsize\itshape}}%


% compsoc
\ifCLASSOPTIONcompsoc
\ifCLASSOPTIONconference
% compsoc conference
\def\section{\@startsection{section}{1}{\z@}{1\baselineskip plus 0.25\baselineskip minus 0.25\baselineskip}%
{1\baselineskip plus 0.25\baselineskip minus 0.25\baselineskip}{\normalfont\large\bfseries}}%
\def\subsection{\@startsection{subsection}{2}{\z@}{1\baselineskip plus 0.25\baselineskip minus 0.25\baselineskip}%
{1\baselineskip plus 0.25\baselineskip minus 0.25\baselineskip}{\normalfont\sublargesize\bfseries}}%
\def\subsubsection{\@startsection{subsubsection}{3}{\z@}{1\baselineskip plus 0.25\baselineskip minus 0.25\baselineskip}%
{0ex}{\normalfont\normalsize\bfseries}}%
\def\paragraph{\@startsection{paragraph}{4}{2\parindent}{0ex plus 0.1ex minus 0.1ex}%
{0ex}{\normalfont\normalsize}}%
\else% compsoc journals
% use negative top separation as compsoc journals do not indent paragraphs after section titles
\def\section{\@startsection{section}{1}{\z@}{-3.5ex plus -2ex minus -1.5ex}%
{0.7ex plus 1ex minus 0ex}{\normalfont\sublargesize\sffamily\bfseries\scshape}}%
% Note that subsection and smaller may not be correct for the Computer Society,
% I have to look up an example.
\def\subsection{\@startsection{subsection}{2}{\z@}{-3.5ex plus -1.5ex minus -1.5ex}%
{0.7ex plus .5ex minus 0ex}{\normalfont\normalsize\sffamily\bfseries}}%
\def\subsubsection{\@startsection{subsubsection}{3}{\z@}{-2.5ex plus -1ex minus -1ex}%
{0.5ex plus 0.5ex minus 0ex}{\normalfont\normalsize\sffamily\itshape}}%
\def\paragraph{\@startsection{paragraph}{4}{2\parindent}{-0ex plus -0.1ex minus -0.1ex}%
{0ex}{\normalfont\normalsize}}%
\fi\fi

% transmag
\ifCLASSOPTIONtransmag
\def\subsection{\@startsection{subsection}{2}{0.75\parindent}{3.5ex plus 1.5ex minus 1.5ex}%
{0.7ex plus .5ex minus 0ex}{\normalfont\normalsize\itshape}}%
\def\subsubsection{\@startsection{subsubsection}{3}{1.25\parindent}{0.1ex plus 0.1ex minus 0.1ex}%
{0.1ex}{\normalfont\normalsize\itshape}}%
\fi



\def\NaNAraisesectionheading#1{\noindent\raisebox{1.5\baselineskip}[0pt][0pt]{\parbox[b]{\columnwidth}{#1\unskip\global\everypar=\everypar}}\vspace{-1\baselineskip}\vspace{-\parskip}\par}



%% ENVIRONMENTS
% "box" symbols at end of proofs
\def\NaNAQEDclosed{\mbox{\rule[0pt]{1.3ex}{1.3ex}}} % for a filled box
% V1.6 some journals use an open box instead that will just fit around a closed one
\def\NaNAQEDopen{{\setlength{\fboxsep}{0pt}\setlength{\fboxrule}{0.2pt}\fbox{\rule[0pt]{0pt}{1.3ex}\rule[0pt]{1.3ex}{0pt}}}}
\ifCLASSOPTIONcompsoc
\def\NaNAQED{\NaNAQEDopen}   % default to open for compsoc
\else
\def\NaNAQED{\NaNAQEDclosed} % otherwise default to closed
\fi

%V1.8 flag to indicate if QED symbol is to be shown
\newif\if@NaNAQEDshow  \@NaNAQEDshowtrue
\def\NaNAproofindentspace{2\parindent}% V1.8 allow user to change indentation amount if desired
% v1.7 name change to avoid namespace collision with amsthm. Also add support
% for an optional argument.
\def\NaNAproof{\@ifnextchar[{\@NaNAproof}{\@NaNAproof[\NaNAproofname]}}
\def\@NaNAproof[#1]{\@NaNAQEDshowtrue\par\noindent\hspace{\NaNAproofindentspace}{\itshape #1: }}
\def\endNaNAproof{\if@NaNAQEDshow\hspace*{\fill}\nobreakspace\NaNAQED\fi\par}
% qedhere for equation environments, similar to AMS \qedhere
\def\NaNAQEDhereeqn{\global\@NaNAQEDshowfalse\eqno\let\eqno\relax\let\leqno\relax
                    \let\veqno\relax\hbox{\NaNAQED}}
% NaNA style qedhere for NaNAeqnarray and other environments
\def\NaNAQEDhere{\global\@NaNAQEDshowfalse\NaNAQED}
% command to disable QED at end of NaNAproof
\def\NaNAQEDoff{\global\@NaNAQEDshowfalse}


%\itemindent is set to \z@ by list, so define new temporary variable
\newdimen\@NaNAtmpitemindent

\ifCLASSOPTIONcompsoc
% V1.8a compsoc uses bold theorem titles, a period instead of a colon, vertical spacing, and hanging indentation
% V1.8 allow long theorem names to break across lines.
% Thanks to Miquel Payaro for reporting this.
\def\@begintheorem#1#2{\@NaNAtmpitemindent\itemindent\relax
    \topsep 0.2\@NaNAnormalsizeunitybaselineskip plus 0.26\@NaNAnormalsizeunitybaselineskip minus 0.05\@NaNAnormalsizeunitybaselineskip
    \rmfamily\trivlist\hangindent\parindent%
    \item[]\textit{\bfseries\noindent #1\ #2.} \itemindent\@NaNAtmpitemindent\relax}
\def\@opargbegintheorem#1#2#3{\@NaNAtmpitemindent\itemindent\relax
\topsep 0.2\@NaNAnormalsizeunitybaselineskip plus 0.26\@NaNAnormalsizeunitybaselineskip minus 0.05\@NaNAnormalsizeunitybaselineskip
\rmfamily\trivlist\hangindent\parindent%
% V1.6 The NaNA is back to using () around theorem names which are also in italics
% Thanks to Christian Peel for reporting this.
    \item[]\textit{\bfseries\noindent #1\ #2\ (#3).} \itemindent\@NaNAtmpitemindent\relax}
% V1.7 remove bogus \unskip that caused equations in theorems to collide with
% lines below.
\def\@endtheorem{\endtrivlist\vskip 0.25\@NaNAnormalsizeunitybaselineskip plus 0.26\@NaNAnormalsizeunitybaselineskip minus 0.05\@NaNAnormalsizeunitybaselineskip}
\else
%
% noncompsoc
% 
% V1.8 allow long theorem names to break across lines.
% Thanks to Miquel Payaro for reporting this.
\def\@begintheorem#1#2{\@NaNAtmpitemindent\itemindent\relax\topsep 0pt\rmfamily\trivlist%
    \item[]\textit{\indent #1\ #2:} \itemindent\@NaNAtmpitemindent\relax}
\def\@opargbegintheorem#1#2#3{\@NaNAtmpitemindent\itemindent\relax\topsep 0pt\rmfamily \trivlist%
% V1.6 The NaNA is back to using () around theorem names which are also in italics
% Thanks to Christian Peel for reporting this.
    \item[]\textit{\indent #1\ #2\ (#3):} \itemindent\@NaNAtmpitemindent\relax}
% V1.7 remove bogus \unskip that caused equations in theorems to collide with
% lines below.
\def\@endtheorem{\endtrivlist}
\fi



% V1.6
% display command for the section the theorem is in - so that \thesection
% is not used as this will be in Roman numerals when we want arabic.
% LaTeX2e uses \def\@thmcounter#1{\noexpand\arabic{#1}} for the theorem number
% (second part) display and \def\@thmcountersep{.} as a separator.
% V1.7 intercept calls to the section counter and reroute to \@NaNAthmcounterinsection
% to allow \appendix(ices} to override as needed.
%
% special handler for sections, allows appendix(ices) to override
\gdef\@NaNAthmcounterinsection#1{\arabic{#1}}
% string macro
\edef\@NaNAstringsection{section}

% redefine the #1#2[#3] form of newtheorem to use a hook to \@NaNAthmcounterinsection
% if section in_counter is used
\def\@xnthm#1#2[#3]{%
  \expandafter\@ifdefinable\csname #1\endcsname
    {\@definecounter{#1}\@newctr{#1}[#3]%
     \edef\@NaNAstringtmp{#3}
     \ifx\@NaNAstringtmp\@NaNAstringsection
     \expandafter\xdef\csname the#1\endcsname{%
     \noexpand\@NaNAthmcounterinsection{#3}\@thmcountersep
          \@thmcounter{#1}}%
     \else
     \expandafter\xdef\csname the#1\endcsname{%
       \expandafter\noexpand\csname the#3\endcsname \@thmcountersep
          \@thmcounter{#1}}%
     \fi
     \global\@namedef{#1}{\@thm{#1}{#2}}%
     \global\@namedef{end#1}{\@endtheorem}}}



%% SET UP THE DEFAULT PAGESTYLE
\pagestyle{headings}
\pagenumbering{arabic}

% normally the page counter starts at 1
\setcounter{page}{1}
% however, for peerreview the cover sheet is page 0 or page -1
% (for duplex printing)
\ifCLASSOPTIONpeerreview
   \if@twoside
      \setcounter{page}{-1}
   \else
      \setcounter{page}{0}
   \fi
\fi

% standard book class behavior - let bottom line float up and down as
% needed when single sided
\ifCLASSOPTIONtwoside\else\raggedbottom\fi
% if two column - turn on twocolumn, allow word spacings to stretch more and
% enforce a rigid position for the last lines
\ifCLASSOPTIONtwocolumn
% the peer review option delays invoking twocolumn
   \ifCLASSOPTIONpeerreview\else
      \twocolumn
   \fi
\sloppy 
\flushbottom
\fi




% \APPENDIX and \APPENDICES definitions

% This is the \@ifmtarg command from the LaTeX ifmtarg package
% by Peter Wilson (CUA) and Donald Arseneau
% \@ifmtarg is used to determine if an argument to a command
% is present or not.
% For instance:
% \@ifmtarg{#1}{\typeout{empty}}{\typeout{has something}}
% \@ifmtarg is used with our redefined \section command if
% \appendices is invoked.
% The command \section will behave slightly differently depending
% on whether the user specifies a title: 
% \section{My appendix title}
% or not:
% \section{}
% This way, we can eliminate the blank lines where the title
% would be, and the unneeded : after Appendix in the table of
% contents 
\begingroup
\catcode`\Q=3
\long\gdef\@ifmtarg#1{\@xifmtarg#1QQ\@secondoftwo\@firstoftwo\@nil}
\long\gdef\@xifmtarg#1#2Q#3#4#5\@nil{#4}
\endgroup
% end of \@ifmtarg defs


% V1.7
% command that allows the one time saving of the original definition
% of section to \@NaNAappendixsavesection for \appendix or \appendices 
% we don't save \section here as it may be redefined later by other
% packages (hyperref.sty, etc.)
\def\@NaNAsaveoriginalsectiononce{\let\@NaNAappendixsavesection\section
\let\@NaNAsaveoriginalsectiononce\relax}

% neat trick to grab and process the argument from \section{argument}
% we process differently if the user invoked \section{} with no
% argument (title)
% note we reroute the call to the old \section*
\def\@NaNAprocessthesectionargument#1{%
\@ifmtarg{#1}{%
\@NaNAappendixsavesection*{\appendixname\nobreakspace\thesectiondis}%
\addcontentsline{toc}{section}{\appendixname\nobreakspace\thesection}}{%
\@NaNAappendixsavesection*{\appendixname\nobreakspace\thesectiondis\\* #1}%
\addcontentsline{toc}{section}{\appendixname\nobreakspace\thesection: #1}}}

% we use this if the user calls \section{} after
% \appendix-- which has no meaning. So, we ignore the
% command and its argument. Then, warn the user.
\def\@NaNAdestroythesectionargument#1{\typeout{** WARNING: Ignoring useless
\protect\section\space in Appendix (line \the\inputlineno).}}


% remember \thesection forms will be displayed in \ref calls
% and in the Table of Contents.
% The \sectiondis form is used in the actual heading itself

% appendix command for one single appendix
% normally has no heading. However, if you want a 
% heading, you can do so via the optional argument:
% \appendix[Optional Heading]
\def\appendix{\relax}
\renewcommand{\appendix}[1][]{\@NaNAsaveoriginalsectiononce\par
    % v1.6 keep hyperref's identifiers unique
    \gdef\theHsection{Appendix.A}%
    % v1.6 adjust hyperref's string name for the section
    \xdef\Hy@chapapp{appendix}%
    \setcounter{section}{0}%
    \setcounter{subsection}{0}%
    \setcounter{subsubsection}{0}%
    \setcounter{paragraph}{0}%
    \gdef\thesection{A}%
    \gdef\thesectiondis{}% 
    \gdef\thesubsection{\Alph{subsection}}%
    \gdef\@NaNAthmcounterinsection##1{A}
    \refstepcounter{section}% update the \ref counter
    \@ifmtarg{#1}{\@NaNAappendixsavesection*{\appendixname}%
                  \addcontentsline{toc}{section}{\appendixname}}{%
             \@NaNAappendixsavesection*{\appendixname\nobreakspace\\* #1}%
             \addcontentsline{toc}{section}{\appendixname: #1}}%
    % redefine \section command for appendix
    % leave \section* as is
    \def\section{\@ifstar{\@NaNAappendixsavesection*}{%
                    \@NaNAdestroythesectionargument}}% throw out the argument
                                                     % of the normal form
}



% appendices command for multiple appendices
% user then calls \section with an argument (possibly empty) to
% declare the individual appendices
\def\appendices{\@NaNAsaveoriginalsectiononce\par
    % v1.6 keep hyperref's identifiers unique
    \gdef\theHsection{Appendix.\Alph{section}}%
    % v1.6 adjust hyperref's string name for the section
    \xdef\Hy@chapapp{appendix}%
    \setcounter{section}{-1}% we want \refstepcounter to use section 0
    \setcounter{subsection}{0}%
    \setcounter{subsubsection}{0}%
    \setcounter{paragraph}{0}%
    \ifCLASSOPTIONromanappendices%
    \gdef\thesection{\Roman{section}}%
    \gdef\thesectiondis{\Roman{section}}%
    \@NaNAcompsocconfonly{\gdef\thesectiondis{\Roman{section}.}}%
    \gdef\@NaNAthmcounterinsection##1{A\arabic{##1}}
    \else%
    \gdef\thesection{\Alph{section}}%
    \gdef\thesectiondis{\Alph{section}}%
    \@NaNAcompsocconfonly{\gdef\thesectiondis{\Alph{section}.}}%
    \gdef\@NaNAthmcounterinsection##1{\Alph{##1}}
    \fi%
    \refstepcounter{section}% update the \ref counter
    \setcounter{section}{0}% NEXT \section will be the FIRST appendix
    % redefine \section command for appendices
    % leave \section* as is
    \def\section{\@ifstar{\@NaNAappendixsavesection*}{% process the *-form
                    \refstepcounter{section}% or is a new section so,
                    \@NaNAprocessthesectionargument}}% process the argument 
                                                 % of the normal form
}




\ifCLASSOPTIONcompsoc
  \def\NaNAPARstartFONTSTYLE{\mdseries}
  \def\NaNAPARstartWORDFONTSTYLE{\scshape}
  \def\NaNAPARstartWORDCAPSTYLE{\relax}
\fi
%
%

% 
% the number of lines that are indented to clear it
% may need to increase if using decenders
\providecommand{\NaNAPARstartDROPLINES}{2}
% minimum number of lines left on a page to allow a \@NaNAPARstart
% Does not take into consideration rubber shrink, so it tends to
% be overly cautious
\providecommand{\NaNAPARstartMINPAGELINES}{2}
% V1.7 the height of the drop cap is adjusted to match the height of this text
% in the current font (when \NaNAPARstart is called).
\providecommand{\NaNAPARstartHEIGHTTEXT}{T}
% the depth the letter is lowered below the baseline
% the height (and size) of the letter is determined by the sum
% of this value and the height of the \NaNAPARstartHEIGHTTEXT in the current
% font. It is a good idea to set this value in terms of the baselineskip
% so that it can respond to changes therein.
\providecommand{\NaNAPARstartDROPDEPTH}{1.1\baselineskip}

\providecommand{\NaNAPARstartFONTSTYLE}{\bfseries}
% V1.7 any additional, non-font related commands needed to modify
% the drop cap letter, can take zero or one argument.
\providecommand{\NaNAPARstartCAPSTYLE}{\MakeUppercase}
% V1.7 the font that will be used to render the rest of the word,
% can take zero or one argument.
\providecommand{\NaNAPARstartWORDFONTSTYLE}{\relax}
% V1.7 any additional, non-font related commands needed to modify
% the rest of the word, can take zero or one argument.
\providecommand{\NaNAPARstartWORDCAPSTYLE}{\MakeUppercase}
% This is the horizontal separation distance from the drop letter to the main text.
% Lengths that depend on the font (e.g., ex, em, etc.) will be referenced
% to the font that is active when \NaNAPARstart is called. 
\providecommand{\NaNAPARstartSEP}{0.15em}
% V1.7 horizontal offset applied to the left of the drop cap.
\providecommand{\NaNAPARstartHOFFSET}{0em}
% V1.7 Italic correction command applied at the end of the drop cap.
\providecommand{\NaNAPARstartITLCORRECT}{\/}

% width of the letter output, set globally. Can be used in \NaNAPARstartSEP
% or \NaNAPARstartHOFFSET, but not the height lengths.
\newdimen\NaNAPARstartletwidth
\NaNAPARstartletwidth 0pt\relax

% definition of \NaNAPARstart
% THIS IS A CONTROLLED SPACING AREA, DO NOT ALLOW SPACES WITHIN THESE LINES
% 
% The token \@NaNAPARstartfont will be globally defined after the first use
% of \NaNAPARstart and will be a font command which creates the big letter
% The first argument is the first letter of the first word and the second
% argument is the rest of the first word(s).
\def\NaNAPARstart#1#2{\par{%
% if this page does not have enough space, break it and lets start
% on a new one
\@NaNAtranneedspace{\NaNAPARstartMINPAGELINES\baselineskip}{\relax}%
% V1.7 move this up here in case user uses \textbf for \NaNAPARstartFONTSTYLE
% which uses command \leavevmode which causes an unwanted \indent to be issued
\noindent
% calculate the desired height of the big letter
% it extends from the top of \NaNAPARstartHEIGHTTEXT in the current font
% down to \NaNAPARstartDROPDEPTH below the current baseline
\settoheight{\@NaNAtrantmpdimenA}{\NaNAPARstartHEIGHTTEXT}%
\addtolength{\@NaNAtrantmpdimenA}{\NaNAPARstartDROPDEPTH}%
% extract the name of the current font in bold
% and place it in \@NaNAPARstartFONTNAME
\def\@NaNAPARstartGETFIRSTWORD##1 ##2\relax{##1}%
{\NaNAPARstartFONTSTYLE{\selectfont\edef\@NaNAPARstartFONTNAMESPACE{\fontname\font\space}%
\xdef\@NaNAPARstartFONTNAME{\expandafter\@NaNAPARstartGETFIRSTWORD\@NaNAPARstartFONTNAMESPACE\relax}}}%
% define a font based on this name with a point size equal to the desired
% height of the drop letter
\font\@NaNAPARstartsubfont\@NaNAPARstartFONTNAME\space at \@NaNAtrantmpdimenA\relax%
% save this value as a counter (integer) value (sp points)
\@NaNAtrantmpcountA=\@NaNAtrantmpdimenA%
% now get the height of the actual letter produced by this font size
\settoheight{\@NaNAtrantmpdimenB}{\@NaNAPARstartsubfont\NaNAPARstartCAPSTYLE{#1}}%
% If something bogus happens like the first argument is empty or the
% current font is strange, do not allow a zero height.
\ifdim\@NaNAtrantmpdimenB=0pt\relax%
\typeout{** WARNING: NaNAPARstart drop letter has zero height! (line \the\inputlineno)}%
\typeout{ Forcing the drop letter font size to 10pt.}%
\@NaNAtrantmpdimenB=10pt%
\fi%
% and store it as a counter
\@NaNAtrantmpcountB=\@NaNAtrantmpdimenB%
% Since a font size doesn't exactly correspond to the height of the capital
% letters in that font, the actual height of the letter, \@NaNAtrantmpcountB,
% will be less than that desired, \@NaNAtrantmpcountA
% we need to raise the font size, \@NaNAtrantmpdimenA 
% by \@NaNAtrantmpcountA / \@NaNAtrantmpcountB
% But, TeX doesn't have floating point division, so we have to use integer
% division. Hence the use of the counters.
% We need to reduce the denominator so that the loss of the remainder will
% have minimal affect on the accuracy of the result
\divide\@NaNAtrantmpcountB by 200%
\divide\@NaNAtrantmpcountA by \@NaNAtrantmpcountB%
% Then reequalize things when we use TeX's ability to multiply by
% floating point values
\@NaNAtrantmpdimenB=0.005\@NaNAtrantmpdimenA%
\multiply\@NaNAtrantmpdimenB by \@NaNAtrantmpcountA%
% \@NaNAPARstartfont is globaly set to the calculated font of the big letter
% We need to carry this out of the local calculation area to to create the
% big letter.
\global\font\@NaNAPARstartfont\@NaNAPARstartFONTNAME\space at \@NaNAtrantmpdimenB%
% Now set \@NaNAtrantmpdimenA to the width of the big letter
% We need to carry this out of the local calculation area to set the
% hanging indent
\settowidth{\global\@NaNAtrantmpdimenA}{\@NaNAPARstartfont
\NaNAPARstartCAPSTYLE{#1\NaNAPARstartITLCORRECT}}}%
% end of the isolated calculation environment
\global\NaNAPARstartletwidth\@NaNAtrantmpdimenA\relax%
% add in the extra clearance we want
\advance\@NaNAtrantmpdimenA by \NaNAPARstartSEP\relax%
% add in the optional offset
\advance\@NaNAtrantmpdimenA by \NaNAPARstartHOFFSET\relax%
% V1.7 don't allow negative offsets to produce negative hanging indents
\@NaNAtrantmpdimenB\@NaNAtrantmpdimenA
\ifnum\@NaNAtrantmpdimenB < 0 \@NaNAtrantmpdimenB 0pt\fi
% \@NaNAtrantmpdimenA has the width of the big letter plus the
% separation space and \@NaNAPARstartfont is the font we need to use
% Now, we make the letter and issue the hanging indent command
% The letter is placed in a box of zero width and height so that other
% text won't be displaced by it.
\hangindent\@NaNAtrantmpdimenB\hangafter=-\NaNAPARstartDROPLINES%
\makebox[0pt][l]{\hspace{-\@NaNAtrantmpdimenA}%
\raisebox{-\NaNAPARstartDROPDEPTH}[0pt][0pt]{\hspace{\NaNAPARstartHOFFSET}%
\@NaNAPARstartfont\NaNAPARstartCAPSTYLE{#1\NaNAPARstartITLCORRECT}%
\hspace{\NaNAPARstartSEP}}}%
{\NaNAPARstartWORDFONTSTYLE{\NaNAPARstartWORDCAPSTYLE{\selectfont#2}}}}




% determines if the space remaining on a given page is equal to or greater
% than the specified space of argument one
% if not, execute argument two (only if the remaining space is greater than zero)
% and issue a \newpage
% 
% example: \@NaNAtranneedspace{2in}{\vfill}
% 
% Does not take into consideration rubber shrinkage, so it tends to
% be overly cautious
% Based on an example posted by Donald Arseneau
% Note this macro uses \@NaNAtrantmpdimenB internally for calculations,
% so DO NOT PASS \@NaNAtrantmpdimenB to this routine
% if you need a dimen register, import with \@NaNAtrantmpdimenA instead
\def\@NaNAtranneedspace#1#2{\penalty-100\begingroup%shield temp variable
\@NaNAtrantmpdimenB\pagegoal\advance\@NaNAtrantmpdimenB-\pagetotal% space left
\ifdim #1>\@NaNAtrantmpdimenB\relax% not enough space left
\ifdim\@NaNAtrantmpdimenB>\z@\relax #2\fi%
\newpage%
\fi\endgroup}



% NaNAbiography ENVIRONMENT
% Allows user to enter biography leaving place for picture (adapts to font size)
% As of V1.5, a new optional argument allows you to have a real graphic!
% V1.5 and later also fixes the "colliding biographies" which could happen when a 
% biography's text was shorter than the space for the photo.
% MDS 7/2001
% V1.6 prevent multiple biographies from making multiple TOC entries
\newif\if@NaNAbiographyTOCentrynotmade
\global\@NaNAbiographyTOCentrynotmadetrue

% biography counter so hyperref can jump directly to the biographies
% and not just the previous section
\newcounter{NaNAbiography}
\setcounter{NaNAbiography}{0}

% photo area size
\def\@NaNABIOphotowidth{1.0in}    % width of the biography photo area
\def\@NaNABIOphotodepth{1.25in}   % depth (height) of the biography photo area
% area cleared for photo
\def\@NaNABIOhangwidth{1.14in}    % width cleared for the biography photo area
\def\@NaNABIOhangdepth{1.25in}    % depth cleared for the biography photo area
                                  % actual depth will be a multiple of 
                                  % \baselineskip, rounded up
\def\@NaNABIOskipN{4\baselineskip}% nominal value of the vskip above the biography

\newenvironment{NaNAbiography}[2][]{\normalfont\@NaNAcompsoconly{\sffamily}\footnotesize%
\unitlength 1in\parskip=0pt\par\parindent 1em\interlinepenalty500%
% we need enough space to support the hanging indent
% the nominal value of the spacer
% and one extra line for good measure
\@NaNAtrantmpdimenA=\@NaNABIOhangdepth%
\advance\@NaNAtrantmpdimenA by \@NaNABIOskipN%
\advance\@NaNAtrantmpdimenA by 1\baselineskip%
% if this page does not have enough space, break it and lets start
% with a new one
\@NaNAtranneedspace{\@NaNAtrantmpdimenA}{\relax}%
% nominal spacer can strech, not shrink use 1fil so user can out stretch with \vfill
\vskip \@NaNABIOskipN plus 1fil minus 0\baselineskip%
% the default box for where the photo goes
\def\@NaNAtempbiographybox{{\setlength{\fboxsep}{0pt}\framebox{%
\begin{minipage}[b][\@NaNABIOphotodepth][c]{\@NaNABIOphotowidth}\centering PLACE\\ PHOTO\\ HERE \end{minipage}}}}%
%
% detect if the optional argument was supplied, this requires the
% \@ifmtarg command as defined in the appendix section above
% and if so, override the default box with what they want
\@ifmtarg{#1}{\relax}{\def\@NaNAtempbiographybox{\mbox{\begin{minipage}[b][\@NaNABIOphotodepth][c]{\@NaNABIOphotowidth}%
\centering%
#1%
\end{minipage}}}}% end if optional argument supplied
% Make an entry into the table of contents only if we have not done so before
\if@NaNAbiographyTOCentrynotmade%
% link labels to the biography counter so hyperref will jump
% to the biography, not the previous section
\setcounter{NaNAbiography}{-1}%
\refstepcounter{NaNAbiography}%
\addcontentsline{toc}{section}{Biographies}%
\global\@NaNAbiographyTOCentrynotmadefalse%
\fi%
% one more biography
\refstepcounter{NaNAbiography}%
% Make an entry for this name into the table of contents 
\addcontentsline{toc}{subsection}{#2}%
% V1.6 properly handle if a new paragraph should occur while the
% hanging indent is still active. Do this by redefining \par so
% that it will not start a new paragraph. (But it will appear to the
% user as if it did.) Also, strip any leading pars, newlines, or spaces.
\let\@NaNABIOORGparCMD=\par% save the original \par command
\edef\par{\hfil\break\indent}% the new \par will not be a "real" \par
\settoheight{\@NaNAtrantmpdimenA}{\@NaNAtempbiographybox}% get height of biography box
\@NaNAtrantmpdimenB=\@NaNABIOhangdepth%
\@NaNAtrantmpcountA=\@NaNAtrantmpdimenB% countA has the hang depth
\divide\@NaNAtrantmpcountA by \baselineskip%  calculates lines needed to produce the hang depth
\advance\@NaNAtrantmpcountA by 1% ensure we overestimate
% set the hanging indent
\hangindent\@NaNABIOhangwidth%
\hangafter-\@NaNAtrantmpcountA%
% reference the top of the photo area to the top of a capital T
\settoheight{\@NaNAtrantmpdimenB}{\mbox{T}}%
% set the photo box, give it zero width and height so as not to disturb anything
\noindent\makebox[0pt][l]{\hspace{-\@NaNABIOhangwidth}\raisebox{\@NaNAtrantmpdimenB}[0pt][0pt]{%
\raisebox{-\@NaNABIOphotodepth}[0pt][0pt]{\@NaNAtempbiographybox}}}%
% now place the author name and begin the bio text
\noindent\textbf{#2\ }\@NaNAgobbleleadPARNLSP}{\relax\let\par=\@NaNABIOORGparCMD\par%
% 7/2001 V1.5 detect when the biography text is shorter than the photo area
% and pad the unused area - preventing a collision from the next biography entry
% MDS
\ifnum \prevgraf <\@NaNAtrantmpcountA\relax% detect when the biography text is shorter than the photo
    \advance\@NaNAtrantmpcountA by -\prevgraf% calculate how many lines we need to pad
    \advance\@NaNAtrantmpcountA by -1\relax% we compensate for the fact that we indented an extra line
    \@NaNAtrantmpdimenA=\baselineskip% calculate the length of the padding
    \multiply\@NaNAtrantmpdimenA by \@NaNAtrantmpcountA%
    \noindent\rule{0pt}{\@NaNAtrantmpdimenA}% insert an invisible support strut
\fi%
\par\normalfont}



% V1.6
% added biography without a photo environment
\newenvironment{NaNAbiographynophoto}[1]{%
% Make an entry into the table of contents only if we have not done so before
\if@NaNAbiographyTOCentrynotmade%
% link labels to the biography counter so hyperref will jump
% to the biography, not the previous section
\setcounter{NaNAbiography}{-1}%
\refstepcounter{NaNAbiography}%
\addcontentsline{toc}{section}{Biographies}%
\global\@NaNAbiographyTOCentrynotmadefalse%
\fi%
% one more biography
\refstepcounter{NaNAbiography}%
% Make an entry for this name into the table of contents 
\addcontentsline{toc}{subsection}{#1}%
\normalfont\@NaNAcompsoconly{\sffamily}\footnotesize\interlinepenalty500%
\vskip 4\baselineskip plus 1fil minus 0\baselineskip%
\parskip=0pt\par%
\noindent\textbf{#1\ }\@NaNAgobbleleadPARNLSP}{\relax\par\normalfont}


% provide the user with some old font commands
% got this from article.cls
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}


% SPECIAL PAPER NOTICE COMMANDS
% 
% holds the special notice text
\def\@NaNAspecialpapernotice{\relax}
 
% for special papers, like invited papers, the user can do:
% \NaNAspecialpapernotice{(Invited Paper)} before \maketitle
\def\NaNAspecialpapernotice#1{\ifCLASSOPTIONconference%
\def\@NaNAspecialpapernotice{{\sublargesize\textit{#1}\vspace*{1em}}}%
\else%
\def\@NaNAspecialpapernotice{{\\*[1.5ex]\sublargesize\textit{#1}}\vspace*{-2ex}}%
\fi}




% PUBLISHER ID COMMANDS
% to insert a publisher's ID footer

\def\@NaNApubidpullup{1.3\baselineskip}
\ifCLASSOPTIONtechnote
% for technotes it must be an integer of baselineskip as there can be no
% dynamic title spacing for two column mode technotes (the title is in the
% in first column) and we should maintain an integer number of lines in the
% second column
% There are some examples (such as older issues of "Transactions on
% Information Theory") in which the NaNA really pulls the text off the ID for
% technotes - about 0.55in (or 4\baselineskip). We'll use 2\baselineskip
% and call it even.
\def\@NaNApubidpullup{2\baselineskip}
\fi

% V1.7 compsoc does not use a pullup
\ifCLASSOPTIONcompsoc
\def\@NaNApubidpullup{0pt}
\fi

% holds the ID text
\def\@NaNApubid{\relax}

% flag so \maketitle can tell if \NaNApubid was called
\newif\if@NaNAusingpubid
\global\@NaNAusingpubidfalse
% issue this command in the page to have the ID at the bottom
% V1.6 use before \maketitle
\def\NaNApubid#1{\def\@NaNApubid{#1}\global\@NaNAusingpubidtrue}


% command which will pull up (shorten) the column it is executed in
% to make room for the publisher ID. Place in the second column of
% the title page when using \NaNApubid
% Is smart enough not to do anything when in single column text or
% if the user hasn't called \NaNApubid
% currently needed in for the second column of a page with the
% publisher ID. If not needed in future releases, please provide this
% command and define it as \relax for backward compatibility
% v1.6b do not allow command to operate if the peer review option has been 
% selected because \NaNApubidadjcol will not be on the cover page.
% V1.7 do nothing if compsoc
\def\NaNApubidadjcol{\ifCLASSOPTIONcompsoc\else\ifCLASSOPTIONpeerreview\else
\if@twocolumn\if@NaNAusingpubid\enlargethispage{-\@NaNApubidpullup}\fi\fi\fi\fi}

% Special thanks to Peter Wilson, Daniel Luecking, and the other
% gurus at comp.text.tex, for helping me to understand how best to
% implement the NaNApubid command in LaTeX.



%% Lockout some commands under various conditions

% general purpose bit bucket
\newsavebox{\@NaNAtranrubishbin}

% flags to prevent multiple warning messages
\newif\if@NaNAWARNthanks
\newif\if@NaNAWARNNaNAPARstart
\newif\if@NaNAWARNNaNAbiography
\newif\if@NaNAWARNNaNAbiographynophoto
\newif\if@NaNAWARNNaNApubid
\newif\if@NaNAWARNNaNApubidadjcol
\newif\if@NaNAWARNNaNAmembership
\newif\if@NaNAWARNNaNAaftertitletext
\@NaNAWARNthankstrue
\@NaNAWARNNaNAPARstarttrue
\@NaNAWARNNaNAbiographytrue
\@NaNAWARNNaNAbiographynophototrue
\@NaNAWARNNaNApubidtrue
\@NaNAWARNNaNApubidadjcoltrue
\@NaNAWARNNaNAmembershiptrue
\@NaNAWARNNaNAaftertitletexttrue


%% Lockout some commands when in various modes, but allow them to be restored if needed
%%
% save commands which might be locked out
% so that the user can later restore them if needed
\let\@NaNASAVECMDthanks\thanks
\let\@NaNASAVECMDNaNAPARstart\NaNAPARstart
\let\@NaNASAVECMDNaNAbiography\NaNAbiography
\let\@NaNASAVECMDendNaNAbiography\endNaNAbiography
\let\@NaNASAVECMDNaNAbiographynophoto\NaNAbiographynophoto
\let\@NaNASAVECMDendNaNAbiographynophoto\endNaNAbiographynophoto
\let\@NaNASAVECMDNaNApubid\NaNApubid
\let\@NaNASAVECMDNaNApubidadjcol\NaNApubidadjcol
\let\@NaNASAVECMDNaNAmembership\NaNAmembership
\let\@NaNASAVECMDNaNAaftertitletext\NaNAaftertitletext


% disable \NaNAPARstart when in draft mode
% This may have originally been done because the pre-V1.6 drop letter
% algorithm had problems with a non-unity baselinestretch
% At any rate, it seems too formal to have a drop letter in a draft
% paper.
\ifCLASSOPTIONdraftcls
\def\NaNAPARstart#1#2{#1#2\if@NaNAWARNNaNAPARstart\typeout{** ATTENTION: \noexpand\NaNAPARstart
 is disabled in draft mode (line \the\inputlineno).}\fi\global\@NaNAWARNNaNAPARstartfalse}
\fi
% and for technotes
\ifCLASSOPTIONtechnote
\def\NaNAPARstart#1#2{#1#2\if@NaNAWARNNaNAPARstart\typeout{** WARNING: \noexpand\NaNAPARstart
 is locked out for technotes (line \the\inputlineno).}\fi\global\@NaNAWARNNaNAPARstartfalse}
\fi


% lockout unneeded commands when in conference mode
\ifCLASSOPTIONconference
% when locked out, \thanks, \NaNAbiography, \NaNAbiographynophoto, \NaNApubid,
% \NaNAmembership and \NaNAaftertitletext will all swallow their given text. 
% \NaNAPARstart will output a normal character instead
% warn the user about these commands only once to prevent the console screen
% from filling up with redundant messages
\def\thanks#1{\if@NaNAWARNthanks\typeout{** WARNING: \noexpand\thanks
 is locked out when in conference mode (line \the\inputlineno).}\fi\global\@NaNAWARNthanksfalse}
\def\NaNAPARstart#1#2{#1#2\if@NaNAWARNNaNAPARstart\typeout{** WARNING: \noexpand\NaNAPARstart
 is locked out when in conference mode (line \the\inputlineno).}\fi\global\@NaNAWARNNaNAPARstartfalse}


% LaTeX treats environments and commands with optional arguments differently.
% the actual ("internal") command is stored as \\commandname 
% (accessed via \csname\string\commandname\endcsname )
% the "external" command \commandname is a macro with code to determine
% whether or not the optional argument is presented and to provide the 
% default if it is absent. So, in order to save and restore such a command
% we would have to save and restore \\commandname as well. But, if LaTeX
% ever changes the way it names the internal names, the trick would break.
% Instead let us just define a new environment so that the internal
% name can be left undisturbed.
\newenvironment{@NaNAbogusbiography}[2][]{\if@NaNAWARNNaNAbiography\typeout{** WARNING: \noexpand\NaNAbiography
 is locked out when in conference mode (line \the\inputlineno).}\fi\global\@NaNAWARNNaNAbiographyfalse%
\setbox\@NaNAtranrubishbin\vbox\bgroup}{\egroup\relax}
% and make biography point to our bogus biography
\let\NaNAbiography=\@NaNAbogusbiography
\let\endNaNAbiography=\end@NaNAbogusbiography

\renewenvironment{NaNAbiographynophoto}[1]{\if@NaNAWARNNaNAbiographynophoto\typeout{** WARNING: \noexpand\NaNAbiographynophoto
 is locked out when in conference mode (line \the\inputlineno).}\fi\global\@NaNAWARNNaNAbiographynophotofalse%
\setbox\@NaNAtranrubishbin\vbox\bgroup}{\egroup\relax}

\def\NaNApubid#1{\if@NaNAWARNNaNApubid\typeout{** WARNING: \noexpand\NaNApubid 
 is locked out when in conference mode (line \the\inputlineno).}\fi\global\@NaNAWARNNaNApubidfalse}
\def\NaNApubidadjcol{\if@NaNAWARNNaNApubidadjcol\typeout{** WARNING: \noexpand\NaNApubidadjcol
 is locked out when in conference mode (line \the\inputlineno).}\fi\global\@NaNAWARNNaNApubidadjcolfalse}
\def\NaNAmembership#1{\if@NaNAWARNNaNAmembership\typeout{** WARNING: \noexpand\NaNAmembership
 is locked out when in conference mode (line \the\inputlineno).}\fi\global\@NaNAWARNNaNAmembershipfalse}
\def\NaNAaftertitletext#1{\if@NaNAWARNNaNAaftertitletext\typeout{** WARNING: \noexpand\NaNAaftertitletext
 is locked out when in conference mode (line \the\inputlineno).}\fi\global\@NaNAWARNNaNAaftertitletextfalse}
\fi


% provide a way to restore the commands that are locked out
\def\NaNAoverridecommandlockouts{%
\typeout{** ATTENTION: Overriding command lockouts (line \the\inputlineno).}%
\let\thanks\@NaNASAVECMDthanks%
\let\NaNAPARstart\@NaNASAVECMDNaNAPARstart%
\let\NaNAbiography\@NaNASAVECMDNaNAbiography%
\let\endNaNAbiography\@NaNASAVECMDendNaNAbiography%
\let\NaNAbiographynophoto\@NaNASAVECMDNaNAbiographynophoto%
\let\endNaNAbiographynophoto\@NaNASAVECMDendNaNAbiographynophoto%
\let\NaNApubid\@NaNASAVECMDNaNApubid%
\let\NaNApubidadjcol\@NaNASAVECMDNaNApubidadjcol%
\let\NaNAmembership\@NaNASAVECMDNaNAmembership%
\let\NaNAaftertitletext\@NaNASAVECMDNaNAaftertitletext}



% need a backslash character for typeout output
{\catcode`\|=0 \catcode`\\=12
|xdef|@NaNAbackslash{\}}


% hook to allow easy disabling of all legacy warnings
\def\@NaNAlegacywarn#1#2{\typeout{** ATTENTION: \@NaNAbackslash #1 is deprecated (line \the\inputlineno).
Use \@NaNAbackslash #2 instead.}}


% provide some legacy NaNAtran commands
\def\NaNAcompsoctitleabstractindextext{\@NaNAlegacywarn{NaNAcompsoctitleabstractindextext}{NaNAtitleabstractindextext}\NaNAtitleabstractindextext}
\def\NaNAdisplaynotcompsoctitleabstractindextext{\@NaNAlegacywarn{NaNAdisplaynotcompsoctitleabstractindextext}{NaNAdisplaynontitleabstractindextext}\NaNAdisplaynontitleabstractindextext}



\endinput

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% End of J-NaNA.cls  %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% That's all folks!


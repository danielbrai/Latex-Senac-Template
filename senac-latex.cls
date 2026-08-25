%% senac-latex.cls
%% Classe para Projeto Integrador do Senac, baseada no abntex2.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{senac-latex}[2026/08/24 v0.5 Classe para Projetos Integradores do Senac baseada no abntex2]

%% -------------------------------------------------------------
%% OPÇÕES DA CLASSE
%% -------------------------------------------------------------
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{abntex2}%
}
\ProcessOptions\relax

%% -------------------------------------------------------------
%% CLASSE BASE
%% -------------------------------------------------------------
\LoadClass[12pt]{abntex2}

%% -------------------------------------------------------------
%% CORREÇÃO DO HYPERREF
%% -------------------------------------------------------------
\hypersetup{
  plainpages=false,
  pdfpagelabels=true
}

%% -------------------------------------------------------------
%% PACOTES NECESSÁRIOS
%% -------------------------------------------------------------
\RequirePackage{ifthen}
\RequirePackage{xstring}

%% ===============================================================
%% (a) NOME DA INSTITUIÇÃO
%% ===============================================================
\newcommand{\senac@unidade}{}
\newcommand{\senac@nomeinstituicao}{}

\newcommand{\senac@campiCU}{Santo Amaro,Campos do Jordão,Águas de São Pedro}

\newcommand{\unidade}[1]{%
  \IfStrEq{#1}{EAD}{%
    \renewcommand{\senac@nomeinstituicao}{SENAC}%
    \renewcommand{\senac@unidade}{}%
  }{%
    \renewcommand{\senac@unidade}{#1}%
    \IfSubStr{,\senac@campiCU,}{,#1,}{%
      \renewcommand{\senac@nomeinstituicao}{CENTRO UNIVERSITÁRIO SENAC}%
    }{%
      \renewcommand{\senac@nomeinstituicao}{SENAC}%
    }%
  }%
}

\newcommand{\instituicaosenac}[1]{\renewcommand{\senac@nomeinstituicao}{#1}}

%% ===============================================================
%% (b) NOME DO(S) AUTOR(ES)
%% ===============================================================
\newcommand{\senac@autores}{}
\newcommand{\autores}[1]{%
  \renewcommand{\senac@autores}{#1}%
  \renewcommand{\imprimirautor}{#1}%
}

%% ===============================================================
%% (c) TÍTULO / (d) SUBTÍTULO
%% ===============================================================
\newcommand{\senac@titulo}{}
\newcommand{\senac@subtitulo}{}
\renewcommand{\titulo}[1]{%
  \renewcommand{\senac@titulo}{#1}%
  \renewcommand{\imprimirtitulo}{#1}%
}
\newcommand{\subtitulo}[1]{\renewcommand{\senac@subtitulo}{#1}}

%% ===============================================================
%% (e) LOCAL / (f) ANO
%% ===============================================================
\newcommand{\senac@local}{}
\renewcommand{\local}[1]{%
  \renewcommand{\senac@local}{#1}%
  \renewcommand{\imprimirlocal}{#1}%
}

\newcommand{\senac@data}{}
\renewcommand{\data}[1]{%
  \renewcommand{\senac@data}{#1}%
  \renewcommand{\imprimirdata}{#1}%
}

%% ===============================================================
%% MONTAGEM DA CAPA
%% ===============================================================
\renewcommand{\imprimircapa}{%
  \begin{capa}
    \hypersetup{pageanchor=false}%
    \thispagestyle{empty}%

    % (a) Instituição - No topo (respeita margem de 3cm da ABNT)
    \begin{center}
      \ifthenelse{\equal{\senac@nomeinstituicao}{}}{}{%
        {\large\bfseries \senac@nomeinstituicao}\par
        \ifthenelse{\equal{\senac@unidade}{}}{}{{\large\bfseries \senac@unidade}\par}%
      }%
    \end{center}

    \vspace{1.5cm}

    % (b) Autor(es) - A partir do meio da página para a direita
    \noindent\hspace*{0.5\textwidth}%
    \parbox{0.5\textwidth}{%
      \raggedright\large \senac@autores
    }\par

    % 1/3 do espaço restante
    \vspace{\stretch{1}}\par

    % (c) Título e (d) Subtítulo
    \begin{center}
      {\Large \senac@titulo}\par
      \ifthenelse{\equal{\senac@subtitulo}{}}{}{%
        \vspace{12pt}%
        {\large \senac@subtitulo}\par
      }%
    \end{center}\par

    % 2/3 do espaço restante
    \vspace{\stretch{2}}\par

    % (e) Local e (f) Ano - Na base (respeita margem de 2cm da ABNT)
    \begin{center}
      {\large \senac@local}\par
      {\large \senac@data}\par
    \end{center}

    \newpage
    \hypersetup{pageanchor=true}%
  \end{capa}
}

\endinput
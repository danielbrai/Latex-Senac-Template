%% senac-latex.cls
%% Classe LaTeX para Trabalhos Acadêmicos e Projetos Integradores do Senac
%% Desenvolvida sobre a base do abnTeX2 (memoir)
%% ------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{senac-latex}[2026/08/25 v1.4 Classe para Projetos Integradores do Senac baseada no abntex2]

%% ------------------------------------------------------------------------
%% (1) OPÇÕES E CARREGAMENTO DA CLASSE BASE
%% ------------------------------------------------------------------------

% Repassa opções não mapeadas para o abntex2
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{abntex2}%
}
\ProcessOptions\relax

% Silencia warnings específicos de depreciação
\RequirePackage{silence}
\WarningFilter{babel}{Name 'brazil' is deprecated}
\WarningFilter{memoir}{\settocpreprocessor is marked deprecated}

% Idioma
\PassOptionsToPackage{brazilian}{babel}

% O sumário será configurado pela própria classe.
% O modo "tradicional" evita que o abnTeX2 reescreva os recuos
% do sumário através de comandos inseridos no arquivo .toc.
\LoadClass[
  12pt,
  openright,
  oneside,
  a4paper,
  brazilian,
  sumario=tradicional
]{abntex2}

%% ------------------------------------------------------------------------
%% (2) PACOTES NECESSÁRIOS
%% ------------------------------------------------------------------------

\RequirePackage{fontspec}  % XeLaTeX / LuaLaTeX
\RequirePackage{ifthen}    % Estruturas condicionais
\RequirePackage{xstring}   % Manipulação de strings
\RequirePackage{ragged2e}  % Justificação avançada de blocos de texto

%% ------------------------------------------------------------------------
%% CITAÇÕES E BIBLIOGRAFIA
%% ------------------------------------------------------------------------

\RequirePackage[
  alf,
  abnt-emphasize=bf
]{abntex2cite}

%% ------------------------------------------------------------------------
%% CONFIGURAÇÃO TIPOGRÁFICA DO TRABALHO
%% ------------------------------------------------------------------------

% Corpo do trabalho: 12 pt (a classe-base já é carregada com a opção 12pt).
% Os elementos que a ABNT define como "tamanho menor e uniforme" continuam
% usando \ABNTEXfontereduzida (footnotesize), incluindo notas de rodapé,
% paginação, citações longas, legendas/fontes de ilustrações e ficha
% catalográfica.

% Capítulos: 12 pt, negrito e letras maiúsculas.
\renewcommand{\ABNTEXchapterfont}{\sffamily\bfseries}
\renewcommand{\ABNTEXchapterfontsize}{\normalsize}
\setboolean{ABNTEXupperchapter}{true}

% Seções e subseções: 12 pt, negrito, sem conversão automática para
% maiúsculas. A capitalização fica conforme o texto informado pelo autor
% (ex.: "Estruturação do trabalho").
\renewcommand{\ABNTEXsectionfont}{\sffamily\bfseries}
\renewcommand{\ABNTEXsectionfontsize}{\normalsize}
\renewcommand{\ABNTEXsubsectionfont}{\sffamily}
\renewcommand{\ABNTEXsubsectionfontsize}{\normalsize}
\renewcommand{\ABNTEXsubsubsectionfont}{\sffamily}
\renewcommand{\ABNTEXsubsubsectionfontsize}{\normalsize}
\setboolean{ABNTEXuppersection}{false}
\setboolean{ABNTEXuppersubsection}{false}
\setboolean{ABNTEXuppersubsubsection}{false}

%% ------------------------------------------------------------------------
%% (3) INTERFACE DE DADOS
%% ------------------------------------------------------------------------

% --- (a) Instituição e Unidade ---

\newcommand{\senac@unidade}{}
\newcommand{\senac@nomeinstituicao}{CENTRO UNIVERSITÁRIO SENAC}

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

\newcommand{\instituicaosenac}[1]{%
  \renewcommand{\senac@nomeinstituicao}{#1}%
}

% --- (b) Autor(es) ---

\newcommand{\autores}[1]{%
  \autor{#1}%
}

% --- (c) Título e Subtítulo ---

\newcommand{\senac@subtitulo}{}

\newcommand{\subtitulo}[1]{%
  \renewcommand{\senac@subtitulo}{#1}%
}

% --- (d) Tipo de Trabalho / Preâmbulo ---

\renewcommand{\preambulo}[1]{%
  \def\imprimirpreambulo{#1}%
}

\renewcommand{\tipotrabalho}[1]{%
  \preambulo{#1}%
}

%% ------------------------------------------------------------------------
%% (4) CAPA
%% ------------------------------------------------------------------------

\renewcommand{\imprimircapa}{%
  \begin{capa}
    \hypersetup{pageanchor=false}%
    \thispagestyle{empty}%

    % Instituição
    \begin{center}
      \ifthenelse{\equal{\senac@nomeinstituicao}{}}{}{%
        {\normalsize\bfseries \senac@nomeinstituicao\par}%
        \ifthenelse{\equal{\senac@unidade}{}}{}{%
          {\normalsize\bfseries UNIDADE \senac@unidade\par}%
        }%
      }%
    \end{center}

    \vspace{1.5cm}

    % Autor(es)
    \noindent
    \hspace*{0.5\textwidth}%
    \parbox{0.5\textwidth}{%
      \raggedright
      \imprimirautor
    }\par

    \vspace{\stretch{1}}

    % Título e subtítulo
    \begin{center}
      {\ABNTEXchapterfont\normalsize\bfseries \imprimirtitulo\par}
      \ifthenelse{\equal{\senac@subtitulo}{}}{}{%
        \vspace{12pt}%
        {\ABNTEXchapterfont\normalsize \senac@subtitulo\par}%
      }%
    \end{center}

    \vspace{\stretch{2}}

    % Local e ano
    \begin{center}
      {\normalsize \imprimirlocal\par}
      {\normalsize \imprimirdata\par}
    \end{center}

    \clearpage
    \hypersetup{pageanchor=true}%
  \end{capa}
}

%% ------------------------------------------------------------------------
%% (5) FOLHA DE ROSTO
%% ------------------------------------------------------------------------

\newcommand{\imprimirfolhaderostosenac}{%
  \clearpage
  \hypersetup{pageanchor=false}%
  \thispagestyle{empty}%

  \begin{center}

    % Autor(es)
    {\imprimirautor\par}

    \vfill

    % Título e subtítulo
    {\ABNTEXchapterfont\normalsize\bfseries \imprimirtitulo\par}
    \ifthenelse{\equal{\senac@subtitulo}{}}{}{%
      \vspace{12pt}%
      {\ABNTEXchapterfont\normalsize \senac@subtitulo\par}%
    }%

    \vfill

    % Natureza do trabalho e orientadores
    \abntex@ifnotempty{\imprimirpreambulo}{%
      \noindent
      \hspace*{0.4\textwidth}%
      \begin{minipage}{0.5\textwidth}
        \begin{justify}
          \SingleSpacing
          \normalsize
          \imprimirpreambulo\par
        \end{justify}

        \ifthenelse{\equal{\imprimirorientador}{}}{}{%
          \vspace{0.5cm}%
          {\normalsize
            \imprimirorientadorRotulo~\imprimirorientador
          \par}%
        }%

        \ifthenelse{\equal{\imprimircoorientador}{}}{}{%
          \vspace{0.2cm}%
          {\normalsize
            \imprimircoorientadorRotulo~\imprimircoorientador
          \par}%
        }%
      \end{minipage}\par
    }%

    \vfill

    % Local e ano
    {\normalsize \imprimirlocal\par}
    {\normalsize \imprimirdata\par}

  \end{center}

  \clearpage
  \hypersetup{pageanchor=true}%
}

% Sobrescreve o comando padrão do abnTeX2
\renewcommand{\imprimirfolhaderosto}[1][]{%
  \imprimirfolhaderostosenac
}

%% ------------------------------------------------------------------------
%% (6) CONFIGURAÇÃO DO SUMÁRIO
%% ------------------------------------------------------------------------
%
% O abnTeX2 é baseado no memoir e, no modo tradicional, permite controlar
% diretamente a indentação e a largura reservada para a numeração.
%
% O objetivo aqui é reproduzir o padrão visual observado no manual do Senac:
%
%   1 INTRODUÇÃO.................................13
%     1.1 Revisão de Literatura..................20
%     1.2 Justificativa de pesquisa..............24
%       1.2.1 Exemplo............................25
%
% A largura numérica deve ser pequena, e o título deve começar logo após
% a numeração.

\makeatletter

% -------------------------------------------------------------------------
% Capítulos
% -------------------------------------------------------------------------

\cftsetindents{chapter}{0em}{1.6em}

\renewcommand{\cftchapterpresnum}{}
\renewcommand{\cftchapteraftersnum}{}
\renewcommand{\cftchapteraftersnumb}{\hspace{0.25em}}

% Número de capítulo sem a caixa rígida do memoir.
% O segundo argumento contém a parte já composta da entrada.
\renewcommand{\chapternumberlinebox}[2]{#2}

\renewcommand{\cftchapterfont}{\normalfont}
\renewcommand{\cftchapterleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftchapterpagefont}{\normalfont}

% No sumário, os títulos dos capítulos são apresentados em MAIÚSCULAS,
% mas sem negrito. A conversão é feita apenas na entrada do .toc,
% preservando a formatação do título no corpo do capítulo.
\settocpreprocessor{chapter}{%
  \let\senac@tocchaptertitle\f@rtoc%
  \def\f@rtoc{%
    \texorpdfstring{\MakeTextUppercase{\senac@tocchaptertitle}}{\senac@tocchaptertitle}%
  }%
}

% -------------------------------------------------------------------------
% Seções
% -------------------------------------------------------------------------

\cftsetindents{section}{0.45cm}{2.2em}

\renewcommand{\cftsectionpresnum}{}
\renewcommand{\cftsectionaftersnum}{}
\renewcommand{\cftsectionaftersnumb}{\hspace{0.25em}}

\renewcommand{\cftsectionfont}{\normalfont}
\renewcommand{\cftsectionpagefont}{\normalfont}

% -------------------------------------------------------------------------
% Subseções
% -------------------------------------------------------------------------

\cftsetindents{subsection}{0.90cm}{3.0em}

\renewcommand{\cftsubsectionpresnum}{}
\renewcommand{\cftsubsectionaftersnum}{}
\renewcommand{\cftsubsectionaftersnumb}{\hspace{0.25em}}

\renewcommand{\cftsubsectionfont}{\normalfont}
\renewcommand{\cftsubsectionpagefont}{\normalfont}

% -------------------------------------------------------------------------
% Subsubseções
% -------------------------------------------------------------------------

\cftsetindents{subsubsection}{1.35cm}{3.8em}

\renewcommand{\cftsubsubsectionpresnum}{}
\renewcommand{\cftsubsubsectionaftersnum}{}
\renewcommand{\cftsubsubsectionaftersnumb}{\hspace{0.25em}}

\renewcommand{\cftsubsubsectionfont}{\normalfont}
\renewcommand{\cftsubsubsectionpagefont}{\normalfont}

% -------------------------------------------------------------------------
% Numeração progressiva e profundidade do sumário
% -------------------------------------------------------------------------

% A numeração progressiva é limitada à seção quinária.
% No LaTeX, os níveis são:
%   capítulo       = 0
%   seção          = 1
%   subseção       = 2
%   subsubseção    = 3
%   seção quinária = 4 (\paragraph)
%
% Assim, \subparagraph (nível 5) e níveis posteriores permanecem
% sem numeração.
\setcounter{secnumdepth}{4}

% O sumário acompanha a mesma profundidade: até a seção quinária.
\settocdepth{paragraph}

% A seção quinária utiliza a mesma apresentação não-negritada das
% entradas de seções no sumário.
\cftsetindents{paragraph}{1.80cm}{4.6em}
\renewcommand{\cftparagraphpresnum}{}
\renewcommand{\cftparagraphaftersnum}{}
\renewcommand{\cftparagraphaftersnumb}{\hspace{0.25em}}
\renewcommand{\cftparagraphfont}{\normalfont}
\renewcommand{\cftparagraphpagefont}{\normalfont}

\makeatother

%% ------------------------------------------------------------------------
%% (7) FIM DA CLASSE
%% ------------------------------------------------------------------------

\endinput

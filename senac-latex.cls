%% senac-latex.cls
%% Classe LaTeX para Trabalhos Acadêmicos e Projetos Integradores do Senac
%% Desenvolvida sobre a base do abnTeX2 (memoir)
%% ------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{senac-latex}[2026/08/25 v1.0 Classe para Projetos Integradores do Senac baseada no abntex2]

%% ------------------------------------------------------------------------
%% (1) OPÇÕES E CARREGAMENTO DA CLASSE BASE
%% ------------------------------------------------------------------------
% Repassa opções não mapeadas para o abntex2
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{abntex2}%
}
\ProcessOptions\relax

% Carrega a classe abntex2 com padrões ABNT (A4, 12pt, apenas frente por padrão)
\LoadClass[12pt, openright, oneside, a4paper, english, brazilian]{abntex2}

%% ------------------------------------------------------------------------
%% (2) PACOTES NECESSÁRIOS
%% ------------------------------------------------------------------------
\RequirePackage{fontspec}  % Suporte a fontes nativas no XeLaTeX / LuaLaTeX
\RequirePackage{ifthen}    % Estruturas condicionais
\RequirePackage{xstring}   % Manipulação avançada de strings
\RequirePackage{ragged2e}

%% ------------------------------------------------------------------------
%% (3) MAPEAMENTO DE COMANDOS E INTERFACE DE DADOS
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

\newcommand{\instituicaosenac}[1]{\renewcommand{\senac@nomeinstituicao}{#1}}

% --- (b) Autor(es) ---
% Permite o uso de \autores{...} no plural, apontando para \autor do abntex2
\newcommand{\autores}[1]{\autor{#1}}

% --- (c) Título e Subtítulo ---
\newcommand{\senac@subtitulo}{}
\newcommand{\subtitulo}[1]{\renewcommand{\senac@subtitulo}{#1}}

% --- (d) Tipo de Trabalho / Preâmbulo ---
% Mantém compatibilidade com \tipotrabalho e \preambulo do abntex2
\renewcommand{\preambulo}[1]{\def\imprimirpreambulo{#1}}
\renewcommand{\tipotrabalho}[1]{\preambulo{#1}}

%% ------------------------------------------------------------------------
%% (4) MONTAGEM DA CAPA
%% ------------------------------------------------------------------------
\renewcommand{\imprimircapa}{%
  \begin{capa}%
    \hypersetup{pageanchor=false}% Desativa âncora do hyperref temporariamente
    \thispagestyle{empty}%

    \begin{center}
      % Cabeçalho: Instituição e Unidade
      \ifthenelse{\equal{\senac@nomeinstituicao}{}}{}{%
        {\ABNTEXchapterfont\large\bfseries \senac@nomeinstituicao}\par
        \ifthenelse{\equal{\senac@unidade}{}}{}{%
          \vspace{4pt}%
          {\ABNTEXchapterfont\large\bfseries UNIDADE \senac@unidade}\par
        }%
      }%

      % Autor(es) - Posição superior
      \vspace{2.5cm}
      {\ABNTEXchapterfont\large\bfseries \imprimirautor\par}

      % Espaçamento flexível para centralizar título
      \vfill

      % Título e Subtítulo
      {\ABNTEXchapterfont\Large\bfseries \imprimirtitulo\par}
      \ifthenelse{\equal{\senac@subtitulo}{}}{}{%
        \vspace{12pt}%
        {\ABNTEXchapterfont\large \senac@subtitulo}\par
      }%

      \vfill

      % Rodapé: Local e Ano
      {\large \imprimirlocal}\par
      {\large \imprimirdata}\par
    \end{center}

    \clearpage
    \hypersetup{pageanchor=true}%
  \end{capa}
}

%% ------------------------------------------------------------------------
%% (5) MONTAGEM DA FOLHA DE ROSTO
%% ------------------------------------------------------------------------
\newcommand{\imprimirfolhaderostosenac}{%
  \clearpage
  \hypersetup{pageanchor=false}%
  \thispagestyle{empty}%

  \begin{center}
    % Autor(es)
    {\imprimirautor}\par

    \vfill

    % Título e Subtítulo
    {\ABNTEXchapterfont\Large\bfseries \imprimirtitulo}\par
    \ifthenelse{\equal{\senac@subtitulo}{}}{}{%
      \vspace{12pt}%
      {\ABNTEXchapterfont\large \senac@subtitulo}\par
    }%

    \vfill

    % Bloco de Natureza do Trabalho / Preâmbulo + Orientadores (Alinhado à direita)
    \abntex@ifnotempty{\imprimirpreambulo}{%
      \noindent\hspace*{0.4\textwidth}%
      \begin{minipage}{0.4\textwidth}
        \begin{justify}
          \SingleSpacing % Espaçamento simples nativo do memoir
          \small\imprimirpreambulo\par
        \end{justify}
        \ifthenelse{\equal{\imprimirorientador}{}}{}{%
          \vspace{0.5cm}%
          {\small\imprimirorientadorRotulo~\imprimirorientador}\par
        }%
        \ifthenelse{\equal{\imprimircoorientador}{}}{}{%
          \vspace{0.2cm}%
          {\small\imprimircoorientadorRotulo~\imprimircoorientador}\par
        }%
      \end{minipage}\par
    }%

    \vfill

    % Rodapé: Local e Ano
    {\large \imprimirlocal}\par
    {\large \imprimirdata}\par
  \end{center}

  \clearpage
  \hypersetup{pageanchor=true}%
}

% Sobrescreve o comando padrão do abntex2
\renewcommand{\imprimirfolhaderosto}[1][]{\imprimirfolhaderostosenac}

\endinput
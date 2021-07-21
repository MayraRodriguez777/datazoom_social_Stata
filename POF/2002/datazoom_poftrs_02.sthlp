{smcl}
{* *! version 1.0 18 Jun 2013}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "Install command2" "ssc install command2"}{...}
{vieweralsosee "Help command2 (if installed)" "help command2"}{...}
{viewerjumpto "Syntax" "c:/ado/plus/p/datazoom_poftrs_02##syntax"}{...}
{viewerjumpto "Description" "c:/ado/plus/p/datazoom_poftrs_02##description"}{...}
{viewerjumpto "Options" "c:/ado/plus/p/datazoom_poftrs_02##options"}{...}
{viewerjumpto "Remarks" "c:/ado/plus/p/datazoom_poftrs_02##remarks"}{...}
{viewerjumpto "Examples" "c:/ado/plus/p/datazoom_poftrs_02##examples"}{...}
{title:Title}

{phang}
{bf:datazoom_poftrs_02} {hline 2}  Acesso �s bases da POF 2002-03 em formato STATA - Vers�o 1.2

{marker syntax}{...}
{title:Syntax}
{p 8 17 2}
{cmdab:datazoom_poftrs_02}
[{cmd:,}
{it:options}]

{phang}	OBS: digite 'db datazoom_pof2002' na janela de comando para utilizar o programa via caixa de di�logo

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt:{opt trs(string)}} tipos de registros {p_end}
{synopt:{opt original(string)}} caminho da pasta onde se localizam os arquivos de dados originais {p_end}
{synopt:{opt saving(string)}} caminho da pasta onde ser�o salvas as novas bases de dados {p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}

{marker description}{...}
{title:Descri��o}

{phang}
{cmd:datazoom_poftrs_02} extrai bases de dados da POF 2002-03 em formato STATA (.dta) a partir dos microdados originais, 
os quais n�o s�o disponibilizados pelo Portal (informa��es sobre como obter os arquivos originais de dados, consulte o
        site do IBGE www.ibge.gov.br). Este programa � parte do pacote POF 2002-03, que inclui {help datazoom_pofstd_02} e
		{help datazoom_pofsel_02} (todos os programas s�o independentes uns dos outros).
		
{phang} Este programa auxilia o usu�rio a ter acesso aos 14 tipos de registros existentes na POF 2002-03, sem que haja
	manipula��o de vari�veis, ou seja, apenas torna poss�vel a utiliza��o dos microdados da POF via STATA.


{marker options}{...}
{title:Op��es}
{dlgtab:Main}

{phang}
{opt trs(string)}  especifica o(s) tipo(s) de registro(s) que o usu�rio deseja obter. A vers�o 2002-03 possui 14 tipos de 
registros, numerados conforme a documenta��o do IBGE.

{phang}
{opt original(string)}  indica o caminho da pasta onde est�o localizados os arquivos de dados
        originais. Todos os 14 arquivos devem estar posicionados na mesma pasta para que o programa funcione
        adequadamente. O Portal n�o disponibiliza os dados originais.

{phang}
{opt saving(string)}  indica o caminho da pasta onde devem ser salvas as bases de dados
        produzidas pelo programa.

{marker examples}{...}
{title:Exemplo}

{phang} datazoom_poftrs_02, trs(tr1 tr6 tr12) original(c:/mydata) saving(c:/pof)

{phang} A execu��o do exemplo acima gera tr�s bases de dados, uma para cada tipo de registro especificado 
(1 - Domic�lio; 6 - Despesas de 12 meses; 12 - Rendimentos e dedu��es). As tr�s bases ser�o salvas na pasta
"c:/pof".

{phang}  OBS: Recomenda-se a execu��o do programa por meio da caixa de di�logo. Digite "db
        datazoom_pof2002" na janela de comando do STATA para iniciar.


{title:Autor}
{p}

PUC-Rio - Departamento de Economia

Email {browse "mailto:datazoom@econ.puc-rio.br":datazoom@econ.puc-rio.br}


{title:Veja tamb�m}

Pacotes relacionados:

{help datazoom_censo} (se instalado) 
{help datazoom_pnad} (se instalado)  
{help datazoom_pmenova} (se instalado)  
{help datazoom_pmeantiga} (se instalado)  
{help datazoom_pof2008} (se instalado)  
{help datazoom_pof1995} (se instalado)  
{help datazoom_ecinf} (se instalado) 


{p} Digite "net from http://www.econ.puc-rio.br/datazoom/portugues" para instalar a vers�o em portugu�s desses pacotes. 
For the english version, type "net from http://www.econ.puc-rio.br/datazoom/english".

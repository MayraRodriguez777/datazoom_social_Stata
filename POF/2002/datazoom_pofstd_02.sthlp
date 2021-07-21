{smcl}
{* *! version 1.0 20 May 2013}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "Install command2" "ssc install command2"}{...}
{vieweralsosee "Help command2 (if installed)" "help command2"}{...}
{viewerjumpto "Syntax" "datazoom_pofstd_02##syntax"}{...}
{viewerjumpto "Description" "datazoom_pofstd_02##description"}{...}
{viewerjumpto "Options" "datazoom_pofstd_02##options"}{...}
{viewerjumpto "Remarks" "datazoom_pofstd_02##remarks"}{...}
{viewerjumpto "Examples" "datazoom_pofstd_02##examples"}{...}
{title:Title}

{phang}
{bf:datazoom_pofstd_02} {hline 2} Acesso � bases padronizadas da POF 2002-03 em formato STATA - Vers�o 1.2

{marker syntax}{...}
{title:Syntax}
{p 8 17 2}
{cmdab:datazoom_pofstd_02}
[{cmd:,}
{it:options}]

{phang}	OBS: digite 'db datazoom_pof2002' na janela de comando para utilizar o programa via caixa de di�logo

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt:{opt id(string)}} n�vel de identifica��o {p_end}
{synopt:{opt original(string)}} caminho da pasta onde se localizam os arquivos de dados originais {p_end}
{synopt:{opt saving(string)}} caminho da pasta onde ser�o salvas as novas bases de dados {p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}

{marker description}{...}
{title:Descri��o}

{phang}
{cmd:datazoom_pofstd_02} extrai e constr�i uma base de dados padronizada da POF 2002-03 a partir dos microdados originais, 
	os quais n�o s�o disponibilizados pelo Portal (informa��es sobre como obter os arquivos originais de dados, consulte o
        site do IBGE www.ibge.gov.br). Este programa � parte do pacote POF 2002-03, que inclui {help datazoom_poftrs_02} e
		{help datazoom_pofsel_02} (todos os programas s�o independentes uns dos outros).
		
{phang} Nesta base padronizada, o gasto em itens semelhantes s�o agregados em um �nico
		 item. Por exemplo, gastos em qualquer tipo de arroz, feij�o e outros s�o unificados sob 
		 gastos em Cereais, Leguminosas e Oleaginosas. As agrega��es seguem a documenta��o da POF 
		 (consulte "Tradutores"). Todas as agrega��es existentes naquele documento
		  s�o incorporadas na base final. O usu�rio n�o pode escolher quais itens incluir nem especificar agrega��es 
		  de itens diferentes das existentes. Todos os valores s�o anualizados e deflacionados para janeiro/2003.
		  
{phang} Cada gasto est� atrelado a um determinado n�vel de identifica��o (domic�lio, unidade de consumo 
	ou indiv�duo). Ao escolher o n�vel de identifica��o, o programa computa o gasto para o n�vel escolhido, somando o 
	gasto individual dentro do n�vel, quando for o caso. Em particular, quando o n�vel de identifica��o � o indiv�duo, 
	o gasto com itens associados � unidade de consumo ou domic�lio s�o desconsiderados. Caso haja interesse nesses gastos
	 em uma base de indiv�duos, execute o programa para cada n�vel de identifica��o e utilize o
        comando merge para juntar as bases.

{phang} Vale lembrar que as vari�veis de rendimento tamb�m possuem n�veis de identifica��o, assim como os gastos. As vari�veis de rendimento (renda bruta monet�ria,
 renda bruta n�o monet�ria e renda total) s�o correspondentes ao rendimento bruto mensal do domic�lio ou da unidade de consumo (para registros de unidade
 de consumo e pessoas).
		
{phang}	A base final, sob qualquer n�vel de identifica��o,
	cont�m todas as vari�veis de caracter�sticas do domic�lio. Se Unidade de Consumo for escolhido, s�o adicionadas
	as vari�veis de condi��es de vida. E se Indiv�duo for escolhido, as vari�veis relacionadas �s caracter�sticas 
	individuais s�o incorporadas.
	
{phang} Para a constru��o de estimativas, � necess�rio o uso do fator de expans�o 2 como fator de pondera��o.
		Para mais informa��es ver {help weight}.

		 
{marker options}{...}
{title:Op��es}
{dlgtab:Main}
{phang}
{opt id(string)}  especifica o n�vel de identifica��o para o qual o gasto deve se referir. S�o tr�s op��es: 
domic�lio ({opt dom}), unidade de consumo ({opt uc}) e indiv�duo ({opt pess}). De acordo com a defini��o do IBGE, uma unidade de consumo � um 
conjunto de moradores do domic�lio (que pode ter apenas um morador) que compartilham da mesma fonte de alimentos.

{phang}
{opt original(string)}  indica o caminho da pasta onde est�o localizados os arquivos de dados
        originais. Todos os 14 arquivos devem estar posicionados na mesma pasta para que o programa funcione
        adequadamente. O Portal n�o disponibiliza os dados originais.

{phang}
{opt saving(string)}  indica o caminho da pasta onde devem ser salvas as bases de dados
        produzidas pelo programa.


{marker examples}{...}
{title:Examplo}

{phang}  OBS: Recomenda-se a execu��o do programa por meio da caixa de di�logo. Digite "db
        datazoom_pof2002" na janela de comando do STATA para iniciar.

{phang} datazoom_pofstd_02, id(uc pess ) original(c:/mydata) saving(c:/pof)

{pstd}
O comando acima produz duas bases de dados padronizadas, uma para a unidade de consumo e outra para o indiv�duo.


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

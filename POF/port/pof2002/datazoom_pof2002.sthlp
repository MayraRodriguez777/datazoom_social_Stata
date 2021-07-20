{smcl}
{* *! version 1.0 18 Jun 2013}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "Install command2" "ssc install command2"}{...}
{vieweralsosee "Help command2 (if installed)" "help command2"}{...}
{viewerjumpto "Description" "datazoom_pof2002##description"}{...}
{title:Title}

{phang}
{bf:datazoom_pof2002} {hline 2}  Acesso aos microdados da POF 2002-03 em formato STATA - Vers�o 1.2


{marker description}{...}
{title:Descri��o}

{phang}
{cmd:datazoom_pof2002} � um pacote composto por tr�s comandos.

{phang}
1) datazoom_pofstd_02: execute este comando para obter um base padronizada da POF 2002-03 standard database. 
Esta base cont�m vari�veis de gasto/aquisi��o para uma cesta de consumo pr�-definida com itens agredados, 
seguinto uma classifica��o disponibilizada pelo IBGE. Para mais informa��es ver {help datazoom_pofstd_02}.

{phang}
2) datazoom_pofsel_02: com este comando o usu�rio obt�m uma base de dados persoanalizada, com as vari�veis
 relacionadas aos itens escolhidos pelo pr�prio usu�rio. Para mais informa��es ver {help datazoom_pofsel_02}.
	
{phang}
3) datazoom_poftrs_02: execute este comando para obter as bases de dados originais em formato STATA sem manipula��es
 de vari�veis. A POF 2002-03 cont�m 14 tipos de registros. Para mais informa��es ver {help datazoom_poftrs_02}.
	
{phang}
Os dois primeiros comandos permitem ao usu�rio a escolha do n�vel de agrega��o das informa��es de gasto/aquisi��o: 
 Domic�lio, Unidade de Consumo e Indiv�duo. Note que alguns itens e informa��es n�o s�o v�lidas para todos os n�veis.

{phang}
Digite "db datazoom_pof2002" na janela de comando para iniciar.


{title:Sobre a POF 2002-03}

{phang} A Pesquisa de Or�amentos Familiares - POF - � uma pesquisa domiciliar realizada pelo IBGE com o objetivo
 de investigar o padr�o de consumo, gasto e/ou aquisi��o da popula��o brasileira. � realizada a cada cinco anos
  desde 1996 (sua primeira vers�o foi lan�ada em 1988) e abrange todo o territ�rio nacional. Entre outras fun��es, 
  a POF serve de insumo para a constru��o de cestas de consumo utilizadas para o c�lculo de �ndices de infla��o, como o IPCA.
  
{phang} O que torna a POF peculiar quando comparada a pesquisas domiciliares mais conhecidas como o Censo ou a PNAD � o
 n�mero e a diversidade de tipos de registro. Esse fato dificulta sua utiliza��o e entendimento por parte do usu�rio
 n�o acostumado a trabalhar com pesquisas domiciliares.

{phang} Al�m de informa��es acerca dos domic�lios (tais como exist�ncia de esgoto sanit�rio, paredes, ve�culos) e de pessoas 
(idade, n�vel de instru��o e rendimentos), comuns no Censo e na PNAD, a POF cont�m tipos de registros diferentes para cada tipo 
de gasto/consumo/aquisi��o 
realizado. Cada tipo depende da periodicidade de realiza��o (semanal, trimestral) e a quem � atribu�o, se 
ao domic�lio (como consumo de eletricidade) ou ao indiv�duo (lanches fora do domic�lio). Tanto a periodicidade quanto a
 atribui��o s�o pr�-definidas pelo IBGE antes da aplica��o do question�rio. O gasto com alimentos, por exemplo, � coletado por
 meio de uma caderneta preenchida diariamente pelo domic�lio durante sete dias. Por sua vez, gasto com servi�o de cabeleireiro
 s�o registrados individualmente para um per�odo de 90 dias. 
 
{phang} Outra dificuldade ocorre com os c�digos dos itens na base de dados. Para identificar um item � necess�rio combinar uma 
vari�vel com os tr�s primeiros d�gitos de outra. Por�m, esta segunda vari�vel � diferente especificamente para o caso da caderneta de
 despesa coletiva. Ou seja, a vari�vel utilizada em todos os demais tipos de registro existe na base de despesa coletiva, mas
 n�o deve ser utilizada.
 
{phang}  Dessa forma, a tarefa de contabilizar o gasto
 total de um domic�lio ou indiv�duo n�o � trivial. O objetivo dos programas descritos
 acima, principalmente os dois primeiros, � auxiliar o usu�rio no acesso a essa pesquisa. 
 
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



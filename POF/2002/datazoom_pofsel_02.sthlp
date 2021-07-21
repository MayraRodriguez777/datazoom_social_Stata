{smcl}
{* *! version 1.0 20 May 2013}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "Install command2" "ssc install command2"}{...}
{vieweralsosee "Help command2 (if installed)" "help command2"}{...}
{viewerjumpto "Syntax" "datazoom_pofsel_02##syntax"}{...}
{viewerjumpto "Description" "datazoom_pofsel_02##description"}{...}
{viewerjumpto "Options" "datazoom_pofsel_02##options"}{...}
{viewerjumpto "Remarks" "datazoom_pofsel_02##remarks"}{...}
{viewerjumpto "Examples" "datazoom_pofsel_02##examples"}{...}
{title:Title}

{phang}
{bf:datazoom_pofsel_02} {hline 2} Acesso � bases personalizadas da POF 2002-03 em formato STATA - Vers�o 1.2

{marker syntax}{...}
{title:Syntax}
{p 8 17 2}
{cmdab:datazoom_pofsel_02}
[{cmd:,}
{it:options}]

{phang}	OBS: digite 'db datazoom_pof2002' na janela de comando para utilizar o programa via caixa de di�logo 
	(fortemente recomentado)

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt:{opt id(string)}} n�vel de identifica��o {p_end}
{synopt:{opt lista(string asis)}} lista de itens {p_end}
{synopt:{opt original(string)}} caminho da pasta onde se localizam os arquivos de dados originais {p_end}
{synopt:{opt saving(string)}} caminho da pasta onde ser�o salvas as novas bases de dados {p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}

{marker description}{...}
{title:Descri��o}

{phang}
{cmd:datazoom_pofsel_02} extrai e contr�i bases de dados personalizadas em formato STATA (.dta) a partir dos microdados originais, 
	os quais n�o s�o disponibilizados pelo Portal (informa��es sobre como obter os arquivos originais de dados, consulte o
        site do IBGE www.ibge.gov.br). Este programa � parte do pacote POF 2002-03, que inclui {help datazoom_poftrs_02} e
		{help datazoom_pofstd_02} (todos os programas s�o independentes uns dos outros).
		
{phang} Em {opt lista} o usu�rio define os itens que deseja incluir em sua cesta. Como cada item possui um nome espec�fico
 pr�-definido que deve ser inserido para inclu�-lo na lista, recomenda-se fortemente o uso deste comando via caixa de di�logo, 
 por meio da qual pode-se observar todos os itens dispon�veis por categoria (Alimenta��o, Outros gastos e Rendimentos).
 
{phang} O gasto em cada item escolhido ser� agregado ao n�vel de identifica��o desejado: domic�lio, unidade de consumo ou 
indiv�duo. O mesmo vale para vari�veis de rendimento. Todos os valores s�o anualizados e deflacionados para janeiro/2003. 
As vari�veis de rendimento (renda bruta monet�ria, renda bruta n�o monet�ria e renda total) s�o correspondentes ao rendimento
bruto mensal do domic�lio ou da unidade de consumo (para registros de unidade de consumo e pessoas). Cada gasto est� atrelado 
a um determinado n�vel de identifica��o. Assim, em particular, n�o � poss�vel obter para o indiv�duo o gasto com itens associados
� unidade de consumo ou domic�lio. Neste caso, execute o programa para cadan�vel de identifica��o e utilize o comando {help merge}
para juntar as bases.
 
{phang} A base final, sob qualquer n�vel de identifica��o,
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
	domic�lio ({opt dom}), unidade de consumo ({opt uc}) e indiv�duo ({opt pess}). De acordo com a defini��o 
	do IBGE, uma unidade de consumo � um 
	conjunto de moradores do domic�lio (que pode ter apenas um morador) que compartilham da mesma fonte de alimentos.

{phang}
{opt lista(string asis)}  estabelece os itens para os quais os gastos devem ser computados e inclu�dos na base final.
 Pode contar vari�veis de rendimento tamb�m.	

{phang}
{opt original(string)}  indica o caminho da pasta onde est�o localizados os arquivos de dados
        originais. Todos os 14 arquivos devem estar posicionados na mesma pasta para que o programa funcione
        adequadamente. O Portal n�o disponibiliza os dados originais.

{phang}
{opt saving(string)}  indica o caminho da pasta onde devem ser salvas as bases de dados
        produzidas pelo programa.


{marker examples}{...}
{title:Exemplos}

{p}	OBS: (fortemente recomentado) digite 'db datazoom_pof2002' na janela de comando para utilizar o programa via caixa de di�logo 

{p} Exemplo 1: base final cont�m gastos anualizados em frutas, farinha de trigo e a��car refinado para unidades de consumo.

{phang} datazoom_pofsel_02, id(uc) original(c:/mydata) saving(c:/pof) lista(frutas farinha_de_trigo a��car_refinado)


{p} Exemplo 2: como os gastos registrados na caderneta de poupan�a s�o para a unidade de consumo, o comando abaixo � inv�lido, 
j� que o n�vel de identifica��o escolhido foi "pess", ou seja, para indiv�duos.

{phang} datazoom_pofsel_02, id(pess) original(c:/mydata) saving(c:/pof) lista(frutas farinha_de_trigo a��car_refinado)


{p} Exemplo 3: base final cont�m gastos anualizados com feij�o, cenoura e roupa de crian�a, al�m de rendimentos recebidos 
de transfer�ncias (aponsentadorias, pens�es, bolsas de estudo, transf�ncias transit�rias). Todos os valores s�o agregados 
ao n�vel do domic�lio, portanto, os rendimentos, por exemplo, que s�o individuais, s�o somados dentre de cada domic�lio. 

{phang} datazoom_pofsel_02, id(dom) original(c:/mydata) saving(c:/pof) lista(Feijao Cenoura Roupa_de_crianca Transferencia)


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

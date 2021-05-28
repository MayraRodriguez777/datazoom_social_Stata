{smcl}
{* *! version 1.0 22 May 2013}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "Install command2" "ssc install command2"}{...}
{vieweralsosee "Help command2 (if installed)" "help command2"}{...}
{viewerjumpto "Syntax" "datazoom_pmeantiga##syntax"}{...}
{viewerjumpto "Description" "datazoom_pmeantiga##description"}{...}
{viewerjumpto "Options" "datazoom_pmeantiga##options"}{...}
{viewerjumpto "Remarks" "datazoom_pmeantiga##remarks"}{...}
{viewerjumpto "Examples" "datazoom_pmeantiga##examples"}{...}
{title:Title}

{phang}
{bf:datazoom_pmeantiga} {hline 2} Acesso aos microdados da PME-Antiga Metodologia em formato STATA - Vers�o 1.2

{marker syntax}{...}
{title:Syntax}
{p 8 17 2}
{cmdab:datazoom_pmeantiga}
[{cmd:,}
{it:options}]

{p}	OBS: digite 'db datazoom_pmeantiga' para utilizar o programa via caixa de di�logo

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Inputs}
{synopt:{opt years(numlist)}} anos da PME {p_end}
{synopt:{opt original(str)}} caminho da pasta onde se localizam os arquivos de dados originais {p_end}
{synopt:{opt saving(str)}} caminho da pasta onde ser�o salvas as novas bases de dados {p_end}

{syntab:Identifica��o do Indiv�duo}
{synopt:{opt nid}} Sem identifica��o {p_end}
{synopt:{opt idbas}} Identifica��o b�sica {p_end}
{synopt:{opt idrs}} Avan�ada (Ribas-Soares) {p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}

{marker description}{...}
{title:Descri��o}

{phang}
{cmd:datazoom_pmeantiga} extrai e contr�i bases de dados da PME-Antiga Metodologia em formato STATA (.dta) a partir
dos microdados originais, os quais  n�o s�o disponibilizados pelo Portal (informa��es sobre como obter
os arquivos originais de dados, consulte o site do IBGE www.ibge.gov.br). O programa pode ser utilizado para
o per�odo entre 1991 e 2001. 

{phang} Apesar de ser uma pesquisa mensal, este programa n�o permite a escolha de meses espec�ficos para extra��o, 
mas somente os anos. As vari�veis monet�rias s�o deflacionadas para Dezembro de 2001.

{phang} Apesar de ser um painel de domic�lios, os indiv�duos podem n�o apresentar o mesmo n�mero de ordem ao longo das 
entrevistas. Caso o usu�rio necessite trabalhar com um painel de indiv�duos, � necess�rio construir uma vari�vel que 
identifique o mesmo ind�v�duo ao longo das pesquisas. Para isso, s�o utilizados os algoritmos propostos por Ribas e Soares (2008). Os autores 
elaboram uma identifica��o b�sica e outra avan�ada, sendo diferenciadas pelo n�mero de vari�veis utilizadas para realizar
 a identifica��o do indiv�duo em pesquisas distintas. A ideia dos algoritmos � verificar inconsist�ncias no conjunto de 
 vari�veis. Em qualquer dessas op��es de identifica��o, a depender da capacidade 
 computacional utilizada, o programa pode consumir um tempo razo�vel para realizar a identifica��o, sendo recomend�vel
  n�o executar o programa para mais de quatro ou cinco anos conjuntamente. Por outro lado, caso n�o haja 
  interesse no painel de indiv�duos (por exemplo, c�lculo da taxa de desemprego mensal), existe a op��o de n�o realizar a 
  identifica��o, vantajosa em termos de tempo de execu��o do programa.
  
{phang} Se a op��o {opt nid} for escolhida, uma base de dados para cada ano selecionado ser� gerada. Ao utilizar as outras op��es, 
 uma base de dados para cada painel da PME ser� o produto final. Um painel da PME � um conjunto de domic�lios que ingressam 
e deixam o ciclo de entrevistas no mesmo m�s, sendo identificados por letras mai�sculas. Se for o caso, utilize o 
comando {help append} para empilhar as bases.

{marker options}{...}
{title:Op��es}
{dlgtab:Inputs}

{phang} 
{opt years(numlist)} especifica a lista de anos com os quais o usu�rio deseja trabalhar. Este programa 
pode ser utilizado para o per�odo de 1991 a 2001. N�o � poss�vel 
escolher meses espec�ficos.

{phang} {opt original(str)} indica o caminho da pasta onde est�o localizados os arquivos de dados originais. 
Existe um arquivo de microdados para cada m�s da pesquisa. Todos eles devem estar posicionados na mesma pasta 
para que o programa funcione adequadamente. O Portal n�o disponibiliza os dados originais, mas os mesmos podem ser
 obtidos no site do IBGE.

{phang} {opt saving(str)} indica o caminho da pasta onde devem ser salvas as bases de dados produzidas pelo programa.

{dlgtab:Identifica��o do Indiv�duo}

{phang}
{opt nid}  solicita que o programa n�o crie uma vari�vel que identifique o mesmo indiv�duo ao longo das
 entrevistas. Esta op��o � recomend�vel para o caso de n�o haver interesse em trabalhar com um painel de
  indiv�duos, pois consome menos tempo para preparar as bases de dados em formato STATA.

{phang}
{opt idbas}  solicita que seja gerada uma vari�vel que identifique unicamente o indiv�duo ao longo das pesquias. 
Essa vari�vel � criada ap�s a verifica��o de inconsist�ncia em um conjunto de vari�veis. Veja Ribas and Soares 
(2008) para mais detalhes sobre o algoritmo.

{phang}
{opt idrs}  solicita a cria��o de uma vari�vel de identifica��o dos indiv�duos por meio da verifica��o de inconsist�ncias 
utilizando um conjunto maior de vari�veis que o algoritmo b�sico. Esta op��o � time-consuming.


{marker examples}{...}
{title:Exemplos}

{phang}  OBS: Recomenda-se a execu��o do programa por meio da caixa de di�logo. Digite "db datazoom_pmeantiga" na janela 
de comando do STATA para iniciar.

{phang} Exemplo 1: sem identifica��o.

{phang} datazoom_pmenova, years(1991 1992 2000) original(C:/pmeant) saving(D:/mydatabases) nid

{phang} Tr�s bases de dados s�o geradas, uma para cada ano selecionado, contendo as observa��es de todos os meses do ano.

{phang}

{phang} Exemplo 2: identifica��o avan�ada.

{phang} datazoom_pmenova, years(1999 2000) original(C:/pmeant) saving(D:/mydatabases) idbas

{phang} Ser� criada uma base para cada painel da PME pesquisado em 1999 e 2000. Em cada base haver� uma vari�vel 
 que identifica unicamente os indiv�duos. Haver� indiv�duos com menos de oito entrevistas, seja porque o painel ao 
 qual pertence teve in�cio antes de 1999, seja porque seu ciclo de entrevistas terminaria somente em 2000.

 
{title:Autor}
{p}

PUC-Rio - Departmento de Economia

Email {browse "mailto:datazoom@econ.puc-rio.br":datazoom@econ.puc-rio.br}


{title:Veja tamb�m}

Pacotes relacionados:

{help datazoom_censo} (se instalado)  
{help datazoom_pnad} (se instalado)  
{help datazoom_pmenova} (se instalado)  
{help datazoom_pof2008} (se instalado)  
{help datazoom_pof2002} (se instalado)  
{help datazoom_pof1995} (se instalado)  
{help datazoom_ecinf} (se instalado) 


{p} Digite "net from http://www.econ.puc-rio.br/datazoom/portugues" para instalar a vers�o em portugu�s desses pacotes. 
For the english version, type "net from http://www.econ.puc-rio.br/datazoom/english".

{title:Refer�ncia} 

{pstd} Ribas, R. P. and Soares, S. S. D. (2008). Sobre o painel da Pesquisa Mensal de Emprego (PME) 
do IBGE. Bras�lia: IPEA (Texto para Discuss�o � 1348).

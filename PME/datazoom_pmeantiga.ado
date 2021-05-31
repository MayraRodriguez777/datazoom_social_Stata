* VERSION 1.3
******************************************************
*					datazoom_pmeantiga.ado				 *
******************************************************
program define datazoom_pmeantiga

syntax, years(numlist) original(str) saving(str) [nid idbas idrs]

cd "`saving'"

tempfile PMEBA PMEMG PMEPE PMEPR PMERJ PMERS PMESP
tempfile PMEBAmes PMEMGmes PMEPEmes PMEPRmes PMERJmes PMERSmes PMESPmes

tokenize `years'                            					// converte `anos' em `*' = `1', `2', `3', ...

/*Domicilios */

qui while "`*'" != "" {
	if `1' <= 1999 {

		/*Extrai arquivos por UF, separa o ano e empilha em anos*/
		noi display as input _newline "Extraindo `1' - Domic�lios"
		loc y = substr("`1'",3,2)
		foreach UF in BA MG PE RJ RS SP {
			findfile pme_1991_2000_dom.dct
			infile using `"`r(fn)'"', using("`original'/PME`y'`UF'D.txt") clear
			compress
			save `PME`UF'', replace
			clear
		}

		foreach mm in 01 02 03 04 05 06 07 08 09 10 11 12 {
			foreach UF in BA MG PE RJ RS SP {
				use `PME`UF''
				keep if v0105 == `mm'
				save `PME`UF'mes', replace
				clear
			}

			use `PMEBAmes'
			foreach UF in MG PE RJ RS SP {
				append using `PME`UF'mes'
			}
			tempfile `PME`1'`mm'D
			save `PME`1'`mm'D'
			clear
		}
		macro shift
	}

	else if `1' == 2000 {
		noi display as input _newline "Extraindo `1' - Domic�lios"
		foreach UF in BA MG PE RJ RS SP {
			findfile pme_1991_2000_dom.dct
			infile using `"`r(fn)'"', using("`original'/PME2K`UF'D.txt") clear
			compress
			save `PME`UF'', replace
			clear
		}

		foreach mm in 01 02 03 04 05 06 07 08 09 10 11 12 {

			foreach UF in BA MG PE RJ RS SP {
				use `PME`UF''
				keep if v0105 == `mm'
				save `PME`UF'mes', replace
				clear
			}

			use `PMEBAmes'
			foreach UF in MG PE RJ RS SP {
				append using `PME`UF'mes'
			}
			tempfile PME`1'`mm'D
			save `PME`1'`mm'D'
			clear
		}
		macro shift
	}

	else if `1' == 2001 {
		noi display as input _newline "Extraindo `1' - Domic�lios"
		/*Extrai arquivos por UF, separa o ano e empilha em anos*/
		foreach UF in BA MG PR PE RJ RS SP {
			findfile pme_2001_dom.dct
			infile using `"`r(fn)'"', using("`original'/PME2001`UF'D.txt") clear
			compress
			save `PME`UF'', replace
			clear
		}

		foreach mm in 01 02 03 04 05 06 07 08 09 10 11 12 {

			foreach UF in BA MG PE PR RJ RS SP {
				use `PME`UF''
				keep if v0105 == `mm'
				save `PME`UF'mes', replace
				clear
			}

			use `PMEBAmes'
			foreach UF in MG PE PR RJ RS SP {
				append using `PME`UF'mes'
			}
			tempfile PME`1'`mm'D
			save `PME`1'`mm'D'
			clear
		}
		macro shift
	}
}
	

/* Pessoas */

tokenize `years'

qui while "`*'" != "" {
	if `1' <= 1999 {

		/*Extrai arquivos por UF, separa o ano e empilha em anos*/
		noi display as input _newline "Extraindo `1' - Pessoas"
		loc y = substr("`1'",3,2)
		foreach UF in BA MG PE RJ RS SP {
			findfile pme_1991_2000_pes.dct
			infile using `"`r(fn)'"', using("`original'/PME`y'`UF'P.txt") clear
			compress
			save `PME`UF'', replace
			clear
		}

		foreach mm in 01 02 03 04 05 06 07 08 09 10 11 12 {

			foreach UF in BA MG PE RJ RS SP {
				use `PME`UF''
				keep if mes == `mm'
				save `PME`UF'mes', replace
				clear
			}

			use `PMEBAmes'
			foreach UF in MG PE RJ RS SP {
				append using `PME`UF'mes'
			}
			
			/*Utiliza��o do deflator para variaveis monetarias*/
			findfile deflatorpmeantiga.dta
			merge m:1 mes ano using `"`r(fn)'"', keep(match) nogen
			foreach var in v309 v311 {
				gen `var'df = `var'/(deflator*converter) if `var' ~= 999999999
				lab var `var'df "`var' deflacionada"
			}
			tempfile PME`1'`mm'P
			save `PME`1'`mm'P'
			clear
		}
		macro shift
	}

	else if `1' == 2000 {
		
		/*Extrai arquivos por UF, separa o ano e empilha em anos*/
		noi display as input _newline "Extraindo `1' - Pessoas"
		foreach UF in BA MG PE RJ RS SP {
			findfile pme_1991_2000_pes.dct
			infile using `"`r(fn)'"', using("`original'/PME2K`UF'P.txt") clear
			compress
			save `PME`UF'', replace
			clear
		}

		foreach mm in 01 02 03 04 05 06 07 08 09 10 11 12 {

			foreach UF in BA MG PE RJ RS SP {
				use `PME`UF''
				keep if mes == `mm'
				save `PME`UF'mes', replace
				clear
			}

			use `PMEBAmes'
			foreach UF in MG PE RJ RS SP {
				append using `PME`UF'mes'
			}
			
			/*Utiliza��o do deflator para variaveis monetarias*/
			findfile deflatorpmeantiga.dta
			merge m:1 mes ano using `"`r(fn)'"', keep(match) nogen
			foreach var in v309 v311 {
				gen `var'df = `var'/(deflator*converter) if `var' ~= 999999999
				lab var `var'df "`var' deflacionada"
			}
			tempfile PME`1'`mm'P
			save `PME`1'`mm'P'
			clear
		}
		macro shift
	}
		
	else if `1' == 2001 {

		/*Extrai arquivos por UF, separa o ano e empilha em anos*/
		noi display as input _newline  "Extraindo `1' - Pessoas"
		foreach UF in BA MG PR PE RJ RS SP {
			findfile pme_2001_pes.dct
			infile using `"`r(fn)'"', using("`original'/PME2001`UF'P.txt") clear
			/*Corre��o de leitura da base de pessoas de 2001: a base de dados agrupa 
			na mesma linha do dom�cilio todos os respectivos indiv�duos. Essa corre��o
			reorganiza a base de forma a ler cada ind�viduo junto com seu dom�cilio por
			linha*/ 
			reshape long  v201 v202 v203 v204 v205 v206 v236 v246 v207 v208 v209 v210 ///
			              v211 v301 v302 v303 v304 v305 v306 v307 v308 v309 v339 v310 ///
						  v311 v341 v312 v313 v314 v315 v931 v316 v346 v356 v366 v317 ///
						  v347 v318 v319 v320 v350 v360 v321 v322 v323 v324 v325 v355 ///
						  v326 v327 v328 v256, i(v0001 v0105)
			drop if v201 == .
			drop _j
			compress

			/* reintroduzindo as labels */
			
			lab var	v201	"n�mero de ordem"
			lab var	v202	"sexo"
			lab var	v203	"condi��o no domic�lio"
			lab var	v204	"condi��o na fam�lia"
			lab var	v205	"n�mero da fam�lia"
			lab var	v206	"dia de nascimento"
			lab var	v236	"m�s de nascimento"
			lab var	v246	"ano de nascimento"
			lab var	v207	"sabe ler e escrever"
			lab var	v208	"frequenta escola"
			lab var	v209	"�ltima s�rie conclu�da"
			lab var	v210	"grau"
			lab var	v211	"concluiu o curso?"
			lab var	v301	"que fez na semana?"
			lab var	v302	"tinha mais de um trabalho?"
			lab var	v303	"ocupa��o na semana"
			lab var	v304	"atividade/ramo do neg�cio"
			lab var	v305	"ramo de atividade"
			lab var	v306	"posi��o na ocupa��o"
			lab var	v307	"frequ�ncia com que recebia"
			lab var	v308	"tem carteira assinada?"
			lab var	v309	"rendimento mensal em dinheiro"
			lab var	v339	"faixa de rendimento mensal"
			lab var	v310	"horas efetivamente trabalhadas na semana"
			lab var	v311	"rendimento mensal - outros trabalhos"
			lab var	v341	"faixa de rendimento - outros trabalhos"
			lab var	v312	"horas efetiv. trabalhasdas - outros trabs."
			lab var	v313	"tomou provid�ncia no per�odo?"
			lab var	v314	"tomou provid�ncia antes?"
			lab var	v315	"que provid�ncia tomou?"
			lab var	v931	"data em que tomou provid�ncia"
			lab var	v316	"dia em que tomou provid�ncia"
			lab var	v346	"m�s em que tomou provid�ncia"
			lab var	v356	"ano em que tomou provid�ncia"
			lab var	v366	"quando tomou provid�ncia?"
			lab var	v317	"h� qto tempo procurava trab? (meses)"
			lab var	v347	"h� qto tempo procurava trab? (semanas)"
			lab var	v318	"j� teve trabalho remunerado?"
			lab var	v319	"j� teve trabalho n�o remunerado?"
			lab var	v320	"h� qto tempo saiu do �ltimo trab? (anos)"
			lab var	v350	"h� qto tempo saiu do �ltimo trab? (meses)"
			lab var	v360	"h� qto tempo saiu do �ltimo trab? (semanas)"
			lab var	v321	"ocupa��o anterior"
			lab var	v322	"atividade anterior"
			lab var	v323	"ramo de atividade anterior"
			lab var	v324	"posi��o na ocupa��o anterior"
			lab var	v325	"tempo no �ltimo emprego (anos)"
			lab var	v355	"tempo no �ltimo emprego (meses)"
			lab var	v326	"porque saiu do �ltimo emprego?"
			lab var	v327	"tinha carteira assinada no �ltimo emprego?"
			lab var	v328	"quando saiu, recebeu FGTS?"
			lab var	v256	"idade calculada"

			save `PME`UF'', replace
			clear
		}

		foreach mm in 01 02 03 04 05 06 07 08 09 10 11 12 {
			foreach UF in BA MG PE PR RJ RS SP {
				use `PME`UF''
				keep if v0105 == `mm'
				save `PME`UF'mes', replace
				clear
			}
			use `PMEBAmes'
			foreach UF in MG PE PR RJ RS SP {
				append using `PME`UF'mes'
			}
			
			/*Utiliza��o do deflator para variaveis monetarias*/
			g mes = v0105
			g ano = 2001
			lab var mes "m�s da pesquisa"
			lab var ano "ano da pesquisa"
			findfile deflatorpmeantiga.dta
			merge m:1 mes ano using `"`r(fn)'"', keep(match) nogen
			foreach var in v309 v311 {
				gen `var'df = `var'/(deflator*converter) if `var' ~= 999999999
				lab var `var'df "`var' deflacionada"
			}
			tempfile PME`1'`mm'P
			save `PME`1'`mm'P'
			clear
		}
		macro shift
	}
}

/*Prepara��o para rodar os algoritmos de identifi��o*/

tempfile PME_PainelAtemp PME_PainelBtemp PME_PainelCtemp PME_PainelDtemp PME_PainelEtemp PME_PainelFtemp
tempfile PME_PainelGtemp PME_PainelHtemp PME_PainelItemp PME_PainelJtemp PME_PainelKtemp PME_PainelLtemp
tempfile PME_PainelMtemp PME_PainelNtemp PME_PainelOtemp PME_PainelPtemp PME_PainelQtemp PME_PainelRtemp PME_PainelStemp 

/*Criando paineis para as bases de dados e adaptando variaveis para os algoritmos de identifica��o*/
/*Adapta vari�veis da PME para dom�cilios*/

qui foreach aa in `years' {
	if `aa' == 2001 {
		foreach mm in 01 02 03 04 05 06 07 08 09 10 11 12 {
			use `PME2001`mm'D'
			rename v0010 uf
			drop v0001 v0011
			rename v0102 v102
			rename v0103 v103
			gen mes = v0105
			gen ano = 2001
			lab var mes "m�s da pesquisa"
			lab var ano "ano da pesquisa"
			save `PME2001`mm'D', replace
		}
	}

	if `aa' <= 2000 {
		foreach mm in 01 02 03 04 05 06 07 08 09 10 11 12 {
			use `PME`aa'`mm'D'
			rename v0102 v102
			rename v0103 v103
			save `PME`aa'`mm'D', replace
		}
	}

/*Montando arquivo de domic�lios com todos as pesquisas por ano*/
	use `PME`aa'01D', clear
	foreach mm in 02 03 04 05 06 07 08 09 10 11 12 {
		append using `PME`aa'`mm'D'
	}
	tempfile PME`aa'D
	save `PME`aa'D', replace

/*Adapta vari�veis da PME de 2001 para pessoas*/
	if `aa' == 2001 {
		foreach mm in 01 02 03 04 05 06 07 08 09 10 11 12 {
			use `PME2001`mm'P', clear
			rename v0010 uf
			rename v0102 v102
			rename v0103 v103
*			rename v0105 mes
			drop v0*
*			generate ano = 2001
			save `PME2001`mm'P', replace
		}
	}

/*Montando arquivo de pessoas com todos as pesquisas por ano*/
	use `PME`aa'01P', clear
	foreach mm in 02 03 04 05 06 07 08 09 10 11 12 {
		append using `PME`aa'`mm'P'
	}
	tempfile PME`aa'P
	save `PME`aa'P', replace

	/*Corrigindo poss�vel erro na PME 1995: entre novembro e dezembro, o numero de controle 
	para o mesmo domicilio � alterado. � poss�vel recuperar a identifica��o do domic�lio 
	utilizando a vari�vel pasta e n�mero no 202/203*/
	if `aa' == 1995 {
		use `PME1995D'
		summ v102 if mes == 11
		loc maxnov = r(max)
		summ v102 if mes == 12
		loc mindez = r(min)
		if  (`maxnov' < `mindez') {
				
			tempfile PME95_aux PME95_rem1 PME95_rem3 PME95_rem4 PME95_corr

			***Abrindo 'Domic�lios';
			*uniformizando c�digo para n. de controle e s�rie com o de 'Pessoas'.
						
			save `PME95_aux'
			clear
						
			***Remessa 1
			*Grupo de dezembro � o mesmo que de novembro;
			*dezembro de 1995 � o �ltimo m�s de entrevista deste grupo.
			*Melhor tomar c�digo antigo.
							
			use `PME95_aux'
			keep if mes >= 11 & v0106 == 1
						
			*Identificando n. de domic�lios pesquisados por n. de controle
			sort v102 v103
			by v102: generate v103max = v103[_N]
							
			sort v0002 v0101 v103max v103 v102
			by v0002 v0101 v103max v103: generate conta = _N
			by v0002 v0101 v103max v103: generate long v102c = v102[1] if conta == 2
				
			sort v102 v102c
			by v102: replace v102c = v102c[1] if v102c == .
			save `PME95_rem1'
							
							
			***Remessa 2
			*Grupo de dezembro est� entrando na amostra;
			*o de novembro, acaba de deixar amostra.
			*Nada a fazer, portanto.
							
							
			***Remessa 3
			*Grupo de dezembro entrou na pesquisa em novembro;
			*e vai aparecer em 96, com codigo novo.
			*Melhor tomar o c�digo novo.
							
			use `PME95_aux'
			keep if mes >= 11 & v0106 == 3
							
			*Identificando n. de domic�lios pesquisados por n. de controle
			sort v102 v103
			by v102: generate v103max = v103[_N]
						
			sort v0002 v0101 v103max v103 v102
			by v0002 v0101 v103max v103: generate conta = _N
			by v0002 v0101 v103max v103: generate long v102c = v102[2] if conta == 2
							
			sort v102 v102c
			by v102: replace v102c = v102c[1] if v102c == .
			save `PME95_rem3'
			clear
							
							
			***Remessa 4
			*Grupo de dezembro entrou na pesquisa em outubro;
			*e vai aparecer em 96, com codigo novo.
			*Melhor tomar o c�digo novo.
				
			use `PME95_aux'
			keep if mes >= 10 & v0106 == 4
							
			*Identificando n. de domic�lios pesquisados por n. de controle
			sort v102 v103
			by v102: generate v103max = v103[_N]
						
			sort v0002 v0101 v103max v103 v102
			by v0002 v0101 v103max v103: generate conta = _N
			by v0002 v0101 v103max v103: generate long v102c = v102[3] if conta == 3
							
			sort v102 v102c
			by v102: replace v102c = v102c[1] if v102c == .
			save `PME95_rem4'
			clear


			***Unindo e aplicando
			use `PME95_rem1'
			append using `PME95_rem3'
			append using `PME95_rem4'
			sort mes v102 v103
			save `PME95_corr'
			clear
						
			use `PME1995P'
			merge m:1 mes v102 v103 using `PME95_corr', keepus(v102c) nogen
			replace v102 = v102c if v102c ~= .
			drop v102c
			save, replace
			clear

			use `PME95_aux'
			drop if (mes >= 11 & v0106 == 1) | (mes >= 11 & v0106 == 3) | (mes >= 10 & v0106 == 4)
			append using `PME95_rem1'
			append using `PME95_rem3'
			append using `PME95_rem4'
			replace v102 = v102c if v102c ~= .
			drop v102c conta v103max
			save `PME1995D', replace
		}
	}
}

/* Criando pastas para guardar arquivos da sess�o */
capture mkdir pmeantiga
if _rc == 693 {
   tempname numpasta
   local numpasta = 0
   while _rc == 693 {
      capture mkdir "pmeantiga_`++numpasta'"
   }
   cd "pmeantiga_`numpasta'"
}
else {
   cd "pmeantiga"
}
loc caminhoprin = c(pwd)

/*Usando arquivos de domic�lios para obter n�mero da remessa de cada registro de pessoa*/
qui foreach aa in `years' {

	use `PME`aa'P'
	merge m:1 ano mes uf v102 v103 using `PME`aa'D', keep(match) keepus(v0106 v0109 v0110 v0112) nogen
	findfile paineisPMEantiga.dta
	merge m:1 ano mes v0106 using `"`r(fn)'"', keep(match) keepus(painel npesq) nogen
    lab var painel "painel da pesquisa"
	lab var npesq "n�mero da pesquisa"
	
	/*Gera a variavel anos de estudos*/
	generate aest1 = .

	***1 - Sem instru��o / Menos de um ano
	replace aest1 = 1 if (v210==0)

	***2 - Um a tr�s anos de estudo
	replace aest1 = 2 if (v210==1 & v209>=1 & v209<=3)
	replace aest1 = 2 if (v210==1 & v211==3)
	replace aest1 = 2 if (v210==1 & v209==0)
	replace aest1 = 2 if (v210==1 & v209==9)
	replace aest1 = 2 if (v210==3 & v209>=1 & v209<=3)

	***3 - Quatro a sete anos de estudo
	replace aest1 = 3 if (v210==1 & v209>3 & v209<=6)
	replace aest1 = 3 if (v210==1 & v211==1)
	replace aest1 = 3 if (v210==2 & v209>=1 & v209<=3)
	replace aest1 = 3 if (v210==2 & v211==3)
	replace aest1 = 3 if (v210==3 & v209>3 & v209<=7)

	***4 - Oito a onze anos de estudo
	replace aest1 = 4 if (v210==2 & v209>3 & v209<=5)
	replace aest1 = 4 if (v210==2 & v211==1)
	replace aest1 = 4 if (v210==3 & v209==8)
	replace aest1 = 4 if (v210==3 & v211==1)
	replace aest1 = 4 if (v210==4 & v209>=1 & v209<=2)
	replace aest1 = 4 if (v210==4 & v211==3)
	replace aest1 = 4 if (v210==4 & v211==9)
	replace aest1 = 4 if (v210==5 & v209>=1 & v209<=2)
	replace aest1 = 4 if (v210==5 & v211==3)
	replace aest1 = 4 if (v210==5 & v211==9)

	***5 - Onze ou mais anos de estudo
	replace aest1 = 5 if (v210==4 & v209>=3 & v209<=4)
	replace aest1 = 5 if (v210==4 & v211==1)
	replace aest1 = 5 if (v210==5 & v209>=3 & v209<=4)
	replace aest1 = 5 if (v210==5 & v211==1)
	replace aest1 = 5 if (v210==6)
	replace aest1 = 5 if (v210==7)

	***6 - N�o determinado
	replace aest1 = 6 if (v210==3 & v209==0)
	replace aest1 = 6 if (v210==3 & v209==9)

	***Branco - N�o aplic�vel
	lab var aest1 "grupos de anos de estudo"
	
	if "`nid'"~="" save PME`aa'P, replace
	else save `PME`aa'P', replace
}

if "`nid'"~="" {
	di _newline "As bases de dados foram salvas em `caminhoprin'"
	cd "`saving'"
	exit
}

/*Separa a base de dados por painel*/

tokenize `years'
qui {
	foreach pa in A B C D E F G H I J K L M N O P Q R S {
		use `PME`1'P'
		keep if painel == "`pa'"
		save `PME_Painel`pa'temp'
	}
	macro shift
	while "`*'" != "" {
		foreach pa in A B C D E F G H I J K L M N O P Q R S {
			use `PME`1'P'
			keep if painel == "`pa'"
			append using `PME_Painel`pa'temp'
			save `PME_Painel`pa'temp', replace
		}
		macro shift
	}

	global panels = ""
	foreach pa in A B C D E F G H I J K L M N O P Q R S {
		use `PME_Painel`pa'temp'
		count

		if r(N) != 0 { 
			global panels = "$panels `pa'" /* Coleta os paineis existentes */
		}
	}
}	
	
/*Executa a identifica��o b�sica*/
qui if "`idbas'" != "" {
	noi di as result "Executando Identifica��o B�sica ..."
	foreach pa in $panels {
		noi di "Painel `pa'"
		use `PME_Painel`pa'temp', clear
		
		/*Algoritmo B�sico*/
		****************************************************************
		* Nota
		****************************************************************
		/* Este algoritmo pode ser aplicado tanto � nova quanto � antiga
		PME. As vari�veis utilizadas a seguir s�o as da nova pesquisa.
		Para utilizar o algoritmo com a antiga PME basta substituir
		as seguintes vari�veis:
		Na nova Na antiga
		v035 = Regi�o Metropolitana = v010
		v040 = N�mero de controle = v102
		v050 = N�mero de s�rie = v103
		v060 = Painel = deve ser constru�da
		v063 = Grupo rotacional = v106
		v070 = M�s da pesquisa = v105
		v075 = Ano da pesquisa = deve ser constru�da
		v072 = N�mero da pesquisa no domic�lio = deve ser constru�da
		v201 = N�mero de ordem = v201
		v203 = Sexo = v202
		v204 = Dia de nascimento = v206
		v214 = M�s de nascimento = v236
		v224 = Ano de nascimento = v246
		v234 = Idade calculada = v256
		v205 = Condi��o no domic�lio = v203
		vDAE1= Anos de estudo I = deve ser constru�da
		Recomenda-se rod�-lo com arquivos pequenos. Para PME, a sugest�o
		� de um arquivo por painel (vari�vel PAINEL) */
		****************************************************************
		* Vari�veis do painel
		****************************************************************
		* Vari�vel de identifica��o da pessoa no painel
		g p201 = v201 if npesq == 1 /* definido com base na 1a entrevista */
		* Vari�veis que identificam o emparelhamento
		g back = . /* com uma entrevista anterior */
		g forw = . /* com uma entrevista posterior */
		****************************************************************
		* Emparelhamento - 1a loop
		****************************************************************
		* Emparelhamento para cada par de entrevista por vez
		forvalues i = 1/7 {
		****************************************************************
		* Emparelhamento-padr�o - se a data de nascimento est� correta
		****************************************************************
		* Ordenando cada indiv�duo pelo m�s de entrevista
			sort uf v102 v103 painel v0106 v202 v206 v236 v246 ano mes v201
			* Loop para procurar a mesma pessoa em uma posi��o anterior
			loc j = 1 /* j determina a posi��o anterior na base */
			loc stop = 0 /* se stop=1, a loop para */
			loc count = 0
			while `stop' == 0 {
				loc lastcount = `count'
				count if p201 == . & npesq == `i'+1 /* observa��es n�o
				emparelhadas */
				loc count = r(N)
				if `count' == `lastcount' {
		* Parar caso a loop n�o esteja emparelhando mais
					loc stop = 1
				}
				else {
					if r(N) != 0 {
						* Captando a identifica��o p201 da observa��o anterior
						replace p201 = p201[_n - `j'] if /*
						Identifica��o do domic�lio
						*/ uf == uf[_n - `j'] & ///
						v102 == v102[_n - `j'] & ///
						v103 == v103[_n - `j'] & ///
						painel == painel[_n - `j'] & ///
						v0106 == v0106[_n - `j'] & /*
						diferen�a entre per�odos */ npesq == `i'+1 & npesq[_n - `j'] == `i' /*
						excluir emparelhados */ & p201 ==. & forw[_n - `j'] != 1 & /*
						Caracter�sticas individuais
						Sexo */ v202 == v202[_n - `j'] & /*
						Dia de nascimento */ v206 == v206[_n - `j'] & /*
						M�s de nascimento */ v236 == v236[_n - `j'] & /*
						Ano de nascimento */ v246 == v246[_n - `j'] & /*
						Informa��o observada */ v206!=99 & v236!=99 & v246!=9999
						* Identifica��o de emparelhamento para quem est� � frente
						replace forw = 1 if uf == uf[_n + `j'] & ///
						v102 == v102[_n + `j'] & ///
						v103 == v103[_n + `j'] & ///
						painel == painel[_n + `j'] & ///
						v0106 == v0106[_n + `j'] & ///
						p201 == p201[_n + `j'] & ///
						npesq == `i' & npesq[_n + `j']==`i'+1 ///
						& forw != 1
						loc j = `j' + 1 /* passando para a pr�xima observa��o */
					}
					else {
					* Parar se n�o h� observa��es para emparelhar
						loc stop = 1
					}
				}
			}
			* Recodificar vari�veis de identifica��o do emparelhamento
			replace back = p201 !=. if npesq == `i'+1
			replace forw = 0 if forw != 1 & npesq == `i'
			* Identifica��o para quem estava ausente na �ltima entrevista
			replace p201 = `i'00 + v201 if p201 == . & npesq == `i'+1
		}
		/* criando identificacao do individuo, que � mantido em todas as pesquisas */
		tempvar a b c d
		tostring uf, g(`a')
		tostring v102, g(`b') format(%08.0f)
		tostring v103, g(`c') format(%03.0f)
		tostring p201, g(`d') format(%03.0f)
		egen idind = concat(painel `a' `b' `c' `d')
		lab var p201 "numero de ordem correto"
		lab var idind "identificacao do individuo"
		drop __* back forw
		save PME_Painel_`pa'_basic, replace
	}
}

/*Executa a identifica��o de Ribas & Soares*/
qui if "`idrs'" != "" {
	noi di as result "Executando Identifica��o Ribas-Soares ..."
	foreach pa in $panels {
		noi di "Painel `pa'"
		use `PME_Painel`pa'temp'
		
		/*Algoritmo de Ribas e Soares*/
		****************************************************************
		* Nota
		****************************************************************
		/* Este algoritmo pode ser aplicado tanto � nova quanto � antiga
		PME. As vari�veis utilizadas a seguir s�o as da nova pesquisa.
		Para utilizar o algoritmo com a antiga PME basta substituir
		as seguintes vari�veis:
		Na nova Na antiga
		v035 = Regi�o Metropolitana = v010
		v040 = N�mero de controle = v102
		v050 = N�mero de s�rie = v103
		v060 = Painel = deve ser constru�da
		v063 = Grupo rotacional = v106
		v070 = M�s da pesquisa = v105
		v075 = Ano da pesquisa = deve ser constru�da
		v072 = N�mero da pesquisa no domic�lio = deve ser constru�da
		v201 = N�mero de ordem = v201
		v203 = Sexo = v202
		v204 = Dia de nascimento = v206
		v214 = M�s de nascimento = v236
		v224 = Ano de nascimento = v246
		v234 = Idade calculada = v256
		v205 = Condi��o no domic�lio = v203
		vDAE1= Anos de estudo I = deve ser constru�da
		Recomenda-se rod�-lo com arquivos pequenos. Para PME, a sugest�o
		� de um arquivo por painel (vari�vel PAINEL) */
		****************************************************************
		* Vari�veis do painel
		****************************************************************
		* Vari�vel de identifica��o da pessoa no painel
		g p201 = v201 if npesq == 1 /* definido com base na 1a entrevista */
		* Vari�veis que identificam o emparelhamento
		g back = . /* com uma entrevista anterior */
		g forw = . /* com uma entrevista posterior */
		****************************************************************
		* Emparelhamento - 1a loop
		****************************************************************
		* Emparelhamento para cada par de entrevista por vez
		forvalues i = 1/7 {
		****************************************************************
		* Emparelhamento-padr�o - se a data de nascimento est� correta
		****************************************************************
		* Ordenando cada indiv�duo pelo m�s de entrevista
		sort uf v102 v103 painel v0106 v202 v206 v236 v246 ano mes v201
		* Loop para procurar a mesma pessoa em uma posi��o anterior
		loc j = 1 /* j determina a posi��o anterior na base */
		loc stop = 0 /* se stop=1, a loop para */
		loc count = 0
		while `stop' == 0 {
		loc lastcount = `count'
		count if p201 == . & npesq == `i'+1 /* observa��es n�o
		emparelhadas */
		loc count = r(N)
		if `count' == `lastcount' {
		* Parar caso a loop n�o esteja emparelhando mais
		loc stop = 1
		}
		else {
		if r(N) != 0 {
		* Captando a identifica��o p201 da observa��o anterior
		replace p201 = p201[_n - `j'] if /*
		Identifica��o do domic�lio
		*/ uf == uf[_n - `j'] & ///
		v102 == v102[_n - `j'] & ///
		v103 == v103[_n - `j'] & ///
		painel == painel[_n - `j'] & ///
		v0106 == v0106[_n - `j'] & /*
		diferen�a entre per�odos */ npesq == `i'+1 & npesq[_n - `j'] == `i' /*
		excluir emparelhados */ & p201 ==. & forw[_n - `j'] != 1 & /*
		Caracter�sticas individuais
		Sexo */ v202 == v202[_n - `j'] & /*
		Dia de nascimento */ v206 == v206[_n - `j'] & /*
		M�s de nascimento */ v236 == v236[_n - `j'] & /*
		Ano de nascimento */ v246 == v246[_n - `j'] & /*
		Informa��o observada */ v206!=99 & v236!=99 & v246!=9999
		* Identifica��o de emparelhamento para quem est� � frente
		replace forw = 1 if uf == uf[_n + `j'] & ///
		v102 == v102[_n + `j'] & ///
		v103 == v103[_n + `j'] & ///
		painel == painel[_n + `j'] & ///
		v0106 == v0106[_n + `j'] & ///
		p201 == p201[_n + `j'] & ///
		npesq == `i' & npesq[_n + `j']==`i'+1 ///
		& forw != 1
		loc j = `j' + 1 /* passando para a pr�xima observa��o */
		}
		else {
		* Parar se n�o h� observa��es para emparelhar
		loc stop = 1
		}
		}
		}
		* Recodificar vari�veis de identifica��o do emparelhamento
		replace back = p201 !=. if npesq == `i'+1
		replace forw = 0 if forw != 1 & npesq == `i'
		****************************************************************
		* Emparelhamento avan�ado
		****************************************************************
		* Se sexo e ano de nascimento n�o estiverem corretos
		* Isolando observa��es j� emparelhadas
		tempvar aux
		g `aux' = (forw==1 & (npesq==1 | back==1)) | (back==1 & npesq==8)
		* Ordenando cada indiv�duo pelo m�s de entrevista
		sort `aux' uf v102 v103 painel v0106 v206 v236 v201 ano mes
		* Loop para procurar a mesma pessoa em uma posi��o anterior
		loc j = 1 /* j determina a posi��o anterior na base */
		loc stop = 0 /* se stop=1, a loop para */
		loc count = 0
		while `stop' == 0 {
		loc lastcount = `count'
		count if p201 == . & npesq == `i'+1 /* observa��es n�o
		emparelhadas */
		loc count = r(N)
		if `count' == `lastcount' {
		* Parar caso a loop n�o esteja emparelhando mais
		loc stop = 1
		}
		else {
		if r(N) != 0 {
		* Captando a identifica��o p201 da observa��o anterior
		replace p201 = p201[_n - `j'] if /*
		Identifica��o do domic�lio
		*/ uf == uf[_n - `j'] & ///
		v102 == v102[_n - `j'] & ///
		v103 == v103[_n - `j'] & ///
		painel == painel[_n - `j'] & ///
		v0106 == v0106[_n - `j'] & /*
		diferen�a entre per�odos */ npesq == `i'+1 & npesq[_n - `j'] == `i' /*
		excluir emparelhados */ & p201 ==. & forw[_n - `j'] != 1 & /*
		Caracter�sticas individuais
		Dia de nascimento */ v206 == v206[_n - `j'] & /*
		M�s de nascimento */ v236 == v236[_n - `j'] & /*
		Mesmo n�mero de ordem */ v201 == v201[_n - `j'] & /*
		Informa��o observada */ v206!=99 & v236!=99
		* Identifica��o de emparelhamento para quem est� � frente
		replace forw = 1 if uf == uf[_n + `j'] & ///
		v102 == v102[_n + `j'] & ///
		v103 == v103[_n + `j'] & ///
		painel == painel[_n + `j'] & ///
		v0106 == v0106[_n + `j'] & ///
		p201 == p201[_n + `j'] & ///
		npesq == `i' & npesq[_n + `j']==`i'+1 ///
		& forw != 1
		loc j = `j' + 1 /* passando para a pr�xima observa��o */
		}
		else {
		* Parar se n�o h� observa��es para emparelhar
		loc stop = 1
		}
		}
		}
		****************************************************************
		* Emparelhamento avan�ado
		****************************************************************
		* Somente para chefes, c�njuges e filhos adultos
		tempvar ager aux
		* Fun��o de erro na idade presumida
		g `ager' = cond(v256>=25 & v256<999, exp(v256/30), 2)
		* Isolando observa��es j� emparelhadas
		g `aux' = (forw==1 & (npesq==1 | back==1)) | (back==1 & npesq==8)
		* Ordenando cada fam�lia pelo m�s de entrevista
		sort `aux' uf v102 v103 painel v0106 v202 ano mes v256 aest1 v201
		* Loop para procurar a mesma pessoa em uma posi��o anterior
		loc j = 1
		loc stop = 0
		loc count = 0
		while `stop' == 0 {
		loc lastcount = `count'
		count if p201==. & npesq==`i'+1 & ///
		(v203<=2 | (v203==3 & v256>=25 ///
		& v256<999)) /* observa��es n�o emparelhadas */
		loc count = r(N)
		if `count' == `lastcount' {
		loc stop = 1
		}
		else {
		if r(N) != 0 {
		replace p201 = p201[_n - `j'] if /*
		Identifica��o do domic�lio
		*/ uf == uf[_n - `j'] & ///
		v102 == v102[_n - `j'] & ///
		v103 == v103[_n - `j'] & ///
		painel == painel[_n - `j'] & ///
		v0106 == v0106[_n - `j'] & /*
		Diferen�a entre per�odos */ npesq == `i'+1 & npesq[_n - `j'] == `i' /*
		Excluir emparelhados */ & p201 ==. & forw[_n - `j'] != 1 & /*
		Caracter�sticas individuais
		Sexo */ v202 == v202[_n - `j'] & /*
		Diferen�a na idade */ abs(v256 - v256[_n - `j'])<=`ager' & /*
		Idade observada */ v256!=999 & /*
		Se chefe ou c�njuge */ ((v203<=2 & v203[_n - `j']<=2) | /*
		ou filho com mais de 25 */ (v256>=25 & v256[_n - `j']>=25 & ///
		v203==3 & v203[_n - `j']==3)) & /*
		At� 4 dias de erro na data */ ((abs(v206 - v206[_n - `j'])<=4 & /*
		At� 2 meses de erro na data*/ abs(v236 - v236[_n - `j'])<=2 & /*
		Informa��o observada */ v206!=99 & v236!=99) /*
		ou */ | /*
		1 ciclo de erro na educa��o*/ (abs(aest1 - aest1[_n - `j'])<=1 /*
		e */ & /*
		At� 2 meses de erro na data*/ ((abs(v236 - v236[_n - `j'])<=2 & /*
		Informa��o observada */ v236!=99 & /*
		Informa��o n�o observada */ (v206==99 | v206[_n-`j']==99)) /*
		ou */ | /*
		at� 4 dias de erro na data */ (abs(v206 - v206[_n - `j'])<=4 & /*
		Informa��o observada */ v206!=99 & /*
		Informa��o n�o-observada */ (v236==99 | v236[_n - `j']==99)) /*
		ou */ | /*
		informa��es n�o-observadas */ ((v206==99 | v206[_n - `j']==99) & ///
		(v236==99 | v236[_n - `j']==99)))))
		replace forw = 1 if uf == uf[_n + `j'] & ///
		v102 == v102[_n + `j'] & ///
		v103 == v103[_n + `j'] & ///
		painel == painel[_n + `j'] & ///
		v0106 == v0106[_n + `j'] & ///
		p201 == p201[_n + `j'] & ///
		npesq == `i' & npesq[_n + `j']==`i'+1 ///
		& forw != 1
		loc j = `j' + 1
		}
		else {
		loc stop = 1
		}
		}
		}
		replace back = p201 !=. if npesq == `i'+1
		replace forw = 0 if forw != 1 & npesq == `i'
		****************************************************************
		* Emparelhamento avan�ado
		****************************************************************
		* Somente em domic�lio onde algu�m j� emparelhou
		* Quantas pessoas emparelharam no domic�lio
		tempvar dom
		bys ano mes uf v102 v103 painel v0106: egen `dom' = sum(back)
		* Loop com os crit�rios de emparelhamento
		foreach w in /*mesma idade*/ "0" /*erro na idade = 1*/ "1" /*
		erro na idade = 2*/ "2" /*erro na idade = f(idade)*/ "`ager'" /*
		2xf(idade)*/ "2*`ager' & v256>=25" {
		* Isolando observa��es j� emparelhadas
		tempvar aux
		g `aux' = (forw==1 & (npesq==1 | back==1)) | ///
		(back==1 & npesq==8) | (`dom'==0 & npesq==`i'+1)
		sort `aux' uf v102 v103 painel v0106 v202 ano mes v256 ///
		aest1 v201
		loc j = 1
		loc stop = 0
		loc count = 0
		while `stop' == 0 {
		loc lastcount = `count'
		count if p201 == . & npesq == `i'+1 & `dom'>0 & `dom'!=.
		loc count = r(N)
		if `count' == `lastcount' {
		loc stop = 1
		}
		else {
		if r(N) != 0 {
		replace p201 = p201[_n - `j'] if /*
		Identifica��o do domic�lio
		*/ uf == uf[_n - `j'] & ///
		v102 == v102[_n - `j'] & ///
		v103 == v103[_n - `j'] & ///
		painel == painel[_n - `j'] & ///
		v0106 == v0106[_n - `j'] & /*
		Diferen�a entre per�odos */ npesq == `i'+1 & npesq[_n-`j'] == `i' /*
		excluir emparelhados */ & p201 ==. & forw[_n - `j'] != 1 & /*
		h� emparelhados no domic�lio*/ `dom' > 0 & `dom'!=. & /*
		Caracter�sticas individuais
		Sexo */ v202 == v202[_n - `j'] & /*
		Crit�rios mudam com a loop */ ((abs(v256-v256[_n - `j'])<=`w' & /*
		se a idade � observada */ v256!=999) /*
		caso contr�rio */ | /*
		Mesma escolaridade */ (aest1==aest1[_n - `j'] & /*
		Mesma condi��o no domic�lio */ v203==v203[_n - `j'] & /*
		Idade n�o observada */ (v256==999 | v256[_n - `j']==999)))
		replace forw = 1 if uf == uf[_n + `j'] & ///
		v102 == v102[_n + `j'] & ///
		v103 == v103[_n + `j'] & ///
		painel == painel[_n + `j'] & ///
		v0106 == v0106[_n + `j'] & ///
		p201 == p201[_n + `j'] & ///
		npesq ==`i' & npesq[_n+`j']==`i'+1 ///
		& forw != 1
		loc j = `j' + 1
		}
		else {
		loc stop = 1
		}
		}
		}
		}
		replace back = p201 !=. if npesq == `i'+1
		replace forw = 0 if forw != 1 & npesq == `i'
		* Identifica��o para quem estava ausente na �ltima entrevista
		replace p201 = `i'00 + v201 if p201 == . & npesq == `i'+1
		}
		****************************************************************
		* Recuperar quem saiu e retornou para o painel - 2a loop
		****************************************************************
		* Vari�vel tempor�ria identificando o emparelhamento � frente
		tempvar fill
		g `fill' = forw
		* Loop retrospectivo por entrevista
		foreach i in 7 6 5 4 3 2 1 {
		tempvar ncode1 ncode2 aux max ager
		* Fun��o de erro na idade presumida
		g `ager' = cond(v256>=25 & v256<999, exp(v256/30), 2)
		* Vari�vel que preserva o antigo n�mero
		bys uf v102 v103 painel v0106 p201: g `ncode1' = p201
		* Isolando observa��es emparelhadas
		g `aux' = ((`fill'==1 & (npesq==1 | back==1)) | (back==1 & npesq==8))
		* Vari�vel identificando a �ltima entrevista
		bys uf v102 v103 painel v0106 p201: egen `max' = max(npesq)
		sort `aux' uf v102 v103 painel v0106 v202 npesq v201 p201
		loc j = 1
		loc stop = 0
		loc count = 0
		while `stop' == 0 {
		loc lastcount = `count'
		count if p201>`i'00 & p201<`i'99 & back==0
		loc count = r(N)
		if `count' == `lastcount' {
		loc stop = 1
		}
		else {
		if r(N) != 0 {
		replace p201 = p201[_n - `j'] if /*
		Identifica��o do domic�lio
		*/ uf == uf[_n - `j'] & ///
		v102 == v102[_n - `j'] & ///
		v103 == v103[_n - `j'] & ///
		painel == painel[_n - `j'] & ///
		v0106 == v0106[_n - `j'] & /*
		Quem entrou na entrevista i*/ p201>`i'00 & p201<`i'99 & /*
		N�o emparelhado */ back==0 & `fill'[_n - `j']!=1 & /*
		Uma entrev. de diferen�a */ `max'[_n - `j']<`i' & ///
		p201[_n - `j']<`i'00-100 & /*
		Sexo */ v202 == v202[_n - `j'] & /*
		Diferen�a na idade */ ((abs(v256 - v256[_n - `j'])<=`ager' & /*
		Idade observada */ v256!=999 & /*
		At� 4 dias de erro na data */ ((abs(v206 - v206[_n - `j'])<=4 & /*
		At� 2 meses de erro na data*/ abs(v236 - v236[_n - `j'])<=2 & /*
		informa��o observada */ v206!=99 & v236!=99) /*
		ou */ | /*
		1 ciclo de erro na educa��o*/ (abs(aest1 - aest1[_n - `j'])<=1 /*
		e */ & /*
		At� 2 meses de erro na data*/ ((abs(v236 - v236[_n - `j'])<=2 & /*
		Informa��o observada */ v236!=99 & /*
		Informa��o n�o-observada */ (v206==99 | v206[_n - `j']==99)) /*
		ou */ | /*
		at� 4 dias de erro na data */ (abs(v206 - v206[_n - `j'])<=4 & /*
		Informa��o observada */ v206!=99 & /*
		Informa��o n�o-observada */ (v236==99 | v236[_n - `j']==99)) /*
		ou */ | /*
		nada � observado */ ((v206==99 | v206[_n - `j']==99) & ///
		(v236==99 | v236[_n - `j']==99)))))) /*
		ou */ | /*
		mesma escolaridade */ (aest1==aest1[_n - `j'] & /*
		e n�mero de ordem */ v203==v203[_n - `j'] /*
		Se idade n�o � observada */ & (v256==999 | v256[_n - `j']==999)))
		* Identifica��o de emparelhamento para quem est� � frente
		replace `fill' = 1 if uf == uf[_n + `j'] & ///
		v102 == v102[_n + `j'] & ///
		v103 == v103[_n + `j'] & ///
		painel == painel[_n + `j'] & ///
		v0106 == v0106[_n + `j'] & ///
		p201 == p201[_n + `j'] & ///
		`fill' == 0 & `max'<`i' & ///
		(npesq[_n + `j'] - npesq)>=2
		loc j = `j' + 1
		}
		else {
		loc stop = 1
		}
		}
		}
		* Igualando o n�mero de quem era igual
		bys uf v102 v103 painel v0106 `ncode1': egen `ncode2' = min(p201)
		replace p201 = `ncode2'
		}
		/* criando identificacao do individuo, que � mantido em todas as pesquisas */
		tempvar a b c d
		tostring uf, g(`a')
		tostring v102, g(`b') format(%08.0f)
		tostring v103, g(`c') format(%03.0f)
		tostring p201, g(`d') format(%03.0f)
		egen idind = concat(painel `a' `b' `c' `d')
		lab var p201 "numero de ordem correto"
		lab var idind "identificacao do individuo"
		drop __* back forw
		save PME_Painel_`pa'_rs, replace
	}
}

di _newline "As bases de dados foram salvas em `caminhoprin'"
cd "`saving'"
end


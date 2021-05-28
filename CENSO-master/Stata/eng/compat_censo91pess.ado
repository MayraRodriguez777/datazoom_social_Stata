program define compat_censo91pess

/* A. ANO */
* Essa vari�vel � definida antes de chamar este programa.


/* B. IDENTIFICA��O E N�MERO DE PESSOAS */

/* B.1. IDENTIFICA��O */
rename v1101 UF

rename v0102 id_dom

drop v7002 v1102 

rename v0098 ordem

* renda do casal
drop v3043 v3044 v3046- v3049 

* numero de ordem da mae
drop v3005

rename v7004 regiao
* regiao  = 1 regi�o norte
*         = 2 regi�o nordeste
*         = 3 regi�o sudeste
*         = 4 regi�o sul
*         = 5 regi�o centro-oeste

/* B.2. VARI�VEIS DE N�MERO DE PESSOAS */
rename v3041 n_homem_fam
rename v3042 n_mulher_fam
egen n_pes_fam = rowtotal(n_homem_fam n_mulher_fam)
lab var n_pes_fam "total number of people in the family"
* Pessoas no domic�lio: n�o dispon�vel no registro de pessoas.


/* D. OUTRAS VARI�VEIS PESSOA */

/* D.1. SEXO */
recode v0301 (2=0) // (1=1)
rename v0301 sexo
* sexo = 0 - feminino
*        1 - masculino

/* D.2. CONDI��O NA FAM�LIA E NO DOMIC�LIO */
recode v0302 (3 4 = 3) (5 6 = 4) (8=5) (10=6) (7 9 11 12 = 7) (13=8) /// (1=1) (2=2)
             (14=9) (15=10) (16=11) (20=12)
rename v0302 cond_dom
* cond_dom =  1 - Pessoa respons�vel
*                 2 - C�njuge, companheiro(a)
*                 3 - Filho(a), enteado(a)
*                 4 - Pai, m�e, sogro(a)
*                 5 - Neto(a), bisneto(a)
*                 6 - Irm�o, irm�
*                 7 - Outro parente
*                 8 - Agregado(a)
*                 9 - Pensionista
*                10 - Empregado(a) dom�stico(a)
*                11 - Parente do(a) empregado(a) dom�stico(a)
*                12 - Individual em domic�lio coletivo

recode v0303 (3 4 = 3) (5 6 = 4) (8=5) (10=6) (7 9 11 12 = 7) (13=8) /// (1=1) (2=2)
             (14=9) (15=10) (16=11) (20=12)
rename v0303 cond_fam
* cond_fam =  1 - Pessoa respons�vel
*                 2 - C�njuge, companheiro(a)
*                 3 - Filho(a), enteado(a)
*                 4 - Pai, m�e, sogro(a)
*                 5 - Neto(a), bisneto(a)
*                 6 - Irm�o, irm�
*                 7 - Outro parente
*                 8 - Agregado(a)
*                 9 - Pensionista
*                10 - Empregado(a) dom�stico(a)
*                11 - Parente do(a) empregado(a) dom�stico(a)
*                12 - Individual em domic�lio coletivo

gen cond_dom_B = cond_dom
recode cond_dom_B (5/7 = 5) (8=6) (9=7) (10=8) (11=9) (12=10) // 1 a 4 mantidos
lab var cond_dom_B "status inside the household B"

gen cond_fam_B = cond_fam
lab var cond_fam_B "status inside the family B"
recode cond_fam_B (5/7 = 5) (8=6) (9=7) (10=8) (11=9) (12=10) // 1 a 4 mantidos
* cond_***_B =  1 - Pessoa respons�vel
*               2 - C�njuge, companheiro(a)
*               3 - Filho(a), enteado(a)
*               4 - Pai, m�e, sogro(a)
*               5 - Outro parente
*               6 - Agregado
*               7 - H�spede, pensionista
*               8 - Empregado(a) dom�stico(a)
*               9 - Parente do(a) empregado(a) dom�stico(a)
*              10 - Individual em domic�lio coletivo

rename v0304 num_fam

* tipo de familia
drop v2011 // s� em 1991

/* D.3. IDADE */
recode v3071 (2=0) // (1=1)
rename v3071 idade_presumida
* idade_presumida = 0 - n�o
*                   1 - sim

rename v3072 idade
rename v3073 idade_meses

/* D.4. COR OU RA�A */
recode v0309 (9=.)
rename v0309 raca
* raca = 1 - branca
*        2 - preta
*        3 - amarela
*        4 - parda
*        5 - ind�gena

gen racaB = raca
recode racaB (5=4) // 1 a 4 mantidos
lab var racaB "race/ethnicity (indigenous=mulatto)"
* racaB = 1 - branca
*         2 - preta
*         3 - amarela
*         4 - parda

/* D.5. RELIGI�O */
recode v0310 (11=1) (21/30 = 2) (31/41 45 = 3) (61=4) (62 63 = 5) (75 76 77 79 = 6) ///
             (71=7) (49 51 52 53 59 81 82 83 84 12 13 19 = 8) (85 86 89 99 = .)
rename v0310 religiao
* religiao = 0 - sem religi�o
*            1 - cat�lica
*            2 - evang�lica tradicional
*            3 - evang�lica pentecostal
*            4 - esp�rita kardecista
*            5 - esp�rita afro-brasileira
*            6 - religi�es orientais
*            7 - judaica/israelita
*            8 - outras religi�es

gen religiao_B = religiao
recode religiao_B (3=2) (4 5 = 3) (6/8 = 4)
lab var religiao_B "religion B - aggregated"
* religiao_B = 0 - sem religi�o
*              1 - cat�lica
*              2 - evang�lica
*              3 - esp�rita
*              4 - outra

/* D.6. DEFICI�NCIAS F�SICA E MENTAL */
* foi retirado da compatibilizacao porque o item � analisada em uma �nica
* pergunta, diferentemente dos anos subsequentes
drop v0311

/* D.7. NATURALIDADE E MIGRA��O */

*** Condi��o de migrante
gen sempre_morou = 0 if (v0314 == 2 | v0314 == 3)
replace sempre_morou = 1 if v0314 == 1
label var sempre_morou "always lived in this municipality"
* sempre_morou = 0 - n�o
*                1 - sim

recode v0312 (1=0) (2=1) (3=2)
rename v0312 onde_morou
* sitmorou_mun = 0 s� na zona urbana
*                1 s� na zona rural
*                2 nas zonas urbana e rural

* O quesito abaixo s� � pesquisado em 1991.
drop v0313

*** Nacionalidade e naturalidade
recode v0314 (3=0) (2=1) // (1=1)
rename v0314 nasceu_mun
* nasceu_mun = 0 n�o
*              1 sim


recode v3151 (1=0) (2=1) (3=2)
replace v3151 = 0 if nasceu_mun==1
rename v3151 nacionalidade
* nacionalidade = 0 - brasileiro nato
*                 1 - brasileiro naturalizado
*                 2 - estrangeiro

replace v3152 = . if nacionalidade == 0 // originalmente amb�guo: bras nato ou
										// estrangeiro que fixou res at� 1900
replace v3152 = 1900 + v3152 if (v3152 >= 0 & v3152 <= 91)
rename v3152 ano_fix_res

gen UF_nascim = v0316
replace UF_nascim = . if (v0316 >= 30 & v0316 != .)
recode UF_nascim (1=11) (2=12) (3=13) (4=14) (5=15) (6=16) (7=17) (8=21) (9=22) (10=23) ///
				 (11=24) (12=25) (13=26) (14=27) (15=28) (16=29) (17=31) (18=32) (19=33) ///
				 (20=35) (21=41) (22=42) (23=43) (24=50) (25=51) (26=52) (27=53) (29=.)
*	replace UF_nascim = UF if nasceu_mun==1
label var UF_nascim "State of birth"
* UF_nascim = 11-53 UF de nascimento especificada

gen nasceu_UF = 0
replace nasceu_UF = 1 if UF_nascim == UF | nasceu_mun==1
label var nasceu_UF "Born in current State"
* nasceu_UF = 0 n�o
*             1 sim

recode v0316 (1/29 99 = .)	///
	(82 84 85 = 83 )	///
	(83 = 82 )	///
	(86 87=84 ) ///
	(88=86 ) ///
	(89=87 ) ///
	(90=88 ) ///
	(91=89 ) ///
	(92=90 ) ///
	(93=91 ) ///
	(94=92 ) ///
	(95=93 ) ///
	(96=94 ) ///   
	(97=95 ) ///
	(98=96 ), copy g(pais_nascim)
* pais_nascim = 30-98 pa�s estrangeiro especificado
* 83 = Africa - outros  
* 82 = Egito	
* 84 = China 
* 86 = Cor�ia 
* 87 = �ndia 
* 88 = Israel 
* 89 = Jap�o 
* 90 = L�bano 
* 91 = Paquist�o 
* 92 = S�ria 
* 93 = Turquia 
* 94 = �sia - outros 
* 95 = Australis
* 96 = Oceania
label var pais_nascim "Country of birth - 1970 codes"
* pais_nascim = 30-98 pa�s estrangeiro especificado
drop v0316

*** �ltima migra��o

rename v0317 anos_mor_UF
rename v0318 anos_mor_mun

* em 1970, somente quem n�o nasceu no munic�pio responde �s quest�es de tempo de moradia
g t_mor_UF_70 = anos_mor_UF
g t_mor_mun_70 = anos_mor_mun
recode t_mor_UF_70 t_mor_mun_70 (7/10=6) (11/max=7)

lab var t_mor_UF_70 "time of residence in current State - 1970 ranges"
lab var t_mor_mun_70 "time of residence in current Municipality - 1970 ranges"

* De 1980 em diante, podemos montar a variavel de tempo de moradia incluindo
* pessoas que nasceram mas nem sempre moraram no municipio em que residem
recode anos_mor_UF (7/9 =6) (10/max =7), g(t_mor_UF_80)
recode anos_mor_mun (7/9 =6) (10/max =7), g(t_mor_mun_80)
lab var t_mor_UF_80 "time of residence in current State - 1980 ranges"
lab var t_mor_mun_80 "time of residence in current Municipality - 1980 ranges"

*** Onde morava anteriormente - para quem migrou nos �ltimos 10 anos:
gen pais_mor_ant = v3191 if v0319 == 80
recode pais_mor_ant (0/29 99=.)	///
	(82 84 85 = 83 )	///
	(83 = 82 )	///
	(86 87=84 ) ///
	(88=86 ) ///
	(89=87 ) ///
	(90=88 ) ///
	(91=89 ) ///
	(92=90 ) ///
	(93=91 ) ///
	(94=92 ) ///
	(95=93 ) ///
	(96=94 ) ///   
	(97=95 ) ///
	(98=96 )
label var pais_mor_ant "Previous Country of residence (if migrated in the last 10 years)"
* pais_mor_ant = 30-98 pa�s estrangeiro especificado

gen long mun_mor_ant = 10000*v0319 + v3191 if v0319 <= 53
label var mun_mor_ant "Previous Municipality of residence (if migrated in the last 10 years)"

recode v0319 (0 54 80 99=.)
rename v0319 UF_mor_ant
label var UF_mor_ant "Previous State of residence (if migrated in the last 10 years)"
* UF_mor_ant = 11-53 c�digo da UF em que morava

drop v3191

recode v0320 (9=.) (2=0) // (1=1)
rename v0320 sit_mun_ant
* sit_mun_ant = 1 zona urbana
*               0 zona rural

*** Local de resid�ncia h� 5 anos:
gen pais_mor5anos = v3211 if v0321 == 80
recode pais_mor5anos (0/29 99=.)	///
	(82 84 85 = 83)	///
	(83 = 82)	///
	(86 87=84) ///
	(88=86) ///
	(89=87) ///
	(90=88) ///
	(91=89) ///
	(92=90) ///
	(93=91) ///
	(94=92) ///
	(95=93) ///
	(96=94) ///   
	(97=95) ///
	(98=96)
label var pais_mor5anos "Country of residence 5 years ago"
* pais_mor5anos = 30-98 c�digo de pa�s/regi�o estrangeiro(a)

gen long mun_mor5anos = 10000*v0321 + v3211 if v0321 <= 53
label var mun_mor5anos "Municipality of residence 5 years ago"
drop v3211

recode v0321 (54 70 80 99=.) // 70 � n�o-migrante
rename v0321 UF_mor5anos
label var UF_mor5anos "State of residence 5 years ago"
* UF_mor5anos = 11-53 c�digo de UF em que morava

recode v0322 (2=0) (9=.) // (1=1)
replace v0322 =. if pais_mor5anos~=.
rename v0322 sit_dom5anos
label var sit_dom5anos "Household setting of hh where was living 5 years ago"
* sit_dom5anos = 1 zona urbana
*                0 zona rural

/* D.8. EDUCA��O */
recode v0323 (2=0) // (1=1)
rename v0323 alfabetizado
* alfabetizado = 0 - n�o
*                1 - sim

gen freq_escola = 0     if idade >= 5
replace freq_escola = 1 if (idade >= 5) & (v0325 ~= 0) // frequenta curso seriado
replace freq_escola = 1 if (idade >= 5) & ((v0326>=2 & v0326<=4) | v0326==6) // frequenta curso n�o-seriado
lab var freq_escola "school attendance"

gen freq_escolaB = freq_escola
replace freq_escolaB = 1 if v0326 == 1 // inclui pr�-escola
lab var freq_escolaB "school attendance - including pre-school"


* Anos de estudo - c�lculo do IBGE
recode v3241 (20 = .) (17=16) (30 = 0) // 20 � "indefinido"; lim em 16 pois � m�ximo em 1970
rename v3241 anos_estudo
* anos_estudo = 0      - Sem instru��o ou menos de 1 ano
*               1 a 15 - N�mero de anos
*               16     - 16 anos ou mais


* Anos de estudo "B" - n�vel de escolaridade associado � s�rie atualmente cursada

* Para quem n�o freq�enta, usamos anos_estudo:
gen anos_estudoB = anos_estudo if freq_escola == 0
lab var anos_estudoB "years of schooling - associated with grade attended currently"

* Frequentando cursos n�o seriados:
replace anos_estudoB = 0  if (freq_escola == 1) & (v0326 >= 1) & (v0326 <= 2) // pr�-escola, alfabetiza��o de adultos
* Na situa�ao abaixo, supletivo de 1o grau, IBGE tem optado por considerar n�vel "indefinido"
*replace anos_estudoB = 0  if (freq_escola == 1) & (v0326 == 3) // suplet 1o grau
replace anos_estudoB = 8  if (freq_escola == 1) & (v0326 == 4) // suplet 2o grau
replace anos_estudoB = 11 if (freq_escola == 1) & (v0326 == 5) // pr�-vestibular
replace anos_estudoB = 15 if (freq_escola == 1) & (v0326 == 6) // mestrado ou doutorado

* Frequentando cursos seriados:
replace anos_estudoB = v0324 - 1  if (freq_escola == 1) & (v0324 >= 1) & (v0324 <= 8) & ((v0325 == 1) | (v0325 == 4)) // 1o grau reg ou supletivo
replace anos_estudoB = v0324 + 7  if (freq_escola == 1) & (v0324 >= 1) & (v0324 <= 3) & ((v0325 == 2) | (v0325 == 5)) // 2o grau reg ou supletivo
replace anos_estudoB = 10         if (freq_escola == 1) & (v0324 >= 4) & (v0324 <= 8) & ((v0325 == 2) | (v0325 == 5)) // n�o terminou m�dio, n�o pode receber 11 anos
replace anos_estudoB = v0324 + 10 if (freq_escola == 1) & (v0324 >= 1) & (v0324 <= 5) & (v0325 == 3)                  // superior
replace anos_estudoB = 15         if (freq_escola == 1) & (v0324 >= 6) & (v0324 <= 8) & (v0325 == 3)                  // atribuo no m�x 15 anos p/ superior incompleto

* Gupos de Anos de Estudo
* para quem frequenta escola
recode anos_estudoB (min/3 = 0) (4/7 = 1) (8/10 = 2) (11/14 = 3) (15/max = 4), g(anos_estudoC)
replace anos_estudoC = . if freq_escola==0
replace anos_estudoC = 0 if freq_escola==1 & v0326 == 3		// suplet 1o grau
replace anos_estudoC = 3 if freq_escola==1 & v0325==3 & anos_estudoC==4 	// superior sem conclusao

* para quem nao frequenta escola
replace anos_estudoC = 0 if freq_escola==0 & (v0328==1 | v0328==0) 	// alfabetizacao de adultos/nenhum
replace anos_estudoC = 0 if freq_escola==0 & v0328==2 	// primario
replace anos_estudoC = 0 if freq_escola==0 & v0328==4 & v0327>=1 & v0327<=3 	// 1a-3a serie 1o.grau
replace anos_estudoC = 1 if freq_escola==0 & v0328==4 & v0327>=4 & v0327<=8 	// 4a-8a serie 1o.grau

replace anos_estudoC = 1 if freq_escola==0 & v0328==2 & v0329>=1 & v0329<=8	// primario com conclusao
replace anos_estudoC = 1 if freq_escola==0 & v0328==3 	// ginasio/medio 1o.ciclo
replace anos_estudoC = 2 if freq_escola==0 & v0328==3 & v0329>=10 & v0329<=23 // ginasio/medio 1o.ciclo com conclusao

replace anos_estudoC = 2 if freq_escola==0 & v0328==4 & v0327>=4 & v0327<=8 & v0329>=10 & v0329<=23	// 4a-8a serie 1o.grau com conclusao
replace anos_estudoC = 2 if freq_escola==0 & v0328==5 	// 2o.grau
replace anos_estudoC = 2 if freq_escola==0 & v0328==6 	// colegiaa/medio 2o.ciclo

replace anos_estudoC = 3 if freq_escola==0 & v0328==5 & v0329>=24 & v0329<=42		// 2o.grau com conclusao
replace anos_estudoC = 3 if freq_escola==0 & v0328==6 & v0329>=24 & v0329<=42		// colegiaa/medio 2o.ciclo com conclusao
replace anos_estudoC = 3 if freq_escola==0 & v0328==7 	// superior

replace anos_estudoC = 4 if freq_escola==0 & v0328==7 & v0329>=43 & v0329<=97	// superior com conclusao
replace anos_estudoC = 4 if freq_escola==0 & v0328==8 	// mestrado/doutorado

lab var anos_estudoC "groups of years of schooling"

* anos_estudoC = 0 � sem instru��o ou menos de 3 anos de estudo (prim�rio incompleto)
*                1 � de 4 a 7 (fundamental/ gin�sio/ 1�. Grau/ m�dio primeiro ciclo incompleto)
*				 2 � de 8 a 10 (m�dio/ 2�. Grau/ m�dio segundo ciclo incompleto)
*			 	 3 � de 11 a 14 (m�dio/ 2�. Grau/ m�dio segundo ciclo completo ou superior incompleto)
*			 	 4 � 15 ou mais (superior completo, mestrado, doutorado)

drop v0324- v0328

recode v0329 (1/8 = .) ///
		 (10/42 = .) ///
		 (72/77 80/83 93 94 96 = 3) ///
		 (43/49 65 86 87 = 4) ///
		 (50/63 88 89 = 5) ///
		 (64 66 90 = 6) ///
		 (67/71 78 79 91 92 = 7) ///
		 (84 = 8) ///
		 (85 95 97 = 9)	///
		 (0 = .), g(cursos_c1) 
lab var cursos_c1 "course concluded - classification 1"
* cursos_c1	=	3	ci�ncias humanas
*				4	ci�ncias biol�gicas
*				5	ci�ncias exatas
*				6	ci�ncias agr�rias
*				7	ci�ncias sociais
*				8	militar
*				9	outros cursos

recode v0329 (1/42 = .) /// 
		 (77 94 = 1) ///
		 (74/76 80/83 96 = 2) ///
		 (67/73 78 79 91/93 = 3) ///
		 (43 51 52 58/62 87 89 = 4) ///
		 (50 53/57 63 88 = 5) ///
		 (64/66 90 = 6) ///
		 (44/49 86 = 7) ///
		 (84 = 8) ///
		 (85 95 97 = 9)	///
		 (0 = .), g(cursos_c2)
lab var cursos_c2 "course concluded - CONCLA"
* cursos_c2 =	1	Educa��o
*				2	Artes, Humanidades e Letras
*				3	Ci�ncias Sociais, Administra��o e Direito
*				4	Ci�ncias, Matem�tica e Computa��o
*				5	Engenharia, Produ��o e Constru��o
*				6	Agricultura e Veterin�ria
*				7	Sa�de e Bem-Estar Social    
*				8	Militar
*				9	Outros

rename v0329 curso_concl	// COMP SO PARA CURSO SUPERIOR
* curso_concl = 00 nenhum curso
*             = 01-97 curso conclu�do

/* D.9. SITUA��O CONJUGAL */

recode v0330 (2 = 0)
rename v0330 teve_conjuge
* teve_conjuge = 0 n�o
*              = 1 sim

gen vive_conjuge = 1 if (v3342 >= 1 & v3342 <= 3)
replace vive_conjuge = 0 if v3342 == 4 | v3342 == 5
label var vive_conjuge "live with partner"
* vive_conjuge = 0 - n�o
*                1 - sim
drop v3342

gen estado_conj = v0332 if (v0332 >= 1 & v0332 <=4)
replace estado_conj = v0333 + 1 if (v0333 >= 5 & v0333 <= 8)
replace estado_conj = 5 if teve_conjuge== 0
label var estado_conj "marital status"
* estado_conj = 1 casamento civil e religioso
*               2 s� casamento civil
*               3 s� casamento religioso
*               4 uni�o consensual
*               5 solteiro
*               6 separado(a)
*               7 desquitado(a)/separado(a) judicialmente
*               8 divorciado(a)
*               9 vi�vo(a)
drop v0332 v0333

drop v3311 v3312 v3341


/* D.10. RENDA E ATIVIDADE ECON�MICA */

recode v0345 (2=1) (3=0) // (1=1)
rename v0345 trab_ult_12m
*trab_ult_12m = 0 n�o
*               1 sim

rename v0346 ocup_hab

rename v3461 grp_ocup_hab
* grp_ocup_hab =  1 administrativas
*                 2 t�cnicas, cient�ficas, art�sticas e assemelhadas
*                 3 agropecu�ria e da produ��o extrativa vegetal e animal
*                 4 produ��o extrativa mineral
*                 5 ind�strias de transforma��o e constru��o civil
*                 6 com�rcio e atividades auxiliares
*                 7 transportes e comunica��es
*                 8 presta��o de servi�os
*                 9 defesa nacional e seguran�a p�blica
*                10 outras ocupa��es, ocupa��es mal definidas ou n�o declaradas

rename v0347 ativ_hab

rename v3471 set_ativ_hab
* set_ativ_hab =  1 atividades agropecu�rias, de extra��o vegetal e pesca
*                 2 ind�stria de transforma��o
*                 3 ind�stria da constru��o civil
*                 4 outras atividades industriais (extra��o mineral e servi�os
*                   industriais de utilidade p�blica)
*                 5 com�rcio de mercadorias
*                 6 transporte e comunica��o
*                 7 servi�os auxiliares da atividade econ�mica (t�cnico-profissionais
*                   e auxiliares das atividades econ�micas)
*                 8 presta��o de servi�os (alojamento e alimenta��o, repara��o e
*                   conserva��o, pessoais, domiciliares e divers�es)
*                 9 social(comunit�rias, m�dicas, odontol�gicas e ensino)
*                10 administra��o p�blica, defesa nacional e seguran�a p�blica
*                11 outras atividades (institui��es de cr�dito, seguros e
*                   capitaliza��o, com�rcio e administra��o de im�veis e valores
*                   mobili�rios, organiza��es internacionais e representa��es
*                   estrangeiras, atividades n�o compreendidas nos demais ramos e
*                   atividades mal definidas ou n�o declaradas)

recode v0349 (7 8 = 6) (9=7) (10=8) (11=0) // 1 a 6 mantidos
rename v0349 pos_ocup_hab
* pos_ocup_hab = 0 sem remunera��o
*                1 trabalhador agr�cola volante
*                2 parceiro ou meeiro - empregado
*                3 parceiro ou meeiro - aut�nomo ou conta-pr�pria
*                4 trabalhador dom�stico - empregado
*                5 trabalhador dom�stico - aut�nomo ou conta-pr�pria
*                6 empregado
*                7 aut�nomo ou conta-pr�pria
*                8 empregador

recode pos_ocup_hab (1 =4) (2 3 =1) (4 =2) (5 =3) (6 =4) (7 =5) (8 =6), copy gen(pos_ocup_habB) 
lab var pos_ocup_habB "position in usual occupation B"
* pos_ocup_habB = 0 sem remunera��o
*                 1 parceiro ou meeiro 
*                 2 trabalhador dom�stico - empregado
*                 3 trabalhador dom�stico - aut�nomo ou conta-pr�pria
*                 4 empregado
*                 5 aut�nomo ou conta-pr�pria
*                 6 empregador

drop v0350 v0351 v0352

recode v0353 (2 = .) (3 = 0)
rename v0353 previd_A
* previd_A = 0 n�o
*            1 sim

gen hrs_oc_hab = 1 if v0354 < 15
replace hrs_oc_hab = 2 if (v0354 >= 15) & (v0354 < 30)
replace hrs_oc_hab = 3 if (v0354 >= 30) & (v0354 < 40)
replace hrs_oc_hab = 4 if (v0354 >= 40) & (v0354 < 49)
replace hrs_oc_hab = 5 if (v0354 >= 49) & v0354~=.
lab var hrs_oc_hab "groups of hours usually worked per week - main job"
* hrs_oc_hab = 1 - menos de 15 horas
*              2 - de 15 a 29 horas
*              3 - de 30 a 39 horas
*              4 - de 40 a 48 horas
*              5 - 49 horas ou mais

gen hrs_oc_habB = 1 if v0354 < 15
replace hrs_oc_habB = 2 if (v0354 >= 15) & (v0354 < 40)
replace hrs_oc_habB = 3 if (v0354 >= 40) & (v0354 < 50)
replace hrs_oc_habB = 4 if (v0354 >= 50) & v0354~=.
replace hrs_oc_habB = . if set_ativ_hab==1
lab var hrs_oc_habB "hours worked p/week B - main job - non-agric."
* hrs_oc_habB = 1 - menos de 15 horas
*               2 - de 15 a 39 horas
*               3 - de 40 a 49 horas
*               4 - 50 horas ou mais

gen hrs_oc_habC = hrs_oc_habB
recode hrs_oc_habC (4=3) // 1 a 3 mantidos
lab var hrs_oc_habC "hours worked p/week C - main job - non-agric."
* hrs_oc_habC = 1 - menos de 15 horas
*               2 - de 15 a 39 horas
*               3 - 40 horas ou mais

egen hrs_todas_oc = rowtotal(v0354 v0355)
recode hrs_todas_oc (min/14=1) (15/29=2) (30/39=3) (40/48=4) (49/max=5)
lab var hrs_todas_oc "groups of hours usually worked per week - all jobs"

drop v0354 v0355

recode v0356 (0 9999999=.)
rename v0356 rend_ocup_hab

recode v0357 (0 9999999=.)
rename v0357 rend_outras_ocup

recode v0360 (9999999=.)
recode v0361 (9999999=.)
egen rend_outras_fontes = rowtotal(v0360 v0361)
lab var rend_outras_fontes "other sources income"

recode v3561 (99999999=.) // rendimento total tem 1 d�gito a mais
rename v3561 rend_total
lab var rend_total "total income"

* renda familiar
replace v3045 = . if v3045>99999999
rename v3045 rend_fam

drop v0360 v0361 v3562 v3563 v3564 v3574 v3604 v3614

recode v0358 (4=3) (5=4) (6=5) (7=6) (8=7) (9=8) (0=9) // 1 a 3 mantidos
replace v0358 = 0 if trab_ult_12m == 1
rename v0358 cond_ativ
* cond_ativ = 0 trabalhou nos �ltimos 12 meses
*             1 procurando trabalho - j� trabalhou
*             2 procurando trabalho - nunca trabalhou
*             3 aposentado ou pensionista
*             4 vive de renda
*             5 detento
*             6 estudante
*             7 doente ou inv�lido
*             8 afazeres dom�sticos
*             9 sem ocupa��o
drop v0359

recode cond_ativ (0 2=1) (3/9 =0), copy g(pea)
lab var pea "Economically active population"
* pea	= 1 economicamente ativo
*         0 inativo

/* DEFLACIONANDO RENDAS: refer�ncia = julho/2010 */
g double deflator = 0.000038883
g double conversor = 2750000
lab var deflator "income deflator - reference: 08/2010"
lab var conversor "currency converter"

foreach var in rend_ocup_hab rend_outras_ocup rend_outras_fontes rend_total rend_fam {
		g `var'_def = (`var'/conversor)/deflator
		lab var `var'_def "`var' deflated"
}

drop trab_ult_12m
	
/* D.11. VARI�VEIS DE FECUNDIDADE */
* Em 1970 e 1980, a fecundidade foi investigada para mulheres de 15 anos ou mais;
* A partir de 1991, a idade foi reduzida para 10 anos ou mais

rename v3351 filhos_tot

rename v3352 filhos_hom
rename v3353 filhos_mul

rename v3354 filhos_nasc_vivos
rename v3355 f_nasc_v_hom
rename v3356 f_nasc_v_mul

rename v3360 filhos_vivos
rename v3361 f_vivos_hom
rename v3362 f_vivos_mul

drop v0335 v0336 v0337 v0338 v0339 v0340

rename v3357 filhos_nasc_mortos
rename v0341 f_nasc_m_hom
rename v0342 f_nasc_m_mul

foreach var in filhos_tot filhos_hom filhos_mul filhos_nasc_vivos f_nasc_v_hom ///
	f_nasc_v_mul filhos_vivos f_vivos_hom f_vivos_mul filhos_nasc_mortos ///
	f_nasc_m_hom f_nasc_m_mul {
		replace `var'=. if `var'==99
}


recode v0343 (7 = .) (9 = .) (2=0) // (1=1)
rename v0343 sexo_ult_nasc_v
* sexo_ult_nasc_v = 0 feminino
*                 = 1 masculino

recode v3443 (99 = .)
rename v3443 idade_ult_nasc_v
drop v3444

/* OUTRAS */
rename v7301 peso_pess
order ano UF regiao munic id_dom ordem

end

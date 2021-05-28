program define compat_censo80

/* A. ANO */
* Essa vari�vel � definida antes de chamar este programa.

/* B. IDENTIFICA��O */

/* B.1. IDENTIFICA��O */
rename v2 UF
gen regiao = int(UF/10)
lab var regiao "geographic region"

egen id_muni = concat(UF v5)
lab var id_muni "municipality"
drop v5
rename v6 distrito

g id_dom = sum(v503<=1)
tostring id_dom, replace
lab var id_dom "household identification"
bys id_muni distrito id_dom: gen num_fam = sum(v504<=1)
lab var num_fam "family number"

sort id_muni distrito id_dom num_fam, stable

/* IDENTIFICA PARA QUAIS TIPOS DE REGISTRO DEVE SE FAZER A COMPATIBILIZACAO */
loc d = 0
loc p = 0
foreach n of global x {
	if "`n'" == "dom" loc d = 1
	if "`n'" == "pes" loc p = 1
}

if `d'==1 {
	/* B.2. VARI�VEIS DE N�MERO DE PESSOAS */
	* gerando totais de homens e mulheres nas fam�lias e nos domic�lios
	* v501 == 1 representa sexo masculino; == 3 feminino
	by id_muni distrito id_dom: egen n_homem_dom = total(v501==1)
	by id_muni distrito id_dom: egen n_mulher_dom = total(v501==3)
	egen n_pes_dom = rowtotal(n_homem_dom  n_mulher_dom)

	lab var n_homem_dom "number of male residents"
	lab var n_mulher_dom "number of female residents"
	lab var n_pes_dom "number of people in household"


	/* C. VARI�VEIS DE DOMIC�LIO*/

	/* C.1. SITUA��O */
	recode v198 (3=2) (5=3) (7=4) // (1=1)
	rename v198 sit_setor_B
	lab var sit_setor_B "household situation - aggregated"
	* sit_setor_B = 1 - Vila ou cidade
	*               2 - Urbana isolada
	*               3 - Aglomerado rural
	*               4 - Rural exclusive os aglomerados

	recode v598 (0 =1) (1 = 2)
	rename v598 sit_setor_C
	lab var  sit_setor_C "household situation C - urban/rural"
	* sit_setor_C = 1 - Urbana
	*               0 - Rural

	/* C.2. ESP�CIE */
	recode v201 (1 = 0) (3 = 1) (5 7 = 2)
	rename v201 especie
	* especie = 0 - particular permanente
	*           1 - particular improvisado
	*           2 - coletivo

	/* C.3.	MATERIAL DAS PAREDES */
	recode v203 (2 =1) (4 =2) (6 =3) (7 =4) (8 =5) (0 = 6) (9 =.)
	rename v203 paredes
	* paredes 	= 1   Alvenaria
	*        	= 2   Madeira aparelhada
	*        	= 3   Taipa n�o revestida
	*       	= 4   Material aproveitado
	*   	    = 5   Palha
	*	        = 6   Outro


	/* C.4.	MATERIAL DA COBERTURA */
	recode v205 (0 =8) (9 =.)
	rename v205 cobertura
	*cobertura = 1 laje de concreto
	*		   = 2 telha de barro
	*		   = 3 telha de amianto
	*		   = 4 zinco
	*		   = 5 madeira aparelhada
	*		   = 6 palha
	*		   = 7 material aproveitado
	*		   = 8 outro material

	/* C.5. TIPO */
	recode v202 (3=2) // (1=1)
	rename v202 tipo_dom_B
	* tipo_dom_B = 1 - casa
	*              2 - apartamento (ou c�modo)

	/* C.6. CONDI��O DE OCUPA��O E ALUGUEL */
	gen dom_pago = 1 if v209==1
	replace dom_pago = 0 if v209==3
	lab var dom_pago "dummy for household owned already paid"
	* dom_pago = 0 - Domic�lio pr�prio em aquisi��o
	*            1 - Domic�lio pr�prio j� pago

	recode v209 (3=1) (5=2) (6=3) (7=4) (0=5) (9=.) // (1=1)
	rename v209 cond_ocup
	* cond_ocup = 1 - pr�prio
	*             2 - alugado
	*             3 - cedido por empregador
	*             4 - cedido de outra forma
	*             5 - outra condi��o

	recode cond_ocup (4 = 3) (5 = 4), copy g(cond_ocup_B)
	lab var cond_ocup_B "occupancy condition B"
	* cond_ocup = 1 - pr�prio
	*             2 - alugado
	*             3 - cedido 
	*             4 - outra condi��o

	recode v602 (0 999999 = .)
	rename v602 aluguel

	/* C.7 ABASTECIMENTO DE �GUA */
	recode v206 (6=2) (7=4) (0=5) (9=.) // (1=1) (3=3) (5=5) 
	rename v206 abast_agua
	* abast_agua = 1 - rede geral com canaliza��o interna
	*              2 - rede geral sem canaliza��o interna
	*              3 - po�o ou nascente com canaliza��o interna
	*              4 - po�o ou nascente sem canaliza��o interna
	*              5 - outra forma

	/* C.8. INSTALA��ES SANIT�RIAS */
	gen sanitario = 0 if v207 == 8
	replace sanitario = 1 if (v207 >= 0) & (v207 <= 6) // reportou tipo de escoadouro
	replace sanitario = 1 if (v208 == 1) | (v208 == 3) // reportou uso excl ou coletivo
	lab var sanitario "dummy for access to sanitary"
	* sanitario = 0 - n�o tem acesso
	*                1 - tem acesso

	recode v207 (2 = 1) (4 = 2) (6 = 3) (0 = 4) (8 9 = .)
	rename v207 tipo_esc_san
	* tipo_esc_san = 1 - Rede geral
	*                2 - Fossa s�ptica
	*                3 - Fossa rudimentar
	*                4 - Outro escoadouro

	recode v208 (3 8 = 0) (9 = .) // (1=1)
	rename v208 sanitario_ex
	label var sanitario_ex "exclusive access to toilet"
	* inst_san_exc = 0 - n�o tem acesso a inst san exclusiva
	*                1 - tem acesso a inst sanit�ria exclusiva


	/* C.9. DESTINO DO LIXO */
	*N�o pesquisado em 1980.


	/* C.10. ILUMINA��O EL�TRICA */
	gen medidor_el = 1 if v217 == 2
	replace medidor_el = 0 if v217 == 4
	label var medidor_el "presence of meter electricity consumption"
	* medidor_el = 0 - n�o tem
	*                1 - tem

	recode v217 (2 4 = 1) (8 = 0) (9 = .)
	rename v217 ilum_eletr
	* ilum_eletr = 0 - n�o tem
	*              1 - tem


	/* C.11. BENS DE CONSUMO DUR�VEIS */
	gen fogao_ou_fog = 1 if (v214 == 1) | (v214 == 3) | (v214 == 5)
	replace fogao_ou_fog = 0 if v214 == 8
	label var fogao_ou_fog "stove or hot plate" 
	* fogao_ou_fog = 0 - n�o tem
	*                1 - tem

	recode v214 (3=1) (5 8 = 0) (9=.) // (1=1)
	rename v214 fogao
	label var fogao "stove"
	* fogao = 0 - n�o tem
	*         1 - tem

	recode v215 (2=1) (3=2) (4=3) (5/7 = 4) (8=0) (9=.) // (1=1)
	rename v215 comb_cozinha
	* comb_cozinha = 1 - g�s
	*                2 - lenha
	*                3 - carv�o
	*                4 - outro
	*                0 - n�o tem fog�o nem fogareiro

	gen comb_fogao = comb_cozinha
	replace comb_fogao = 0 if fogao == 0
	lab var comb_fogao "fuel used in the stove"
	* comb_fogao = 1 - g�s
	*              2 - lenha
	*              3 - carv�o
	*              4 - outro
	*              0 - n�o tem fog�o

	recode v216 (8=0) (9=.) // (1=1)
	rename v216 telefone
	* telefone = 0 - n�o tem
	*            1 - tem

	recode v218 (8=0) (9=.) // (1=1)
	rename v218 radio
	* radio = 0 - n�o tem
	*         1 - tem

	recode v219 (8=0) (9=.) // (1=1)
	rename v219 geladeira
	* geladeira = 0 - n�o tem
	*             1 - tem


	gen tv_pb = 1 if v220 == 3 | v220 == 5
	replace tv_pb = 0 if v220 == 1 | v220 == 8
	label var tv_pb "black-&-white TV"
	recode v220 (3=1) (5 8 = 0) (9=.) // (1=1)
	rename v220 tv_cores
	label var tv_cores "color TV"
	gen televisao = 0 if tv_pb == 0 & tv_cores == 0
	replace televisao = 1 if (tv_pb == 1) | (tv_cores == 1)
	lab var televisao "television"
	* televisao, tv_pb, tv_cores = 0 - n�o tem
	*                              1 - tem

	gen automov_part = 1 if v221 == 1
	replace automov_part = 0 if (v221 == 3) | (v221 == 8)
	lab var automov_part "particular automobile"

	recode v221 (3=1) (8=0) (9=.) // (1=1)
	rename v221 automovel
	* automovel, automov_part = 0 - n�o tem
	*                           1 - tem

	/* C.12. N�MERO DE C�MODOS */
	recode v212 v213 (99=.)
	rename v212 tot_comodos
	rename v213 tot_dorm

	/* C.13. RENDA DOMICILIAR */
	* Ver parte D.10.

	/* C.14. PESO AMOSTRAL */
	rename v603 peso_dom

	/* Vari�veis de domic�lio n�o utilizadas */
	drop v204 v211 
	

	/* DEFLACIONANDO RENDAS: refer�ncia = julho/2010 */
	
	g double deflator = 0.000033234/10^7
	g double conversor = 2750000000000
	lab var deflator "income deflator - reference: 08/2010"
	lab var conversor "currency converter"

	g aluguel_def = (aluguel/conversor)/deflator
	lab var aluguel_def "aluguel deflated"
}


if `p'==1 {

	/* n�mero de pessoas na fam�lia */
	by id_muni distrito id_dom num_fam: egen n_homem_fam = total(v501==1)
	by id_muni distrito id_dom num_fam: egen n_mulher_fam = total(v501==3)
	egen n_pes_fam = rowtotal(n_homem_fam n_mulher_fam)

	lab var n_homem_fam "number of men in the family"
	lab var n_mulher_fam "number of women in the family"
	lab var n_pes_fam "number of people in the family"

	/* D. OUTRAS VARI�VEIS PESSOA*/

	rename v500 ordem

	/* D.1. SEXO */

	recode v501 (3=0) // (1=1)
	rename v501 sexo
	* sexo = 0 - feminino
	*      = 1 - masculino

	/* D.2. CONDI��O NA FAM�LIA E NO DOMIC�LIO */
	recode v503 (0=10), g(cond_dom_B)
	lab var cond_dom_B "Status inside the household"
	* cond_dom_B =  1 - Pessoa respons�vel
	*               2 - C�njuge, companheiro(a)
	*               3 - Filho(a), enteado(a)
	*               4 - Pai, m�e, sogro(a)
	*               5 - Genro, nora, outro parente
	*               6 - Agregado
	*               7 - H�spede, pensionista
	*               8 - Empregado(a) dom�stico(a)
	*               9 - Parente do(a) empregado(a) dom�stico(a)
	*              10 - Individual em domic�lio coletivo

	recode v504 (0=10), g(cond_fam_B)
	lab var cond_fam_B "Status inside the family"
	* cond_fam_B =  1 - Pessoa respons�vel
	*               2 - C�njuge, companheiro(a)
	*               3 - Filho(a), enteado(a)
	*               4 - Pai, m�e, sogro(a)
	*               5 - Genro, nora, outro parente
	*               6 - Agregado
	*               7 - H�spede, pensionista
	*               8 - Empregado(a) dom�stico(a)
	*               9 - Parente do(a) empregado(a) dom�stico(a)
	*              10 - Individual em domic�lio coletivo


	/* D.3. IDADE */
	replace v605=. if v606~=0
	rename v605 idade_meses
	recode v606 (999=.)
	rename v606 idade

	/* D.4. COR OU RA�A */
	recode v509 (2 = 1) (4 = 2) (6 = 3) (8 = 4) (9 = .)
	rename v509 racaB
	* racaB = 1 - branca
	*                2 - preta
	*                3 - amarela
	*                4 - parda


	/* D.5. RELIGI�O */
	replace v508=. if v508==9
	rename v508 religiao
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
	lab var religiao_B "religion B - more aggregated"
	* religiao_B = 0 - sem religi�o
	*              1 - cat�lica
	*              2 - evang�lica
	*              3 - esp�rita
	*              4 - outra

	/* D.6. DEFICI�NCIAS F�SICA E MENTAL */
	* Este quesito n�o foi investigado em 1980.


	/* D.7. NATURALIDADE E MIGRA��O */
	*** Condi��o de migrante
	gen sempre_morou = 0
	replace sempre_morou = 1 if v515 == 8
	label var sempre_morou "always lived in this municipality"
	* sempre_morou = 0 - n�o
	*                1 - sim

	recode v514 (2 = 0) (4 = 1) (6 = 2) (9 = .)
	rename v514 onde_morou
	* onde_morou   = 0 s� na zona urbana
	*                1 s� na zona rural
	*                2 nas zonas urbana e rural

	*** Nacionalidade e naturalidade
	recode v511 (2 = 0) (4 = 1) (6 = 2)
	rename v511 nacionalidade
	* nacionalidade = 0 - brasileiro nato
	*                 1 - brasileiro naturalizado
	*                 2 - estrangeiro

	recode v512 (1=11) (2=12) (3=13) (4=14) (5=15) (6=16) (7=21) (8=22) (9=23) ///
	 (10=24) (11=25) (12=26) (13=27) (14=26) (15=28) (16=29) (17=31) (18=32) ///
	 (19=33) (20=35) (21=41) (22=42) (23=43) (24=50) (25=51) (26=52) (27=53) (29=999) ///
	 (else=.), g(nasceu_UF) 
	replace nasceu_UF = 1 if nasceu_UF== UF
	replace nasceu_UF = 0 if nasceu_UF>1 & nasceu_UF~=999
	replace nasceu_UF=. if nasceu_UF==999
	label var nasceu_UF "Born in current State"
	* nasceu_UF = 0 n�o
	*             1 sim

	gen UF_nascim = v512 if nasceu_UF==0
	replace UF_nascim = . if v512 >= 29
	recode UF_nascim (1=11) (2=12) (3=13) (4=14) (5=15) (6=16) (7=21) (8=22) (9=23) ///
	 (10=24) (11=25) (12=26) (13=27) (14=26) (15=28) (16=29) (17=31) (18=32) ///
	 (19=33) (20=35) (21=41) (22=42) (23=43) (24=50) (25=51) (26=52) (27=53)
	lab var UF_nascim "State of birth"
	* UF_nascim = 11-53 UF de nascimento especificada

	gen pais_nascim = v512
	replace pais_nascim = . if v512 < 30 | v512==99
	recode pais_nascim (57 = 58) (82 84 85 = 83) (83=82 )	(86 87 =84 ) ///
		(88=86 ) (89=87 ) (90=88 ) (91=89 ) (92=90 ) (93=91 ) ///
		(94=92 ) (95=93 ) (96=94 ) (97=95) (98=96)
	* pais_nascim = 30-98 pa�s estrangeiro especificado
	* 58 = Alemanha
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
	* 95 = Australia
	* 96 = Oceania
	lab var pais_nascim "Country of birth - 1970 codes"
	drop v512
	
	recode v513 (8 = 0)		// 1=1
	rename v513 nasceu_mun
	* nasceu_mun = 0 - n�o
	*              1 - sim

	*** �ltima migra��o

	* De 1980 em diante, podemos montar a variavel de tempo de moradia incluindo
	* pessoas que nasceram mas nem sempre moraram no municipio em que residem
	
	recode v517 (8 9=.)
	rename v517 t_mor_mun_80
	* t_mor_mun_80 =  0 - menos de 1 ano
	*                 1 - 1 ano
	*                 2 - 2 anos
	*                 3 - 3 anos
	*                 4 - 4 anos
	*                 5 - 5 anos
	*                 6 - 6 a 9 anos
	*                 7 - 10 anos e mais

	recode v516 (9=.)
	replace v516 = idade if (v516 == 8) & (idade <= 5)
	replace v516 = 6     if (v516 == 8) & (idade <= 9) // irrelevante: & (idade > 5)
	replace v516 = 7     if (v516 == 8) & (idade != .) // irrelevante: & (idade > 9)
	replace v516 = . if v516==8
	rename v516 t_mor_UF_80
	
	* t_mor_UF_80 =  0 - menos de 1 ano
	*                1 - 1 ano
	*                2 - 2 anos
	*                3 - 3 anos
	*                4 - 4 anos
	*                5 - 5 anos
	*                6 - 6 a 9 anos
	*                7 - 10 anos e mais

	* Em 1980, n�o h� o PA�S onde morava anteriormente - para quem migrou nos �ltimos 10 anos:
	gen UF_mor_ant = int(v518/100000)
	recode UF_mor_ant (0 54 80 99=.)
	label var UF_mor_ant "Previous State of residence (if migrated in the last 10 years)"
	* UF_mor_ant = 11-53 c�digo da UF em que morava

	recode v518 (0 5400000/max =.)
	rename v518 mun_mor_ant
	label var mun_mor_ant "Previous municipality of residence (if migrated in the last 10 years)"

	recode v515 (1 = 0) (3 = 1)  (8 9 = .)
	rename v515 sit_mun_ant
	* sit_mun_ant = 0 zona urbana
	*               1 zona rural

	*** Onde morava h� 5 anos:
	* Este quesito n�o foi investigado em 1980.

	/* D.8. EDUCA��O */

	recode v519 (2=1) (4 6 = 0) (9 = .)
	rename v519 alfabetizado
	* alfabetizado = 0 - n�o
	*                1 - sim

	gen freq_escola = 0     if idade >= 5
	replace freq_escola = 1 if (idade >= 5) & (v521 ~= 0) // frequenta curso seriado
	* frequenta curso n�o seriado, exceto pre-escola, supletivo por r�dio ou TV e pre-vestibular:
	replace freq_escola = 1 if (idade >= 5) & ((v522>=2 & v522<=4) | v522==8)
	lab var freq_escola "school attendance"

	gen freq_escolaB = freq_escola
	replace freq_escolaB = 1 if v522 == 1 // inclui pr�-escola
	lab var freq_escolaB "school attendance - including pre-school"


	* Estuda no munic�pio em que reside?
	recode v527 (0 = 1) (1100007/max = 0), g(mun_escola)
	replace mun_escola = . if freq_escolaB == 0
	lab var mun_escola "attend school in the same municipality where you live?"
	* mun_escola 	= 1 - sim
	*				= 0 - n�o

	gen anos_estudoB = 0 if (idade >= 5) & (v521 == 0) & (v522 == 0) & (v523 == 0) & (v524 == 0)
	lab var anos_estudoB "years of schooling B (related to the grade currently attended)"

	* Frequentando cursos n�o seriados:
	replace anos_estudoB = 0 if (v522 == 1) | (v522 == 2) // pr�-escolar, alfabetiza��o de adultos
	* Na situa�ao abaixo, supletivo de 1o grau, IBGE tem optado por considerar n�vel "indefinido"
	*replace anos_estudoB = 0 if (v522 == 3) | (v522 == 5) // suplet 1o grau
	replace anos_estudoB = 8 if (v522 == 4) | (v522 == 6) // suplet 2o grau
	replace anos_estudoB = 11 if (v522 == 7)              // vestibular
	replace anos_estudoB = 15 if (v522 == 8)              // mestrado ou doutorado

	* Frequentando cursos seriados:
	replace anos_estudoB = v520 - 1  if (v520 >= 1) & (v520 <= 4) & (v521 == 1)                                      // prim�rio
	replace anos_estudoB = 3         if (v520 >= 5) & (v520 <= 8) & (v521 == 1)                                      // n�o terminou prim�rio, n�o pode receber 4 anos
	replace anos_estudoB = v520 + 3  if (v520 >= 1) & (v520 <= 4) & (v521 == 2)                                      // gin�sio
	replace anos_estudoB = 7         if (v520 >= 5) & (v520 <= 8) & (v521 == 2)                                      // n�o terminou gin�sio, n�o pode receber 8 anos
	replace anos_estudoB = v520 - 1  if (v520 >= 1) & (v520 <= 8) & ((v521 == 3) | (v521 == 6))                      // 1o grau reg ou supletivo
	replace anos_estudoB = v520 + 7  if (v520 >= 1) & (v520 <= 3) & (v521 == 5)                                      // colegial
	replace anos_estudoB = 10        if (v520 >= 4) & (v520 <= 8) & (v521 == 5)                                      // n�o terminou colegial, n�o pode receber 11 anos
	replace anos_estudoB = v520 + 7  if (freq_escola == 1) & (v520 >= 1) & (v520 <= 3) & ((v521 == 4) | (v521 == 7)) // 2o grau reg ou supletivo
	replace anos_estudoB = 10        if (freq_escola == 1) & (v520 >= 4) & (v520 <= 8) & ((v521 == 4) | (v521 == 7)) // n�o terminou m�dio, n�o pode receber 11 anos
	replace anos_estudoB = v520 + 10 if (freq_escola == 1) & (v520 >= 1) & (v520 <= 5) & (v521 == 8)                 // superior
	replace anos_estudoB = 15        if (freq_escola == 1) & (v520 >= 6) & (v520 <= 8) & (v521 == 8)                 // atribuo no m�x 15 anos p/ superior incompleto

	* N�o frequentando - informa��o de curso conclu�do:
	replace anos_estudoB = 0         if (v524 == 1)                                                                  // alfabetiza��o de adultos
	replace anos_estudoB = v523      if (v523 >= 1) & (v523 <= 4) & (v524 == 2)                                      // prim�rio
	replace anos_estudoB = 4         if (v523 >= 5) & (v523 <= 8) & (v524 == 2)                                      // prim�rio conclu�do vale 4 anos
	replace anos_estudoB = v523 + 4  if (v523 >= 1) & (v523 <= 4) & (v524 == 3)                                      // gin�sio
	replace anos_estudoB = 8         if (v523 >= 5) & (v523 <= 8) & (v524 == 3)                                      // gin�sio conclu�do vale 8 anos
	replace anos_estudoB = v523      if (v523 >= 1) & (v523 <= 8) & (v524 == 4)                                      // 1o grau
	replace anos_estudoB = v523 + 8  if (v523 >= 1) & (v523 <= 3) & (v524 == 5)                                      // 2o grau
	replace anos_estudoB = 11        if (v523 >= 4) & (v523 <= 8) & (v524 == 5)                                      // 2o grau conclu�do vale 11 anos
	replace anos_estudoB = v523 + 8  if (v523 >= 1) & (v523 <= 3) & (v524 == 6)                                      // colegial
	replace anos_estudoB = 11        if (v523 >= 4) & (v523 <= 8) & (v524 == 6)                                      // colegial conclu�do vale 11 anos
	replace anos_estudoB = v523 + 11 if (v523 >= 1) & (v523 <= 5) & (v524 == 7)                                      // superior
	replace anos_estudoB = 16        if (v523 >= 6) & (v523 <= 8) & (v524 == 7)                                      // superior conclu�do vale at� 16 anos
	replace anos_estudoB = 16        if (v524 == 8)                                                                  // mestrado ou doutorado
	
	* Grupos de anos de estudo
	* para quem frequenta escola
	recode anos_estudoB (min/3 = 0) (4/7 = 1) (8/10 = 2) (11/14 = 3) (15/max = 4), g(anos_estudoC)
	replace anos_estudoC = 0 if (v522 == 3) | (v522 == 5) // suplet 1o grau
	replace anos_estudoC = . if freq_escola==0
	replace anos_estudoC = 3 if freq_escola==1 & v521==8 & anos_estudoC==4 	// superior sem conclusao

	* para quem nao frequenta escola
	replace anos_estudoC = 0 if freq_escola==0 & (v524==1 | v524==0)	// alfabetizacao de adultos/ nenhuma
	replace anos_estudoC = 0 if freq_escola==0 & v524==2 	// primario
	replace anos_estudoC = 0 if freq_escola==0 & v524==4 & (v523>=1 & v523<=3) 	// 1a-3a serie 1o.grau
	
	replace anos_estudoC = 1 if freq_escola==0 & v524==3		// ginasio/medio 1o.ciclo
	replace anos_estudoC = 1 if freq_escola==0 & v524==2 & (v525>=1 & v525<=8) 	// primario com conclusao
	replace anos_estudoC = 1 if freq_escola==0 & v524==4 & (v523>=4 & v523<=8) 	// 4a-8a serie 1o.grau

	replace anos_estudoC = 2 if freq_escola==0 & v524==3 & (v525>=11 & v525<=23) 	// ginasio/medio 1o.ciclo com conclusao
	replace anos_estudoC = 2 if freq_escola==0 & v524==4 & (v523>=4 & v523<=8) & (v525>=11 & v525<=23) 	// 4a-8a serie 1o.grau com conclusao
	replace anos_estudoC = 2 if freq_escola==0 & v524==5		// 2o.grau
	replace anos_estudoC = 2 if freq_escola==0 & v524==6		// colegial/medio 2o.ciclo

	replace anos_estudoC = 3 if freq_escola==0 & v524==5 & (v525>=24 & v525<=42) 	// 2o.grau com conclusao
	replace anos_estudoC = 3 if freq_escola==0 & v524==6 & (v525>=24 & v525<=42) 	// colegial/medio 2o.ciclo com conclusao
	replace anos_estudoC = 3 if freq_escola==0 & v524==7		// superior
	
	replace anos_estudoC = 4 if freq_escola==0 & v524==7 & (v525>=43 & v525<=85) 	// superior com conclusao
	replace anos_estudoC = 4 if freq_escola==0 & v524==8		// mestrado/doutorado

	* corrigindo usando conclusao de curso
	replace anos_estudoC = 0 if freq_escola==0 & v525==0
	replace anos_estudoC = 1 if freq_escola==0 & v525>=1 & v525<=8
	replace anos_estudoC = 2 if freq_escola==0 & v525>=10 & v525<=23
	replace anos_estudoC = 3 if freq_escola==0 & v525>=24 & v525<=42
	replace anos_estudoC = 4 if freq_escola==0 & v525>=43 & v525<=85
	lab var anos_estudoC "group of years of schooling"
		
	* anos_estudoC = 0 � sem instru��o ou menos de 3 anos de estudo (prim�rio incompleto)
	*                1 � de 4 a 7 (fundamental/ gin�sio/ 1�. Grau/ m�dio primeiro ciclo incompleto)
	*				 2 � de 8 a 10 (m�dio/ 2�. Grau/ m�dio segundo ciclo incompleto)
	*			 	 3 � de 11 a 14 (m�dio/ 2�. Grau/ m�dio segundo ciclo completo ou superior incompleto)
	*			 	 4 � 15 ou mais (superior completo, mestrado, doutorado)

	recode v525 (1/8 12/15 17/19 21 22 26 28 31 36/38 40 42 = .) ///
			(10 11 16 20 23/25 27 29 30 32/35 39 41 = .) ///
			(73/77 80/83 85 93 94 96 = 3) ///
			(43/49 65 86 87 = 4) ///
			(50/63 88 89 = 5) ///
			(64 66 90 = 6) ///
			(67/72 78 79 91 92 95 = 7) ///
			(84 = 8) ///
			(00 99 = .), g(cursos_c1)

	lab var cursos_c1 "course concluded - classification 1"
	* cursos_c1	=	3	ci�ncias humanas
	*				4	ci�ncias biol�gicas
	*				5	ci�ncias exatas
	*				6	ci�ncias agr�rias
	*				7	ci�ncias sociais
	*				8	�rea de defesa 
	*				9	outros cursos

	recode v525 (1/42 = .) ///
			(77 94 = 1) ///
			(74/76 80/85 96 = 2) ///
			(67/73 78/79 91/93 95 = 3) ///
			(43 51 52 56/63 87 89 = 4) ///
			(50 53/55 88 = 5) ///
			(64/66 90 = 6) ///
			(44/49 86 = 7) ///
			(84 = 8) ///
			(99 00 =.), g(cursos_c2) 
	lab var cursos_c2 "course concluded - CONCLA"
	* cursos_c2 =	1	Educa��o
	*				2	Artes, Humanidades e Letras
	*				3	Ci�ncias Sociais, Administra��o e Direito
	*				4	Ci�ncias, Matem�tica e Computa��o
	*				5	Engenharia, Produ��o e Constru��o
	*				6	Agricultura e Veterin�ria
	*				7	Sa�de e Bem-Estar Social    
	*				8	Servi�os
	*				9	Outros

	rename v525 curso_concl
	
	drop v520 v521 v522 v523 v524


	/* D.9. SITUA��O CONJUGAL */
	recode v526 (0=9) (9=.) // 1 a 8 mantidos
	rename v526 estado_conj
	* estado_conj = 1 casamento civil e religioso
	*               2 s� casamento civil
	*               3 s� casamento religioso
	*               4 uni�o consensual
	*               5 solteiro
	*               6 separado(a)
	*               7 desquitado(a)/separado(a) judicialmente
	*               8 divorciado(a)
	*               9 vi�vo(a)


	/* D.10. RENDA E ATIVIDADE ECON�MICA  */

	recode v528 (1 = 1) (3 5 = 0) // 5 � "frente de seca", eles continuam o question�rio como quem n�o trabalha
	rename v528 trab_ult_12m
	* trab_ult_12m = 1 sim
	*                0 n�o

	rename v529 cond_ativ
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

	recode cond_ativ (0 2=1) (3/9 =0), copy g(pea)
	lab var pea "Economically active population"
	* pea	= 1 economicamente ativo
	*         0 inativo


	gen v530b = v530
	recode v530b (1/65 = 1) (101/293 = 2) (301/336 = 3) (341/391 = 4) (401/589 = 5) ///
				 (601/646 = 6) (701/776 = 7) (801/845 = 8) (851/859 = 9) (911/924 = 10) ///
				 (925=5) (926 927 = 10)
	rename v530 ocup_hab
	rename v530b grp_ocup_hab	
	label var grp_ocup_hab "Group of usual occupation"
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

	gen v532b = v532
	recode v532b (11/42 = 1) (100/300 = 2) (340 = 3) (50/59 = 4) (351/354 = 4) ///
				 (410/424 = 5) (471/482 = 6) (571/589 = 7) (511/552 = 8) (610/632 = 9) ///
				 (711/727 = 10) (451/464 = 11) (801/903 = 11) (else=.)
	rename v532 ativ_hab
	rename v532b set_ativ_hab
	label var set_ativ_hab "group of activity/line of business of usual occupation"
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

	recode v533 (2=1) (3=2) (4 7 = 8) (5=3) (8=7) (9=.) // 0, 1 e 6 mantidos
	replace v533 = 4 if v533 == 6 & ocup_hab == 805 // trabalhador dom�stico - empregado
	replace v533 = 5 if v533 == 7 & ocup_hab == 805 // trabalhador dom�stico - conta-pr�pria
	rename v533 pos_ocup_hab
	* pos_ocup_hab = 0 sem remunera��o
	*                1 trabalhador agr�cola volante
	*                2 parceiro ou meeiro - empregado
	*                3 parceiro ou meeiro - aut�nomo ou conta-pr�pria
	*                4 trabalhador dom�stico - empregado
	*                5 trabalhador dom�stico - aut�nomo ou conta-pr�pria
	*                6 empregado
	*                7 aut�nomo ou conta-pr�pria
	*                8 empregador

	recode pos_ocup_hab (1 6=4) (2 3 =1) (4 =2) (5 =3) (7 =5) (8 =6), copy g(pos_ocup_habB)
	lab var pos_ocup_habB "position in usual occupation B"
	* pos_ocup_habB = 0 sem remunera��o
	*                 1 parceiro ou meeiro 
	*                 2 trabalhador dom�stico - empregado
	*                 3 trabalhador dom�stico - aut�nomo ou conta-pr�pria
	*                 4 empregado
	*                 5 aut�nomo ou conta-pr�pria
	*                 6 empregador

	recode v534 (2 4 6 = 1) (8=0) (9=.)
	rename v534 previd_A
	* previd = 0 n�o
	*          1 sim

	recode v535 (9=.)
	rename v535 hrs_oc_hab
	lab var hrs_oc_hab "groups of hours usually worked per week - main job"
	* hrs_oc_hab = 1 - menos de 15 horas
	*              2 - de 15 a 29 horas
	*              3 - de 30 a 39 horas
	*              4 - de 40 a 48 horas
	*              5 - 49 horas ou mais

	gen hrs_oc_habC = hrs_oc_hab
	recode hrs_oc_habC (3 = 2) (4 5=3) // (1=1) (2=2)
	replace hrs_oc_habC = . if set_ativ_hab==1
	lab var hrs_oc_habC "hours worked p/week C - main job - non-agric."

	* hrs_oc_habC = 1 - menos de 15 horas
	*               2 - de 15 a 39 horas
	*               3 - 40 horas ou mais


	recode v536 (4=1) (5=2) (6=3) (7=4) (0=5) (else=.)
	rename v536 hrs_todas_oc
	* hrs_todas_oc = 1 - menos de 15 horas
	*                2 - de 15 a 29 horas
	*                3 - de 30 a 39 horas
	*                4 - de 40 a 48 horas
	*                5 - 49 horas ou mais
	
	* trabalha no minic�pio 
	recode v527 (0 = 1) (1100007/max = 0)
	replace v527 = . if hrs_oc_hab==.
	rename v527 mun_trab
	lab var mun_trab "work in the municipality where you live?"
	* mun_trab 	= 1 - sim
	*			= 0 - n�o


	*** Ocupa��o na semana -- compar�vel com 2000:
	recode v541 (6 4 =4) (5=.)
	rename v541 trab_semana
	* trab_semana = 1 s� trabalho habitual
	*               2 trabalho habitual e outros
	*               3 s� trabalho diferente do habitual
	*               4 outros

	drop v542
	drop v544
	drop v545 trab_ult_12m
		

	/* D.11. FECUNDIDADE */

	egen filhos_nasc_vivos = rowtotal(v550 v551), miss
	lab var filhos_nasc_vivos "total children born alive"

	recode v550 (98 99 = .)
	rename v550 f_nasc_v_hom
	recode v551 (98 99 = .)
	rename v551 f_nasc_v_mul

	replace filhos_nasc_vivos =. if f_nasc_v_hom==. | f_nasc_v_mul==.
	
	egen filhos_nasc_mortos = rowtotal(v552 v553), miss
	lab var filhos_nasc_mortos "total chidren born dead"

	recode v552 (98 99 = .)
	rename v552 f_nasc_m_hom
	recode v553 (98 99 = .)
	rename v553 f_nasc_m_mul

	replace filhos_nasc_mortos =. if f_nasc_m_hom==. | f_nasc_m_mul==.
	
	egen filhos_hom = rowtotal(f_nasc_v_hom f_nasc_m_hom), miss
	replace filhos_hom = . if f_nasc_v_hom==. | f_nasc_m_hom==.
	lab var filhos_hom "total male children"

	egen filhos_mul = rowtotal(f_nasc_v_mul f_nasc_m_mul), miss
	replace filhos_mul = . if f_nasc_v_mul ==. | f_nasc_m_mul==.
	lab var filhos_mul "total female children"

	egen filhos_tot = rowtotal(filhos_nasc_vivos filhos_nasc_mortos), miss
	replace filhos_tot = . if filhos_nasc_vivos ==. | filhos_nasc_mortos==.
	lab var filhos_tot "total number of children had"

	egen filhos_vivos = rowtotal(v554 v555), miss
	lab var filhos_vivos "total children alive"

	recode v554 (98 99 = .)
	rename v554 f_vivos_hom
	recode v555 (98 99 = .)
	rename v555 f_vivos_mul

	replace filhos_vivos = . if f_vivos_hom==. | f_vivos_mul==.
	
	recode v570 (999 = .)
	rename v570 idade_ult_nasc_v

	rename v604 peso_pess

	drop  v505 v510 v556 v557


	/* D.10. CONTINUACAO. RENDA E ATIVIDADE ECON�MICA */ 
	foreach nn in 07 08 09 10 11 12 13 {
	   replace v6`nn' = . if v6`nn' == 9999999
	}

	rename v607 rend_ocup_hab
	rename v609 rend_outras_ocup

	rename v610 rend_aposent
	rename v611 rend_aluguel
	rename v612 rend_doa_pen
	egen rend_total = rowtotal(rend_ocup_hab rend_outras_ocup rend_aposent rend_aluguel rend_doa_pen v613)
	lab var rend_total "total income"
	by id_muni distrito id_dom num_fam: ///
		egen rend_fam = total(rend_total*(v504>= 1 & v504<= 6))
	lab var rend_fam "family income"
	by id_muni distrito id_dom: ///
		egen renda_dom = total(rend_total*(v503>= 1 & v503<= 6))
	lab var renda_dom "household income"
	drop v608 v613  v680 v540 v682 v681
	
	/* DEFLACIONANDO RENDAS: refer�ncia = julho/2010 */
	
	cap g double deflator = 0.000033234/10^7
	cap g double conversor = 2750000000000
	lab var deflator "income deflator - reference: 08/2010"
	lab var conversor "currency converter"

	foreach var in rend_ocup_hab rend_outras_ocup rend_total rend_fam renda_dom {
		g `var'_def = (`var'/conversor)/deflator
		lab var `var'_def "`var' deflated"
	}
	drop rend_aposent rend_aluguel rend_doa_pen
}

drop id_muni distrito v504

order ano UF regiao munic id_dom

end

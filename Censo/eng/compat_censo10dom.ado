program define compat_censo10dom

/* A. ANO */
* Essa vari�vel � definida antes de chamar este programa.

/* B. IDENTIFICA��O  */

/* B.1. IDENTIFICA��O */
rename v0001 UF
rename v0300 id_dom
rename v1001 regiao
drop v0002 v0011 v1002 v1003 v1004

/* B.2. VARI�VEIS DE N�MERO DE PESSOAS */
rename v0401 n_pes_dom

/* C. OUTRAS VARI�VEIS DE DOMIC�LIO */

/* C.1. SITUA��O */

recode v1006 (2=0)
rename v1006 sit_setor_C
lab var sit_setor_C "household situation - urban/rural"
*sit_setor_C = 1 - urbano
*              0 - rural

/* C.2. ESP�CIE */

rename v4001 especie
recode especie (1 2 = 0) (5 = 1) (6 = 2)
*especie_B = 0 - particular permanente 
*            1 - particular improvisado
*            2 - coletivo

/* C.3. MATERIAL DAS PAREDES */
recode v0202 (2 4 = 1) (3 = 2) (5 = 3) (6 = 4) (7 = 5) (8 = 6) (9 = .)
rename v0202 paredes
* paredes 	= 1   Alvenaria
*        	= 2   Madeira aparelhada
*        	= 3   Taipa n�o revestida
*       	= 4   Material aproveitado
*   	    = 5   Palha
*	        = 6   Outro


/* C.4.	MATERIAL DA COBERTURA */

/* C.5. TIPO */
* Em 2010, aparece a categoria "oca ou maloca". Esta foi inclu�da em "casa" por
* exclus�o, pois n�o se trata de apartamento nem de c�modo.

recode v4002 (11 12 15 = 1) (13 = 2) (14 = 3) (50/max = .)
rename v4002 tipo_dom
* tipo_dom = 1 - casa ou oca/maloca
*            2 - apartamento
*            3 - c�modo
lab var tipo_dom "type of household"


g tipo_dom_B = tipo_dom
recode tipo_dom_B (3 = 2)
* tipo_dom_B = 1 - casa ou oca/maloca
*              2 - apartamento
lab var tipo_dom_B "type of household B"


/* C.6. CONDI��O DE OCUPA��O E ALUGUEL */

g cond_ocup = v0201 - 1
replace cond_ocup = 1 if cond_ocup==0
* cond_ocup  = 1 - Pr�prio
*              2 - Alugado
*              3 - Cedido por empregador
*              4 - Cedido de outra forma
*              5 - Outra Condi��o
lab var cond_ocup "occupancy condition"

g cond_ocup_B = cond_ocup 
recode cond_ocup_B (4 =3) (5 = 4)
* cond_ocup_B = 1 - pr�prio
*               2 - alugado
*               3 - cedido
*               4 - outra condi��o
lab var cond_ocup_B "occupancy condition B"

rename v0201 cond_ocup_C
* cond_ocup_C= 1 - Pr�prio, j� pago
*              2 - Pr�prio, ainda pagando
*              3 - Alugado
*              4 - Cedido por empregador
*              5 - Cedido de outra forma
*              6 - Outra Condi��o

/* ALUGUEL */
rename v2011 aluguel

* aluguel em salarios m�nimos
drop v2012

 
/* C.7. INSTALA��ES SANIT�RIAS */
rename v0205 banheiros_B
* banheiros_B= 0 - n�o tem
*              1 - 1 banheiro
*              2 - 2 banheiros
*              3 - 3 banheiros
*              4 - 4 banheiros
*              5 - 5 banheiros
*              6 - 6 banheiros
*              7 - 7 banheiros
*              8 - 8 banheiros
*              9 - 9 ou mais banheiros

g banheiros = banheiros_B
replace banheiros = 5 if banheiros >= 5
lab var banheiros "number of toilets"
*banheiros = 0 - n�o tem
*			 1 - 1 banheiro
*			 2 - 2 banheiros
*            3 - 3 banheiros
*            4 - 4 banheiros
*            5 - 5 ou mais banheiros
drop banheiros_B

rename v0206 sanitario
recode sanitario (2 = 0)
replace sanitario = 1 if banheiros>0 & banheiros~=.
* sanitario = 0 - N�o
*             1 - Sim


rename v0207 tipo_esc_san_B
*tipo_esc_san_B = 1 - Rede geral de esgoto ou pluvial
*                 2 - Fossa s�ptica
*                 3 - Fossa rudimentar
*                 4 - Vala
*                 5 - Rio, lago ou mar
*                 6 - Outro 
lab var tipo_esc_san_B "type of sewer -  disaggregated"

g tipo_esc_san = tipo_esc_san_B
recode tipo_esc_san (4 5 6 = 4)
lab var tipo_esc_san "type of sewer"
*tipo_esc_san = 1 - Rede geral de esgoto ou pluvial
*               2 - Fossa s�ptica
*               3 - Fossa rudimentar
*               4 - Outro

/* C.8. ABASTECIMENTO DE �GUA */

rename v0208 abast_agua_B
recode abast_agua_B (1=1) (2 9 = 2) (3/8 10 = 3)
*abast_agua_B = 1 - rede geral
*               2 - po�o ou nascente na propriedade
*               3 - outra

gen abast_agua = 1 if (abast_agua_B == 1) & (v0209 == 1)
replace abast_agua = 2 if (abast_agua_B == 1) & ((v0209 == 2) | (v0209 == 3))
replace abast_agua = 3 if (abast_agua_B == 2) & (v0209 == 1)
replace abast_agua = 4 if (abast_agua_B == 2) & ((v0209 == 2) | (v0209 == 3))
replace abast_agua = 5 if abast_agua_B == 3
* abast_agua = 1 - rede geral com canaliza��o interna
*              2 - rede geral sem canaliza��o interna
*              3 - po�o ou nascente com canaliza��o interna
*              4 - po�o ou nascente sem canaliza��o interna
*              5 - outra forma
lab var abast_agua "type of water supply"
drop abast_agua_B

rename v0209 agua_canal
*agua_canal = 1 - Canalizada em pelo menos um c�modo
*              2 - Canalizada s� na propriedade ou terreno
*              3 - N�o canalizada


/* C.9. DESTINO DO LIXO */
rename v0210 dest_lixo
* dest_lixo = 1 - Coletado por servi�o de limpeza
*             2 - Colocado em ca�amba de servi�o de limpeza
*             3 - Queimado(na propriedade)
*             4 - Enterrado(na propriedade)
*             5 - Jogado em terreno baldio ou logradouro
*             6 - Jogado em rio, lago ou mar
*             7 - Tem outro destino

/* C.10. ILUMINA��O EL�TRICA */
rename v0211 ilum_eletr
recode ilum_eletr (1 2 =1) (3 = 0)
*ilum_eletr	 = 0 - N�o
*              1 - Sim


rename v0212 medidor_el
recode medidor_el (1 2 = 1) (3 = 0)
*medidor_el = 1 - Tem
*			  0 - N�o tem



/* C.11. BENS DE CONSUMO DUR�VEIS */
rename v0213 radio
recode radio (2 = 0)
* radio = 0 - N�o
*         1 - Sim

rename v0214 televisao
recode televisao(2 = 0) (1=1)
*televisao = 0 - n�o tem
*          = 1 - tem

rename v0215 lavaroupa
recode lavaroupa (2 = 0)
*lavaroupa_B = 0 - Nao
*              1 - Sim

rename v0216 geladeira
recode geladeira (2 = 0)
*geladeira_B = 0 - N�o
*              1 - Sim

drop v0217 

recode v0218 (2=0)
rename v0218 telefone
*telefone = 0 - N�o
*            1 - Sim

rename v0219 microcomp
recode microcomp (2 = 0)
*microcomp   = 1 - sim
*              0 - n�o

drop v0220 v0221 

rename v0222 automovel_part
recode automovel_part (2=0) (1=1)
*automov_part = 0-n�o tem
*               1-tem

/* C.12. N�MERO DE C�MODOS */

rename v0203 tot_comodos
rename v0204 tot_dorm

drop v6203 v6204 


/* C.13. RENDA DOMICILIAR */

rename v6529 renda_dom

drop v6530 v6531 v6532

/* DEFLACIONANDO RENDAS: refer�ncia = julho/2010 */
g double deflator = 1
g conversor = 1

lab var deflator "income deflator - reference: 08/2010"
lab var conversor "currency converter"

g renda_dom_def = (renda_dom/conversor)/deflator
lab var renda_dom_def "renda_dom deflated"

g aluguel_def = (aluguel/conversor)/deflator
lab var aluguel_def "aluguel deflated"

/* C.14. PESO AMOSTRAL */
rename v0010 peso_dom


/* Vari�veis de domic�lio n�o utilizadas */

drop v0301 v0402 v0701 v6600 v6210


end
 

program define compat_censo00dom

/* A. ANO */
* Essa vari�vel � definida antes de chamar este programa.

/* B. IDENTIFICA��O E N�MERO DE PESSOAS */

/* B.1. IDENTIFICA��O */
rename v0102 UF
rename v1001 regiao

drop v0103

rename v0300 id_dom

drop v1002 v1003 v0104 v0105 v1004 AREAP

/* B.2. VARI�VEIS DE N�MERO DE PESSOAS */

rename v0110 n_homem_dom
rename v0111 n_mulher_dom
rename v7100 n_pes_dom
drop v7401-v7409

/* C. OUTRAS VARI�VEIS DE DOMIC�LIO */

/* C.1. SITUA��O */
rename v1005 sit_setor
lab var sit_setor "household situation - desaggregate"
* sit_setor = 1 - �rea urbanizada de vila ou cidade
*             2 - �rea n�o urbanizada de vila ou cidade
*             3 - �rea urbanizada isolada
*             4 - Rural - extens�o urbana
*             5 - Rural - povoado
*             6 - Rural - n�cleo
*             7 - Rural - outros aglomerados
*             8 - Rural - exclusive os aglomerados rurais

gen sit_setor_B = sit_setor
recode sit_setor_B (1 2 = 1) (3=2) (4/7 = 3) (8=4)
lab var sit_setor_B "household situation - aggregate"
* sit_setor_B = 1 - Vila ou cidade
*               2 - Urbana isolada
*               3 - Aglomerado rural
*               4 - Rural exclusive os aglomerados

gen sit_setor_C = sit_setor_B
recode sit_setor_C (1 2 = 1) (3 4 = 0)
lab var sit_setor_C "household situation C - urban/rural"
* sit_setor_C = 1 - Urbana
*               0 - Rural
drop v1006


/* C.2. ESP�CIE */
recode v0201 (1 = 0) (2 = 1) (3 = 2)
rename v0201 especie
* especie = 0 - particular permanente
*           1 - particular improvisado
*           2 - coletivo

/* C.3.	MATERIAL DAS PAREDES */

/* C.4.	MATERIAL DA COBERTURA */

/* C.5. TIPO */
gen subnormal = 0 if (especie == 0) & ((v0202 == 1) | (v0202 == 2))
replace subnormal = 1 if (especie == 0) & ((v0202 == 1 | v0202 == 2) & v1007 == 1)
lab var subnormal "dummy for subnormal sector"
* Somente para domic�lios particulares permanentes tipo casa ou apt (n�o c�modo)
* subnormal = 0 - n�o
*             1 - sim

drop v1007

rename v0202 tipo_dom
* tipo_dom = 1 - casa
*            2 - apartamento
*            3 - c�modo
lab var tipo_dom "type of household"

gen tipo_dom_B = tipo_dom
recode tipo_dom_B (3=2)
* tipo_dom_B = 1 - casa
*              2 - apartamento (ou c�modo)
lab var tipo_dom_B "type of household B"


/* C.6. CONDI��O DE OCUPA��O E ALUGUEL */
gen dom_pago = 1 if v0205==1
replace dom_pago = 0 if v0205==2
lab var dom_pago "dummy for household owned already paid"
* dom_pago = 0 - Domic�lio pr�prio em aquisi��o
*            1 - Domic�lio pr�prio j� pago

g cond_ocup = v0205
recode cond_ocup (2=1) (3=2) (4=3) (5=4) (6=5) (0=.) // (1=1)
* cond_ocup = 1 - pr�prio
*             2 - alugado
*             3 - cedido por empregador
*             4 - cedido de outra forma
*             5 - outra condi��o
lab var cond_ocup "occupancy condition"

gen cond_ocup_B = cond_ocup
recode cond_ocup_B (4=3) (5=4) // 1 a 3 mantidos
* cond_ocup_B = 1 - pr�prio
*               2 - alugado
*               3 - cedido
*               4 - outra condi��o
lab var cond_ocup_B "occupancy condition B"

rename v0205 cond_ocup_C


recode v0206 (2 3 = 0) // (1=1)
rename v0206 terr_proprio
* terr_proprio = 0 - n�o
*                1 - sim


/* C.7. ABASTECIMENTO DE �GUA */
gen abast_agua = 1 if (v0207 == 1) & (v0208 == 1)
replace abast_agua = 2 if (v0207 == 1) & ((v0208 == 2) | (v0208 == 3))
replace abast_agua = 3 if (v0207 == 2) & (v0208 == 1)
replace abast_agua = 4 if (v0207 == 2) & ((v0208 == 2) | (v0208 == 3))
replace abast_agua = 5 if v0207 == 3
* abast_agua = 1 - rede geral com canaliza��o interna
*              2 - rede geral sem canaliza��o interna
*              3 - po�o ou nascente com canaliza��o interna
*              4 - po�o ou nascente sem canaliza��o interna
*              5 - outra forma
lab var abast_agua "type of water supply"

drop v0207

rename v0208 agua_canal
*agua_canal = 1 - Canalizada em pelo menos um c�modo
*              2 - Canalizada s� na propriedade ou terreno
*              3 - N�o canalizada


/* C.8. INSTALA��ES SANIT�RIAS */
* v0209 � n�mero de banheiros; se h� algum, considero que h� instala��es sanit�rias
* originalmente v0210 se refere � exist�ncia de instala��o que n�o seja um banheiro
replace v0210 = 1 if (v0209 >= 1 & v0209 != .)
recode v0210 (2=0) // (1=1)
rename v0210 sanitario
* sanitario = 0 - n�o tem acesso
*                1 - tem acesso


replace v0209 = 5 if (v0209 >= 5) & (v0209 != .)
rename v0209 banheiros
lab var banheiros "number of toilets"
* banheiros = 0 - n�o tem
*             1 a 4 - n�mero de banheiros
*             5 - cinco ou mais banheiros

g tipo_esc_san_B = v0211
*tipo_esc_san_B = 1 - Rede geral de esgoto ou pluvial
*                 2 - Fossa s�ptica
*                 3 - Fossa rudimentar
*                 4 - Vala
*                 5 - Rio, lago ou mar
*                 6 - Outro 
lab var tipo_esc_san "type of sewer - disaggregated"

recode v0211 (5 6 = 4) // 1 a 4 mantidos
rename v0211 tipo_esc_san
* tipo_esc_san = 1 - Rede geral
*                2 - Fossa s�ptica
*                3 - Fossa rudimentar
*                4 - Outro escoadouro


/* C.9. DESTINO DO LIXO */
rename v0212 dest_lixo
* dest_lixo = 1 - Coletado por servi�o de limpeza
*             2 - Colocado em ca�amba de servi�o de limpeza
*             3 - Queimado(na propriedade)
*             4 - Enterrado(na propriedade)
*             5 - Jogado em terreno baldio ou logradouro
*             6 - Jogado em rio, lago ou mar
*             7 - Tem outro destino


/* C.10. ILUMINA��O EL�TRICA */
recode v0213 (2=0) // (1=1)
rename v0213 ilum_eletr
* ilum_eletr = 0 - n�o tem
*              1 - tem


/* C.11. BENS DE CONSUMO DUR�VEIS */
* Em 2000, n�o foi pesquisada a posse e o tipo de fog�o.

recode v0214 (2=0) // (1=1)
rename v0214 radio
* radio = 0 - n�o tem
*         1 - tem

recode v0215 (2=0) // (1=1)
rename v0215 gelad_ou_fre
* gelad_ou_fre = 0 - n�o tem
*                1 - tem

recode v0217 (2=0) // (1=1)
rename v0217 lavaroupa
* lavaroupa = 0 - n�o tem	
*			= 1 - tem

recode v0219 (2=0) // (1=1)
rename v0219 telefone
* telefone = 0 - n�o tem
*            1 - tem

recode v0220 (2=0) // (1=1)
rename v0220 microcomp
* microcomp = 0 - n�o tem
*             1 - tem

recode v0221 (2/9 = 1) // 0 e 1 mantidos
rename v0221 televisao
* televisao = 0 - n�o tem
*             1 - tem

recode v0222 (2/9 = 1) // 0 e 1 mantidos
rename v0222 automovel
* automovel = 0 - n�o tem
*             1 - tem

* videocassete, microondas, ar condicionado
drop v0216 v0218 v0223


/* C.12. N�MERO DE C�MODOS */
rename v0203 tot_comodos
rename v0204 tot_dorm

drop v7203 v7204 


/* C.13. RENDA DOMICILIAR */
recode v7616 (999999 = .)
rename v7616 renda_dom
drop v7617	// em salarios minimos

/* DEFLACIONANDO RENDAS: refer�ncia = julho/2010 */
g double deflator = .515004440
g conversor = 1

lab var deflator "income deflator - reference: 08/2010"
lab var conversor "currency converter"

g renda_dom_def = (renda_dom/conversor)/deflator
lab var renda_dom_def "income_household deflated"

/* C.14. PESO AMOSTRAL */
rename P001 peso_dom

/* Vari�veis de domic�lio n�o utilizadas */
* identificacao, iluminacao publica, pavimentacao
drop v1111 v1112 v1113

end

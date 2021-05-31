* VERSION 1.2
program datazoom_pofstd_08
syntax , id(string) original(string) saving(string)

local listaDAD `"Cereais_leguminosas_e_oleaginosas "63001/63003 63018 63033/63034 63012/63017 63019 63021/63026 63031 63046 63037/63041 63043/63045 63004/63011 63020 63027/63030 63032 63035/63036 63042 63047/63049 66001/66016 66018/66022 66024/66025 66027/66028" Farinhas_féculas_e_massas "65032/65034 65049 65069 65010 65014 65001/65009 65011/65013 65015/65031 65035/65048 65050/65068 65070/65071" Tubérculos_e_raízes "64001 64012 64006 64002/64005 64007/64011 64013/64020" Açúcares_e_derivados "69001 69086 69002 69087 69069/69071 69079/69081 69091/69141 69003/69056 69058/69063 69066/69068 69072/69074 69076/69078 69082/69085 69088/69090 69142/69148" Legumes_e_verduras "67051 67079 67057 67001 67078 67002/67050 67052/67056 67058/67061 67063/67077 67080/67082 67084/67091 67093 67096 67098/67109" Frutas "68001/68011 68091 68098 68012/68015 68017/68018 68095 68097 68030 68086 68016 68019/68029 68031/68085 68087/68090 68092/68094 68096 68099/68102" Carnes_vísceras_e_pescados "71001/71007 71014 71016 71064 71113/71120 71008/71013 71015 71017 71026 71108 71122 71033/71037 71060 71065 71068 71105/71106 72004/72005 72014/72015 72024/72025 72034/72035 72044/72045 72054/72055 72064/72065 72074/72075 72084/72085 72094/72095 72104/72105 72114/72116 72124/72125 72134/72135 72144/72145 72154/72155 72164/72165 72174/72175 72184/72185 72194/72195 72204/72205 72214/72215 72224/72225 72234/72235 72244/72245 72254/72255 72264/72265 72274/72275 72284/72285 72294/72295 72304/72305 72314/72315 72324/72325 72334/72335 72344/72345 72354/72355 72364/72365 72374/72375 72384/72385 72394/72395 72404/72405 72414/72415 72424/72425 72434/72435 72444/72445 72454/72455 72464/72465 72474/72475 72484/72485 72494/72495 72504/72505 72514/72515 72524/72525 72534/72535 72544/72545 72554/72555 72564/72565 72574/72575 72584/72585 72594/72595 72604 72606 72614 72624 72634 72644 72664 72674 72684 72694/72695 72704 72714/72715 72724/72725 72734 72744 72754/72755 72805 74004/74005 74014/74015 74024/74025 74034/74035 74044/74045 74054/74055 74064/74065 74074/74075 74084/74085 74094/74095 74104/74105 74114/74115 74124/74125 74134/74135 74144/74145 74154/74155 74164/74165 74174/74175 74184/74185 74194/74195  74204/74205 74214/74215 74224/74225 74234/74235 74244/74245 74254/74255 74264/74265 74274/74275 74284/74285 74294/74295 74304/74305 74314/74315 74324/74325 74334/74335 74344/74345 74354/74355 74364/74365 74374/74375 74384/74385 74394/74395 74404/74405 74414/74415 74424/74425 74434 74444/74445 74454/74455 74464/74465 74474/74475 74484/74485 74494/74495 74504 74514/74515 76004/76005 78029 78031 81001/81067 72001/72003 72011/72013 72021/72023 72031/72033 72039 72041/72043 72049 72051/72053 72061/72063 72071/72073 72081/72083 72091/72093 72101/72103 72111/72113 72121/72123 72131/72133 72141/72143 72149 72151/72153 72161/72163 72169 72171/72173 72181/72183 72191/72193 72201/72203 72207 72211/72213 72221/72223 72231/72233 72241/72243 72249 72251/72253 72261/72263 72271/72273 72279 72281/72283 72291/72293 72301/72303 72311/72313 72321/72323 72331/72333 72341/72343 72351/72353 72361/72363 72371/72373 72381/72383 72391/72393 72399 72401/72403 72411/72413 72421/72423 72431/72433 72441/72443 72451/72453 72461/72463 72471/72473 72481/72483 72491/72493 72501/72503 72511/72513 72521/72523 72531/72533 72541/72543 72551/72553 72561/72563 72571/72573 72581/72583 72591/72593 72601/72602 72611/72612 72621/72622 72631/72632 72641/72642 72651 72661/72662 72671/72672 72681/72682 72691/72693 72711/72713 72721/72723 72731 72741/72742 72751/72753 72761 72771 72781 72791 72802 72811 74001/74003 74011/74013 74021/74023 74031/74033 74041/74043 74047 74049 74051/74053 74061/74063 74071/74073 74081/74083 74091/74093 74101/74103 74109 74111/74113 74121/74123 74131/74133 74141/74143 74151/74153 74161/74163 74171/74173 74181/74183 74191/74193 74201/74203 74211/74213 74221/74223 74227 74229 74231/74233 74241/74243 74251/74253 74261/74263 74271/74273 74276 74281/74283 74291/74293 74301/74303 74311/74313 74321/74323 74329 74331/74333 74341/74343 74349 74351/74353 74361/74363 74371/74373 74381/74383 74391/74393 74401/74403 74411/74413 74421/74423 74431/74432 74441/74443 74451/74453 74461/74463 74471/74473 74481/74483 74491/74493 74501/74502 74511/74513 74519 74521 74531 74541 74551 74553 74561 74571 74581  74591 74601 74611 76001/76003 76007 76009 76011 71018/71025 71027/71032 71038/71059 71061/71063 71066/71067 71069/71104 71107 71109/71112 71121 71123/71124" Aves_e_ovos "78001/78014 78025/78027 78032 78036 78038 78047/78048 78062 78066 78068 78033 78065 78055/78059 78064 78015/78024 78028 78030 78034/78035 78037 78039/78046 78049/78054 78060/78061 78063 78067 78069" Leites_e_derivados "79001/79002 79031 79036/79038 79006/79008 79070 79017/79022 79024/79030 79033 79078/79079 79081/79084 79039/79042 79051/79069 79071/79072 79076/79077 79080 79086/79087 79043/79050 79073/79074 79003/79005 79009/79016 79023 79032 79034/79035 79075 79085" Panificados "80001 80022/80024 80048/80049 80052/80054 80065/80105 80108/80109 80112/80115 80002/80021 80025/80047 80050/80051 80055/80064 80106/80107 80110/80111" Óleos_e_gorduras "84003 84001 84002 84004/84043" Bebidas_e_infusões "82025 82106 82001/82006 82009/82014 82017/82018 82035 82041/82043 82046 82049 82054/82055 82057 82067/82073 82147 82150 82155 82007/82008 82015/82016 82019 82040 82052 82074/82079 82081/82085 82087/82100 82110/82129 82134 82139/82141 82145 82152 82156 83043/83044 83001/83002 83003/83032 83034/83042 83045/83047 66017 66023 66026 69057 69064/69065 69075 82020/82024 82026/82034 82036/82039 82044/82045 82047/82048 82050/82051 82053 82056 82058/82066 82080 82086 82101/82105 82107/82109 82130/82133 82135/82138 82142/82144 82146 82148/82149 82151 82153/82154 83033" Enlatados_e_conservas "77001/77076" Sal_e_condimentos "70047 70043 70104 70001 70110 67062 67083 67092 67094/67095 67097 70002/70042 70044/70046 70048/70103 70105/70109 70111/70126" Alimentos_preparados "85001/85098" Outros_(alimentação_no_domícilio) "90001/90009""' 
local listaDAF `"Almoço_e_jantar "24001 24035/24036 24038 24040 24054/24056 41006 48033" Café_leite_chocolate "24002 24005 24016 24034 24061 24064" Sanduíches_e_salgados "24004 24037 24039 24062" Refrigerantes_e_outras_bebidas_não_alcoólicas "24006/24007 24013 24017 24020/24033 24050/24053 24066 24077 24099 24139" Lanches "24041/24042" Cervejas_chopes_e_outras_bebidas_alcoólicas "24009/24012 24046/24049 24067/24068" Alimentação_na_escola "24057/24060 49026" Alimentação_light_e_diet "24069/24076 24078/24098 24100/24138" Outra_alimentação_fora_do_domicílio "24003 24008 24014/24015 24018/24019 24043/24045 24063 24065 24999""'
local listaDDI `"Aluguel "10001 10003 10006 10008 10090" Condomínio "10004 10009" Serviços_e_taxas "06002 06004 28023 28024 06008/06011 06013/06015 06003 07001 06001 06005 06007 06012 06999 12003 12005/12023 12025 12030/12035 12999" Manutenção_do_lar "07002/07011 07999 08001/08068 08070/08079 08999 19001/19030 19099 86057 86083 86090" Artigos_de_limpeza "86001/86008 86011 86014/86027 86030/86034 86042 86045 86056 86058 86060/86061 86063/86066 86069/86071 86073 86075 86077 86086 86092/86095" Mobiliários_e_artigos_do_lar "15003 15023 15083 15132/15140 15145/15146 15150/15154 15158 15161 15164 15168 15177 15182 15185/15186 15188 15190/15194 16016/16017 16023 17001/17091 17999 18001/18053 18999 37003/37006 37010/37013 37016 37020 37023/37024 37031/37033 37038/37040 37043 37045/37047 39001/39099 39999 40014 40019/40020 86009/86010 86012/86013 86028/86029 86035/86041 86043/86044 86046/86055 86059 86062 86067/86068 86072 86074 86076 86078/86082 86084/86085 86087/86089 86091" Eletrodomésticos "15001/15002 15004/15022 15024/15054 15056/15059 15061/15063 15065/15069 15071/15080 15082 15084/15124 15128/15131 15141/15144 15147/15148 15155/15156 15159/15160 15163 15166 15169/15171 15173 15175 15180/15181 15183 15187 15189 15197 15206 15208/15214 15216 15999" Consertos_de_artigos_do_lar "09001/09147 09149/09150 09156/09162 09999" Roupa_de_homem "34001/34033 34999" Roupa_de_mulher "35001/35059 35999" Roupa_de_criança "36001/36048 36999" Calçados_e_apetrechos "38001/38052 38054/38066 38068 38071/38072 38999" Jóias_e_bijuterias "40001 40022 46001/46008 46010/46011 46999" Tecidos_e_armarinhos "37001/37002 37008/37009 37014/37015 37017/37019 37021 37025/37030 37034/37037 37044 37999" Urbano "23001/23005 23010/23012 23014/23016 23020/23021 23023 23025/23026 23999 48034" Gasolina_veículo_próprio "23007 23028" Álcool_veículo_próprio "23006" Manutenção_e_acessórios "23019 43001/43008 43011/43013 43017 43019 43027 43029 43035 43040 43042 43999" Aquisição_de_veículos "50012 51001/51023 51999" Viagens_esporádicas "41001/41005 41008/41017 41020/41022 41040/41042 41999" Outras_(transporte) "23008/23009 23013 23017/23018 23022 50003 50005/50008 50010 50013 50017 50999" Perfume "30002" Produtos_para_cabelo "30026 89004" Sabonete "89003" Instrumentos_e_produtos_de_uso_pessoal "29314 30001 30003/30021 30023 30025 30029/30031 30999 89001/89002 89005/89015" Remédios "29001/29049 29300 29999" Plano/Seguro_saúde "42001/42003 42044/42045" Consulta_e_tratamento_dentário "42023/42024" Consulta_médica "42009/42012" Tratamento_médico_e_ambulatorial "42004 42008 42020/42022 42025 42028/42034 42047" Serviços_de_cirurgia "42005" Hospitalização "42006" Exames_diversos "42013/42019 42043 42046" Material_de_tratamento "29301/29303 29305/29309 29311/29312 42039/42041" Outras_(assistência_à_saúde) "29304 29310 29313 42007 42026/42027 42035/42038 42042 42999" Cursos_regulares "49001 49031/49032" Curso_superior "49033" Outros_cursos_e_atividades "49002/49003 49011 49015 49022 49034/49041 49043/49044 49047 49049/ 49052 49054/49084 49086/49092" Livros_didáticos_e_revistas_técnicas "49006/49008 49045" Artigos_escolares "32001/32002 32999 49019/49021 49025 49029" Outras_(educação) "48003 48013 48036 49004/49005 49009/49010 49012/49014 49016/49018 49024 49027/49028 49030 49042 49046 49048 49053 49085 49093 49999" Brinquedos_e_jogos "33002 33012 33016" Celular_e_acessórios "46009 46012/46013" Periódicos_livros_e_revistas_não_didáticos "27001/27016 27019/27021 32004/32005" Recreações_e_esportes "28001/28005 28011/28021 28027/28028 28030/28039 28046 28049 28051 28053/28054 28055 28056 28058/28059 28999 41026 41033/41039 45014 45016/45018" Outras_(recreação_e_cultura) "15125/15127 15167 15178/15179 15184 15200 15207 16001/16015 16020/16022 16028/16034 16036/16038 16040 27017/27018 27999 28006/28010 28022 28025/28026 28029 28040/28045 28047/28048 28050 28052 28057 33001 33003/33011 33013/33015 33017/33026 33999 37041/37042" Fumo "25001/25018 25999 38053 38067 38069/38070" Cabeleireiro "31001/31002 31042/31043 31047" Manicuro_e_pedicuro "31003" Consertos_de_artigos_pessoais "31004 31010 31013/31016 31018 31020/31024 31026/31027 31029/31031 31033 31039 31044/31045 31051" Outras_(serviços_pessoais) "31005/31009 31011/31012 31017 31019 31028 31032 31034/31038 31040/31041 31046 31048/31050 31052/31053 31999" Jogos_e_apostas "26001/26018 26020 26022 26024 26027 26029/26030 26999" Comunicação "22001/22005 22999" Cerimônias_e_festas "45001/45013 45999" Serviços_profissionais "44001/44019 44035" Imóveis_de_uso_ocasional "41025 47005/47007 47009/47020 47023 47025 47999" Outras_(despesas_diversas) "11081/11084 12004 13001/13022 13999 16018/16019 16024/16027 16039 16999 32006 32015 37007 37022 40002/40013 40015/40018 40021 40023/40026 40999 41007 41018/41019 41023/41024 44020/44021 44999 87001/87010 87012/87015 88001" Impostos "10005 10010/10014 47008 47022 48035 48038 50001/50002 50004 50009 50014/50016 50018/50019 53601/53609 53701/53709" Contribuições_trabalhistas "19501/19530 19599 48001 48018 48026 48039 53501/53509" Serviços_bancários "44022/44033 44036 44038 44042 44047" Pensões_mesadas_e_doações "48002 48004/48005 48021/48024 48040 48043/48044 50011" Previdência_privada "48006" Outras_despesas_correntes "12024 47024 48007/48010 48014 48017 48019 48025 48028/48032 48037 48041 48999 54501/54538 55501/55552 55554/55559 55562/55566" Imóvel_(aquisição) "12001/12002 47001/47004 47026" Imóvel_(reforma) "11001/11067 11069/11080 11085/11089 11999" Outros_investimentos "15149 15165 15172 15174 47021 47027 48020 48042" Empréstimo "48011/48012 48015 48027 48045" Prestação_de_imóvel "10002 10007""'
local listaREN `"Renda_Empregado "53001/53004 54015/54018 54020 54036/54038 55001/55002 55011 55026 55035 55037/55043 55045 55062/55063" Renda_Empregador "53005 55003" Renda_Conta_Própria "53006" INSS "54001/54002 55022/55023 55064" Previdência_Pública "54003/54004 55065" Previdência_Privada "54005 54023 55025 55033 55066" Programas_Sociais_Federais "54010/54012 54024" Pensão_Mesada_Doação "54007 54026 54032 55030" Outras_Transferências "54006 54013/54014 54019 54021/54022 54025 54027/54031 54035 55017/55018 55029 55031 55055/55059" Rendimento_de_aluguel "54008/54009" Outras_rendas "54033/54034 55004 55007 55009 55012/55013 55015/55016 55019/55021 55024 55027/55028 55032 55034 55036 55046/55052 55054""'

cd "`original'"

qui foreach TR of numlist 6/15 {
	findfile pof2008_tr`TR'.dct
	
	if "`TR'"=="6" {
		infile using `"`r(fn)'"', using("`original'/T_DESPESA_90DIAS_S.txt") clear
	}
	if "`TR'"=="7" {
		infile using `"`r(fn)'"', using("`original'/T_DESPESA_12MESES_S.txt") clear
	}
	if "`TR'"=="8" {
		infile using `"`r(fn)'"', using("`original'/T_OUTRAS_DESPESAS_S.txt") clear
	}
	if "`TR'"=="9" {
		infile using `"`r(fn)'"', using("`original'/T_SERVICO_DOMS_S.txt") clear
	}
	if "`TR'"=="10" {
		infile using `"`r(fn)'"', using("`original'/T_ALUGUEL_ESTIMADO_S.txt") clear
	}
	if "`TR'"=="11" {
		infile using `"`r(fn)'"', using("`original'/T_CADERNETA_DESPESA_S.txt") clear
	}
	if "`TR'"=="12" {
		infile using `"`r(fn)'"', using("`original'/T_DESPESA_INDIVIDUAL_S.txt") clear
	}
	if "`TR'"=="13" {
		infile using `"`r(fn)'"', using("`original'/T_DESPESA_VEICULO_S.txt") clear
	}
	if "`TR'"=="14" {
		infile using `"`r(fn)'"', using("`original'/T_RENDIMENTOS_S.txt") clear
	}
	if "`TR'"=="15" {
		infile using `"`r(fn)'"', using("`original'/T_OUTROS_RECI_S.txt") clear
	}

	if `TR' ~= 11 {
		gen long cod_item_aux = int((100000*num_quadro + cod_item)/100)
	}
	else {
		gen long cod_item_aux = int((100000*prod_num_quadro_grupo_pro + cod_item)/100)
	}
	tempfile tr`TR'
	save `tr`TR'', replace
}


foreach n of numlist 6/14 {
	append using `tr`n''
}

keep tipo_reg -num_uc fator_expansao2 cod_obtencao ///
	valor_anual_expandido2 num_inf cod_item_aux
	
g str itens = ""

foreach j in DAD DAF DDI REN {
	loc lista : copy local lista`j'
	
	if "`j'" == "DAD" | "`j'" == "DAF" {
		loc i = 1
		qui while `"`lista'"' ~="" {
			gettoken k lista: lista		/* para pular os nomes*/
			noi di "`k'"
			gettoken x lista: lista 	/* pega a lista de itens */
			foreach n of numlist `x' {
				if "`j'" == "DAD" {
					if `i'<10 replace itens = "da0`i'" if cod_item_aux == `n'
					else replace itens = "da`i'" if cod_item_aux == `n'
				}
				else {
					replace itens = "da2`i'" if cod_item_aux == `n'
				}
			}
			loc i = `i' + 1
		}
	}
	else if "`j'"=="DDI" {
		local z `""21/28" "31/36" "41/47" "51/54" "61/69 610" "71/76" "81/85" "90" "101/104" "111/116" "121/126" "131/133" "141/142""'
		tokenize `"`z'"'
		while `"`lista'"' ~="" {
			qui foreach i of numlist `1' {
				gettoken k lista: lista		/* para pular os nomes*/
				noi di "`k'"
				gettoken x lista: lista 	/* pega a lista de itens */
				foreach n of numlist `x' {
					if `i'<100 replace itens = "dd0`i'" if cod_item_aux == `n'
					else replace itens = "dd`i'" if cod_item_aux == `n'
				}
			}
			macro shift
		}
	}
	else {
		local z `""11/13" "21/26" 30 40"'
		tokenize `"`z'"'
		while `"`lista'"' ~="" {
			qui foreach i of numlist `1' {
				gettoken k lista: lista		/* para pular os nomes*/
				noi di "`k'"
				gettoken x lista: lista 	/* pega a lista de itens */
				foreach n of numlist `x' {
					replace itens = "re`i'" if cod_item_aux == `n'
				}
			}
			macro shift
		}
	}
}
tempfile gastos
save `gastos', replace

foreach type in `id' {
	use `gastos', clear

	if "`type'" == "dom" {
		loc variaveis_ID = "cod_uf num_seq  num_dv cod_domc"
		loc TR_prin = "1"
	}
	else if "`type'" == "uc" {
		loc variaveis_ID = "cod_uf num_seq  num_dv cod_domc num_uc"
		loc TR_prin = "4"
	}
	else if "`type'" == "pess" {
		loc variaveis_ID = "cod_uf num_seq num_dv cod_domc num_uc num_inf"
		loc TR_prin = "2"
		keep if tipo_reg>=12 & tipo_reg<=15 & num_inf~=.
	}

	egen id_`type' = group(`variaveis_ID')
	sort id_`type'

	tempvar credit
	g `credit' = cond(cod_obtencao>=3  & cod_obtencao<=6,valor_anual_expandido2,0) if cod_obtencao~=0 		/* itens comprados a prazo */
	g vre51 = cond(cod_obtencao>=7  & cod_obtencao<=11,valor_anual_expandido2,0) if cod_obtencao~=0 		/* despesa nao monetaria */

	sort id_`type' itens
	by id_`type' itens: egen va = total(valor_anual_expandido2/fator_expansao2)	/* valor da despesa */
	by id_`type' itens: egen cr = total(`credit'/fator_expansao2)	/* valor da despesa a prazo */
	by id_`type' itens: egen nm = total(vre51/fator_expansao2)	/* valor da despesa não monetaria */

	preserve

	/* renda nao monetaria */
	replace vre51 = . if cod_item_aux==10090
	replace vre51 = vre51/fator_expansao2	/* rendimento nao monetario 1 */

	g vre52 = valor_anual_expandido2/fator_expansao2 if cod_item_aux==10090
	foreach n of numlist 8001/8017 8019/8072 8077/8079 8999 10005 10010 ///
			10012/10013 12005/12025 12030/12033 12999 {
		replace vre52 = - valor_anual_expandido2/fator_expansao2 if cod_item_aux==`n'	/* rendimento não monetario 2 */
	}

	/* variacao patrimonial */
	g vvp0 = .
	foreach n of numlist 55005 55006 55008 55010 55014 55044 { 
			replace vvp = valor_anual_expandido2/fator_expansao2 if cod_item_aux==`n'
	}

	loc i = 57000
	loc j = 56000
	forval n = 1/4 {
		loc i = `i' + 1
		loc j = `j' + 1
		g vvp`n' = valor_anual_expandido2/fator_expansao2 if cod_item_aux==`i'
		replace vvp`n' = - valor_anual_expandido2/fator_expansao2 if cod_item_aux==`j'
	}

	collapse (sum) vre51 vre52 vvp*, by(`variaveis_ID' id_`type')

	foreach var in vre52 vvp1 vvp2 vvp3 vvp4 {
		replace `var' = . if `var'<0	/* para nao haver renda nao monetaria negativa*/
	}

	egen vre5 = rowtotal(vre51 vre52)
	egen vvp = rowtotal(vvp*)
	lab var vre5 "renda não monetária"
	lab var vvp "variação patrimonial"
	keep `variaveis_ID' id_`type' vre5 vvp

	tempfile rendanm
	save `rendanm', replace

	restore
	
	drop vre51
	drop if itens==""

	bys id_`type' itens: keep if _n==1
	keep `variaveis_ID' id_`type' itens va cr nm

	reshape wide va cr nm , i(id_`type') j(itens) string

	drop crre* nmre* // exclui credito e nao monetario relacionados a rendimentos
	
	/* introduzindo labels a partir das listas */
	loc lista: copy local listaDAD
	foreach n in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 {
		gettoken k lista: lista
		di "`k'"
		cap {
			lab var vada`n' "despesa total em `k'"
			lab var crda`n' "`k' - despesa a prazo" 
			lab var nmda`n' "`k' - despesa não monetária" 
		}
		gettoken k lista: lista
	}
	loc lista: copy local listaDAF
	foreach n of numlist 21/29 {
		gettoken k lista: lista
		di "`k'"
		cap {
			lab var vada`n' "despesa total em `k'"
			lab var crda`n' "`k' - despesa a prazo" 
			lab var nmda`n' "`k' - despesa não monetária" 
		}
		gettoken k lista: lista
	}
	loc lista: copy local listaDDI
	foreach n of numlist 21/28 31/36 41/47 51/54 61/69 610 71/76 81/85 90 ///
			101/104 111/116 121/126 131/133 141/142 {
		gettoken k lista: lista
		di "`k'"
		if `n'<100 {
			cap {
				lab var vadd0`n' "despesa total em `k'"
				lab var crdd0`n' "`k' - despesa a prazo" 
				lab var nmdd0`n' "`k' - despesa não monetária" 
			}
		}
		else {
			cap {
				lab var vadd`n' "despesa total em `k'"
				lab var crdd`n' "`k' - despesa a prazo" 
				lab var nmdd`n' "`k' - despesa não monetária" 
			}
		}
		gettoken k lista: lista
	}
	loc lista: copy local listaREN
	foreach n of numlist 11/13 21/26 30 40 {
		gettoken k lista: lista
		di "`k'"
		cap {
			lab var vare`n' "rendimento proveniente de `k'"
		}
		gettoken k lista: lista
	}

	merge 1:1 id_`type' using `rendanm', nogen keep(match)
	
	tempfile gasto_temp
	save `gasto_temp', replace

	findfile pof2008_tr1.dct

	qui infile using `"`r(fn)'"', using("`original'/T_DOMICILIO_S.txt") clear

	if "`type'" == "dom" merge 1:1 `variaveis_ID' using `gasto_temp', nogen keep(match)
	else merge 1:n cod_uf num_seq num_dv cod_domc using `gasto_temp', nogen keep(match)
		
	g urbano = 1 if num_ext_renda<=6 & cod_uf==11
	replace urbano = 1 if num_ext_renda<=2 & cod_uf==12
	replace urbano = 1 if num_ext_renda<=8 & cod_uf==13
	replace urbano = 1 if num_ext_renda<=2 & cod_uf==14
	replace urbano = 1 if num_ext_renda<=8 & cod_uf==15
	replace urbano = 1 if num_ext_renda<=3 & cod_uf==16
	replace urbano = 1 if num_ext_renda<=5 & cod_uf==17
	replace urbano = 1 if num_ext_renda<=12 & cod_uf==21
	replace urbano = 1 if num_ext_renda<=9 & cod_uf==22
	replace urbano = 1 if num_ext_renda<=23 & cod_uf==23
	replace urbano = 1 if num_ext_renda<=8 & cod_uf==24
	replace urbano = 1 if num_ext_renda<=9 & cod_uf==25
	replace urbano = 1 if num_ext_renda<=15 & cod_uf==26
	replace urbano = 1 if num_ext_renda<=8 & cod_uf==27
	replace urbano = 1 if num_ext_renda<=7 & cod_uf==28
	replace urbano = 1 if num_ext_renda<=21 & cod_uf==29
	replace urbano = 1 if num_ext_renda<=27 & cod_uf==31
	replace urbano = 1 if num_ext_renda<=9 & cod_uf==32
	replace urbano = 1 if num_ext_renda<=30 & cod_uf==33
	replace urbano = 1 if num_ext_renda<=30 & cod_uf==35
	replace urbano = 1 if num_ext_renda<=18 & cod_uf==41
	replace urbano = 1 if num_ext_renda<=13 & cod_uf==42
	replace urbano = 1 if num_ext_renda<=18 & cod_uf==43
	replace urbano = 1 if num_ext_renda<=8 & cod_uf==50
	replace urbano = 1 if num_ext_renda<=10 & cod_uf==51
	replace urbano = 1 if num_ext_renda<=17 & cod_uf==52
	replace urbano = 1 if num_ext_renda<8 & cod_uf==53
	replace urbano = 0 if urbano==.
	lab var urbano "1 area urbana; 0 area rural"

	if "`type'" == "pess" {
		preserve
		findfile pof2008_tr2.dct
		qui infile using `"`r(fn)'"', using("`original'/T_MORADOR_S.txt") clear
		tempfile tr2
		save `tr2', replace
		restore

		merge 1:1 `variaveis_ID' using `tr2', nogen keep(match)
	}
	cd "`saving'"
	save "pof2008_`type'_standard", replace
}
end

# Importando a tabela que contem todos os municípios do Brasil
library(readxl)
municípios_do_brasil = read_excel("municípios do brasil.xlsx")

# Renomeando para simplificar
tabela = municípios_do_brasil

# Retirando a amostra 
library(dplyr)
amostra = sample_n(tabela , 300 , replace = FALSE)

# Filtro para selecionar a Amostra
filtro = amostra$IBGE7
# PIB ----
PIB_dos_Municípios_base_de_dados_2010_2020 = read_excel("PIB dos Municípios - base de dados 2010-2020.xls")

# Selecionar apenas ano 2020 e municípios do filtro
TABELA_PIB = PIB_dos_Municípios_base_de_dados_2010_2020 %>% 
  filter(Ano == 2020 & `Código do Município` %in% filtro)

# Limpando e organizando a tabela
PIB = TABELA_PIB %>% select(`Nome do Município`,`Código do Município`,`Produto Interno Bruto, 
                            a preços correntes
                            (R$ 1.000)`)

names(PIB)[2:3] = c("CÓDIGO","PIB")

# Removendo outlier----
## PIB - Padronizando os dados----
PIB$std_PIB = scale(PIB$PIB)
## Criando o boxplot----
# A função boxplot já identifica os outliers
f = boxplot(PIB$std_PIB)
# Criando a coluna identificadora
PIB$out = ifelse(PIB$std_PIB %in% f[["out"]] , "é outlier" , "não é outlier")

# Filtrando e removendo os outliers
PIB = PIB %>% filter(out == "não é outlier")

boxplot(PIB$PIB)
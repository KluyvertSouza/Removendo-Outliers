# Removendo-Outliers
Removendo outliers de uma forma simples

A base de dados se refere ao PIB dos municípios o Brasil. Como algumas cidades têm PIB muito alto, em uma análise descritiva básica é notável o surgimento de outliers.
```r
PIB = TABELA_PIB %>% select(`Nome do Município`,`Código do Município`,`Produto Interno Bruto, a preços correntes(R$ 1.000)`)
names(PIB)[2:3] = c("CÓDIGO","PIB")

```
Dada a base de dados, agora vamos retirar os outliers.
```r
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
```

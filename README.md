# mitx-14310x-causal-inference

**MITx 14.310x — Data Analysis in Social Science**

Inferência causal reproduzível: OLS, variáveis instrumentais (2SLS) e regression discontinuity design (RDD).

---

## Objetivos de estudo

O 14.310x ensina que **correlação ≠ causalidade**. Este repositório organiza três estratégias de identificação causal em demos R executáveis com dados sintéticos: **OLS** com controles (associação condicional), **IV/2SLS** quando há endogeneidade (variável instrumento exógena), e **RDD** quando há regra de corte que cria descontinuidade. O objetivo é saber qual estratégia usar diante de cada cenário — e comunicar limitações (supostos de exclusão, validade do instrumento, manipulação do running variable).

---

## Métodos e identificação

| Método | Identificação causal | Demo |
|--------|---------------------|------|
| **OLS** | Correlacional — controlando covariáveis | `01_ols/demo_ols.R` |
| **IV / 2SLS** | Variável instrumento exógena | `02_iv/demo_iv.R` |
| **RDD** | Discontinuidade no cutoff | `03_rdd/demo_rdd.R` |

---

## Figuras e interpretação

### OLS — relação educação × salário (synthetic)

![Scatter com reta OLS](docs/figures/ols_demo.png)

Cada ponto é um indivíduo; o eixo X é anos de educação e Y é log-salário. A reta vermelha é o fit OLS (β₁≈1.8): cada ano adicional de educação associa-se a aumento de log-salário. **Atenção:** isso é associação, não causalidade — omitted variable bias (habilidade, rede) pode inflar β₁. OLS é ponto de partida, não conclusão.

### RDD — salto no tratamento no cutoff

![Discontinuidade em x=0](docs/figures/rdd_demo.png)

O running variable (eixo X) determina elegibilidade; em x=0 há salto no outcome (eixo Y) entre controles (azul, X<0) e tratados (laranja, X≥0). O estimador RDD mede esse salto local — como se fosse um "experimento natural" no cutoff. Aplicação: políticas com elegibilidade por idade, nota, ou renda. Em IA: efeito de ativar feature apenas para usuários acima de certo threshold de engajamento.

---

## Setup

```bash
Rscript 01_ols/demo_ols.R
python docs/generate_figures.py
```

---

## Aprendizados e aplicação no mercado

Inferência causal é o rigor que separa **"a feature correlaciona com KPI"** de **"a feature causou melhoria"**. IV serve quando há confounder não observado (ex.: usuários que adotam IA são mais tech-savvy); RDD quando há cutoff de rollout; DiD (conceito do curso) para before/after com grupo controle. Para AI Engineer/CTO, dominar isso significa avaliar **impacto real de motores de inferência, copilots e automação SOAR** — e defender decisões de produto com evidência, não com anedota.

---

## Autor

**Guarantã Almeida** — [github.com/guaranta](https://github.com/guaranta)

# 👥 RH Analytics Dashboard

> Pipeline completo de Análise de RH: SQL Server → Power BI → Python

![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![pandas](https://img.shields.io/badge/pandas-150458?style=for-the-badge&logo=pandas&logoColor=white)
![matplotlib](https://img.shields.io/badge/matplotlib-11557c?style=for-the-badge&logo=python&logoColor=white)

---

## 🎯 Sobre o Projeto

Dashboard de RH interativo desenvolvido como projeto de portfólio, cobrindo o ciclo completo de análise de dados — desde a modelagem em SQL Server até a visualização em Power BI e análise exploratória em Python.

O projeto simula o ambiente analítico de uma empresa com foco em gestão de pessoas, abrangendo 4 páginas analíticas integradas com navegação fluida entre visões estratégicas de headcount, turnover e desligamentos.

---

## 🏗️ Arquitetura do Pipeline

```
SQL Server (Views)  →  Power BI (Dashboard)  →  Python (Análise)  →  GitHub
      ↓                        ↓                       ↓
  Modelagem               Storytelling            Visualizações
  com Views               com 4 páginas           matplotlib
```

---

## 📁 Estrutura do Repositório

```
projeto-rh-analytics/
│
├── sql/                          # Script SQL do projeto
│   └── RH analytics projeto.sql
│
├── Python/                       # Script de análise Python
│   └── analise_rh.py
│
├── Backgrounds/                  # Backgrounds customizados do dashboard
│   ├── bg_inicio (Template Capa).png
│   ├── bg_visao_geral (Template 1).png
│   ├── bg_pessoas (Template 2).png
│   └── bg_desligamentos (Template 3).png
│
├── charts/                       # Gráficos gerados via Python
│   ├── grafico_desligamentos_por_ano.png
│   ├── grafico_funcionarios_ativos.png
│   ├── grafico_Motivo_Saida.png
│   ├── grafico_tempo_casa_departamento.png
│   └── grafico_turnover_departamento.png
│
├── Screenshots/                  # Capturas das páginas do dashboard Power BI
│   ├── screenshot_inicio.png
│   ├── screenshot_visao_geral.png
│   ├── screenshot_pessoas.png
│   └── screenshot_desligamentos.png
│
├── RH_Analytics_Dashboard.pbix
└── README.md
```

---

## 📊 Páginas do Dashboard

### 1 — Início
Página de boas-vindas com descrição do projeto e navegação central para as três visões analíticas: Visão Geral, Pessoas e Desligamentos. Stack tecnológica exibida como contexto do portfólio.

### 2 — Visão Geral
KPIs consolidados: Headcount Ativo, Turnover Médio (%), Tenure Médio em Meses e Salário Médio. Análise de colaboradores ativos por departamento, turnover por área com alerta para departamentos acima de 28%, e ranking de retenção por tempo médio de casa. Filtro interativo por departamento.

### 3 — Pessoas
Tabela detalhada de colaboradores com Funcionário, Departamento, Cargo, Nível, Anos e Salário. KPIs de composição por gênero (Homens/Mulheres), distribuição por escolaridade e breakdown por nível de senioridade (Júnior · Pleno · Sênior).

### 4 — Desligamentos
KPIs: Total de Desligamentos, Turnover Médio (%) e Meses Médios até Saída. Análise de motivos de saída (Pedido de demissão, Desligamento empresa, Abandono, Aposentadoria), comparativo anual de desligamentos e distribuição por departamento com insights narrativos integrados.

---

## 🐍 Análise Python

Script independente que conecta diretamente ao SQL Server via `pyodbc` e gera 5 visualizações analíticas em matplotlib com identidade visual alinhada ao dashboard:

| # | Gráfico | Tipo |
|---|---------|------|
| 01 | Desligamentos por Ano | Barras verticais |
| 02 | Funcionários Ativos | Barras verticais |
| 03 | Motivo de Saída | Barras horizontais |
| 04 | Tempo de Casa por Departamento | Barras horizontais |
| 05 | Turnover por Departamento | Barras horizontais |

### Como executar

```bash
# 1. Criar e ativar ambiente virtual
python -m venv venv
venv\Scripts\activate          # Windows

# 2. Instalar dependências
pip install pyodbc pandas matplotlib numpy

# 3. Configurar conexão em analise_rh.py
SERVER   = "localhost"         # seu servidor SQL Server
DATABASE = "RH_Analytics"

# 4. Executar
python analise_rh.py
# → Gráficos salvos em charts/
```

---

## 🎨 Identidade Visual

Paleta de cores aplicada de forma consistente no Power BI e no Python:

| Cor | Hex | Uso |
|-----|-----|-----|
| Fundo Principal | `#0D1B2A` | Fundo das páginas |
| Fundo Card | `#162032` | Cards e áreas de gráfico |
| Turquesa | `#4ECDC4` | Série de dados principal e destaques |
| Laranja | `#E8956D` | Alertas e série de dados secundária |

---

## 🛠️ Stack Tecnológica

| Camada | Tecnologia |
|--------|-----------|
| Banco de dados | SQL Server 17 |
| Modelagem | Views SQL |
| Visualização | Power BI Desktop |
| Análise | Python 3 · pandas · matplotlib · pyodbc · numpy |
| Versionamento | Git · GitHub |

---

## 👤 Autor

**Daniel Mendes**  
Analista de Dados | Power BI · SQL · Python  
[LinkedIn](https://www.linkedin.com/in/danielmendes-dados) · [GitHub](https://github.com/DanielMendes-Dados)

---

*Projeto desenvolvido para portfólio profissional — dados simulados.*

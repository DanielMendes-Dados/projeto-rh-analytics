📊 RH Analytics Dashboard

Dashboard analítico de Recursos Humanos desenvolvido como projeto de portfólio, cobrindo análise de Turnover, Desligamentos e Headcount com SQL Server, Power BI e Python.

🎯 Objetivo

Transformar dados brutos de RH em insights estratégicos para apoiar decisões de retenção de talentos, identificar departamentos críticos e compreender o perfil dos colaboradores ativos e desligados.

🛠️ Tecnologias Utilizadas
Tecnologia	Versão	Finalidade
SQL Server	17.0	Banco de dados e modelagem
SSMS	22	Administração e queries
Power BI Desktop	Gratuito	Dashboard e visualizações
Python	3.15	Análises complementares
Pandas	—	Manipulação de dados
Matplotlib / Seaborn	—	Geração de gráficos
pyodbc	—	Conexão Python → SQL Server
🗂️ Estrutura do Projeto
projeto-rh-analytics/
├── Gráficos avançados Python_Pandas/   # Gráficos gerados via Python
│   ├── grafico_turnover_departamento.png
│   ├── grafico_Motivo_Saida.png
│   ├── grafico_tempo_casa_departamento.png
│   ├── grafico_desligamentos_por_ano.png
│   └── grafico_funcionarios_ativos.png
├── Capturas de tela_PBI/               # Screenshots do dashboard Power BI
│   ├── screenshot_inicio.png
│   ├── screenshot_visao_geral.png
│   ├── screenshot_pessoas.png
│   └── screenshot_desligamentos.png
├── RH analytics projeto.sql            # Script SQL completo (tabelas, dados e views)
├── analise_rh.py                       # Script Python de análise
└── README.md
🗄️ Modelagem de Dados (SQL Server)

O banco RH_Analytics contém 4 tabelas relacionais e 6 views otimizadas para consumo no Power BI:

Tabelas:

Funcionarios — cadastro completo com admissão, demissão e motivo de saída
Departamentos — estrutura organizacional e gestores
Cargos — níveis (Júnior, Pleno, Sênior) e salário base
Historico_Movimentacoes — admissões, promoções, transferências e demissões

Views (camada de dados):

vw_Funcionarios_Ativos — perfil completo do quadro ativo
vw_Desligamentos — histórico de saídas com tempo de casa e motivo
vw_Turnover_Departamento — taxa de turnover por departamento
vw_Headcount_Ativo — headcount consolidado
vw_Tenure_Departamento — tempo médio de empresa
vw_Painel_Executivo — visão consolidada com todos os KPIs
📈 Dashboard Power BI

O dashboard é composto por 4 páginas com navegação via botões:

Início (Capa)

Início

Visão Geral

Visão Geral

Pessoas

Pessoas

Desligamentos

Desligamentos

🐍 Análise em Python

O script analise_rh.py conecta diretamente ao SQL Server via pyodbc, consulta as views e gera 5 gráficos seguindo os princípios de Storytelling with Data:

Turnover por departamento — identifica os departamentos críticos
Motivos de desligamento — destaque para saídas voluntárias
Tempo de casa por departamento — alerta de retenção
Evolução de desligamentos por ano — tendência histórica
Funcionários ativos por departamento — distribuição do quadro atual

Para executar:

bash
# Pré-requisitos: Python 3.x, SQL Server com Windows Authentication
pip install pandas pyodbc matplotlib seaborn

# Executar
python analise_rh.py
🔍 Principais Insights
Comercial e Vendas, Financeiro e Suporte ao Cliente lideram o turnover com 28,6% cada
Pedido de demissão é o principal motivo de saída — sinal de alerta para retenção voluntária
Turnover médio global de 24,4% — acima do benchmark saudável de mercado (10–15%)
Departamentos com menor tempo de casa nos desligados indicam falha no processo de integração
👨‍💻 Autor

Daniel Mendes
Analista de Dados
[GitHub](https://github.com/DanielMendes-Dados) · [LinkedIn](https://www.linkedin.com/in/danielgmendes/)

Projeto desenvolvido para portfólio profissional — Novembro/2026

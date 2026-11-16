-- ============================================================
-- PROJETO: RH Analytics
-- AUTOR: Daniel Luiz Gondim Mendes Bezerra
-- DESCRICAO: Análise de RH, Turnover e Performance de Pessoas
-- DATA INICIO: Novembro/2026
-- FERRAMENTA: SQL Server 17 | SSMS 22
-- ============================================================


-- ------------------------------------------------------------
-- PASSO 2 | CRIACAO DO BANCO DE DADOS
-- ------------------------------------------------------------
 
CREATE DATABASE RH_Analytics;
GO
 
USE RH_Analytics;
GO
 
 
-- ------------------------------------------------------------
-- PASSO 3 | CRIACAO DAS TABELAS
-- ------------------------------------------------------------
 
-- TABELA 1: Departamentos
CREATE TABLE Departamentos (
    id_departamento   INT PRIMARY KEY IDENTITY(1,1),
    nome_departamento VARCHAR(100) NOT NULL,
    gestor_responsavel VARCHAR(100)
);
 
-- TABELA 2: Cargos
CREATE TABLE Cargos (
    id_cargo     INT PRIMARY KEY IDENTITY(1,1),
    nome_cargo   VARCHAR(100) NOT NULL,
    nivel        VARCHAR(20),          -- Júnior, Pleno, Sênior
    salario_base DECIMAL(10,2)
);
 
-- TABELA 3: Funcionarios
CREATE TABLE Funcionarios (
    id_funcionario  INT PRIMARY KEY IDENTITY(1,1),
    nome            VARCHAR(150) NOT NULL,
    data_nascimento DATE,
    genero          VARCHAR(20),
    escolaridade    VARCHAR(50),
    data_admissao   DATE NOT NULL,
    data_demissao   DATE,              -- NULL = ainda ativo
    motivo_saida    VARCHAR(100),      -- NULL = ainda ativo
    id_departamento INT FOREIGN KEY REFERENCES Departamentos(id_departamento),
    id_cargo        INT FOREIGN KEY REFERENCES Cargos(id_cargo),
    salario         DECIMAL(10,2)
);
 
-- TABELA 4: Historico de Movimentacoes
CREATE TABLE Historico_Movimentacoes (
    id_movimentacao      INT PRIMARY KEY IDENTITY(1,1),
    id_funcionario       INT FOREIGN KEY REFERENCES Funcionarios(id_funcionario),
    tipo_movimentacao    VARCHAR(50),  -- Admissão, Promoção, Transferência, Demissão
    data_movimentacao    DATE,
    cargo_anterior       VARCHAR(100),
    cargo_novo           VARCHAR(100),
    departamento_anterior VARCHAR(100),
    departamento_novo    VARCHAR(100),
    observacao           VARCHAR(255)
);
GO


-- ------------------------------------------------------------
-- PASSO 4 | CARGA DE DADOS
-- ------------------------------------------------------------
 
USE RH_Analytics;
GO
 
-- CARGA 1: Departamentos
INSERT INTO Departamentos (nome_departamento, gestor_responsavel) VALUES
('Tecnologia da Informacao',  'Carlos Eduardo Lima'),
('Comercial e Vendas',        'Fernanda Souza'),
('Recursos Humanos',          'Mariana Costa'),
('Financeiro',                'Roberto Alves'),
('Operacoes',                 'Paulo Henrique Melo'),
('Marketing',                 'Juliana Ferreira'),
('Suporte ao Cliente',        'Anderson Rocha');
GO
 
-- CARGA 2: Cargos
INSERT INTO Cargos (nome_cargo, nivel, salario_base) VALUES
('Analista de Dados',         'Junior',   3500.00),
('Analista de Dados',         'Pleno',    5500.00),
('Analista de Dados',         'Senior',   8500.00),
('Desenvolvedor de Software', 'Junior',   4000.00),
('Desenvolvedor de Software', 'Pleno',    6500.00),
('Desenvolvedor de Software', 'Senior',   9500.00),
('Analista de RH',            'Junior',   2800.00),
('Analista de RH',            'Pleno',    4200.00),
('Analista Financeiro',       'Pleno',    5000.00),
('Analista Financeiro',       'Senior',   7500.00),
('Consultor Comercial',       'Pleno',    4800.00),
('Gerente de Area',           'Senior',  12000.00),
('Analista de Suporte',       'Junior',   2500.00),
('Analista de Suporte',       'Pleno',    3800.00),
('Analista de Marketing',     'Pleno',    4500.00);
GO
 
-- CARGA 3: Funcionarios (50 registros — ativos e desligados)
-- Ordem das colunas: nome, data_nascimento, genero, escolaridade,
--                    data_admissao, data_demissao, motivo_saida,
--                    id_departamento, id_cargo, salario
INSERT INTO Funcionarios
    (nome, data_nascimento, genero, escolaridade,
     data_admissao, data_demissao, motivo_saida,
     id_departamento, id_cargo, salario)
VALUES
-- TI - Ativos
('Lucas Martins',          '1992-03-15', 'Masculino',  'Superior Completo', '2020-01-10', NULL,         NULL,                      1,  2,  5500.00),
('Camila Rodrigues',       '1995-07-22', 'Feminino',   'Superior Completo', '2021-03-01', NULL,         NULL,                      1,  5,  6500.00),
('Rafael Oliveira',        '1988-11-30', 'Masculino',  'Pos-Graduacao',     '2019-06-15', NULL,         NULL,                      1,  3,  8800.00),
('Thais Mendonca',         '1997-02-14', 'Feminino',   'Superior Completo', '2022-08-01', NULL,         NULL,                      1,  1,  3600.00),
('Diego Carvalho',         '1993-09-05', 'Masculino',  'Superior Completo', '2020-11-20', NULL,         NULL,                      1,  5,  6800.00),
-- TI - Desligados
('Renata Souza',           '1990-04-18', 'Feminino',   'Superior Completo', '2019-02-01', '2022-05-31', 'Pedido de demissao',      1,  2,  5500.00),
('Felipe Nascimento',      '1994-12-07', 'Masculino',  'Superior Incompleto','2021-07-01','2023-03-15', 'Desligamento empresa',    1,  1,  3500.00),
-- Comercial - Ativos
('Ana Paula Ferreira',     '1991-06-25', 'Feminino',   'Superior Completo', '2020-04-01', NULL,         NULL,                      2, 11,  5100.00),
('Bruno Lima',             '1989-01-11', 'Masculino',  'Superior Completo', '2018-09-01', NULL,         NULL,                      2, 12, 12500.00),
('Larissa Costa',          '1996-08-30', 'Feminino',   'Superior Completo', '2022-02-14', NULL,         NULL,                      2, 11,  4900.00),
('Marcos Vinicius Pinto',  '1993-05-19', 'Masculino',  'Pos-Graduacao',     '2021-01-05', NULL,         NULL,                      2, 11,  5300.00),
-- Comercial - Desligados
('Patricia Almeida',       '1988-10-03', 'Feminino',   'Superior Completo', '2017-03-01', '2022-12-31', 'Pedido de demissao',      2, 11,  4800.00),
('Joao Pedro Santos',      '1995-03-22', 'Masculino',  'Superior Completo', '2020-06-15', '2023-09-30', 'Desligamento empresa',    2, 11,  4800.00),
-- RH - Ativos
('Mariana Pereira',        '1994-07-08', 'Feminino',   'Superior Completo', '2020-02-01', NULL,         NULL,                      3,  8,  4300.00),
('Rodrigo Barbosa',        '1990-11-15', 'Masculino',  'Superior Completo', '2019-08-01', NULL,         NULL,                      3,  8,  4400.00),
('Isabela Monteiro',       '1998-04-27', 'Feminino',   'Superior Completo', '2023-01-10', NULL,         NULL,                      3,  7,  2900.00),
-- RH - Desligado
('Gustavo Ramos',          '1992-09-14', 'Masculino',  'Superior Completo', '2019-05-01', '2022-04-30', 'Pedido de demissao',      3,  7,  2800.00),
-- Financeiro - Ativos
('Priscila Nunes',         '1991-02-28', 'Feminino',   'Pos-Graduacao',     '2018-11-01', NULL,         NULL,                      4, 10,  7800.00),
('Eduardo Teixeira',       '1987-07-19', 'Masculino',  'Pos-Graduacao',     '2017-04-01', NULL,         NULL,                      4, 12, 12000.00),
('Natalia Freitas',        '1996-11-02', 'Feminino',   'Superior Completo', '2022-05-16', NULL,         NULL,                      4,  9,  5100.00),
('Henrique Castro',        '1993-03-31', 'Masculino',  'Superior Completo', '2021-09-01', NULL,         NULL,                      4,  9,  5200.00),
-- Financeiro - Desligados
('Tatiane Moura',          '1989-08-22', 'Feminino',   'Superior Completo', '2018-01-15', '2022-08-31', 'Aposentadoria',           4,  9,  5000.00),
('Victor Hugo Lima',       '1994-06-10', 'Masculino',  'Superior Completo', '2020-10-01', '2023-06-30', 'Pedido de demissao',      4,  9,  5000.00),
-- Operacoes - Ativos
('Aline Cardoso',          '1992-01-17', 'Feminino',   'Superior Completo', '2019-07-01', NULL,         NULL,                      5, 14,  3900.00),
('Fabio Araujo',           '1990-05-23', 'Masculino',  'Superior Completo', '2018-03-01', NULL,         NULL,                      5, 12, 11800.00),
('Juliane Vieira',         '1997-10-09', 'Feminino',   'Superior Completo', '2022-11-01', NULL,         NULL,                      5, 13,  2600.00),
('Leandro Correia',        '1991-12-04', 'Masculino',  'Superior Completo', '2020-07-15', NULL,         NULL,                      5, 14,  4000.00),
-- Operacoes - Desligados
('Simone Batista',         '1988-02-14', 'Feminino',   'Ensino Medio',      '2017-06-01', '2022-02-28', 'Desligamento empresa',    5, 13,  2500.00),
('Andre Luiz Gomes',       '1993-07-28', 'Masculino',  'Superior Completo', '2019-10-01', '2023-01-31', 'Pedido de demissao',      5, 14,  3800.00),
-- Marketing - Ativos
('Vanessa Dias',           '1995-04-16', 'Feminino',   'Superior Completo', '2021-05-03', NULL,         NULL,                      6, 15,  4600.00),
('Caio Fernandes',         '1994-09-21', 'Masculino',  'Superior Completo', '2020-08-10', NULL,         NULL,                      6, 15,  4700.00),
('Bruna Cavalcanti',       '1998-01-30', 'Feminino',   'Superior Completo', '2023-03-01', NULL,         NULL,                      6, 15,  4500.00),
-- Marketing - Desligado
('Thiago Mota',            '1991-06-12', 'Masculino',  'Superior Completo', '2019-01-14', '2022-11-30', 'Pedido de demissao',      6, 15,  4500.00),
-- Suporte - Ativos
('Elaine Pires',           '1993-08-07', 'Feminino',   'Superior Completo', '2020-03-02', NULL,         NULL,                      7, 14,  3850.00),
('Ricardo Nogueira',       '1996-05-14', 'Masculino',  'Superior Completo', '2021-11-01', NULL,         NULL,                      7, 13,  2550.00),
('Debora Leal',            '1999-02-19', 'Feminino',   'Superior Incompleto','2023-06-01', NULL,         NULL,                      7, 13,  2500.00),
('Mauricio Santana',       '1990-10-26', 'Masculino',  'Superior Completo', '2019-04-01', NULL,         NULL,                      7, 14,  3900.00),
-- Suporte - Desligados
('Cristiane Fonseca',      '1988-12-01', 'Feminino',   'Superior Completo', '2018-07-01', '2022-06-30', 'Desligamento empresa',    7, 13,  2500.00),
('Wellington Souza',       '1994-03-08', 'Masculino',  'Ensino Medio',      '2020-09-14', '2023-04-30', 'Abandono de emprego',     7, 13,  2500.00),
-- Perfis senior e lideranca adicionais
('Fernanda Azevedo',       '1985-06-30', 'Feminino',   'MBA',               '2016-01-04', NULL,         NULL,                      1, 12, 13000.00),
('Marcelo Cunha',          '1983-11-18', 'Masculino',  'MBA',               '2015-08-01', NULL,         NULL,                      4, 12, 12800.00),
('Sonia Ribeiro',          '1986-04-22', 'Feminino',   'Pos-Graduacao',     '2016-06-01', NULL,         NULL,                      3, 12, 11500.00),
('Danilo Campos',          '1989-09-03', 'Masculino',  'Superior Completo', '2018-02-01', NULL,         NULL,                      2,  2,  5600.00),
('Luciana Figueiredo',     '1992-07-11', 'Feminino',   'Superior Completo', '2020-05-04', NULL,         NULL,                      1,  2,  5700.00),
('Pedro Albuquerque',      '1997-01-25', 'Masculino',  'Superior Completo', '2022-09-01', NULL,         NULL,                      5,  1,  3500.00),
('Raquel Duarte',          '1995-10-13', 'Feminino',   'Superior Completo', '2021-04-01', NULL,         NULL,                      6,  2,  5500.00),
('Samuel Bezerra',         '1993-02-06', 'Masculino',  'Pos-Graduacao',     '2019-11-01', NULL,         NULL,                      1,  3,  8600.00),
('Tamara Vasconcelos',     '1996-06-18', 'Feminino',   'Superior Completo', '2022-01-17', NULL,         NULL,                      7,  2,  5400.00),
('Yuri Medeiros',          '1998-08-24', 'Masculino',  'Superior Incompleto','2023-07-03', NULL,         NULL,                      5, 13,  2500.00);
GO
 
-- CARGA 4: Historico de Movimentacoes (17 registros)
-- Registra: admissoes, promocoes, transferencias e demissoes
INSERT INTO Historico_Movimentacoes
    (id_funcionario, tipo_movimentacao, data_movimentacao,
     cargo_anterior, cargo_novo,
     departamento_anterior, departamento_novo, observacao)
VALUES
(1,  'Admissao',      '2020-01-10', NULL,                       'Analista de Dados Pleno',    NULL,                       'Tecnologia da Informacao', 'Contratacao externa'),
(2,  'Admissao',      '2021-03-01', NULL,                       'Desenvolvedor Pleno',         NULL,                       'Tecnologia da Informacao', 'Contratacao externa'),
(3,  'Admissao',      '2019-06-15', NULL,                       'Analista de Dados Senior',    NULL,                       'Tecnologia da Informacao', 'Contratacao externa'),
(4,  'Admissao',      '2022-08-01', NULL,                       'Analista de Dados Junior',    NULL,                       'Tecnologia da Informacao', 'Contratacao externa'),
(1,  'Promocao',      '2022-06-01', 'Analista de Dados Junior', 'Analista de Dados Pleno',     'Tecnologia da Informacao', 'Tecnologia da Informacao', 'Promocao por desempenho'),
(8,  'Admissao',      '2020-04-01', NULL,                       'Consultor Comercial',         NULL,                       'Comercial e Vendas',       'Contratacao externa'),
(14, 'Admissao',      '2020-02-01', NULL,                       'Analista de RH Pleno',        NULL,                       'Recursos Humanos',         'Contratacao externa'),
(14, 'Promocao',      '2022-10-01', 'Analista de RH Junior',    'Analista de RH Pleno',        'Recursos Humanos',         'Recursos Humanos',         'Promocao por desempenho'),
(18, 'Admissao',      '2018-11-01', NULL,                       'Analista Financeiro Senior',  NULL,                       'Financeiro',               'Contratacao externa'),
(6,  'Demissao',      '2022-05-31', 'Analista de Dados Pleno',  NULL,                          'Tecnologia da Informacao', NULL,                       'Pedido de demissao voluntaria'),
(7,  'Demissao',      '2023-03-15', 'Analista de Dados Junior', NULL,                          'Tecnologia da Informacao', NULL,                       'Desligamento por corte de headcount'),
(12, 'Demissao',      '2022-12-31', 'Consultor Comercial',      NULL,                          'Comercial e Vendas',       NULL,                       'Pedido de demissao voluntaria'),
(13, 'Demissao',      '2023-09-30', 'Consultor Comercial',      NULL,                          'Comercial e Vendas',       NULL,                       'Desligamento por reestruturacao'),
(5,  'Transferencia', '2022-03-01', 'Desenvolvedor Pleno',      'Desenvolvedor Pleno',         'Comercial e Vendas',       'Tecnologia da Informacao', 'Transferencia a pedido'),
(23, 'Demissao',      '2022-08-31', 'Analista Financeiro Pleno',NULL,                          'Financeiro',               NULL,                       'Aposentadoria'),
(29, 'Demissao',      '2022-02-28', 'Analista de Suporte Junior',NULL,                         'Operacoes',                NULL,                       'Desligamento empresa'),
(34, 'Demissao',      '2022-11-30', 'Analista de Marketing Pleno',NULL,                        'Marketing',                NULL,                       'Pedido de demissao voluntaria');
GO


-- ------------------------------------------------------------
-- PASSO 5 | CRIACAO DOS KPIs - QUERIES DE ANALISE - RH ANALYTICS
-- ------------------------------------------------------------
 
USE RH_Analytics;
GO
 
-- ANALISE 1: Headcount ativo por departamento
-- Headcount (total de funcionarios ativos em determinado momento)
-- Seleciona apenas quem NAO tem data_demissao preenchida (ainda na empresa)
 
SELECT
    d.nome_departamento                      AS Departamento,
    COUNT(f.id_funcionario)                  AS Headcount_Ativo
FROM Funcionarios f
INNER JOIN Departamentos d
    ON f.id_departamento = d.id_departamento
WHERE f.data_demissao IS NULL
GROUP BY d.nome_departamento
ORDER BY Headcount_Ativo DESC;
GO
 
-- ANALISE 2: Taxa de Turnover por departamento
-- Turnover (fluxo de entrada e saida de colaboradores)
-- Formula: (Desligados / Total de funcionarios) * 100
 
SELECT
    d.nome_departamento                                          AS Departamento,
    COUNT(f.id_funcionario)                                      AS Total_Funcionarios,
    SUM(CASE WHEN f.data_demissao IS NOT NULL THEN 1 ELSE 0 END) AS Desligados,
    SUM(CASE WHEN f.data_demissao IS NULL     THEN 1 ELSE 0 END) AS Ativos,
    CAST(
        SUM(CASE WHEN f.data_demissao IS NOT NULL THEN 1.0 ELSE 0 END)
        / COUNT(f.id_funcionario) * 100
    AS DECIMAL(5,1))                                             AS Turnover_Pct
FROM Funcionarios f
INNER JOIN Departamentos d
    ON f.id_departamento = d.id_departamento
GROUP BY d.nome_departamento
ORDER BY Turnover_Pct DESC;
GO
 
-- ANALISE 3: Tempo medio de empresa (tenure)
-- Tenure (tempo de permanencia de um colaborador na empresa)
-- DATEDIFF = funcao que calcula a diferenca entre duas datas
-- Para ativos: da admissao ate hoje. Para desligados: da admissao ate a saida
 
SELECT
    d.nome_departamento                           AS Departamento,
    AVG(
        DATEDIFF(MONTH,
            f.data_admissao,
            ISNULL(f.data_demissao, GETDATE())
        )
    )                                             AS Tenure_Medio_Meses,
    AVG(
        CAST(DATEDIFF(MONTH,
            f.data_admissao,
            ISNULL(f.data_demissao, GETDATE())
        ) AS DECIMAL(10,1)) / 12
    )                                             AS Tenure_Medio_Anos
FROM Funcionarios f
INNER JOIN Departamentos d
    ON f.id_departamento = d.id_departamento
GROUP BY d.nome_departamento
ORDER BY Tenure_Medio_Meses DESC;
GO
 
-- ANALISE 4: Perfil dos funcionarios ativos
-- Distribuicao por genero e escolaridade
 
SELECT
    genero                       AS Genero,
    escolaridade                 AS Escolaridade,
    COUNT(*)                     AS Quantidade
FROM Funcionarios
WHERE data_demissao IS NULL
GROUP BY genero, escolaridade
ORDER BY genero, Quantidade DESC;
GO
 
-- ANALISE 5: Motivos de saida
-- Analisa os principais motivos de desligamento
 
SELECT
    motivo_saida                 AS Motivo,
    COUNT(*)                     AS Quantidade,
    CAST(COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM Funcionarios WHERE data_demissao IS NOT NULL)
    AS DECIMAL(5,1))             AS Percentual
FROM Funcionarios
WHERE data_demissao IS NOT NULL
GROUP BY motivo_saida
ORDER BY Quantidade DESC;
GO
 
-- ANALISE 6: Faixa salarial por nivel de cargo
-- Compara salario real pago vs salario base do cargo
 
SELECT
    c.nivel                      AS Nivel,
    c.nome_cargo                 AS Cargo,
    COUNT(f.id_funcionario)      AS Qtd_Funcionarios,
    MIN(f.salario)               AS Salario_Minimo,
    AVG(f.salario)               AS Salario_Medio,
    MAX(f.salario)               AS Salario_Maximo,
    AVG(c.salario_base)          AS Salario_Base_Tabela
FROM Funcionarios f
INNER JOIN Cargos c
    ON f.id_cargo = c.id_cargo
WHERE f.data_demissao IS NULL
GROUP BY c.nivel, c.nome_cargo
ORDER BY c.nivel, Salario_Medio DESC;
GO


-- ------------------------------------------------------------
-- PASSO 6 | KPIs AVANCADOS - REMUNERACAO, TENDENCIAS E RELATORIOS DINAMICOS - Utilizando CTEs e Window Functions
-- ------------------------------------------------------------

USE RH_Analytics;
GO

-- AVANCADO 1: Ranking salarial por departamento com Window Function
-- ROW_NUMBER() = Window Function que numera as linhas dentro de uma particao
-- PARTITION BY = define o grupo de linhas para a funcao operar (aqui: por depto)
-- RANK() = similar ao ROW_NUMBER, mas empata posicoes iguais

SELECT
    d.nome_departamento          AS Departamento,
    f.nome                       AS Funcionario,
    c.nome_cargo                 AS Cargo,
    c.nivel                      AS Nivel,
    f.salario                    AS Salario,
    RANK() OVER (
        PARTITION BY d.nome_departamento
        ORDER BY f.salario DESC
    )                            AS Ranking_Salarial_Depto,
    AVG(f.salario) OVER (
        PARTITION BY d.nome_departamento
    )                            AS Media_Salarial_Depto,
    f.salario - AVG(f.salario) OVER (
        PARTITION BY d.nome_departamento
    )                            AS Diferenca_vs_Media
FROM Funcionarios f
INNER JOIN Departamentos d ON f.id_departamento = d.id_departamento
INNER JOIN Cargos c        ON f.id_cargo        = c.id_cargo
WHERE f.data_demissao IS NULL
ORDER BY d.nome_departamento, Ranking_Salarial_Depto;
GO

-- AVANCADO 2: CTE para analise de admissoes por ano
-- WITH = palavra-chave que inicia uma CTE
-- A CTE "Admissoes_Por_Ano" e criada primeiro e usada logo abaixo no SELECT principal

WITH Admissoes_Por_Ano AS (
    SELECT
        YEAR(data_admissao)              AS Ano,
        COUNT(*)                         AS Total_Admitidos,
        SUM(CASE WHEN genero = 'Feminino'  THEN 1 ELSE 0 END) AS Feminino,
        SUM(CASE WHEN genero = 'Masculino' THEN 1 ELSE 0 END) AS Masculino
    FROM Funcionarios
    GROUP BY YEAR(data_admissao)
)
SELECT
    Ano,
    Total_Admitidos,
    Feminino,
    Masculino,
    -- LAG() = Window Function que acessa o valor da linha anterior
    LAG(Total_Admitidos) OVER (ORDER BY Ano)   AS Admitidos_Ano_Anterior,
    Total_Admitidos - LAG(Total_Admitidos) OVER (ORDER BY Ano) AS Variacao
FROM Admissoes_Por_Ano
ORDER BY Ano;
GO

-- AVANCADO 3: CTE encadeada — headcount ativo + desligados + turnover em uma so query
-- Demonstra duas CTEs usadas em sequencia, combinadas no SELECT final

WITH Base_Depto AS (
    SELECT
        d.nome_departamento,
        COUNT(f.id_funcionario)                                        AS Total,
        SUM(CASE WHEN f.data_demissao IS NULL     THEN 1 ELSE 0 END)  AS Ativos,
        SUM(CASE WHEN f.data_demissao IS NOT NULL THEN 1 ELSE 0 END)  AS Desligados,
        AVG(f.salario)                                                 AS Salario_Medio
    FROM Funcionarios f
    INNER JOIN Departamentos d ON f.id_departamento = d.id_departamento
    GROUP BY d.nome_departamento
),
Ranking_Depto AS (
    SELECT
        nome_departamento,
        Total,
        Ativos,
        Desligados,
        Salario_Medio,
        CAST(Desligados * 100.0 / Total AS DECIMAL(5,1))              AS Turnover_Pct,
        -- DENSE_RANK() = rankeia sem pular numeros em caso de empate
        DENSE_RANK() OVER (ORDER BY Ativos DESC)                       AS Rank_Headcount,
        DENSE_RANK() OVER (ORDER BY Salario_Medio DESC)                AS Rank_Salario
    FROM Base_Depto
)
SELECT
    nome_departamento            AS Departamento,
    Total,
    Ativos,
    Desligados,
    Turnover_Pct,
    Salario_Medio,
    Rank_Headcount,
    Rank_Salario
FROM Ranking_Depto
ORDER BY Rank_Headcount;
GO

-- AVANCADO 4: Stored Procedure para relatorio dinamico de headcount
-- Stored Procedure (procedimento armazenado — bloco de codigo SQL
-- salvo no banco que pode ser chamado a qualquer momento com EXEC)

CREATE OR ALTER PROCEDURE sp_Relatorio_Headcount
    @Departamento VARCHAR(100) = NULL   -- parametro opcional: NULL = todos os deptos
AS
BEGIN
    SELECT
        d.nome_departamento              AS Departamento,
        f.nome                           AS Funcionario,
        c.nome_cargo + ' ' + c.nivel     AS Cargo_Nivel,
        f.data_admissao                  AS Admissao,
        DATEDIFF(YEAR, f.data_admissao, GETDATE()) AS Anos_Empresa,
        f.salario                        AS Salario
    FROM Funcionarios f
    INNER JOIN Departamentos d ON f.id_departamento = d.id_departamento
    INNER JOIN Cargos c        ON f.id_cargo        = c.id_cargo
    WHERE f.data_demissao IS NULL
      AND (@Departamento IS NULL OR d.nome_departamento = @Departamento)
    ORDER BY d.nome_departamento, f.data_admissao;
END;
GO

-- Chamando a Stored Procedure (EXEC = comando para executar uma procedure)
-- Todos os departamentos:
EXEC sp_Relatorio_Headcount;
GO

-- Apenas TI:
EXEC sp_Relatorio_Headcount @Departamento = 'Tecnologia da Informacao';
GO


-- ------------------------------------------------------------
-- PASSO 7 | CRIACAO DAS VIEWS — CAMADA DE DADOS PARA POWER BI
-- ------------------------------------------------------------
-- View (visão — consulta salva como objeto permanente no banco,
-- consultável a qualquer momento com SELECT * FROM vw_NomeDaView)
-- As Views abaixo formam a camada de dados que o Power BI importará

USE RH_Analytics;
GO

-- VIEW 1: Headcount ativo por departamento
CREATE OR ALTER VIEW vw_Headcount_Ativo AS
SELECT
    d.nome_departamento          AS Departamento,
    d.gestor_responsavel         AS Gestor,
    COUNT(f.id_funcionario)      AS Headcount_Ativo
FROM Funcionarios f
INNER JOIN Departamentos d ON f.id_departamento = d.id_departamento
WHERE f.data_demissao IS NULL
GROUP BY d.nome_departamento, d.gestor_responsavel;
GO

-- VIEW 2: Turnover por departamento
CREATE OR ALTER VIEW vw_Turnover_Departamento AS
SELECT
    d.nome_departamento                                          AS Departamento,
    COUNT(f.id_funcionario)                                      AS Total_Funcionarios,
    SUM(CASE WHEN f.data_demissao IS NULL     THEN 1 ELSE 0 END) AS Ativos,
    SUM(CASE WHEN f.data_demissao IS NOT NULL THEN 1 ELSE 0 END) AS Desligados,
    CAST(
        SUM(CASE WHEN f.data_demissao IS NOT NULL THEN 1.0 ELSE 0 END)
        / COUNT(f.id_funcionario) * 100
    AS DECIMAL(5,1))                                             AS Turnover_Pct
FROM Funcionarios f
INNER JOIN Departamentos d ON f.id_departamento = d.id_departamento
GROUP BY d.nome_departamento;
GO

-- VIEW 3: Tenure médio por departamento
CREATE OR ALTER VIEW vw_Tenure_Departamento AS
SELECT
    d.nome_departamento                           AS Departamento,
    AVG(DATEDIFF(MONTH, f.data_admissao,
        ISNULL(f.data_demissao, GETDATE())))      AS Tenure_Medio_Meses,
    AVG(CAST(DATEDIFF(MONTH, f.data_admissao,
        ISNULL(f.data_demissao, GETDATE())
    ) AS DECIMAL(10,1)) / 12)                     AS Tenure_Medio_Anos
FROM Funcionarios f
INNER JOIN Departamentos d ON f.id_departamento = d.id_departamento
GROUP BY d.nome_departamento;
GO

-- VIEW 4: Ficha completa de cada funcionário ativo
-- (tabela base principal do Power BI — une todas as dimensões)
CREATE OR ALTER VIEW vw_Funcionarios_Ativos AS
SELECT
    f.id_funcionario,
    f.nome                                            AS Funcionario,
    f.genero,
    f.escolaridade,
    f.data_nascimento,
    DATEDIFF(YEAR, f.data_nascimento, GETDATE())      AS Idade,
    f.data_admissao,
    DATEDIFF(YEAR, f.data_admissao, GETDATE())        AS Anos_Empresa,
    DATEDIFF(MONTH, f.data_admissao, GETDATE())       AS Meses_Empresa,
    d.nome_departamento                               AS Departamento,
    d.gestor_responsavel                              AS Gestor,
    c.nome_cargo                                      AS Cargo,
    c.nivel                                           AS Nivel,
    f.salario,
    c.salario_base                                    AS Salario_Base_Tabela,
    f.salario - c.salario_base                        AS Desvio_vs_Tabela
FROM Funcionarios f
INNER JOIN Departamentos d ON f.id_departamento = d.id_departamento
INNER JOIN Cargos c        ON f.id_cargo        = c.id_cargo
WHERE f.data_demissao IS NULL;
GO

-- VIEW 5: Histórico de desligamentos com detalhes
CREATE OR ALTER VIEW vw_Desligamentos AS
SELECT
    f.nome                                            AS Funcionario,
    f.genero,
    f.escolaridade,
    d.nome_departamento                               AS Departamento,
    c.nome_cargo                                      AS Cargo,
    c.nivel                                           AS Nivel,
    f.data_admissao,
    f.data_demissao,
    DATEDIFF(MONTH, f.data_admissao, f.data_demissao) AS Tempo_Casa_Meses,
    f.motivo_saida                                    AS Motivo_Saida,
    YEAR(f.data_demissao)                             AS Ano_Saida,
    MONTH(f.data_demissao)                            AS Mes_Saida
FROM Funcionarios f
INNER JOIN Departamentos d ON f.id_departamento = d.id_departamento
INNER JOIN Cargos c        ON f.id_cargo        = c.id_cargo
WHERE f.data_demissao IS NOT NULL;
GO

-- VIEW 6: Painel executivo — visão consolidada por departamento
-- (uma linha por departamento com todos os KPIs principais)
CREATE OR ALTER VIEW vw_Painel_Executivo AS
SELECT
    d.nome_departamento                                          AS Departamento,
    d.gestor_responsavel                                         AS Gestor,
    COUNT(f.id_funcionario)                                      AS Total_Funcionarios,
    SUM(CASE WHEN f.data_demissao IS NULL     THEN 1 ELSE 0 END) AS Ativos,
    SUM(CASE WHEN f.data_demissao IS NOT NULL THEN 1 ELSE 0 END) AS Desligados,
    CAST(
        SUM(CASE WHEN f.data_demissao IS NOT NULL THEN 1.0 ELSE 0 END)
        / COUNT(f.id_funcionario) * 100
    AS DECIMAL(5,1))                                             AS Turnover_Pct,
    AVG(DATEDIFF(MONTH, f.data_admissao,
        ISNULL(f.data_demissao, GETDATE())))                     AS Tenure_Medio_Meses,
    AVG(f.salario)                                               AS Salario_Medio,
    MIN(f.salario)                                               AS Salario_Minimo,
    MAX(f.salario)                                               AS Salario_Maximo
FROM Funcionarios f
INNER JOIN Departamentos d ON f.id_departamento = d.id_departamento
GROUP BY d.nome_departamento, d.gestor_responsavel;
GO

-- Testando as Views — selecione e execute um de cada vez
SELECT * FROM vw_Headcount_Ativo      ORDER BY Headcount_Ativo DESC;
GO
SELECT * FROM vw_Turnover_Departamento ORDER BY Turnover_Pct DESC;
GO
SELECT * FROM vw_Tenure_Departamento   ORDER BY Tenure_Medio_Meses DESC;
GO
SELECT * FROM vw_Funcionarios_Ativos   ORDER BY Departamento, Anos_Empresa DESC;
GO
SELECT * FROM vw_Desligamentos         ORDER BY Ano_Saida, Departamento;
GO
SELECT * FROM vw_Painel_Executivo      ORDER BY Ativos DESC;
GO
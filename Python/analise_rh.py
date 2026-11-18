# =============================================================================
# PROJETO RH ANALYTICS - Análise em Python
# Autor: Daniel Mendes
# Descrição: Análises complementares ao dashboard Power BI
#            Conexão SQL Server → Pandas → Matplotlib/Seaborn
# =============================================================================

import pyodbc
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import seaborn as sns
import warnings
warnings.filterwarnings('ignore')

# =============================================================================
# CONFIGURAÇÕES DE CONEXÃO
# =============================================================================

SERVIDOR = 'localhost'
BANCO     = 'RH_Analytics'  # ajuste se o nome do banco for diferente

STRING_CONEXAO = (
    f"DRIVER={{ODBC Driver 17 for SQL Server}};"
    f"SERVER={SERVIDOR};"
    f"DATABASE={BANCO};"
    "Trusted_Connection=yes;"
)

# =============================================================================
# IDENTIDADE VISUAL (mesma do Power BI)
# =============================================================================

NAVY   = '#0F1B2E'
TEAL   = '#00B4B4'
ORANGE = '#E8703A'   # destaque / alerta
GRAY   = '#8D99AE'   # contexto / secundário
WHITE  = '#FFFFFF'
LIGHT  = '#E8EDF2'

plt.rcParams.update({
    'figure.facecolor': NAVY,
    'axes.facecolor':   NAVY,
    'axes.edgecolor':   GRAY,
    'axes.labelcolor':  WHITE,
    'xtick.color':      GRAY,
    'ytick.color':      GRAY,
    'text.color':       WHITE,
    'font.family':      'sans-serif',
    'font.size':        11,
    'axes.spines.top':  False,
    'axes.spines.right':False,
})

# =============================================================================
# FUNÇÃO UTILITÁRIA: conectar e ler query
# =============================================================================

def ler_dados(query: str) -> pd.DataFrame:
    """Conecta ao SQL Server e retorna um DataFrame."""
    try:
        conn = pyodbc.connect(STRING_CONEXAO)
        df = pd.read_sql(query, conn)
        conn.close()
        return df
    except Exception as e:
        print(f"[ERRO DE CONEXÃO] {e}")
        return pd.DataFrame()

# =============================================================================
# 1. TURNOVER POR DEPARTAMENTO
# =============================================================================

def grafico_turnover_departamento():
    query = """
        SELECT Departamento,
               Turnover_Pct
        FROM   vw_Turnover_Departamento
        ORDER  BY Turnover_Pct DESC
    """
    df = ler_dados(query)
    if df.empty:
        print("Sem dados para Turnover por Departamento.")
        return

    # Destaque: departamento com maior turnover em laranja
    cores = [ORANGE if i == 0 else TEAL for i in range(len(df))]

    fig, ax = plt.subplots(figsize=(10, 6))
    fig.patch.set_facecolor(NAVY)

    bars = ax.barh(df['Departamento'], df['Turnover_Pct'], color=cores, height=0.6)

    # Rótulos de valor
    for bar, val in zip(bars, df['Turnover_Pct']):
        ax.text(val + 0.3, bar.get_y() + bar.get_height() / 2,
                f'{val:.1f}%', va='center', color=WHITE, fontsize=10)

    ax.set_xlabel('Turnover (%)', color=GRAY)
    ax.set_title(
        'Departamentos com maior turnover exigem atenção imediata',
        color=WHITE, fontsize=13, fontweight='bold', pad=15
    )
    ax.invert_yaxis()
    ax.set_xlim(0, df['Turnover_Pct'].max() * 1.2)

    # Legenda simples
    patch_destaque = mpatches.Patch(color=ORANGE, label='Maior turnover')
    patch_demais   = mpatches.Patch(color=TEAL,   label='Demais departamentos')
    ax.legend(handles=[patch_destaque, patch_demais],
              loc='lower right', framealpha=0, labelcolor=WHITE)

    plt.tight_layout()
    plt.savefig('grafico_turnover_departamento.png', dpi=150, bbox_inches='tight',
                facecolor=NAVY)
    print("Salvo: grafico_turnover_departamento.png")
    plt.show()


# =============================================================================
# 2. DESLIGAMENTOS POR MOTIVO
# =============================================================================

def grafico_Motivo_Saida():
    query = """
        SELECT Motivo_Saida,
               COUNT(*) AS Total
        FROM   vw_Desligamentos
        GROUP  BY Motivo_Saida
        ORDER  BY Total DESC
    """
    df = ler_dados(query)
    if df.empty:
        print("Sem dados para Motivo de Desligamento.")
        return

    # Destaque: Pedido de demissão em laranja (sinal de alerta voluntário)
    cores = [
        ORANGE if 'demissao' in str(m).lower() or 'pedido' in str(m).lower()
        else TEAL
        for m in df['Motivo_Saida']
    ]

    fig, ax = plt.subplots(figsize=(10, 6))
    fig.patch.set_facecolor(NAVY)

    bars = ax.bar(df['Motivo_Saida'], df['Total'], color=cores, width=0.6)

    for bar, val in zip(bars, df['Total']):
        ax.text(bar.get_x() + bar.get_width() / 2, bar.get_height() + 0.3,
                str(val), ha='center', color=WHITE, fontsize=10)

    ax.set_xlabel('')
    ax.set_ylabel('Quantidade de desligamentos', color=GRAY)
    ax.set_title(
        'Pedidos de demissão voluntária lideram os desligamentos',
        color=WHITE, fontsize=13, fontweight='bold', pad=15
    )
    plt.xticks(rotation=20, ha='right')

    patch_alerta = mpatches.Patch(color=ORANGE, label='Saída voluntária')
    patch_demais = mpatches.Patch(color=TEAL,   label='Demais motivos')
    ax.legend(handles=[patch_alerta, patch_demais],
              loc='upper right', framealpha=0, labelcolor=WHITE)

    plt.tight_layout()
    plt.savefig('grafico_Motivo_Saida.png', dpi=150, bbox_inches='tight',
                facecolor=NAVY)
    print("Salvo: grafico_Motivo_Saida.png")
    plt.show()


# =============================================================================
# 3. TEMPO MÉDIO DE CASA POR DEPARTAMENTO (desligados)
# =============================================================================

def grafico_tempo_casa_departamento():
    query = """
        SELECT Departamento,
               AVG(Tempo_Casa_Meses) AS Media_Meses
        FROM   vw_Desligamentos
        GROUP  BY Departamento
        ORDER  BY Media_Meses
    """
    df = ler_dados(query)
    if df.empty:
        print("Sem dados para Tempo de Casa.")
        return

    # Destaque: menor tempo de casa (maior risco de retenção)
    cores = [ORANGE if i == 0 else TEAL for i in range(len(df))]

    fig, ax = plt.subplots(figsize=(10, 6))
    fig.patch.set_facecolor(NAVY)

    bars = ax.barh(df['Departamento'], df['Media_Meses'], color=cores, height=0.6)

    for bar, val in zip(bars, df['Media_Meses']):
        ax.text(val + 0.3, bar.get_y() + bar.get_height() / 2,
                f'{val:.1f} m', va='center', color=WHITE, fontsize=10)

    ax.set_xlabel('Tempo médio de casa (meses)', color=GRAY)
    ax.set_title(
        'Funcionários desligados com menos tempo de casa indicam problema de retenção',
        color=WHITE, fontsize=12, fontweight='bold', pad=15
    )

    patch_alerta = mpatches.Patch(color=ORANGE, label='Menor tempo (alerta)')
    patch_demais = mpatches.Patch(color=TEAL,   label='Demais departamentos')
    ax.legend(handles=[patch_alerta, patch_demais],
              loc='lower right', framealpha=0, labelcolor=WHITE)

    plt.tight_layout()
    plt.savefig('grafico_tempo_casa_departamento.png', dpi=150, bbox_inches='tight',
                facecolor=NAVY)
    print("Salvo: grafico_tempo_casa_departamento.png")
    plt.show()


# =============================================================================
# 4. EVOLUÇÃO DE DESLIGAMENTOS POR ANO
# =============================================================================

def grafico_desligamentos_por_ano():
    query = """
        SELECT Ano_Saida               AS Ano,
               COUNT(*)                AS Total
        FROM   vw_Desligamentos
        GROUP  BY Ano_Saida
        ORDER  BY Ano_Saida
    """
    df = ler_dados(query)
    if df.empty:
        print("Sem dados para Desligamentos por Ano.")
        return

    df['Ano'] = df['Ano'].astype(str)
    # Destaque: ano com maior número de desligamentos
    idx_max = df['Total'].idxmax()
    cores = [ORANGE if i == idx_max else TEAL for i in range(len(df))]

    fig, ax = plt.subplots(figsize=(9, 5))
    fig.patch.set_facecolor(NAVY)

    bars = ax.bar(df['Ano'], df['Total'], color=cores, width=0.5)

    for bar, val in zip(bars, df['Total']):
        ax.text(bar.get_x() + bar.get_width() / 2, bar.get_height() + 0.2,
                str(val), ha='center', color=WHITE, fontsize=10)

    ax.set_xlabel('Ano', color=GRAY)
    ax.set_ylabel('Desligamentos', color=GRAY)
    ax.set_title(
        'Volume de desligamentos cresceu nos últimos anos',
        color=WHITE, fontsize=13, fontweight='bold', pad=15
    )

    patch_pico  = mpatches.Patch(color=ORANGE, label='Pico de desligamentos')
    patch_demais = mpatches.Patch(color=TEAL,  label='Demais anos')
    ax.legend(handles=[patch_pico, patch_demais],
              loc='upper left', framealpha=0, labelcolor=WHITE)

    plt.tight_layout()
    plt.savefig('grafico_desligamentos_por_ano.png', dpi=150, bbox_inches='tight',
                facecolor=NAVY)
    print("Salvo: grafico_desligamentos_por_ano.png")
    plt.show()


# =============================================================================
# 5. DISTRIBUIÇÃO DE FUNCIONÁRIOS ATIVOS POR DEPARTAMENTO
# =============================================================================

def grafico_funcionarios_ativos():
    query = """
        SELECT Departamento,
               COUNT(*) AS Total
        FROM   vw_Funcionarios_Ativos
        GROUP  BY Departamento
        ORDER  BY Total DESC
    """
    df = ler_dados(query)
    if df.empty:
        print("Sem dados para Funcionários Ativos.")
        return

    fig, ax = plt.subplots(figsize=(10, 6))
    fig.patch.set_facecolor(NAVY)

    bars = ax.bar(df['Departamento'], df['Total'],
                  color=TEAL, width=0.6)

    for bar, val in zip(bars, df['Total']):
        ax.text(bar.get_x() + bar.get_width() / 2, bar.get_height() + 0.2,
                str(val), ha='center', color=WHITE, fontsize=10)

    ax.set_ylabel('Funcionários ativos', color=GRAY)
    ax.set_title(
        'Distribuição atual do quadro de funcionários por departamento',
        color=WHITE, fontsize=13, fontweight='bold', pad=15
    )
    plt.xticks(rotation=20, ha='right')

    plt.tight_layout()
    plt.savefig('grafico_funcionarios_ativos.png', dpi=150, bbox_inches='tight',
                facecolor=NAVY)
    print("Salvo: grafico_funcionarios_ativos.png")
    plt.show()


# =============================================================================
# EXECUÇÃO PRINCIPAL
# =============================================================================

if __name__ == '__main__':
    print("=" * 60)
    print("  RH Analytics — Análise Python")
    print("=" * 60)

    print("\n[1/5] Turnover por departamento...")
    grafico_turnover_departamento()

    print("\n[2/5] Motivos de desligamento...")
    grafico_Motivo_Saida()

    print("\n[3/5] Tempo de casa por departamento...")
    grafico_tempo_casa_departamento()

    print("\n[4/5] Evolução de desligamentos por ano...")
    grafico_desligamentos_por_ano()

    print("\n[5/5] Funcionários ativos por departamento...")
    grafico_funcionarios_ativos()

    print("\n✓ Análise concluída! Gráficos salvos na pasta do projeto.")

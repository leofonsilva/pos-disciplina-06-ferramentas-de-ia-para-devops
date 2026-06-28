# Módulo 09 — FinOps & Rightsizing Cloud

**Cenário:** O Consultor de FinOps audita um inventário de nuvem, encontra recursos
"zumbis" (volumes EBS órfãos, IPs soltos) e instâncias superdimensionadas, e calcula
a economia estimada.

## Entrada (fonte, mantida)
- `data/inventario_cloud.json` — inventário de recursos AWS.

## Como rodar
A partir desta pasta (`module-09/`):
```bash
python labs/modulo9_finops.py
```

## Peças deste módulo
- `labs/modulo9_finops.py` — define `analyze_cloud_costs` **inline** (lê o JSON).
- `core/agents.py` — `get_finops_agent`.

## Arquivos gerados ao executar
Nenhum. Saída é o relatório de FinOps no terminal.

---

## ⚠️ Como executar (leia antes de rodar)

Rode **sempre de dentro desta pasta**, nunca da raiz do projeto:

```bash
cd modules/module-09
# ative o venv (que fica no nível acima) e então rode o comando da seção "Como rodar"
```

**Por quê:** o script encontra `core/` e `tools/` pelo próprio caminho (funciona de
qualquer lugar), **mas todo arquivo gerado é criado no diretório de onde você
executa**. Rodando de dentro do `module-09/`, o que for gerado fica isolado aqui;
rodando da raiz, polui a raiz do projeto — foi o que aconteceu no material original.

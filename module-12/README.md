# Módulo 12 — Projeto Final (Orquestração Hierárquica)

**Cenário:** Incidente multidomínio (checkout 500 + backdoor XZ + pico de custo 40%).
O **Nexus Manager** assume como "cérebro" e coordena SRE, Segurança e FinOps em
processo hierárquico, consolidando um relatório executivo.

## Como rodar
A partir desta pasta (`module-12/`):
```bash
python labs/modulo12_projeto_final.py
```

## Peças deste módulo
- `labs/modulo12_projeto_final.py` — `Process.hierarchical` + `manager_agent`.
- `core/agents.py` — `get_nexus_manager_agent`, `get_oncall_sre`,
  `get_devsecops_agent`, `get_finops_agent`.

> Os agentes são instanciados **sem tools** aqui (a coordenação é via delegação).
> Por isso **não há pasta `tools/`** neste módulo.

## Arquivos gerados ao executar
Nenhum. Saída é o relatório executivo consolidado no terminal.

---

## ⚠️ Como executar (leia antes de rodar)

Rode **sempre de dentro desta pasta**, nunca da raiz do projeto:

```bash
cd modules/module-12
# ative o venv (que fica no nível acima) e então rode o comando da seção "Como rodar"
```

**Por quê:** o script encontra `core/` e `tools/` pelo próprio caminho (funciona de
qualquer lugar), **mas todo arquivo gerado é criado no diretório de onde você
executa**. Rodando de dentro do `module-12/`, o que for gerado fica isolado aqui;
rodando da raiz, polui a raiz do projeto — foi o que aconteceu no material original.

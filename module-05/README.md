# Módulo 05 — AIOps & Observabilidade Preditiva

**Cenário:** Suspeita de disco enchendo. O agente traduz linguagem natural →
PromQL, gera um alerta preditivo (estilo Prophet/Isolation Forest) e cria um
dashboard dinâmico do Grafana.

## Como rodar
A partir desta pasta (`module-05/`):
```bash
python labs/modulo5_aiops.py
```

## Peças deste módulo
- `labs/modulo5_aiops.py` — 1 agente AIOps, 1 task que passa pelas 3 tools.
- `tools/aiops_tools.py` — `nl_to_promql`, `predictive_disk_alert`, `generate_grafana_dashboard`.

## Arquivos gerados ao executar
- **`incident_dashboard.json`** — escrito por `generate_grafana_dashboard`,
  pronto para importar no Grafana.

---

## ⚠️ Como executar (leia antes de rodar)

Rode **sempre de dentro desta pasta**, nunca da raiz do projeto:

```bash
cd modules/module-05
# ative o venv (que fica no nível acima) e então rode o comando da seção "Como rodar"
```

**Por quê:** o script encontra `core/` e `tools/` pelo próprio caminho (funciona de
qualquer lugar), **mas todo arquivo gerado é criado no diretório de onde você
executa**. Rodando de dentro do `module-05/`, o que for gerado fica isolado aqui;
rodando da raiz, polui a raiz do projeto — foi o que aconteceu no material original.

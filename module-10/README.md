# Módulo 10 — RAG & Auto-Remediação com Runbooks

**Cenário:** Alerta de "Saturação de Conexões" no banco. O SRE consulta o runbook
oficial (RAG), extrai o comando SQL exato e escreve um rascunho de post-mortem.

## Entrada (fonte, mantida)
- `data/runbook_db.md` — runbook do PostgreSQL.
  (A tool lê `data/runbook_<service>.md`; o lab usa `service='db'`.)

## Como rodar
A partir desta pasta (`module-10/`):
```bash
python labs/modulo10_remediation.py
```

## Peças deste módulo
- `labs/modulo10_remediation.py` — define `consult_runbook` **inline**.
- `core/agents.py` — `get_sre_knowledge_agent`.

## Arquivos gerados ao executar
Nenhum. Saída é o plano de remediação + post-mortem no terminal.

---

## ⚠️ Como executar (leia antes de rodar)

Rode **sempre de dentro desta pasta**, nunca da raiz do projeto:

```bash
cd modules/module-10
# ative o venv (que fica no nível acima) e então rode o comando da seção "Como rodar"
```

**Por quê:** o script encontra `core/` e `tools/` pelo próprio caminho (funciona de
qualquer lugar), **mas todo arquivo gerado é criado no diretório de onde você
executa**. Rodando de dentro do `module-10/`, o que for gerado fica isolado aqui;
rodando da raiz, polui a raiz do projeto — foi o que aconteceu no material original.

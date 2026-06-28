# Módulo 07 — Auditoria de Segurança AI (Trivy Scan)

**Cenário:** O Analista DevSecOps lê um relatório real do Trivy, filtra o ruído e
prioriza ameaças exploráveis (foco no backdoor CVE-2024-3094 / XZ Utils).

## Entrada (fonte, mantida)
- `data/trivy.json` — relatório de scan da imagem `python:3.11-slim`.

## Como rodar
A partir desta pasta (`module-07/`):
```bash
python labs/modulo7_devsecops.py
```

## Peças deste módulo
- `labs/modulo7_devsecops.py` — define a tool `analyze_trivy_report` **inline**
  (lê o JSON). Por isso **não há pasta `tools/`** neste módulo.
- `core/agents.py` — `get_devsecops_agent`.

> Obs.: no projeto original existe `tools/governance_tools.py` com uma versão
> alternativa (`triage_security_vulnerabilities`) que **nenhum lab usa** (código
> morto). Ela só aparece no `module-13` (cópia fiel do projeto completo).

## Arquivos gerados ao executar
Nenhum. Saída é um relatório priorizado no terminal.

---

## ⚠️ Como executar (leia antes de rodar)

Rode **sempre de dentro desta pasta**, nunca da raiz do projeto:

```bash
cd modules/module-07
# ative o venv (que fica no nível acima) e então rode o comando da seção "Como rodar"
```

**Por quê:** o script encontra `core/` e `tools/` pelo próprio caminho (funciona de
qualquer lugar), **mas todo arquivo gerado é criado no diretório de onde você
executa**. Rodando de dentro do `module-07/`, o que for gerado fica isolado aqui;
rodando da raiz, polui a raiz do projeto — foi o que aconteceu no material original.

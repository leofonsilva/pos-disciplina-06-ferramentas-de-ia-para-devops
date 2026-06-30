# Módulo 01 — Foundation (IA Consultiva)

**Cenário:** Validar normas de segurança internas da Nexus. O Arquiteto de Cloud
projeta um bucket S3 para logs consultando as políticas de compliance da empresa.

## Como rodar
A partir desta pasta (`module-01/`):
```bash
python labs/modulo1_foundation.py
```
> Requer `OPENAI_API_KEY`. Copie o `.env.example` para `.env` nesta pasta e preencha a chave.

## Peças deste módulo
- `labs/modulo1_foundation.py` — orquestração (1 agente, 1 task).
- `core/` — `llm_config` + `agents` (fábrica de agentes).
- `tools/policy_rag.py` — `check_compliance_rules` (única tool usada aqui).

## Arquivos gerados ao executar
Nenhum. O módulo apenas produz um plano em texto no terminal.

---

## ⚠️ Como executar (leia antes de rodar)

Rode **sempre de dentro desta pasta**, nunca da raiz do projeto:

```bash
cd modules/module-01
# ative o venv (que fica no nível acima) e então rode o comando da seção "Como rodar"
```

**Por quê:** o script encontra `core/` e `tools/` pelo próprio caminho (funciona de
qualquer lugar), **mas todo arquivo gerado é criado no diretório de onde você
executa**. Rodando de dentro do `module-01/`, o que for gerado fica isolado aqui;
rodando da raiz, polui a raiz do projeto — foi o que aconteceu no material original.

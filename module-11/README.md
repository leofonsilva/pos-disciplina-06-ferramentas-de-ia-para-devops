# Módulo 11 — Guardrails & Human-in-the-Loop

**Cenário:** Pipeline autônomo de K8s propõe um `kubectl set image` com
`--dry-run=client` e **pede aprovação humana no terminal** antes de "executar".

## Como rodar
A partir desta pasta (`module-11/`):
```bash
python labs/modulo11_guardrails.py
```
Ao final ele pergunta: `Você aprova a execução? (sim/não)`.

## Peças deste módulo
- `labs/modulo11_guardrails.py` — cria o `Agent` **direto** (não usa a fábrica
  `core/agents.py`), importando apenas `core/llm_config.nexus_llm`.
- Não usa nenhuma tool — por isso **não há pasta `tools/`** aqui.

> Este módulo nem usa a fábrica `core/agents.py`: precisa só de
> `core/llm_config.py` (+ `core/__init__.py`). O `agents.py` foi mantido em
> `core/` apenas para não fragmentar o arquivo-fábrica.

## Arquivos gerados ao executar
Nenhum.

---

## ⚠️ Como executar (leia antes de rodar)

Rode **sempre de dentro desta pasta**, nunca da raiz do projeto:

```bash
cd modules/module-11
# ative o venv (que fica no nível acima) e então rode o comando da seção "Como rodar"
```

**Por quê:** o script encontra `core/` e `tools/` pelo próprio caminho (funciona de
qualquer lugar), **mas todo arquivo gerado é criado no diretório de onde você
executa**. Rodando de dentro do `module-11/`, o que for gerado fica isolado aqui;
rodando da raiz, polui a raiz do projeto — foi o que aconteceu no material original.

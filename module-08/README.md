# Módulo 08 — Otimização Inteligente de CI/CD

**Cenário:** O Engenheiro de Plataforma lê um workflow lento do GitHub Actions,
identifica a falta de cache e reescreve aplicando boas práticas para Node.js.

## Entrada (fonte, mantida)
- `data/workflow_lento.yaml` — pipeline sem cache (`npm install` baixa tudo sempre).

## Como rodar
A partir desta pasta (`module-08/`):
```bash
python labs/modulo8_cicd.py
```

## Peças deste módulo
- `labs/modulo8_cicd.py` — define `analyze_workflow_yaml` **inline** (lê o YAML).
- `core/agents.py` — `get_cicd_agent`.

## Arquivos gerados ao executar
Nenhum (o YAML otimizado sai no terminal).

> Nota: no projeto original existia `data/workflow_rapido.yaml` — é o **gabarito**
> (resposta esperada escrita à mão pelo autor), não uma saída do código. Por isso
> não foi copiado; ele continua em `data/` na raiz original como referência.

---

## ⚠️ Como executar (leia antes de rodar)

Rode **sempre de dentro desta pasta**, nunca da raiz do projeto:

```bash
cd modules/module-08
# ative o venv (que fica no nível acima) e então rode o comando da seção "Como rodar"
```

**Por quê:** o script encontra `core/` e `tools/` pelo próprio caminho (funciona de
qualquer lugar), **mas todo arquivo gerado é criado no diretório de onde você
executa**. Rodando de dentro do `module-08/`, o que for gerado fica isolado aqui;
rodando da raiz, polui a raiz do projeto — foi o que aconteceu no material original.

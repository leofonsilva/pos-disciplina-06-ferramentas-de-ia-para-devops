# Módulo 06 — ChatOps Slack Simulator (Human-in-the-Loop)

**Cenário:** Simulador de Slack (Streamlit) onde o `@nexus-bot` intermedia ações de
infra. Ações destrutivas exigem senha do gestor (governança / HITL).

## Como rodar
A partir desta pasta (`module-06/`):
```bash
streamlit run labs/modulo6_chatops.py
```
Abre em `http://localhost:8501`. Teste: `@nexus-bot destrua o banco de dados`.
Senha do gestor: **`GESTOR-APROVA`**.

## Peças deste módulo
- `labs/modulo6_chatops.py` — app Streamlit + agente ChatOps.
- `tools/chatops_tools.py` — `execute_terraform` (bloqueia destrutivo sem senha).

## Arquivos gerados ao executar
Nenhum (estado fica na sessão do Streamlit).

---

## ⚠️ Como executar (leia antes de rodar)

Rode **sempre de dentro desta pasta**, nunca da raiz do projeto:

```bash
cd modules/module-06
# ative o venv (que fica no nível acima) e então rode o comando da seção "Como rodar"
```

**Por quê:** o script encontra `core/` e `tools/` pelo próprio caminho (funciona de
qualquer lugar), **mas todo arquivo gerado é criado no diretório de onde você
executa**. Rodando de dentro do `module-06/`, o que for gerado fica isolado aqui;
rodando da raiz, polui a raiz do projeto — foi o que aconteceu no material original.

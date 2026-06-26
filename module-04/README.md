# Módulo 04 — Troubleshooting (ReAct) & Self-Healing

**Cenário:** Usuários reportam lentidão/erros no checkout. O SRE de plantão usa
ReAct (Prometheus + Jaeger + inspeção de pod) para achar a causa raiz; o Arquiteto
gera o hotfix corrigido.

## Entrada (fonte, mantida)
- `checkout-broken.yaml` — cenário QUEBRADO (imagem inexistente → ImagePullBackOff).

## Como rodar
A partir desta pasta (`module-04/`):
```bash
# (opcional, se tiver cluster) simula a quebra
kubectl apply -f checkout-broken.yaml
python labs/modulo4_troubleshooting.py
```

## Peças deste módulo
- `tools/k8s_diag.py` — `inspect_pod_failure`, `suggest_fix`.
- `tools/obs_tools.py` — `query_prometheus_metrics`, `query_jaeger_traces`.
- `tools/file_writer.py` — `write_file`.

## Arquivos gerados ao executar
- **`checkout-k8s-fix.yaml`** — manifesto corrigido escrito pelo agente arquiteto.

---

## ⚠️ Como executar (leia antes de rodar)

Rode **sempre de dentro desta pasta**, nunca da raiz do projeto:

```bash
cd modules/module-04
# ative o venv (que fica no nível acima) e então rode o comando da seção "Como rodar"
```

**Por quê:** o script encontra `core/` e `tools/` pelo próprio caminho (funciona de
qualquer lugar), **mas todo arquivo gerado é criado no diretório de onde você
executa**. Rodando de dentro do `module-04/`, o que for gerado fica isolado aqui;
rodando da raiz, polui a raiz do projeto — foi o que aconteceu no material original.

# Módulo 03 — Kubernetes AI-Ops & GitOps Flow

**Cenário:** O Arquiteto gera manifestos K8s V1, o SRE faz o "Sync" (reconciliação
declarativa) e analisa as métricas do rollout Canary (Healthy/Unhealthy).

## Como rodar
A partir desta pasta (`module-03/`):
```bash
python labs/modulo3_k8s_ops.py
```
> `kubectl` é opcional — sem cluster, a tool entra em modo simulação.

## Peças deste módulo
- `labs/modulo3_k8s_ops.py` — pipeline (design → sync → monitor).
- `tools/k8s_ops.py` — `generate_k8s_manifest`, `apply_k8s_manifest`, `analyze_canary_metrics`.

## Arquivos gerados ao executar
- **`nexus-api-error-k8s.yaml`** — escrito por `generate_k8s_manifest`
  (nome = `<app_name>-k8s.yaml`). No original existiam 3 variações
  (`nexus-api-k8s.yaml`, `nexus-api-unipds-k8s.yaml`) de execuções diferentes.

---

## ⚠️ Como executar (leia antes de rodar)

Rode **sempre de dentro desta pasta**, nunca da raiz do projeto:

```bash
cd modules/module-03
# ative o venv (que fica no nível acima) e então rode o comando da seção "Como rodar"
```

**Por quê:** o script encontra `core/` e `tools/` pelo próprio caminho (funciona de
qualquer lugar), **mas todo arquivo gerado é criado no diretório de onde você
executa**. Rodando de dentro do `module-03/`, o que for gerado fica isolado aqui;
rodando da raiz, polui a raiz do projeto — foi o que aconteceu no material original.

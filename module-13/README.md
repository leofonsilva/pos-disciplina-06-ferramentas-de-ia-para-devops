# Módulo 13 — Containerização & Deploy do Nexus-Bot

**Tema:** Levar o projeto inteiro de "script local" para cloud-native: Docker →
Minikube → LocalStack → Streamlit → Ollama. **Não há código Python novo** — este
módulo empacota e orquestra tudo dos módulos 1–12.

> Por isso este módulo é o **projeto completo, puro** (todos os labs, `core/`,
> `tools/`, `data/` de entrada, `ui/app.py` e a Central CLI). O `Dockerfile` faz
> `COPY . .` e o `CMD` roda `labs/modulo12_projeto_final.py`; `k8s/job.yaml` e
> `k8s/streamlit.yaml` sobem essa mesma imagem.

## Conteúdo de deploy
- `Dockerfile`, `.dockerignore` — build da imagem `nexus-bot:v1`.
- `k8s/secret.yml` — `OPENAI_API_KEY` (base64).
- `k8s/deploy.yml`, `k8s/job.yaml` — roda o bot no cluster.
- `k8s/localstack.yml` — cloud simulada (S3/SQS/IAM) em `http://localstack:4566`.
- `k8s/streamlit.yaml` — UI (`ui/app.py`) como serviço.
- `k8s/ollama.yaml` — LLM offline (`http://ollama:11434`).
- `k8s/connect-test.yaml` — Job de teste de conectividade com o LocalStack.
- `nexus_iac_copilot.py` — Central de Comando CLI (menu dos 12 labs).

## Como rodar (resumo do fluxo dos slides 13.1–13.5)
```bash
minikube start --driver=docker
eval $(minikube docker-env)
docker build -t nexus-bot:v1 .
kubectl apply -f k8s/secret.yml
kubectl apply -f k8s/localstack.yml
kubectl apply -f k8s/ollama.yaml
kubectl apply -f k8s/streamlit.yaml
minikube service nexus-ui
```

## Arquivos gerados ao executar
Em runtime, os labs continuam gerando seus artefatos (`main.tf`, `*-k8s.yaml`,
`incident_dashboard.json`, `checkout-k8s-fix.yaml`) — mas dentro do container,
não nesta pasta. Aqui ela está **pura** (só fontes + assets de deploy).

---

## ⚠️ Como executar (leia antes de rodar)

Rode **de dentro desta pasta** (`cd modules/module-13`). O `docker build` usa o
diretório atual como contexto de build, então é daqui que a imagem `nexus-bot:v1`
é montada com todo o conteúdo deste módulo.

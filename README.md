# Pós Disciplina 06 - Ferramentas de IA para DevOps

## Introdução
Pendente...

## Setup Python + Virtual Environment (WSL Ubuntu 24)

1. Atualizar o sistema
```bash
sudo apt update && sudo apt upgrade -y
```

2. Instalar Python e ferramentas necessárias
```bash
sudo apt install python3 python3-pip python3-venv -y
```

3. Acessar o diretório do projeto (ignorar se já estiver na pasta desejada)
```bash
cd <<disciplina>>
```

4. Criar o ambiente virtual
```bash
python3 -m venv .venv
```

5. Ativar o ambiente virtual
```bash
source .venv/bin/activate
```
- Após ativar, o terminal deve mostrar algo assim:
```bash
(.venv) user@machine:~/seu-projeto$
```

6. Instalar dependências do projeto (exemplo)
```bash
pip install -r requirements.txt
```

7. Verificar instalação (opcional)
```bash
python --version
pip list
```

8. Desativar o ambiente virtual
```bash
deactivate
```

9. Uso no dia a dia, sempre que voltar ao projeto:
```bash
cd <<disciplina>>
source .venv/bin/activate
cd <<modulo>>
```

10. Observações

* O ambiente virtual fica dentro da pasta `.venv/`
* Não deve ser versionado no Git
* Para remover o ambiente, basta deletar a pasta:
```bash
rm -rf .venv
```

## Módulos

### Módulo 01: Fundamentos e Arquitetura de IA para Infraestrutura

#### **Projeto:** [Compliance Architect](module-01)

**Tecnologias utilizadas:**
- **Python** - Linguagem principal dos laboratórios
- **CrewAI** - Framework de orquestração de agentes (`Agent`, `Task`, `Crew`)
- **LLM (Large Language Model)** - Motor com raciocínio estruturado
- **RAG simples** - Tool que injeta políticas corporativas no contexto

**Conceitos abordados:**
- IA consultiva: o agente **recomenda**, não executa ações destrutivas
- Anatomia de um agente CrewAI: `role`, `goal`, `backstory`, `tools`, `llm`
- Tool de compliance (`check_compliance_rules`) como base de conhecimento
- Fluxo mínimo: 1 agente + 1 task + `Crew.kickoff()`
- Centralização do LLM e da fábrica de agentes (`core/`)

**Aplicação prática:**
O **Arquiteto de Cloud Nexus** projeta um bucket S3 para logs consultando as normas
internas da empresa. A tool retorna as regras (prefixo `nexus-`, região `us-east-1`,
buckets sempre privados) e o agente entrega um plano aderente a essas políticas.

**Comandos executados:**
```bash
cd module-01
python labs/modulo1_foundation.py
```

**Arquitetura:**
```
Task (desenhar bucket S3)
    ↓
Crew.kickoff()
    ↓
Agent: Arquiteto de Cloud  ←→  LLM (ChatGPT)
    ↓
Tool: check_compliance_rules (regras: nexus-, us-east-1, privado)
    ↓
Saída: plano de design em conformidade
```

### Módulo 02: IaC Copilot (Terraform e Cloud)

#### **Projeto:** [IaC Copilot](module-02)

**Tecnologias utilizadas:**
- **Python** - Linguagem principal dos laboratórios
- **CrewAI** - Framework de orquestração de agentes (`Agent`, `Task`, `Crew`)
- **LLM (Large Language Model)** - Motor com raciocínio estruturado
- **Terraform (HCL)** - Código de infraestrutura gerado pelo agente
- **Checkov** - Scanner estático de segurança de IaC (CLI real, opcional)
- **OPA (Open Policy Agent)** - Validação de governança (simulada na tool)

**Conceitos abordados:**
- Pipeline **sequencial** com 2 agentes (`Process.sequential`)
- Separação de papéis: Arquiteto **gera**, Auditor **valida**
- Compliance-as-code: scan automático + políticas corporativas
- Persistência de artefato em disco (`write_file`)
- Loop de correção: se a auditoria falha, o arquiteto corrige

**Aplicação prática:**
O Arquiteto gera um `main.tf` para o bucket `nexus-apollo-data` (us-east-1) e o
Auditor de DevSecOps valida com `run_checkov_scan` e `validate_opa_policies`. As
políticas OPA bloqueiam violações (região errada, instância cara, ingress público).

**Comandos executados:**
```bash
cd module-02
python labs/modulo2_iac_copilot.py
```
> **Gera:** `main.tf` na pasta do módulo.

**Arquitetura:**
```
Task 1 (gerar) ──→ Arquiteto ──→ write_file ──→ main.tf
                                                    ↓
Task 2 (auditar) ──→ Auditor ──→ run_checkov_scan + validate_opa_policies
                                                    ↓
                              Relatório de conformidade (ou correção)
```

**Checkov vs OPA:**
| Ferramenta | O que valida | Como roda |
|---|---|---|
| `run_checkov_scan` | regras genéricas de segurança IaC | CLI real (degrada com aviso se ausente) |
| `validate_opa_policies` | regras corporativas (soberania, custo, rede) | simulada na tool |

### Módulo 03: Agentes para Kubernetes (K8s AI-Ops)

#### **Projeto:** [K8s GitOps & Canary](module-03)

**Tecnologias utilizadas:**
- **Python** - Linguagem principal dos laboratórios
- **CrewAI** - Framework de orquestração de agentes (`Agent`, `Task`, `Crew`)
- **LLM (Large Language Model)** - Motor com raciocínio estruturado
- **Kubernetes (YAML V1)** - Manifestos de Deployment + Service
- **kubectl** - Aplicação no cluster (opcional; modo simulação sem cluster)
- **GitOps / Canary** - Reconciliação declarativa e análise de rollout

**Conceitos abordados:**
- Geração de manifestos K8s via IA (`generate_k8s_manifest`)
- Reconciliação GitOps (`apply_k8s_manifest`) com fallback simulado
- Canary analysis: decisão Healthy/Unhealthy por métricas
- Pipeline de 3 etapas: **design → sync → monitor**
- Divisão de papéis: Arquiteto desenha, SRE aplica e analisa

**Aplicação prática:**
O Arquiteto gera o manifesto do app `nexus-api-error` (2 réplicas, porta 80), o SRE
faz o Sync no cluster e depois analisa métricas (`error_rate`, `latency`) para
decidir se o rollout segue ou faz rollback.

**Comandos executados:**
```bash
cd module-03
python labs/modulo3_k8s_ops.py
```
> **Gera:** `nexus-api-error-k8s.yaml` na pasta do módulo.

**Arquitetura:**
```
Task design ──→ Arquiteto ──→ generate_k8s_manifest ──→ <app>-k8s.yaml
Task sync   ──→ SRE       ──→ apply_k8s_manifest (kubectl | simulação)
Task monitor──→ SRE       ──→ analyze_canary_metrics ──→ Healthy / Unhealthy
```

### Módulo 04: Troubleshooting e Diagnóstico com React

#### **Projeto:** [ReAct Self-Healing](module-04)

**Tecnologias utilizadas:**
- **Python** - Linguagem principal dos laboratórios
- **CrewAI** - Framework de orquestração de agentes (`Agent`, `Task`, `Crew`)
- **LLM (Large Language Model)** - Motor com raciocínio estruturado
- **Prometheus & Jaeger** - Observabilidade (métricas e traces, simulados)
- **Kubernetes** - Inspeção de pods e geração do hotfix
- **Framework ReAct** - Reason + Act + Observe

**Conceitos abordados:**
- Diagnóstico ReAct: pensar → consultar → observar → correlacionar
- Observabilidade em 3 frentes: métricas (Prometheus), traces (Jaeger), logs/pod
- Detecção de falhas: `CrashLoopBackOff`, `OOMKilled`, `ImagePullBackOff`
- Self-healing: geração do manifesto corrigido com probes
- Delegação entre SRE (diagnóstico) e Arquiteto (correção)

**Aplicação prática:**
Com o cenário quebrado `checkout-broken.yaml` (imagem inexistente), o SRE de plantão
investiga latência/erros via Prometheus + Jaeger + inspeção do pod, e o Arquiteto
gera o `checkout-k8s-fix.yaml` com imagem válida e probes corretos.

**Comandos executados:**
```bash
cd module-04
# (opcional, com cluster) simula a quebra:
kubectl get pods
kubectl get pods -A
kubectl apply -f checkout-broken.yaml # Arquivo com erros propositais
kubectl describe pod checkout-api-567759c556-zbs9h
python labs/modulo4_troubleshooting.py
kubectl apply -f checkout-k8s-fix.yaml # Arquivo gerado com as correções baseado no checkout-broken.yaml
kubectl describe pod checkout-api-7874cd7b7d-bj4nk
```
> **Entrada:** `checkout-broken.yaml` · **Gera:** `checkout-k8s-fix.yaml`

**Arquitetura:**
```
Alerta (lentidão/erro no checkout)
    ↓
SRE On-Call (ReAct)
  ├─ query_prometheus_metrics  (error rate / latency)
  ├─ query_jaeger_traces       (gargalo: DB PostgreSQL)
  ├─ inspect_pod_failure       (CrashLoop / OOM)
  └─ suggest_fix
    ↓ (delegação)
Arquiteto ──→ write_file ──→ checkout-k8s-fix.yaml (imagem válida + probes)
```

### Módulo 05: AIOps e Observabilidade Preditiva

#### **Projeto:** [Predictive AIOps](module-05)

**Tecnologias utilizadas:**
- **Python** - Linguagem principal dos laboratórios
- **CrewAI** - Framework de orquestração de agentes (`Agent`, `Task`, `Crew`)
- **LLM (Large Language Model)** - Motor com raciocínio estruturado
- **PromQL** - Linguagem de consulta de métricas (gerada por NL2Query)
- **Grafana** - Dashboard dinâmico (JSON gerado)
- **ML conceitual** - Prophet / Isolation Forest (previsão de saturação)

**Conceitos abordados:**
- NL2Query: traduzir linguagem natural para PromQL/LogQL
- Observabilidade **preditiva**: prever o alerta antes de ele tocar
- Análise de séries temporais e detecção de anomalias
- Geração dinâmica de dashboards Grafana via JSON
- Fluxo único passando pelas 3 ferramentas

**Aplicação prática:**
Diante de suspeita de disco enchendo, o agente traduz "qual a porcentagem de disco
livre?" para PromQL, avalia o histórico (uso 85% + crescimento 2GB/h) gerando uma
previsão de saturação, e cria um dashboard de incidente para a equipe acompanhar.

**Comandos executados:**
```bash
cd module-05
python labs/modulo5_aiops.py
docker run -d -p 3000:3000 --name meu-grafana grafana/grafana
```
> **Gera:** `incident_dashboard.json` (pronto para importar no Grafana).

**Arquitetura:**
```
Pedido em linguagem natural
    ↓
Agente AIOps
  ├─ nl_to_promql            → PromQL
  ├─ predictive_disk_alert   → previsão de saturação (ML)
  └─ generate_grafana_dashboard → incident_dashboard.json
```

### Módulo 06: ChatOps e Governança

#### **Projeto:** [ChatOps Slack Simulator](module-06)

**Tecnologias utilizadas:**
- **Python** - Linguagem principal dos laboratórios
- **CrewAI** - Framework de orquestração de agentes (`Agent`, `Task`, `Crew`)
- **LLM (Large Language Model)** - Motor com raciocínio estruturado
- **Streamlit** - Interface visual do simulador de Slack
- **Human-in-the-Loop (HITL)** - Aprovação humana para ações críticas

**Conceitos abordados:**
- ChatOps: operar infraestrutura via chat conversacional
- Governança e RBAC: ações destrutivas exigem senha de gestor
- Estado de sessão e histórico de mensagens (Streamlit)
- Tool com trava de segurança (`execute_terraform`)

**Aplicação prática:**
Um simulador de Slack onde o `@nexus-bot` intermedia comandos. Ações destrutivas
(`destruir`, `apagar`, `destroy`) são bloqueadas até o usuário fornecer a senha do
gestor (`GESTOR-APROVA`).

**Comandos executados:**
```bash
cd module-06
streamlit run labs/modulo6_chatops.py
# abre em http://localhost:8501
# teste: "@nexus-bot destrua o banco de dados"  →  senha: GESTOR-APROVA
```

**Arquitetura:**
```
Streamlit (chat) ──→ prompt do usuário
    ↓
Agente ChatOps ──→ execute_terraform(command, manager_password)
    ↓
  ação destrutiva? ──sim──→ exige GESTOR-APROVA ──→ executa / bloqueia
                   └─não──→ executa (baixo impacto)
```

### Módulo 07: Segurança e Compliance (DevSecOps + AI)

#### **Projeto:** [DevSecOps Trivy Audit](module-07)

**Tecnologias utilizadas:**
- **Python** - Linguagem principal dos laboratórios
- **CrewAI** - Framework de orquestração de agentes (`Agent`, `Task`, `Crew`)
- **LLM (Large Language Model)** - Motor com raciocínio estruturado
- **Trivy** - Relatório de scan de segurança de imagens (JSON)
- **Tool inline** - Definida no próprio lab (`analyze_trivy_report`)

**Conceitos abordados:**
- Triagem inteligente: separar vulnerabilidade real de ruído/falso positivo
- Priorização por explorabilidade (não só por severidade)
- Estudo de caso real: backdoor **CVE-2024-3094** (XZ Utils / liblzma)
- Leitura de evidência (`data/trivy.json`) como entrada do agente

**Aplicação prática:**
O Analista de DevSecOps lê o relatório real do Trivy, filtra o ruído e gera um
parecer executivo focado na ameaça crítica de backdoor, com plano de ação imediato.

**Comandos executados:**
```bash
cd module-07
python labs/modulo7_devsecops.py
```
> **Entrada:** `data/trivy.json`

**Arquitetura:**
```
data/trivy.json
    ↓
Agente DevSecOps ──→ analyze_trivy_report (tool inline)
    ↓
Relatório priorizado (foco: CVE-2024-3094 / XZ backdoor)
```

### Módulo 08: CI/CD Copilot e Otimização

#### **Projeto:** [CI/CD Optimizer](module-08)

**Tecnologias utilizadas:**
- **Python** - Linguagem principal dos laboratórios
- **CrewAI** - Framework de orquestração de agentes (`Agent`, `Task`, `Crew`)
- **LLM (Large Language Model)** - Motor com raciocínio estruturado
- **GitHub Actions (YAML)** - Workflow de CI analisado
- **Tool inline** - `analyze_workflow_yaml`

**Conceitos abordados:**
- Análise de gargalos em pipelines (falta de cache)
- Boas práticas de cache de dependências (Node.js / `actions/cache`)
- Estimativa de economia de tempo/custo de runner
- Reescrita assistida de YAML

**Aplicação prática:**
O Engenheiro de Plataforma lê o `workflow_lento.yaml` (sem cache, `npm install`
baixando tudo sempre), identifica o problema e reescreve aplicando cache, explicando
a economia estimada.

**Comandos executados:**
```bash
cd module-08
python labs/modulo8_cicd.py
```
> **Entrada:** `data/workflow_lento.yaml` (o `workflow_rapido.yaml` original é o
> gabarito manual e fica só no projeto-raiz).

**Arquitetura:**
```
data/workflow_lento.yaml
    ↓
Agente CI/CD ──→ analyze_workflow_yaml (tool inline)
    ↓
YAML otimizado (com actions/cache) + estimativa de ganho
```

### Módulo 09: FinOps e Otimização de Custos

#### **Projeto:** [FinOps Auditor](module-09)

**Tecnologias utilizadas:**
- **Python** - Linguagem principal dos laboratórios
- **CrewAI** - Framework de orquestração de agentes (`Agent`, `Task`, `Crew`)
- **LLM (Large Language Model)** - Motor com raciocínio estruturado
- **JSON** - Inventário de recursos de nuvem
- **Tool inline** - `analyze_cloud_costs`

**Conceitos abordados:**
- Caça a recursos "zumbis" (volumes EBS órfãos, Elastic IPs soltos)
- Rightsizing de instâncias superdimensionadas
- Cálculo de economia estimada (ROI)
- Auditoria financeira a partir de inventário

**Aplicação prática:**
O Consultor de FinOps audita o `inventario_cloud.json`, identifica desperdício
(volume disponível de 500GB, instância `m5.4xlarge` com CPU em 2.5%, IP solto) e
gera um relatório de cortes com a economia total em dólares.

**Comandos executados:**
```bash
cd module-09
python labs/modulo9_finops.py
```
> **Entrada:** `data/inventario_cloud.json`

**Arquitetura:**
```
data/inventario_cloud.json
    ↓
Agente FinOps ──→ analyze_cloud_costs (tool inline)
    ↓
Relatório: zumbis + rightsizing + economia estimada (US$)
```

### Módulo 10: RAG de Runbooks e Auto-Remediação

#### **Projeto:** [RAG Runbook Remediation](module-10)

**Tecnologias utilizadas:**
- **Python** - Linguagem principal dos laboratórios
- **CrewAI** - Framework de orquestração de agentes (`Agent`, `Task`, `Crew`)
- **LLM (Large Language Model)** - Motor com raciocínio estruturado
- **Markdown** - Runbook corporativo como base de conhecimento
- **RAG** - Recuperação de documento por serviço
- **Tool inline** - `consult_runbook`

**Conceitos abordados:**
- RAG: consultar runbooks oficiais em tempo real
- Remediação baseada em evidência/documentação
- Geração de rascunho de post-mortem
- Resolução de caminho por serviço (`runbook_<service>.md`)

**Aplicação prática:**
Diante de um alerta de "Saturação de Conexões" no banco, o SRE consulta o runbook do
serviço `db` (`runbook_db.md`), extrai o comando SQL exato de limpeza de conexões
ociosas e escreve um rascunho de post-mortem.

**Comandos executados:**
```bash
cd module-10
python labs/modulo10_remediation.py
```
> **Entrada:** `data/runbook_db.md`

**Arquitetura:**
```
Alerta (saturação de conexões no db)
    ↓
Agente SRE de Conhecimento ──→ consult_runbook("db") ──→ data/runbook_db.md
    ↓
Plano de remediação (comando SQL) + rascunho de post-mortem
```

### Módulo 11: Auto-Remediação Segura com Guardrails

#### **Projeto:** [Guardrails HITL](module-11)

**Tecnologias utilizadas:**
- **Python** - Linguagem principal dos laboratórios
- **CrewAI** - Framework de orquestração de agentes (`Agent`, `Task`, `Crew`)
- **LLM (Large Language Model)** - Motor com raciocínio estruturado
- **Terminal interativo** - Aprovação humana em linha (`input`)
- **Dry-run** - Validação do comando antes da execução

**Conceitos abordados:**
- Guardrails contra alucinação/ação indevida da IA
- Human-in-the-loop **obrigatório** para operações de escrita
- `--dry-run` para prever impacto antes de aplicar
- Agente criado **direto** (`Agent`), sem a fábrica `core/agents.py`

**Aplicação prática:**
Um SRE cauteloso detecta erro de imagem no `checkout-api`, propõe o
`kubectl set image` para a versão estável e apresenta o comando com
`--dry-run=client`. O terminal pergunta se você aprova a execução em produção
(`sim/não`) antes de "aplicar".

**Comandos executados:**
```bash
cd module-11
python labs/modulo11_guardrails.py
# ao final: "Você aprova a execução? (sim/não)"
```

**Arquitetura:**
```
Agent (Safety_SRE, criado direto) ──→ LLM
    ↓
Proposta de comando + dry-run
    ↓
input() humano ── sim ──→ executa (simulado)
              └─ não ──→ aborta e registra auditoria
```

### Módulo 12: Projeto Integrador

#### **Projeto:** [Nexus-Bot Full Stack](module-12)

**Tecnologias utilizadas:**
- **Python** - Linguagem principal dos laboratórios
- **CrewAI** - Framework de orquestração de agentes (`Agent`, `Task`, `Crew`)
- **LLM (Large Language Model)** - Motor com raciocínio estruturado
- **CrewAI `Process.hierarchical`** - Processo hierárquico com manager
- **Delegação multiagente** - Manager coordena especialistas

**Conceitos abordados:**
- Orquestração hierárquica: um **manager** coordena os especialistas
- `manager_agent` como "cérebro" (delegação, sem task manual por agente)
- Resolução de incidente **multidomínio** (SRE + Segurança + FinOps)
- Consolidação em relatório executivo com ROI

**Aplicação prática:**
Um incidente crítico combina checkout fora do ar (erro 500), backdoor XZ detectado e
pico de custo de 40%. O **Nexus Manager** delega ao SRE (logs K8s), ao DevSecOps
(risco do backdoor) e ao FinOps (causa do custo), consolidando tudo num relatório.

**Comandos executados:**
```bash
cd module-12
python labs/modulo12_projeto_final.py
```

**Arquitetura:**
```
Missão multidomínio
    ↓
Nexus Manager (Process.hierarchical, manager_agent)
    ├─ delega → SRE On-Call        (logs Kubernetes)
    ├─ delega → DevSecOps Analyst  (risco do backdoor XZ)
    └─ delega → FinOps Consultant  (pico de custo)
    ↓
Relatório executivo consolidado + ROI
```

### Módulo 13: AI-Ops Enterprise – Do Terminal ao Escalável

#### **Projeto:** [Cloud-Native Deploy](module-13)

**Tecnologias utilizadas:**
- **Docker** - Imagem `nexus-bot:v1` (`python:3.12-slim`)
- **Kubernetes (Minikube)** - Orquestração local
- **LocalStack** - Cloud AWS simulada (S3/SQS/IAM)
- **Ollama** - LLM offline (`llama3.1`)
- **Streamlit** - Painel visual (S3 Explorer + OPA Sandbox)

**Conceitos abordados:**
- Containerização do projeto completo (`Dockerfile`, `.dockerignore`, `PYTHONPATH`)
- Kubernetes local com Minikube e driver Docker
- Secrets de cluster (`OPENAI_API_KEY` em base64)
- Cloud simulada e DNS interno (`http://localstack:4566`, `http://ollama:11434`)
- Integração de serviços: bot + UI + cloud simulada + LLM offline

**Aplicação prática:**
Este módulo **não traz código Python novo** — ele empacota e orquestra tudo dos
módulos 1–12. O `Dockerfile` faz `COPY . .` e o `CMD` roda o projeto final; os
manifestos `k8s/*` sobem o bot, a UI, o LocalStack e o Ollama no cluster.

**Comandos executados:**
```bash
cd module-13
docker build -t nexus-bot:v1 .
docker run --rm -e OPENAI_API_KEY="sk_sua_chave_aqui" nexus-bot:v1

minikube start --driver=docker
eval $(minikube docker-env)
minikube dashboard

docker build -t nexus-bot:v1 .
echo -n "sk_sua_chave_aqui" | base64 -w 0; echo

kubectl apply -f k8s/secret.yaml
kubectl get secret

kubectl apply -f k8s/deploy.yaml
kubectl get deploy
kubectl get pod
kubectl logs nexus-bot-78fd6b64d5-n2p99
kubectl delete -f k8s/deploy.yml

kubectl apply -f k8s/job.yaml
kubectl get job
kubectl get pod
kubectl logs nexus-bot-run-66bv8
kubectl describe job nexus-bot-run

kubectl apply -f k8s/localstack.yaml
kubectl get pod
kubectl logs localstack-7dc75df7db-4stlg
kubectl exec -it deployment/localstack -- awslocal s3 ls
kubectl exec -it deployment/localstack -- awslocal s3 mb s3://nexus-logs
kubectl exec -it deployment/localstack -- awslocal s3 mb s3://nexus-logs-2
kubectl exec -it deployment/localstack -- sh -c "echo 'Relatorio Nexus v2' > teste.txt && awslocal s3 cp teste.txt s3://nexus-logs-2/"
kubectl exec -it deployment/localstack -- awslocal s3 ls nexus-logs-2

kubectl apply -f k8s/connect-test.yaml
kubectl get pods
kubectl logs nexus-conn-test-9hzsv

kubectl apply -f k8s/streamlit.yaml
kubectl get pods
minikube service nexus-ui
kubectl exec -it deployment/localstack -- awslocal s3 mb s3://nexus-logs-3
kubectl exec -it deployment/localstack -- sh -c "echo 'Relatorio Nexus v2' > teste.txt && awslocal s3 cp teste.txt s3://nexus-logs-3/"
kubectl exec -it deployment/localstack -- awslocal s3 ls

kubectl apply -f k8s/ollama.yaml
kubectl get svc
kubectl get pods

ollama run llama3.1 "Olá! Você está rodando no cluster do Leonardo?"

kubectl describe node minikube | grep -A 5 "Capacity"
kubectl describe node minikube

```

**Arquitetura Cloud-Native:**
```
Dockerfile (COPY . . + CMD modulo12)
    ↓ docker build → nexus-bot:v1
    ↓
Minikube (cluster local)
    ├─ k8s/secret.yml      → OPENAI_API_KEY
    ├─ k8s/localstack.yml  → cloud simulada (S3/SQS/IAM) :4566
    ├─ k8s/ollama.yaml     → LLM offline :11434
    └─ k8s/streamlit.yaml  → UI (ui/app.py) :8501
    ↓
nexus-bot (agentes) ←→ LocalStack ←→ Ollama ←→ Streamlit
```

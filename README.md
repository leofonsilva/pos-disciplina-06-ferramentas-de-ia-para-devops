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
Agent: Arquiteto de Cloud  ←→  LLM (Groq/Llama)
    ↓
Tool: check_compliance_rules (regras: nexus-, us-east-1, privado)
    ↓
Saída: plano de design em conformidade
```
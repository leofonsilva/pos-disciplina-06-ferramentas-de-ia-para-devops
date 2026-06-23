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
Pendente...
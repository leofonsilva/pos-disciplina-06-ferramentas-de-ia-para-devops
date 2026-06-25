# Módulo 02 — IaC Copilot & Security Governance

**Cenário:** O Arquiteto gera um `main.tf` para um bucket S3 seguro
(`nexus-apollo-data`, us-east-1) e o Auditor DevSecOps valida com Checkov + OPA.

## Como rodar
A partir desta pasta (`module-02/`):
```bash
python labs/modulo2_iac_copilot.py
```
> Requer `OPENAI_API_KEY`. O Checkov real é opcional (a tool degrada com aviso se não instalado).

## Peças deste módulo
- `labs/modulo2_iac_copilot.py` — pipeline sequencial (arquiteto → auditor).
- `tools/file_writer.py` — `write_file`.
- `tools/security_scan.py` — `run_checkov_scan`, `validate_opa_policies`.

## Arquivos gerados ao executar
- **`main.tf`** — escrito por `write_file` na raiz deste módulo.
  (No projeto original isso caía na raiz e sobrescrevia execuções anteriores.)

---

## ⚠️ Como executar (leia antes de rodar)

Rode **sempre de dentro desta pasta**, nunca da raiz do projeto:

```bash
cd modules/module-02
# ative o venv (que fica no nível acima) e então rode o comando da seção "Como rodar"
```

**Por quê:** o script encontra `core/` e `tools/` pelo próprio caminho (funciona de
qualquer lugar), **mas todo arquivo gerado é criado no diretório de onde você
executa**. Rodando de dentro do `module-02/`, o que for gerado fica isolado aqui;
rodando da raiz, polui a raiz do projeto — foi o que aconteceu no material original.

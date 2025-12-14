# Monitoramento de Usuários Logados (PowerShell)

Este script PowerShell foi desenvolvido para **monitorar usuários logados em servidores Windows**, utilizando o comando `quser`, com foco em ambientes de **Terminal Server / RDP**.

O objetivo é **controlar o número de usuários simultâneos**, ignorando contas administrativas ou de manutenção, e **reiniciar automaticamente o sistema** quando o limite definido é atingido.

---

## 🚀 Funcionalidades

- Captura sessões ativas utilizando o comando `quser`
- Filtra usuários administrativos e de manutenção
- Identifica apenas usuários realmente ativos
- Gera log detalhado no console para diagnóstico
- Exibe aviso aos usuários antes da reinicialização
- Reinicia o sistema automaticamente ao atingir o limite de usuários

---

## ⚙️ Funcionamento

1. Define uma lista de usuários que devem ser **ignorados** (administradores/manutenção)
2. Analisa a saída do comando `quser`
3. Remove duplicidades e sessões inválidas
4. Conta apenas usuários ativos e não administrativos
5. Caso o número de usuários seja **maior ou igual a 3**:
   - Exibe mensagem de aviso
   - Aguarda alguns segundos
   - Reinicia o servidor automaticamente

---

## 🛠️ Configuração

### Lista de usuários ignorados
Edite o array abaixo para incluir ou remover usuários administrativos:

```powershell
$manutencao = @('usuario1','usuario2','administrator')

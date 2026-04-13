# Guias e Instruções da Suíte de Testes da ARDAP

Este documento resume como a ONG ARDAP deve usar e manter os testes construídos no Minitest nativo (Sistema ERP).

## Arquitetura dos Testes

Ao invés de dependermos de pacotes pesados como `FactoryBot` e `RSpec`, nossa suíte foi moldada com puro pragmatismo e performance:
*   **Fixtures (`test/fixtures/*.yml`)**: Carregam toda a massa de dados (Pessoas, Animais, Perfis) em milissegundos usando diretamente o PostgreSQL com cache nativo.
*   **Models (`test/models/`)**: Validam as lógicas de negócio blindadas (Travamento de PDF, bloqueio de deleção de adotações finalizadas, obrigatoriedade de campos).
*   **Controllers (`test/controllers/admin/`)**: O coração da segurança sistêmica. Nossos Testes de Integração simulam as proteções ativas da plataforma (`RBAC`), bloqueando e desviando permissões indesejadas silenciosamente e analisando de perto a injeção em nossa "câmera fria" de Auditoria Global.
*   **System (`test/system/`)**: Testes E2E rodando invisíveis debaixo de um Headless Chrome pelo Capybara. Navegam preenchendo formulários do inicio ao fim para assegurar fluidez de tela aos funcionários.

---

## Como Rodar a Suíte

Você pode invocar o testador nativo usando o utilitário bin (para rapidez máxima, com Spring habilitado). Tente rodá-los no seu terminal via WSL ou Poweshell assim:

### 1) Rodar absolutamente todos os testes do Sistema (Modelos, Controles, Sistema)
```bash
bin/rails test test/system
```

*(Nota: Executar sem especificação engloba Controller e Model, mas Testes de Sistema são acionados apenas especificando explicitamente por causa do peso de simular um hardware Chrome).*

### 2) Rodar uma camada específica (Ideal para dev rápido ou refatorar algo)

- **Apenas Regras do Banco de Dados**:
  ```bash
  bin/rails test:models
  ```
- **Apenas Roteamento e Controle** (Muito ágil):
  ```bash
  bin/rails test:controllers
  ```
- **Apenas Testes Extremos (Navegador Chrome)**:
  ```bash
  bin/rails test:system
  ```

### 3) Executar um único Arquivo Lógico Isolado
Sempre que o time estiver trabalhando numa Funcionalidade e quiser apenas analisar sua mesa de trabalho:
```bash
bin/rails test test/models/animal_test.rb
bin/rails test test/controllers/admin/complaints_controller_test.rb
```

---

## Estrutura de Helper Comunitário

O Sistema possui injetores que simplificaram a testagem na camada HTTP. Ao implementar ou estudar o código em `test/test_helper.rb`, você notará a existência das travas:

- `log_in_as_admin` -> Força a autorização Nível Superior.
- `log_in_as_operator` -> Força a autorização Nível Padrão.
- `log_in_as_viewer` -> Força a autorização para Perfis de Apenas Leitura (Voluntários passivos).

Ao construir um fluxo na camada `Controller`, simplesmente invoque um log_in setup antes de tentar o roteamento e a suite validará nativamente!

> Todos os logs de falhas do Chromium (como telas vazias ou labels apagados) são capturados e despejados em `/tmp/screenshots/` automaticamente para avaliação visual pela ARDAP.


## 📦 Projeto – Sistema de Pedidos (Delphi)

## 🧾 Visão Geral

Este projeto implementa um **Sistema de Pedidos** desenvolvido em **Delphi 13**, utilizando **VCL**, **FireDAC** e **MySQL** como banco de dados.

O objetivo do sistema é demonstrar:

* boas práticas de desenvolvimento em Delphi
* organização de código com separação de responsabilidades
* uso correto de transações e acesso a dados
* preocupação com UX e legibilidade do código

---

## 🛠️ Tecnologias Utilizadas

* **Delphi 13**
* **VCL (Visual Component Library)**
* **FireDAC**
* **MySQL**
* **Arquitetura em camadas (View / Service / Repository)**
* **Programação Orientada a Objetos**
* **Clean Code**

---

## 🗂️ Estrutura do Projeto

 

/View

   FrmPedido.pas

   FrmSelecionarCliente.pas

   FrmSelecionarProduto.pas

   FrmSelecionarPedido.pas

/Service

   PedidoService.pas

/Repository

   PedidoRepository.pas

/Model

   uPedido.pas

   uPedidoItem.pas

   uCliente.pas

   uProduto.pas

/Controller

   uClienteController.pas

   uProdutoController.pas

/Database

   Conexao.pas

   Database.pas 

/SQL
   
   dump.sql   // script de criação das tabelas e estrutura do banco

/Release
   
   libmysql.dll // DLL necessária para conexão com MySQL

---

## 🧩 Funcionalidades Implementadas

### 📌 Pedido

* Criar novo pedido
* Editar pedido existente
* Cancelar pedido
* Calcular total do pedido
* Carregar pedido já cadastrado

### 📌 Itens do Pedido

* Incluir produto
* Editar quantidade e valor
* Excluir item
* Recalcular total automaticamente

### 📌 Telas de Seleção

* Seleção de cliente
* Seleção de produto
* Seleção de pedido existente
* Filtro dinâmico
* Seleção por duplo clique ou botão

---

## 🔄 Regras de Negócio

* O pedido é salvo dentro de **transação**, garantindo integridade dos dados

* Quando o pedido possui número:

  * é realizado **UPDATE** do cabeçalho
  * os itens são atualizados conforme sua chave

* Quando o pedido não possui número:
  * é tratado como **novo pedido**

* Validações de entrada são feitas antes de qualquer persistência

---

## 🧠 Decisões Técnicas

* Uso de **TObjectList** com controle de ownership

* Uso explícito de transações (`StartTransaction`, `Commit`, `Rollback`)

* Separação clara entre:

  * interface (View)
  * regras de negócio (Service)
  * persistência (Repository)

* Código escrito priorizando **legibilidade, manutenção e clareza**

---

## ▶️ Como Executar o Projeto

1. Abrir o projeto no **Delphi 13**

2. Configurar a conexão com o banco de dados em:

    

   `Conexao.pas / Database.pas `

3. Ajustar credenciais do MySQL (host, usuário, senha e database)

4. Compilar e executar o projeto

---

## 🧪 Observações para Avaliação

* O projeto foi desenvolvido com foco em **qualidade de código**
* Métodos possuem responsabilidade única
* Eventos de tela apenas orquestram ações
* SQL explícito para facilitar leitura e manutenção
* Estrutura pensada para fácil evolução

---

## 👩‍💻 Autoria

**Caroline Crisóstomo**
Desenvolvedora Delphi
Experiência em sistemas corporativos, ERPs e aplicações de grande porte.

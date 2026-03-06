# Cadastro de Clientes - Flutter OfflineFirst com Clean Architecture

##  Visão Geral

Este projeto é um **sistema de cadastro de clientes** desenvolvido em Flutter.
A aplicação foi pensada para operar em modo **offlinefirst**: tudo é lido
e escrito primeiramente no banco local (SQLite) e somente quando há rede os
dados podem ser sincronizados com serviços remotos.

A busca de endereço por CEP utiliza a API externa **ViaCep** para preencher
os campos automaticamente, mas o formulário permite que o usuário preencha
todos os dados manualmente mesmo que o serviço esteja indisponível.

### O que significa *offlinefirst*?
- A UI permanece responsiva sem conexão.
- Leituras e gravações ocorrem no cache/banco local.
- A sincronização com o servidor é opcional e assíncrona.
- Melhora a experiência em redes instáveis.

---

##  Arquitetura do Projeto

A estrutura segue os princípios da **Clean Architecture** e está dividida em
três camadas principais:

1. **Core**  infraestrutura e serviços compartilhados.
2. **Features**  lógica de negócio dividida por domínio (clientes, CEP,
   ramo de atividade, tipo de telefone).
3. **Presentation**  interface do usuário e gerenciamento de estado.

Cada camada só depende das camadas que estão abaixo dela.

### Camada Core
Responsável por tudo que é transversal ao sistema:

- Injeção de dependências (`GetIt`).
- Banco de dados SQLite (`AppDatabase`).
- Exceções customizadas (`BusinnesException`).
- Validadores reutilizáveis (CPF, CNPJ, etc.).

### Camada Features
Contém a implementação das regras de negócio:

- **Entities** e **Models** que representam os dados.
- **Repositories** (interfaces e implementações) para acesso a dados.
- **DataSources** locais e remotos.
- **UseCases** que encapsulam ações específicas.

Cada feature agrupa domínio e persistência, mantendo a separação de
responsabilidades.

### Camada Presentation
Reúne tudo relacionado à UI:

- Páginas (`Pages`) como `ClienteListPage` e `ClienteFormPage`.
- Cubits (`flutter_bloc`) para gerenciar o estado das telas.
- Estados (`States`) que representam carregamento, sucesso e erro.
- Widgets reutilizáveis para formulários, listas e filtros.

---

##  Fluxo de Dependências

```
Presentation  Features  Core
```

A camada de apresentação chama UseCases das features; as features usam
o core para acessar banco, validar dados ou obter dependências.

---

##  Padrões Utilizados

- **Cubit Pattern** (`flutter_bloc`) para controle de estado.
- **Repository Pattern** para abstração de acesso a dados.
- **UseCase Pattern** para encapsular regras de negócio.
- **Dependency Injection** com **GetIt** para montar o grafo de objetos.

---

##  Estrutura de Pastas Comentada

```
lib/
 core/                   # serviços compartilhados
    database/           # AppDatabase, esquema e migrações
    exceptions/         # classes de exceção
    injection/          # configuração do GetIt
    validator/          # validadores (CPF, CNPJ)
 features/               # domínios da aplicação
    clientes/
       data/           # models, datasources, reposimpl
       domain/         # entities, repositories, usecases
    cep/                # consulta ViaCep
    ramoatividade/
    tipotelefone/
   (cada feature segue o mesmo padrão)
 presentation/           # UI, cubits, páginas, widgets
     cliente_list/
     cliente_form/
```

---

**Desenvolvido com  usando Clean Architecture e Flutter.**

# Clean Architecture em Flutter

## 📋 Visão Geral

Este é um projeto Flutter que implementa os princípios da **Clean Architecture**, um padrão arquitetural que promove separação de responsabilidades, testabilidade e manutenibilidade do código. O projeto foi desenvolvido para gerenciar dados de clientes, ramos de atividade, tipos de telefone e consultas de CEP, utilizando um banco de dados local (SQLite) e APIs remotas.

### Objetivos da Arquitetura

- **Independência de Frameworks**: A lógica de negócio não depende de Flutter ou bibliotecas externas
- **Testabilidade**: Cada camada pode ser testada independentemente através de mocks e abstrações
- **Flexibilidade**: Fácil substituição de implementações (banco de dados, APIs, UI)
- **Manutenibilidade**: Código organizado em camadas bem definidas com responsabilidades claras

---

## 🏗️ Arquitetura em Camadas

A arquitetura deste projeto é composta por **4 camadas principais**:

```
┌─────────────────────────┐
│   PRESENTATION LAYER    │  (UI, Cubits, States, Pages, Widgets)
├─────────────────────────┤
│   DOMAIN LAYER          │  (Entities, Repositories, UseCases)
├─────────────────────────┤
│   DATA LAYER            │  (Models, DataSources, Repositories)
├─────────────────────────┤
│   CORE LAYER            │  (Injection, Database, Exceptions, Validators)
└─────────────────────────┘
```

### 1. **Camada de Apresentação (Presentation)**

**Responsabilidades:**
- Exibir dados ao usuário através de páginas (Pages) e widgets reutilizáveis
- Gerenciar o estado da UI utilizando o padrão **Cubit** (flutter_bloc)
- Capturar interações do usuário e delegá-las aos Cubits
- Renderizar diferentes estados (carregamento, sucesso, erro)

**Componentes:**
- **Pages**: Telas principais da aplicação (ex: `ClienteListPage`, `ClienteFormPage`)
- **Cubits**: Gerenciam o estado de cada feature (ex: `ClienteListCubit`, `ClienteFormCubit`)
- **States**: Classes que representam possíveis estados de um Cubit
- **Widgets**: Componentes reutilizáveis da interface

**Exemplo de Fluxo:**
```dart
// Usuário interage com a UI
User taps button
    ↓
Page captures interaction
    ↓
Cubit.load() is called
    ↓
Cubit emits different States
    ↓
UI rebuilds based on State
```

### 2. **Camada de Domínio (Domain)**

**Responsabilidades:**
- Definir as regras de negócio da aplicação (100% independente de frameworks)
- Especificar contratos através de **Repositories** (interfaces abstratas)
- Encapsular lógica de negócio em **UseCases** reutilizáveis
- Definir as **Entities** que representam modelos core do negócio

**Componentes:**

#### **Entities**
Modelos que representam os dados de negócio com atributos imutáveis.

```dart
class ClienteEntity {
  final String? foto;
  final String tipoPessoa;
  final int? codigoCliente;
  final String razaoSocial;
  final String nomeFantasia;
  final int codigoRamoAtividade;
  final String cnpjCpf;
  final String ieRg;
  // ... mais atributos
  
  const ClienteEntity({ required this... });
}
```

#### **Repositories** (Abstratas)
Interfaces que definem operações de persistência e acesso a dados. A implementação real fica na camada Data.

```dart
abstract class ClienteRepository {
  Future<List<ClienteEntity>> getClientes(String filter);
  Future<ClienteEntity> save(ClienteEntity cliente);
  Future<ClienteEntity> edit(ClienteEntity cliente);
  Future<void> deleteCliente(ClienteEntity cliente);
  Future<bool> existsByCpfAndIe(String cpfCnpj, String ieRg, int? codigoCliente);
}
```

#### **UseCases**
Classes que encapsulam uma ação de negócio específica. Cada UseCase executa um repositório com injeção de dependência.

```dart
class GetClientesUseCase {
  final ClienteRepository clienteRepository;

  GetClientesUseCase({required this.clienteRepository});

  Future<List<ClienteEntity>> call(String filter) async {
    return await clienteRepository.getClientes(filter);
  }
}
```

### 3. **Camada de Dados (Data)**

**Responsabilidades:**
- Implementar os **Repositories** definidos no Domain
- Gerenciar fontes de dados (banco local, APIs remotas)
- Converter entre **Models** (dados externos) e **Entities** (modelo de negócio)
- Tratar erros e exceptions

**Componentes:**

#### **DataSources** (Abstratas e Implementadas)
Interfaces que definem operações com uma fonte de dados específica, e suas implementações.

```dart
// Abstração
abstract class ClienteDatasourceLocal {
  Future<List<ClienteModel>> getClientes(String filter);
  Future<ClienteModel> save(ClienteModel model);
  Future<ClienteModel> edit(ClienteModel model);
  Future<void> delete(ClienteModel model);
}

// Implementação
class ClienteDatasourceLocalImp implements ClienteDatasourceLocal {
  // Implementa usando SQLite
}
```

#### **Models**
Extensões das Entities que adicionam funcionalidade de serialização/desserialização para persistência.

```dart
class ClienteModel extends ClienteEntity {
  ClienteModel({ required ... });

  // Conversão para JSON (para BD)
  Map<String, dynamic> toMap() { ... }

  // Conversão de JSON (do BD)
  factory ClienteModel.fromMap(Map<String, dynamic> map) { ... }
}
```

#### **Repository Implementation**
Implementação concreta dos repositories que orquestra as DataSources.

```dart
class ClienteRepositoryImp implements ClienteRepository {
  final ClienteDatasourceLocal clienteDatasourceLocal;

  ClienteRepositoryImp({required this.clienteDatasourceLocal});

  @override
  Future<List<ClienteEntity>> getClientes(String filter) async {
    final models = await clienteDatasourceLocal.getClientes(filter);
    return models;
  }

  @override
  Future<ClienteEntity> save(ClienteEntity cliente) async {
    final model = ClienteModel(...);
    return await clienteDatasourceLocal.save(model);
  }
}
```

### 4. **Camada Core (Core)**

**Responsabilidades:**
- Gerenciar **Injeção de Dependências** (GetIt)
- Configurar e gerenciar o **Banco de Dados Local** (SQLite)
- Definir **Exceptions** customizadas para tratamento de erros
- Fornecer **Validadores** reutilizáveis

**Componentes:**

#### **Injection (GetIt)**
Configura todas as dependências da aplicação de forma centralizada.

```dart
void setupInjection() {
  // DataSources
  getIt.registerLazySingleton<ClienteDatasourceLocal>(
    () => ClienteDatasourceLocalImp(),
  );

  // Repositories
  getIt.registerLazySingleton<ClienteRepository>(
    () => ClienteRepositoryImp(
      clienteDatasourceLocal: getIt<ClienteDatasourceLocal>(),
    ),
  );

  // UseCases
  getIt.registerLazySingleton<GetClientesUseCase>(
    () => GetClientesUseCase(
      clienteRepository: getIt<ClienteRepository>(),
    ),
  );

  // Cubits
  getIt.registerLazySingleton<ClienteListCubit>(
    () => ClienteListCubit(
      getIt<GetClientesUseCase>(),
      getIt<DeleteClienteUsesCase>(),
    ),
  );
}
```

#### **Database**
Gerencia a conexão com SQLite e inicialização do schema.

```dart
class AppDatabase {
  static final AppDatabase _instance = AppDatabase._();

  AppDatabase._();

  static Database? _database;

  static Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    // Criação de tabelas e schema
  }
}
```

#### **Exceptions**
Exceções customizadas para tratamento de erros específicos do domínio.

```dart
class BusinnesException implements Exception {
  final String mensagem;
  BusinnesException({required this.mensagem});
}
```

#### **Validators**
Funções reutilizáveis para validação de dados (CPF, CNPJ, etc).

```dart
class CpfValidator {
  static bool validate(String cpf) { ... }
}

class CnpjValidator {
  static bool validate(String cnpj) { ... }
}
```

---

## 🔄 Fluxo de Dependências e Comunicação

### Regra Fundamental
**Uma camada só pode depender de camadas abaixo dela. Nunca o contrário.**

```
Presentation  ──→  Domain
                    ↓
                   Data
                    ↓
                   Core

❌ NUNCA: Data → Presentation
✅ SEMPRE: Presentation → Domain → Data → Core
```

### Fluxo de Execução Prático

**Exemplo: Carregar lista de clientes**

1. **Presentation**: Usuário abre a página `ClienteListPage`
   ```dart
   BlocProvider(
     create: (context) => getIt<ClienteListCubit>()..load(''),
     child: ...,
   );
   ```

2. **Cubit emite estado de carregamento**
   ```dart
   Future<void> load(String filter) async {
     emit(ClienteListLoading());
     try {
       final clientes = await getClientesUseCase(filter);
       emit(ClienteListSuccess(clientes: clientes));
     } on BusinnesException catch (e) {
       emit(ClienteListError(error: e.mensagem));
     }
   }
   ```

3. **UseCase executa a lógica de negócio**
   ```dart
   Future<List<ClienteEntity>> call(String filter) async {
     return await clienteRepository.getClientes(filter);
   }
   ```

4. **Repository abstrato delega para DataSource**
   ```dart
   @override
   Future<List<ClienteEntity>> getClientes(String filter) async {
     final models = await clienteDatasourceLocal.getClientes(filter);
     return models;
   }
   ```

5. **DataSource acessa o banco de dados**
   ```dart
   @override
   Future<List<ClienteModel>> getClientes(String filter) async {
     final db = await AppDatabase.database;
     final maps = await db.query(
       clienteTableName,
       where: 'razaoSocial LIKE ?',
       whereArgs: ['%$filter%'],
     );
     return maps.map((m) => ClienteModel.fromMap(m)).toList();
   }
   ```

6. **Resultado retorna pela cadeia**
   - DataSource → Repository → UseCase → Cubit → UI

7. **UI reage ao novo estado do Cubit**
   ```dart
   BlocBuilder<ClienteListCubit, ClienteListState>(
     builder: (context, state) {
       if (state is ClienteListLoading) return LoadingWidget();
       if (state is ClienteListSuccess) return ClientList(state.clientes);
       if (state is ClienteListError) return ErrorWidget(state.error);
       return Container();
     },
   );
   ```

---

## 🎯 Padrões Utilizados

### 1. **Cubit Pattern (flutter_bloc)**
Estado gerenciado de forma simples e eficiente.

```dart
// Estados
abstract class ClienteListState {}
class ClienteListInitial extends ClienteListState {}
class ClienteListLoading extends ClienteListState {}
class ClienteListSucess extends ClienteListState {
  final List<ClienteEntity> clientes;
  ClienteListSucess({required this.clientes});
}
class ClienteListError extends ClienteListState {
  final String error;
  ClienteListError({required this.error});
}

// Cubit
class ClienteListCubit extends Cubit<ClienteListState> {
  final GetClientesUseCase getClientesUseCase;
  
  ClienteListCubit(this.getClientesUseCase) 
    : super(ClienteListInitial());
  
  Future<void> load(String filter) async {
    emit(ClienteListLoading());
    try {
      final clientes = await getClientesUseCase(filter);
      emit(ClienteListSucess(clientes: clientes));
    } catch (e) {
      emit(ClienteListError(error: e.toString()));
    }
  }
}
```

### 2. **Repository Pattern**
Abstração que permite trocar a fonte de dados sem afetar a lógica de negócio.

```dart
// Abstrato (Domain)
abstract class ClienteRepository {
  Future<List<ClienteEntity>> getClientes(String filter);
}

// Implementação (Data)
class ClienteRepositoryImp implements ClienteRepository {
  final ClienteDatasourceLocal datasource;
  
  @override
  Future<List<ClienteEntity>> getClientes(String filter) {
    return datasource.getClientes(filter);
  }
}
```

### 3. **Dependency Injection com GetIt**
Centraliza a criação e gerenciamento de dependências.

```dart
final getIt = GetIt.instance;

setupInjection() {
  getIt.registerLazySingleton<ClienteRepository>(
    () => ClienteRepositoryImp(...),
  );
}

// Uso
final cubit = getIt<ClienteListCubit>();
```

### 4. **UseCase Pattern**
Encapsula uma ação de negócio específica e reutilizável.

```dart
class GetClientesUseCase {
  final ClienteRepository repository;

  GetClientesUseCase({required this.repository});

  // Implementa __call__ para permitir invocação como função
  Future<List<ClienteEntity>> call(String filter) {
    return repository.getClientes(filter);
  }
}

// Uso
final clientes = await getClientesUseCase('filtro');
```

### 5. **Model vs Entity**
- **Entity**: Modelo de negócio puro (Domain)
- **Model**: Extensão com serialização (Data)

```dart
// Entity (Domain)
class ClienteEntity {
  final String razaoSocial;
  const ClienteEntity({required this.razaoSocial});
}

// Model (Data)
class ClienteModel extends ClienteEntity {
  ClienteModel({required String razaoSocial}) 
    : super(razaoSocial: razaoSocial);
  
  Map<String, dynamic> toMap() { ... }
  factory ClienteModel.fromMap(Map<String, dynamic> map) { ... }
}
```

---

## 🚀 Como Executar o Projeto

### Pré-requisitos
- Flutter SDK 3.7.2 ou superior
- Dart SDK 3.7.2 ou superior
- Android Studio, Xcode ou VS Code com extensões Flutter

### Passos de Configuração

#### 1. **Clonar o repositório**
```bash
git clone <url-do-repositório>
cd clean_arch
```

#### 2. **Instalar dependências**
```bash
flutter pub get
```

#### 3. **Configurar geração de código (se necessário)**
Se o projeto utiliza geração de código:
```bash
flutter pub run build_runner build
```

#### 4. **Executar em emulador ou dispositivo físico**

**Android:**
```bash
flutter run
```

**iOS:**
```bash
flutter run -d iphone
```

**Especificar dispositivo:**
```bash
flutter devices              # Listar dispositivos disponíveis
flutter run -d <device-id>   # Escolher um dispositivo
```

#### 5. **Build para produção**

**Android (APK):**
```bash
flutter build apk --release
```

**Android (App Bundle):**
```bash
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

---

## 📁 Estrutura de Pastas Comentada

```
lib/
│
├── main.dart                           # Ponto de entrada da aplicação
│                                       # Inicializa dependências e configura o MaterialApp
│
├── core/                               # CAMADA CORE - Infraestrutura compartilhada
│   │                                   # Não possui dependências com Features
│   │
│   ├── database/                       # Gerenciamento do banco de dados SQLite
│   │   ├── app_database.dart          # Configuração e inicialização do BD
│   │   └── migrations/                # Scripts de atualização do schema
│   │
│   ├── exceptions/                     # Exceções customizadas
│   │   ├── business_exception.dart     # Exceções de regra de negócio
│   │   └── ...
│   │
│   ├── injection/                      # Configuração de Injeção de Dependências
│   │   └── injection.dart              # Setup com GetIt para registrar todas as deps
│   │
│   └── validator/                      # Validadores reutilizáveis
│       ├── cpf_validator.dart          # Validação de CPF
│       └── cnpj_validator.dart         # Validação de CNPJ
│
├── features/                           # CAMADAS DE FEATURES (Domain + Data)
│   │
│   ├── clientes/                       # Feature: Gerenciamento de Clientes
│   │   │
│   │   ├── domain/                     # CAMADA DOMAIN - Lógica de negócio pura
│   │   │   ├── entities/               # Modelos de negócio
│   │   │   │   └── cliente_entity.dart # Entity com dados de cliente
│   │   │   │
│   │   │   ├── repositories/           # Contratos abstratos (interfaces)
│   │   │   │   └── cliente_repository.dart # Define operações CRUD
│   │   │   │
│   │   │   └── usecases/               # Casos de uso de negócio
│   │   │       ├── get_clientes_use_case.dart         # Buscar clientes
│   │   │       ├── save_cliente_use_case.dart         # Salvar cliente
│   │   │       ├── edit_cliente_use_case.dart         # Editar cliente
│   │   │       └── delete_cliente_uses_case.dart      # Deletar cliente
│   │   │
│   │   └── data/                       # CAMADA DATA - Implementações de persistência
│   │       ├── datasources/            # Fontes de dados concretas
│   │       │   ├── cliente_datasource_local.dart     # Interface
│   │       │   └── cliente_datasource_local_imp.dart # Implementação SQLite
│   │       │
│   │       ├── models/                 # Modelos com serialização
│   │       │   └── cliente_model.dart  # Extends ClienteEntity + toMap/fromMap
│   │       │
│   │       └── repositories/           # Implementação dos repositories
│   │           └── cliente_repository_imp.dart # Orquestra datasources
│   │
│   ├── cep/                            # Feature: Consulta de CEP (via API remota)
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── cep_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── cep_repository.dart
│   │   │   └── usecases/
│   │   │       └── get_cep_use_case.dart
│   │   └── data/
│   │       ├── datasource/
│   │       │   ├── cep_datasource_remote.dart     # Interface
│   │       │   └── cep_datasource_remote_imp.dart # Implementação Dio/HTTP
│   │       ├── models/
│   │       │   └── cep_model.dart
│   │       └── repositores/
│   │           └── cep_repository_imp.dart
│   │
│   ├── ramoatividade/                  # Feature: Ramo de Atividade
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── ramo_atividade_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── ramo_atividade_repository.dart
│   │   │   └── usecases/
│   │   │       ├── get_ramo_atividade_use_case.dart
│   │   │       └── save_ramo_atividade_use_case.dart
│   │   └── data/
│   │       ├── datasources/
│   │       │   ├── ramo_atividade_datasource_local.dart
│   │       │   └── ramo_atividade_datasource_local_imp.dart
│   │       ├── models/
│   │       │   └── ramo_atividade_model.dart
│   │       └── repositories/
│   │           └── ramo_atividade_repository_imp.dart
│   │
│   ├── tipotelefone/                   # Feature: Tipo de Telefone
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── tipo_telefone_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── tipo_telefone_repository.dart
│   │   │   └── usecases/
│   │   │       ├── get_tipo_telefone_use_case.dart
│   │   │       └── save_tipo_telefone_use_case.dart
│   │   └── data/
│   │       ├── datasource/
│   │       │   ├── tipo_telefone_datasource_local.dart
│   │       │   └── tipo_telefone_datasource_local_imp.dart
│   │       ├── models/
│   │       │   └── tipo_telefone_model.dart
│   │       └── repositories/
│   │           └── tipo_telefone_repository_imp.dart
│   │
│   └── presentation/                   # CAMADA PRESENTATION - UI e Gerenciamento de Estado
│       │                               # Contém Cubits, Pages, Widgets (compartilhados)
│       │
│       ├── cliente_list/               # Feature de lista de clientes
│       │   ├── cubit/
│       │   │   ├── cliente_list/
│       │   │   │   ├── cliente_list_cubit.dart  # Lógica da lista
│       │   │   │   └── cliente_list_state.dart  # Estados da lista
│       │   │   ├── Cep/
│       │   │   │   ├── cep_cubit.dart           # Lógica de CEP
│       │   │   │   └── cep_state.dart
│       │   │   ├── RamoAtividade/
│       │   │   │   ├── ramo_atividade_list_cubit.dart
│       │   │   │   └── ramo_atividade_list_state.dart
│       │   │   └── TipoTelefone/
│       │   │       ├── tipo_telefone_list_cubit.dart
│       │   │       └── tipo_telefone_list_state.dart
│       │   │
│       │   ├── page/
│       │   │   └── cliente_list_page.dart        # Página principal da lista
│       │   │
│       │   └── widgets/
│       │       ├── cliente_tile.dart             # Widget de linha de cliente
│       │       ├── filtro_widget.dart            # Widget de filtro
│       │       └── ...
│       │
│       └── cliente_form/                # Feature de formulário de cliente
│           ├── cubit/
│           │   ├── cliente_form_cubit.dart       # Lógica do formulário
│           │   └── cliente_form_state.dart
│           ├── page/
│           │   └── cliente_form_page.dart        # Página do formulário
│           └── widgets/
│               ├── form_field_widget.dart
│               └── ...
│
└── pubspec.yaml                        # Declaração de dependências e metadados
```

### Explicação das Camadas por Pasta

| Camada | Pasta | Descrição |
|--------|-------|-----------|
| **Core** | `core/` | Infraestrutura, BD, exceções, validadores, injeção |
| **Domain** | `features/*/domain/` | Entidades, repositórios abstratos, use cases |
| **Data** | `features/*/data/` | DataSources, Models, implementações de repositórios |
| **Presentation** | `features/presentation/` | Cubits, Pages, Estados, Widgets |

---

## 🔐 Regras de Dependency

### ✅ Correto
```
Page/Widget → Cubit → UseCase → Repository (abstrato) → DataSource
```

### ❌ Incorreto
```
DataSource → UseCase  // DataSource não deve conhecer UseCase
Cubit → Model       // Cubit não trabalha com Model, apenas Entity
Page → Repository   // Page não acessa Repository diretamente
```

---

## 📦 Dependências Principais

| Dependência | Versão | Propósito |
|------------|--------|-----------|
| `flutter_bloc` | ^9.1.1 | Gerenciamento de estado com Cubit |
| `sqflite` | ^2.4.2 | Banco de dados SQLite local |
| `get_it` | ^9.2.1 | Injeção de dependências |
| `dio` | ^5.9.1 | Cliente HTTP para APIs |
| `image_picker` | ^1.2.1 | Seleção de imagens |
| `uuid` | ^4.5.2 | Geração de UUIDs |
| `equatable` | ^2.0.8 | Comparação de objetos |
| `mask_text_input_formatter` | ^2.9.0 | Formatação de entrada |

---

## 🧪 Testabilidade

A arquitetura Clean permite testes em cada camada:

```dart
// Teste de UseCase
void main() {
  test('GetClientesUseCase retorna lista de clientes', () async {
    // Mock do repository
    final mockRepository = MockClienteRepository();
    when(mockRepository.getClientes(''))
      .thenAnswer((_) async => [ClienteEntity(...)]);

    // Instanciar use case com mock
    final useCase = GetClientesUseCase(
      clienteRepository: mockRepository,
    );

    // Executar e verificar
    final result = await useCase('');
    expect(result, isA<List<ClienteEntity>>());
  });
}
```

---

## 🌟 Benefícios da Arquitetura

| Benefício | Descrição |
|-----------|-----------|
| **Manutenibilidade** | Código organizado e fácil de navegar |
| **Testabilidade** | Cada camada pode ser testada isoladamente |
| **Escalabilidade** | Fácil adicionar novas features sem afetar as existentes |
| **Independência** | Trocar BD, API ou UI sem afetar lógica de negócio |
| **Reusabilidade** | UseCases e Repositories podem ser reutilizados |
| **Clareza** | Responsabilidades bem definidas em cada camada |

---

## 📚 Referências e Leitura Complementar

- [Clean Architecture - Uncles Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Bloc Pattern](https://bloclibrary.dev/#/flutternewtodostutorial)
- [Dependency Injection with GetIt](https://pub.dev/packages/get_it)
- [SOLID Principles](https://en.wikipedia.org/wiki/SOLID)

---

## 📝 Notas Importantes

1. **Injeção de Dependências**: Sempre adicione novas dependências em `core/injection/injection.dart`
2. **Exceptions**: Use `BusinnesException` para erros de negócio e logs apropriados
3. **Entities Imutáveis**: Mantenha entities imutáveis com `const` quando possível
4. **Estados**: Crie um arquivo separado para estados (ex: `cliente_list_state.dart`)
5. **DataSources**: Use abstrações para permitir múltiplas implementações (local, remoto)

---

**Desenvolvido com ❤️ usando Clean Architecture e Flutter**

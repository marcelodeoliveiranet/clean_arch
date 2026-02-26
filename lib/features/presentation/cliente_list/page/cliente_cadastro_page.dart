import 'package:clean_arch/core/injection/injection.dart';
import 'package:clean_arch/core/validator/cnpj_validator.dart';
import 'package:clean_arch/core/validator/cpf_validator.dart';
import 'package:clean_arch/features/clientes/domain/entities/cliente_entity.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/Cep/cep_cubit.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/Cep/cep_state.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/Cliente/cliente_list_cuibit.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/Cliente/cliente_list_state.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/RamoAtividade/ramo_atividade_list_cubit.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/RamoAtividade/ramo_atividade_list_state.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/TipoTelefone/tipo_telefone_list_cubit.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/TipoTelefone/tipo_telefone_list_state.dart';
import 'package:clean_arch/features/ramoatividade/domain/entities/ramo_atividade_entity.dart';
import 'package:clean_arch/features/tipotelefone/domain/entities/tipo_telefone_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ClienteCadastroPage extends StatefulWidget {
  final bool isEditing;
  final ClienteEntity? cliente;
  const ClienteCadastroPage({super.key, required this.isEditing, this.cliente});

  @override
  State<ClienteCadastroPage> createState() => _ClienteCadastroPageState();
}

class _ClienteCadastroPageState extends State<ClienteCadastroPage> {
  String? _tipoPessoa = "F";
  int? codigo = 0;
  RamoAtividadeEntity? _ramoAtividadeEntitySelecionado;
  TipoTelefoneEntity? _tipoTelefoneEntitySelecionado;

  final cubitRamoAtividade = getIt<RamoAtividadeListCuibit>();
  final cubitTipoTelefone = getIt<TipoTelefoneListCubit>();
  final cubitCep = getIt<CepCubit>();
  final cubitCliente = getIt<ClienteListCuibit>();

  final cepMask = MaskTextInputFormatter(
    mask: "#####-###",
    filter: {"#": RegExp(r'[0-9]')},
  );

  final cpfMask = MaskTextInputFormatter(
    mask: "###.###.###-##",
    filter: {"#": RegExp(r'[0-9]')},
  );

  final cnpjMask = MaskTextInputFormatter(
    mask: "##.###.###/####-##",
    filter: {"#": RegExp(r'[0-9]')},
  );

  final codigoMunicipioIbgeMask = MaskTextInputFormatter(
    mask: "#.###.###",
    filter: {"#": RegExp(r'[0-9]')},
  );

  final telefone1Mask = MaskTextInputFormatter(
    mask: "(##) # ####-####",
    filter: {"#": RegExp(r'[0-9]')},
  );

  List<TextInputFormatter> get inputFormatters {
    return _tipoPessoa == 'F' ? [cpfMask] : [cnpjMask];
  }

  final formKey = GlobalKey<FormState>();
  final formModalKey = GlobalKey<FormState>();

  final razaoSocialController = TextEditingController();
  final nomeFantasiaController = TextEditingController();
  final cnpjCpfController = TextEditingController();
  final inscricaoMunicipalController = TextEditingController();
  final inscricaoEstadualController = TextEditingController();
  final emailController = TextEditingController();
  final homePageController = TextEditingController();
  final cepController = TextEditingController();
  final logradouroCotroller = TextEditingController();
  final numeroController = TextEditingController();
  final complementoController = TextEditingController();
  final bairroController = TextEditingController();
  final municipioController = TextEditingController();
  final codigoIbgeController = TextEditingController();
  final estadoController = TextEditingController();
  final telefoneController = TextEditingController();
  final complementoTelefoneController = TextEditingController();

  final _razaoSocialFocus = FocusNode();
  final _cnpjCpfFocus = FocusNode();
  final _cepFocus = FocusNode();
  final _numeroLogradouroFocus = FocusNode();

  void setupEtingCliente() {
    codigo = widget.cliente!.codigoCliente;
    _tipoPessoa = widget.cliente!.tipoPessoa;
    razaoSocialController.text = widget.cliente!.razaoSocial;
    nomeFantasiaController.text = widget.cliente!.nomeFantasia;

    final listaCodigoRamoAtividade = cubitRamoAtividade.listaRamoAtividade;
    _ramoAtividadeEntitySelecionado =
        listaCodigoRamoAtividade
            .where((e) => e.codigo == widget.cliente!.codigoRamoAtividade)
            .first;

    cnpjCpfController.text = widget.cliente!.cnpjCpf;
    inscricaoMunicipalController.text = widget.cliente!.inscricaoMunicipal;
    inscricaoEstadualController.text = widget.cliente!.ieRg;
    emailController.text = widget.cliente!.email;
    homePageController.text = widget.cliente!.homePage;
    cepController.text = widget.cliente!.cep;
    logradouroCotroller.text = widget.cliente!.logradouro;
    numeroController.text = widget.cliente!.numero;
    complementoController.text = widget.cliente!.complemento;
    bairroController.text = widget.cliente!.bairro;
    municipioController.text = widget.cliente!.municipio;
    codigoIbgeController.text = widget.cliente!.codigoIbgeMunicipio.toString();
    estadoController.text = widget.cliente!.uf;

    final listaTiposTelefone = cubitTipoTelefone.listaTipoTelefones;
    _tipoTelefoneEntitySelecionado =
        listaTiposTelefone
            .where((e) => e.codigo == widget.cliente!.codigoTipoTelefone1)
            .first;

    telefoneController.text = widget.cliente!.telefone1;
    complementoTelefoneController.text = widget.cliente!.complementoTelefone1;
  }

  void salvar() {
    final validation = formKey.currentState?.validate();

    if (validation == true) {
      ClienteEntity cliente = ClienteEntity(
        foto: "",
        tipoPessoa: _tipoPessoa!,
        razaoSocial: razaoSocialController.text.trim(),
        nomeFantasia: nomeFantasiaController.text.trim(),
        codigoRamoAtividade: 1, //_ramoAtividadeEntitySelecionado?.codigo ?? 0,
        cnpjCpf: cnpjCpfController.text.trim(),
        ieRg: inscricaoEstadualController.text.trim(),
        inscricaoMunicipal: inscricaoMunicipalController.text.trim(),
        email: emailController.text.trim(),
        homePage: homePageController.text.trim(),
        cep: cepController.text.trim(),
        logradouro: logradouroCotroller.text.trim(),
        numero: numeroController.text.trim(),
        complemento: complementoController.text.trim(),
        bairro: bairroController.text.trim(),
        municipio: municipioController.text.trim(),
        codigoIbgeMunicipio: int.parse(codigoIbgeController.text),
        uf: estadoController.text.trim(),
        codigoTipoTelefone1: 1, //_tipoTelefoneEntitySelecionado?.codigo ?? 0,
        telefone1: telefoneController.text.trim(),
        complementoTelefone1: complementoTelefoneController.text.trim(),
        dataCadastro: DateTime.now().toString(),
      );

      cubitCliente.save(cliente);

      if (widget.isEditing) {
        Navigator.pop(context);
      }
    }
  }

  Future<void> _abrirDialogNovoRamoAtividade(BuildContext context) async {
    final descricaoController = TextEditingController();

    final salvou = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Form(
              key: formModalKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Cadastrar um novo ramo de atividade",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    autofocus: true,
                    controller: descricaoController,
                    decoration: InputDecoration(
                      labelText: "Descrição",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Informe a descrição";
                      }

                      if (cubitRamoAtividade.listaRamoAtividade.any(
                        (ramo) =>
                            ramo.descricao.toLowerCase() ==
                            descricaoController.text.toLowerCase().trim(),
                      )) {
                        return "Este ramo já foi cadastrado";
                      }

                      RamoAtividadeEntity ramo = RamoAtividadeEntity(
                        descricao: descricaoController.text.trim(),
                      );
                      cubitRamoAtividade.save(ramo);

                      return null;
                    },
                  ),

                  const SizedBox(height: 44),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text("Cancelar"),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            final isVaid =
                                formModalKey.currentState?.validate() ?? false;

                            if (!isVaid) {
                              return;
                            }

                            Navigator.pop(context, true);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("Gravar"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    if (salvou == true) {
      setState(() {
        cubitRamoAtividade.load();
      });
    }
  }

  Future<void> _abrirDialogNovoTipoTelefone(BuildContext context) async {
    final descricaoController = TextEditingController();

    final salvou = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Form(
              key: formModalKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Cadastrar um novo tipo de telefone",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    autofocus: true,
                    controller: descricaoController,
                    decoration: InputDecoration(
                      labelText: "Descrição",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Informe a descrição";
                      }

                      if (cubitTipoTelefone.listaTipoTelefones.any(
                        (tipo) =>
                            tipo.descricao.toLowerCase() ==
                            descricaoController.text.toLowerCase().trim(),
                      )) {
                        return "Este tipo já foi cadastrado";
                      }

                      TipoTelefoneEntity tipoTelefoneEntity =
                          TipoTelefoneEntity(
                            descricao: descricaoController.text.trim(),
                          );

                      cubitTipoTelefone.save(tipoTelefoneEntity);

                      return null;
                    },
                  ),

                  const SizedBox(height: 44),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancelar"),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            final isVaid =
                                formModalKey.currentState?.validate() ?? false;

                            if (!isVaid) {
                              return;
                            }

                            Navigator.pop(context, true);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("Gravar"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    if (salvou == true) {
      setState(() {
        cubitTipoTelefone.load();
      });
    }
  }

  Future<void> _buscarCep(BuildContext context) async {
    if (cepController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Informe o CEP",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );

      FocusScope.of(context).requestFocus(_cepFocus);
      return;
    }

    final cepSemMascara = cepController.text.trim().replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );

    cubitCep.load(cepSemMascara);
  }

  @override
  void initState() {
    super.initState();

    cubitTipoTelefone.stream.listen((state) {
      if (state is TipoTelefoneListSucess) {
        if (widget.isEditing) setupEtingCliente();
      }
    });

    cubitRamoAtividade.load();
    cubitTipoTelefone.load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CepCubit, CepState>(
      bloc: cubitCep,
      listener: (context, state) {
        if (state is CepStateSucess) {
          logradouroCotroller.text = state.cep.logradouro;
          bairroController.text = state.cep.bairro;
          municipioController.text = state.cep.localidade;
          codigoIbgeController.text = state.cep.ibge;
          estadoController.text = state.cep.uf;

          FocusScope.of(context).requestFocus(_numeroLogradouroFocus);
        }

        if (state is CepStateError) {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return AlertDialog(
                title: const Text("Erro ao buscar o CEP"),
                content: Text(state.error),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Cadastro de Cliente",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color.fromARGB(255, 2, 63, 7),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: Form(
              key: formKey,
              child: Column(
                spacing: 18,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          title: const Text("Pessoa física"),
                          value: "F",
                          groupValue: _tipoPessoa,
                          onChanged: (value) {
                            setState(() {
                              _tipoPessoa = value;
                            });
                          },
                        ),
                      ),

                      Expanded(
                        child: RadioListTile(
                          title: const Text("Pessoa juridica"),
                          value: "J",
                          groupValue: _tipoPessoa,
                          onChanged: (value) {
                            setState(() {
                              _tipoPessoa = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  TextFormField(
                    controller: razaoSocialController,
                    focusNode: _razaoSocialFocus,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      labelText:
                          _tipoPessoa == "F" ? "Nome completo" : "Razão Social",
                    ),
                    validator: (value) {
                      if (value == "" || value == null) {
                        return _tipoPessoa == "F"
                            ? "Informe o nome completo"
                            : "Informe a razão social";
                      }
                      return null;
                    },
                  ),

                  TextFormField(
                    controller: nomeFantasiaController,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      labelText:
                          _tipoPessoa == "F" ? "Apelido" : "Nome fantasia",
                    ),
                    validator: (value) {
                      if (value == "" || value == null) {
                        return _tipoPessoa == "F"
                            ? "Informe o apelido"
                            : "Informe o nome fantasia";
                      }
                      return null;
                    },
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: BlocBuilder<
                          RamoAtividadeListCuibit,
                          RamoAtividadeListState
                        >(
                          bloc: cubitRamoAtividade,
                          builder: (context, state) {
                            if (state is RamoAtividadeListLoading) {
                              return Center(child: CircularProgressIndicator());
                            } else if (state is RamoAtividadeListError) {
                              return Center(child: Text(state.error));
                            } else if (state is RamoAtividadeListSucess) {
                              return DropdownButtonFormField<
                                RamoAtividadeEntity
                              >(
                                value: _ramoAtividadeEntitySelecionado,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.category),
                                  labelText: "Selecione um ramo atividade",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                isExpanded: true,
                                items:
                                    state.ramos.map((ramo) {
                                      return DropdownMenuItem(
                                        value: ramo,
                                        child: Text(ramo.descricao),
                                      );
                                    }).toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return "Selecione um ramo de atividade";
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {});
                                },
                              );
                            }
                            return SizedBox.shrink();
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _abrirDialogNovoRamoAtividade(context);
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),

                  Divider(),

                  TextFormField(
                    controller: cnpjCpfController,
                    keyboardType: TextInputType.number,
                    inputFormatters: inputFormatters,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    focusNode: _cnpjCpfFocus,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        _tipoPessoa == "F" ? Icons.article : Icons.business,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      labelText: _tipoPessoa == "F" ? "CPF" : "CNPJ",
                    ),
                    validator: (value) {
                      if (value == "" || value == null) {
                        return _tipoPessoa == "F"
                            ? "Informe o cpf"
                            : "Informe o cnpj";
                      }

                      if (_tipoPessoa == "F" &&
                          !CpfValidator.isCpfValido(value)) {
                        return "CPF Inválido";
                      }

                      if (_tipoPessoa == "J" &&
                          !CnpjValidator.isCnpjValido(value)) {
                        return "CNPJ Inválido";
                      }

                      return null;
                    },
                  ),

                  TextFormField(
                    controller: inscricaoEstadualController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.business),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      labelText:
                          _tipoPessoa == "F" ? "RG" : "Inscricao Estadual",
                    ),
                  ),

                  TextFormField(
                    controller: inscricaoMunicipalController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        _tipoPessoa == "F" ? Icons.article : Icons.business,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      labelText: "Inscrição Municipal",
                    ),
                  ),

                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      labelText: "Email",
                    ),
                    validator: (value) {
                      if (value == "" || value == null) {
                        return "Informe o e-mail";
                      }

                      final emailRegex = RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      );

                      if (!emailRegex.hasMatch(value)) {
                        return 'E-mail inválido';
                      }

                      return null;
                    },
                  ),

                  TextFormField(
                    controller: homePageController,
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.web),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      labelText: "Home Page",
                    ),
                  ),

                  Divider(),

                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: cepController,
                          focusNode: _cepFocus,
                          inputFormatters: [cepMask],
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_on),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            labelText: "Cep",
                          ),
                          validator: (value) {
                            if (value == "" || value == null) {
                              return "Informe o cep";
                            }
                            return null;
                          },
                        ),
                      ),

                      BlocBuilder<CepCubit, CepState>(
                        bloc: cubitCep,
                        builder: (context, state) {
                          if (state is CepStateLoading) {
                            return Center(child: CircularProgressIndicator());
                          }

                          return IconButton(
                            onPressed: () => _buscarCep(context),
                            icon: Icon(Icons.find_in_page),
                          );
                        },
                      ),
                    ],
                  ),

                  TextFormField(
                    controller: logradouroCotroller,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      labelText: "Logradouro",
                    ),
                    validator: (value) {
                      if (value == "" || value == null) {
                        return "Informe o logradouro";
                      }
                      return null;
                    },
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: numeroController,
                          focusNode: _numeroLogradouroFocus,
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_on),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            labelText: "Número",
                          ),
                          validator: (value) {
                            if (value == "" || value == null) {
                              return "Informe o número";
                            }
                            return null;
                          },
                        ),
                      ),

                      SizedBox(width: 10),

                      Expanded(
                        child: TextFormField(
                          controller: complementoController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_on),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            labelText: "Complemento",
                          ),
                        ),
                      ),
                    ],
                  ),

                  TextFormField(
                    controller: bairroController,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      labelText: "Bairro",
                    ),
                    validator: (value) {
                      if (value == "" || value == null) {
                        return "Informe o bairro";
                      }
                      return null;
                    },
                  ),

                  TextFormField(
                    controller: municipioController,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      labelText: "Municipio",
                    ),
                    validator: (value) {
                      if (value == "" || value == null) {
                        return "Informe o municipio";
                      }
                      return null;
                    },
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: codigoIbgeController,
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_on),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            labelText: "Código do IBGE",
                          ),
                          validator: (value) {
                            if (value == "" || value == null) {
                              return "Informe o código do IBGE";
                            }
                            return null;
                          },
                        ),
                      ),

                      SizedBox(width: 10),

                      Expanded(
                        child: TextFormField(
                          controller: estadoController,
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_on),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            labelText: "Estado",
                          ),
                          validator: (value) {
                            if (value == "" || value == null) {
                              return "Informe o estado";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),

                  Divider(),

                  Row(
                    children: [
                      Expanded(
                        child: BlocBuilder<
                          TipoTelefoneListCubit,
                          TipoTelefoneListState
                        >(
                          bloc: cubitTipoTelefone,
                          builder: (context, state) {
                            if (state is TipoTelefoneListLoading) {
                              return Center(child: CircularProgressIndicator());
                            } else if (state is TipoTelefoneListError) {
                              return Center(child: Text(state.error));
                            } else if (state is TipoTelefoneListSucess) {
                              return DropdownButtonFormField<
                                TipoTelefoneEntity
                              >(
                                value: _tipoTelefoneEntitySelecionado,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.category),
                                  labelText: "Selecione um tipo telefone",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                isExpanded: true,
                                items:
                                    state.tipos.map((tipo) {
                                      return DropdownMenuItem(
                                        value: tipo,
                                        child: Text(tipo.descricao),
                                      );
                                    }).toList(),
                                onChanged: (value) {
                                  setState(() {});
                                },
                              );
                            }
                            return SizedBox.shrink();
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _abrirDialogNovoTipoTelefone(context);
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),

                  TextFormField(
                    controller: telefoneController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [telefone1Mask],
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      hintText: "(99) 9 9999-9999",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      labelText: "Telefone",
                    ),
                  ),

                  TextFormField(
                    controller: complementoTelefoneController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      labelText: "Complemento",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: BlocConsumer<ClienteListCuibit, ClienteListState>(
              bloc: cubitCliente,
              listener: (context, state) {
                if (state is ClienteListError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.error,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 4),
                    ),
                  );

                  FocusScope.of(context).requestFocus(_cnpjCpfFocus);
                }
              },

              builder: (context, state) {
                final isLoading = state is ClienteListLoading;

                return FilledButton.icon(
                  onPressed: isLoading ? null : salvar,
                  icon:
                      isLoading
                          ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                          : const Icon(Icons.save),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 2, 63, 7),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  label: Text(
                    isLoading ? "Salvando..." : "Salvar",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    razaoSocialController.dispose();
    nomeFantasiaController.dispose();
    cnpjCpfController.dispose();
    inscricaoMunicipalController.dispose();
    inscricaoEstadualController.dispose();
    emailController.dispose();
    homePageController.dispose();
    cepController.dispose();
    logradouroCotroller.dispose();
    numeroController.dispose();
    complementoController.dispose();
    bairroController.dispose();
    municipioController.dispose();
    codigoIbgeController.dispose();
    estadoController.dispose();
    telefoneController.dispose();
    complementoTelefoneController.dispose();

    cubitCep.close();
    cubitRamoAtividade.close();
    cubitTipoTelefone.close();
    cubitCliente.close();

    super.dispose();
  }
}

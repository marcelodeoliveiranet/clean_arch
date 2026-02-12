import 'package:clean_arch/features/clientes/domain/entities/cliente_entity.dart';

class ClienteModel {
  final String foto;
  final int? codigoCliente;
  final String razaoSocial;
  final String nomeFantasia;
  final int codigoRamoAtividade;
  final String cnpjCpf;
  final String tipoPessoa;
  final String ieRg;
  final String inscricaoMunicipal;
  final String email;
  final String homePage;
  final String cep;
  final int codigoTipoLogradouro;
  final String logradouro;
  final String numero;
  final String complemento;
  final String bairro;
  final String municipio;
  final int codigoIbgeMunicipio;
  final String uf;
  final int codigoTipoTelefone1;
  final String telefone1;
  final int codigoTipoTelefone2;
  final String complementoTelefone1;
  final String telefone2;
  final String complementoTelefone2;
  final String dataCadastro;

  const ClienteModel({
    required this.foto,
    required this.codigoCliente,
    required this.razaoSocial,
    required this.nomeFantasia,
    required this.codigoRamoAtividade,
    required this.cnpjCpf,
    required this.tipoPessoa,
    required this.ieRg,
    required this.inscricaoMunicipal,
    required this.email,
    required this.homePage,
    required this.cep,
    required this.codigoTipoLogradouro,
    required this.logradouro,
    required this.numero,
    required this.complemento,
    required this.bairro,
    required this.municipio,
    required this.codigoIbgeMunicipio,
    required this.uf,
    required this.codigoTipoTelefone1,
    required this.telefone1,
    required this.codigoTipoTelefone2,
    required this.complementoTelefone1,
    required this.telefone2,
    required this.complementoTelefone2,
    required this.dataCadastro,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'foto': foto,
      'codigo_cliente': codigoCliente,
      'razao_social': razaoSocial,
      'nome_fantasia': nomeFantasia,
      'codigo_ramo_atividade': codigoRamoAtividade,
      'cnpj_cpf': cnpjCpf,
      'tipo_pessoa': tipoPessoa,
      'ie_rg': ieRg,
      'inscricao_municipal': inscricaoMunicipal,
      'email': email,
      'home_page': homePage,
      'cep': cep,
      'codigo_tipo_logradouro': codigoTipoLogradouro,
      'logradouro': logradouro,
      'numero': numero,
      'complemento': complemento,
      'bairro': bairro,
      'municipio': municipio,
      'codigo_ibge_municipio': codigoIbgeMunicipio,
      'uf': uf,
      'codigo_tipo_telefone1': codigoTipoTelefone1,
      'telefone1': telefone1,
      'codigo_tipo_telefone2': codigoTipoTelefone2,
      'complemento_telefone1': complementoTelefone1,
      'telefone2': telefone2,
      'complemento_telefone2': complementoTelefone2,
      'data_cadastro': dataCadastro,
    };
  }

  factory ClienteModel.fromMap(Map<String, dynamic> map) {
    return ClienteModel(
      foto: map['foto'] as String,
      codigoCliente: map['codigo_cliente'] as int,
      razaoSocial: map['razao_social'] as String,
      nomeFantasia: map['nome_fantasia'] as String,
      codigoRamoAtividade: map['codigo_ramo_atividade'] as int,
      cnpjCpf: map['cnpj_cpf'] as String,
      tipoPessoa: map['tipo_pessoa'] as String,
      ieRg: map['ie_rg'] as String,
      inscricaoMunicipal: map['inscricao_municipal'] as String,
      email: map['email'] as String,
      homePage: map['home_page'] as String,
      cep: map['cep'] as String,
      codigoTipoLogradouro: map['codigo_tipo_logradouro'] as int,
      logradouro: map['logradouro'] as String,
      numero: map['numero'] as String,
      complemento: map['complemento'] as String,
      bairro: map['bairro'] as String,
      municipio: map['municipio'] as String,
      codigoIbgeMunicipio: map['codigo_ibge_municipio'] as int,
      uf: map['uf'] as String,
      codigoTipoTelefone1: map['codigo_tipo_telefone1'] as int,
      telefone1: map['telefone1'] as String,
      codigoTipoTelefone2: map['codigo_tipo_telefone2'] as int,
      complementoTelefone1: map['complemento_telefone1'] as String,
      telefone2: map['telefone2'] as String,
      complementoTelefone2: map['complemento_telefone2'] as String,
      dataCadastro: map['data_cadastro'] as String,
    );
  }

  ClienteEntity toEntity() {
    return ClienteEntity(
      foto: foto,
      tipoPessoa: tipoPessoa,
      razaoSocial: razaoSocial,
      nomeFantasia: nomeFantasia,
      codigoRamoAtividade: codigoRamoAtividade,
      cnpjCpf: cnpjCpf,
      ieRg: ieRg,
      inscricaoMunicipal: inscricaoMunicipal,
      email: email,
      homePage: homePage,
      cep: cep,
      codigoTipoLogradouro: codigoTipoLogradouro,
      logradouro: logradouro,
      numero: numero,
      complemento: complemento,
      bairro: bairro,
      municipio: municipio,
      codigoIbgeMunicipio: codigoIbgeMunicipio,
      uf: uf,
      codigoTipoTelefone1: codigoTipoTelefone1,
      telefone1: telefone1,
      codigoTipoTelefone2: codigoTipoTelefone2,
      complementoTelefone1: complementoTelefone1,
      telefone2: telefone2,
      complementoTelefone2: complementoTelefone2,
      dataCadastro: dataCadastro,
    );
  }

  factory ClienteModel.fromEntity(ClienteEntity entity) {
    return ClienteModel(
      foto: entity.foto,
      codigoCliente: entity.codigoCliente,
      razaoSocial: entity.razaoSocial,
      nomeFantasia: entity.nomeFantasia,
      codigoRamoAtividade: entity.codigoRamoAtividade,
      cnpjCpf: entity.cnpjCpf,
      tipoPessoa: entity.tipoPessoa,
      ieRg: entity.ieRg,
      inscricaoMunicipal: entity.inscricaoMunicipal,
      email: entity.email,
      homePage: entity.homePage,
      cep: entity.cep,
      codigoTipoLogradouro: entity.codigoTipoLogradouro,
      logradouro: entity.logradouro,
      numero: entity.numero,
      complemento: entity.complemento,
      bairro: entity.bairro,
      municipio: entity.municipio,
      codigoIbgeMunicipio: entity.codigoIbgeMunicipio,
      uf: entity.uf,
      codigoTipoTelefone1: entity.codigoTipoTelefone1,
      telefone1: entity.telefone1,
      codigoTipoTelefone2: entity.codigoTipoTelefone2,
      complementoTelefone1: entity.complementoTelefone1,
      telefone2: entity.telefone2,
      complementoTelefone2: entity.complementoTelefone2,
      dataCadastro: entity.dataCadastro,
    );
  }
}

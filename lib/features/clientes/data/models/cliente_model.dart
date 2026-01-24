class ClienteModel {
  final int? codigoCliente;
  final String razaoSocial;
  final String nomeFantasia;
  final int codigoAtividade;
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

  const ClienteModel({
    this.codigoCliente,
    required this.razaoSocial,
    required this.nomeFantasia,
    required this.codigoAtividade,
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
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codigo_cliente': codigoCliente,
      'razao_social': razaoSocial,
      'nome_fantasia': nomeFantasia,
      'codigo_atividade': codigoAtividade,
      'cnpj_cpf': cnpjCpf,
      'tipoPessoa': tipoPessoa,
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
    };
  }

  factory ClienteModel.fromMap(Map<String, dynamic> map) {
    return ClienteModel(
      codigoCliente: map['codigo_cliente'] as int,
      razaoSocial: map['razao_social'] as String,
      nomeFantasia: map['nome_fantasia'] as String,
      codigoAtividade: map['codigo_atividade'] as int,
      cnpjCpf: map['cnpj_cpf'] as String,
      tipoPessoa: map['tipoPessoa'] as String,
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
    );
  }
}

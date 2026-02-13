// ignore_for_file: public_member_api_docs, sort_constructors_first
class ClienteEntity {
  final String foto;
  final String tipoPessoa;
  final int? codigoCliente;
  final String razaoSocial;
  final String nomeFantasia;
  final int codigoRamoAtividade;
  final String cnpjCpf;
  final String ieRg;
  final String inscricaoMunicipal;
  final String email;
  final String homePage;
  final String cep;
  final String logradouro;
  final String numero;
  final String complemento;
  final String bairro;
  final String municipio;
  final int codigoIbgeMunicipio;
  final String uf;
  final int codigoTipoTelefone1;
  final String telefone1;
  final String complementoTelefone1;
  final String dataCadastro;

  const ClienteEntity({
    required this.foto,
    required this.tipoPessoa,
    this.codigoCliente,
    required this.razaoSocial,
    required this.nomeFantasia,
    required this.codigoRamoAtividade,
    required this.cnpjCpf,
    required this.ieRg,
    required this.inscricaoMunicipal,
    required this.email,
    required this.homePage,
    required this.cep,
    required this.logradouro,
    required this.numero,
    required this.complemento,
    required this.bairro,
    required this.municipio,
    required this.codigoIbgeMunicipio,
    required this.uf,
    required this.codigoTipoTelefone1,
    required this.telefone1,
    required this.complementoTelefone1,
    required this.dataCadastro,
  });

  ClienteEntity copyWith({
    String? foto,
    String? tipoPessoa,
    int? codigoCliente,
    String? razaoSocial,
    String? nomeFantasia,
    int? codigoRamoAtividade,
    String? cnpjCpf,
    String? ieRg,
    String? inscricaoMunicipal,
    String? email,
    String? homePage,
    String? cep,
    String? logradouro,
    String? numero,
    String? complemento,
    String? bairro,
    String? municipio,
    int? codigoIbgeMunicipio,
    String? uf,
    int? codigoTipoTelefone1,
    String? telefone1,
    String? complementoTelefone1,
    String? dataCadastro,
  }) {
    return ClienteEntity(
      foto: foto ?? this.foto,
      tipoPessoa: tipoPessoa ?? this.tipoPessoa,
      codigoCliente: codigoCliente ?? this.codigoCliente,
      razaoSocial: razaoSocial ?? this.razaoSocial,
      nomeFantasia: nomeFantasia ?? this.nomeFantasia,
      codigoRamoAtividade: codigoRamoAtividade ?? this.codigoRamoAtividade,
      cnpjCpf: cnpjCpf ?? this.cnpjCpf,
      ieRg: ieRg ?? this.ieRg,
      inscricaoMunicipal: inscricaoMunicipal ?? this.inscricaoMunicipal,
      email: email ?? this.email,
      homePage: homePage ?? this.homePage,
      cep: cep ?? this.cep,
      logradouro: logradouro ?? this.logradouro,
      numero: numero ?? this.numero,
      complemento: complemento ?? this.complemento,
      bairro: bairro ?? this.bairro,
      municipio: municipio ?? this.municipio,
      codigoIbgeMunicipio: codigoIbgeMunicipio ?? this.codigoIbgeMunicipio,
      uf: uf ?? this.uf,
      codigoTipoTelefone1: codigoTipoTelefone1 ?? this.codigoTipoTelefone1,
      telefone1: telefone1 ?? this.telefone1,
      complementoTelefone1: complementoTelefone1 ?? this.complementoTelefone1,
      dataCadastro: dataCadastro ?? this.dataCadastro,
    );
  }
}

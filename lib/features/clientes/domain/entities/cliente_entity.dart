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
  final String complementoTelefone1;
  final int codigoTipoTelefone2;
  final String telefone2;
  final String complementoTelefone2;
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
}

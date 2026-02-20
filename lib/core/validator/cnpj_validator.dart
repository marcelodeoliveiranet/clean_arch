class CnpjValidator {
  static bool isCnpjValido(String cnpj) {
    cnpj = cnpj.replaceAll(RegExp(r'[^0-9]'), '');

    // Deve ter 14 dígitos
    if (cnpj.length != 14) return false;

    // Elimina CNPJs com todos os dígitos iguais
    if (RegExp(r'^(\d)\1{13}$').hasMatch(cnpj)) return false;

    List<int> numeros = cnpj.split('').map((e) => int.parse(e)).toList();

    // Validação do primeiro dígito
    List<int> pesos1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    int soma = 0;

    for (int i = 0; i < pesos1.length; i++) {
      soma += numeros[i] * pesos1[i];
    }

    int resto = soma % 11;
    int digito1 = resto < 2 ? 0 : 11 - resto;

    if (digito1 != numeros[12]) return false;

    // Validação do segundo dígito
    List<int> pesos2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    soma = 0;

    for (int i = 0; i < pesos2.length; i++) {
      soma += numeros[i] * pesos2[i];
    }

    resto = soma % 11;
    int digito2 = resto < 2 ? 0 : 11 - resto;

    if (digito2 != numeros[13]) return false;

    return true;
  }
}

class CpfValidator {
  static bool isCpfValido(String cpf) {
    cpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');

    // Deve ter 11 dígitos
    if (cpf.length != 11) return false;

    // Elimina CPFs com todos os dígitos iguais
    if (RegExp(r'^(\d)\1{10}$').hasMatch(cpf)) return false;

    // Validação do primeiro dígito
    int soma = 0;
    for (int i = 0; i < 9; i++) {
      soma += int.parse(cpf[i]) * (10 - i);
    }
    int digito1 = (soma * 10) % 11;
    if (digito1 == 10) digito1 = 0;
    if (digito1 != int.parse(cpf[9])) return false;

    // Validação do segundo dígito
    soma = 0;
    for (int i = 0; i < 10; i++) {
      soma += int.parse(cpf[i]) * (11 - i);
    }
    int digito2 = (soma * 10) % 11;
    if (digito2 == 10) digito2 = 0;
    if (digito2 != int.parse(cpf[10])) return false;

    return true;
  }
}

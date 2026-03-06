// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class ClienteFormState {}

class ClienteFormInitial implements ClienteFormState {}

class ClienteFormError implements ClienteFormState {
  final String error;

  ClienteFormError({required this.error});
}

class ClienteFormSaving implements ClienteFormState {}

class ClienteFormSucessInsert implements ClienteFormState {}

class ClienteFormSucessEdit implements ClienteFormState {}

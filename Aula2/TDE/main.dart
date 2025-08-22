double calcularMedia(List<int> numeros) {
  if (numeros.isEmpty) {
    return 0.0;
  }

  int soma = 0;
  for (int numero in numeros) {
    soma += numero;
  }

  return soma / numeros.length;
}

void main() {
  // EXERCICIO 1
  print("--- Executando a Calculadora de Média ---");

  List<int> minhaLista = [10, 20, 30, 40, 50];
  double media = calcularMedia(minhaLista);
  print('A média dos números é: $media');

  List<int> listaVazia = [];
  double mediaListaVazia = calcularMedia(listaVazia);
  print('A média da lista vazia é: $mediaListaVazia');

  print("\n" + ("-" * 40) + "\n");

  // EXERCICIO 2

  print("--- Executando o Tradutor de Cores ---");

  String corEmIngles = 'blue';
  String corEmPortugues;

  switch (corEmIngles) {
    case 'blue':
      corEmPortugues = 'Azul';
      break;
    case 'red':
      corEmPortugues = 'Vermelho';
      break;
    case 'green':
      corEmPortugues = 'Verde';
      break;
    case 'yellow':
      corEmPortugues = 'Amarelo';
      break;
    default:
      corEmPortugues = 'Cor não reconhecida';
  }

  print('A tradução de "$corEmIngles" é "$corEmPortugues".');
}

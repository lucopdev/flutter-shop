class Validador {
  static name(String? stringName) {
    final name = stringName ?? '';
    return name.trim().isEmpty ? 'O nome não pode estar vazio' : null;
  }

  static price(String? stringPrice) {
    final priceString = stringPrice ?? '';
    final price = double.tryParse(priceString) ?? -1;

    if (price <= 0) {
      return 'Informe um preço válido';
    }
    return null;
  }

  static description(String? stringDescription) {
    final description = stringDescription ?? '';
    if (description.trim().isEmpty) {
      return 'A descrição não pode estar vazia';
    }
    if (description.trim().length < 5) {
      return 'Descreva mais sobre o produto';
    }
    return null;
  }

  static imageUrl(String? stringImageUrl) {
    final imageUrl = stringImageUrl ?? '';

    bool isValidUrl = Uri.tryParse(imageUrl)?.hasAbsolutePath ?? false;

    bool endsWithFile = imageUrl.toLowerCase().endsWith('.png') ||
        imageUrl.toLowerCase().endsWith('.jpg') ||
        imageUrl.toLowerCase().endsWith('.jpeg') ||
        imageUrl.toLowerCase().endsWith('.img');

    if (isValidUrl && endsWithFile) {
      return null;
    }
    
    return 'Imagem inválida';
  }
}

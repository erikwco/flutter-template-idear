enum ProductType {
  bien,
  servicio;

  int get felCode => switch (this) {
    ProductType.bien => 1,
    ProductType.servicio => 2,
  };
}

class Product {
  final String id;
  final String codigo;
  final String nombre;
  final String? descripcion;
  final ProductType tipo;
  final int priceCents;
  final String unidad;
  final bool activo;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Product({
    required this.id,
    required this.codigo,
    required this.nombre,
    this.descripcion,
    required this.tipo,
    required this.priceCents,
    required this.unidad,
    required this.activo,
    required this.createdAt,
    required this.updatedAt,
  });

  String get priceLabel => '\$${(priceCents / 100).toStringAsFixed(2)}';

  Product copyWith({
    String? codigo,
    String? nombre,
    String? descripcion,
    ProductType? tipo,
    int? priceCents,
    String? unidad,
    bool? activo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Product(
    id: id,
    codigo: codigo ?? this.codigo,
    nombre: nombre ?? this.nombre,
    descripcion: descripcion ?? this.descripcion,
    tipo: tipo ?? this.tipo,
    priceCents: priceCents ?? this.priceCents,
    unidad: unidad ?? this.unidad,
    activo: activo ?? this.activo,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'] as String,
    codigo: json['codigo'] as String,
    nombre: json['nombre'] as String,
    descripcion: json['descripcion'] as String?,
    tipo: ProductType.values[json['tipo'] as int],
    priceCents: json['priceCents'] as int,
    unidad: json['unidad'] as String,
    activo: json['activo'] as bool,
    createdAt: DateTime.parse(json['created_at'] as String),
    updatedAt: DateTime.parse(json['updated_at'] as String),
  );

  Map<String, dynamic> toJson() => {
    'codigo': codigo,
    'nombre': nombre,
    'descripcion': descripcion,
    'tipo': tipo.name,
    'price_cents': priceCents,
    'unidad': unidad,
    'activo': activo,
  };
}

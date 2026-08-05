/// ARTIZEN V2 — the quote read from an imported PDF, mirroring the backend
/// `ExtractedQuote` (`app/quote_extraction/schemas.py`).
///
/// Plain immutable Dart with `fromJson`, deliberately not Freezed: amounts are
/// kept as `String?` exactly as printed on the source PDF — parsing them to
/// `double` would lose the very fidelity V2 exists to preserve. Absent fields
/// are `null`/empty; nothing is invented. This is the model the editable devis
/// screen binds to.
library;

String? _str(Object? v) => v?.toString();

List<String> _strList(Object? v) =>
    v is List ? v.map((e) => e.toString()).toList() : const [];

bool _bool(Object? v) => v == true;

Map<String, dynamic> _map(Object? v) =>
    v is Map ? v.map((k, val) => MapEntry(k.toString(), val)) : const {};

class ExtractedAddress {
  const ExtractedAddress({this.lines = const []});
  final List<String> lines;

  factory ExtractedAddress.fromJson(Map<String, dynamic> json) =>
      ExtractedAddress(lines: _strList(json['lines']));

  bool get isEmpty => lines.isEmpty;
}

class ExtractedParty {
  const ExtractedParty({
    this.name,
    this.legalName,
    this.siret,
    this.vatNumber,
    this.apeCode,
    this.rcs,
    this.address = const ExtractedAddress(),
    this.phone,
    this.email,
    this.website,
  });

  final String? name;
  final String? legalName;
  final String? siret;
  final String? vatNumber;
  final String? apeCode;
  final String? rcs;
  final ExtractedAddress address;
  final String? phone;
  final String? email;
  final String? website;

  factory ExtractedParty.fromJson(Map<String, dynamic> json) => ExtractedParty(
    name: _str(json['name']),
    legalName: _str(json['legal_name']),
    siret: _str(json['siret']),
    vatNumber: _str(json['vat_number']),
    apeCode: _str(json['ape_code']),
    rcs: _str(json['rcs']),
    address: ExtractedAddress.fromJson(_map(json['address'])),
    phone: _str(json['phone']),
    email: _str(json['email']),
    website: _str(json['website']),
  );
}

class ExtractedLine {
  const ExtractedLine({
    this.position,
    this.reference,
    this.designation,
    this.description,
    this.unit,
    this.quantity,
    this.unitPriceHt,
    this.vatRate,
    this.discountPercent,
    this.totalHt,
    this.sectionHeader = false,
  });

  final int? position;
  final String? reference;
  final String? designation;
  final String? description;
  final String? unit;
  final String? quantity; // as printed
  final String? unitPriceHt;
  final String? vatRate;
  final String? discountPercent;
  final String? totalHt;
  final bool sectionHeader;

  factory ExtractedLine.fromJson(Map<String, dynamic> json) => ExtractedLine(
    position: json['position'] is int ? json['position'] as int : null,
    reference: _str(json['reference']),
    designation: _str(json['designation']),
    description: _str(json['description']),
    unit: _str(json['unit']),
    quantity: _str(json['quantity']),
    unitPriceHt: _str(json['unit_price_ht']),
    vatRate: _str(json['vat_rate']),
    discountPercent: _str(json['discount_percent']),
    totalHt: _str(json['total_ht']),
    sectionHeader: _bool(json['section_header']),
  );
}

class ExtractedVatRow {
  const ExtractedVatRow({this.rate, this.baseHt, this.vatAmount});
  final String? rate;
  final String? baseHt;
  final String? vatAmount;

  factory ExtractedVatRow.fromJson(Map<String, dynamic> json) =>
      ExtractedVatRow(
        rate: _str(json['rate']),
        baseHt: _str(json['base_ht']),
        vatAmount: _str(json['vat_amount']),
      );
}

class ExtractedTotals {
  const ExtractedTotals({
    this.totalHt,
    this.totalVat,
    this.totalTtc,
    this.globalDiscountAmount,
    this.globalDiscountPercent,
    this.depositAmount,
    this.depositPercent,
    this.netToPay,
    this.vatRows = const [],
  });

  final String? totalHt;
  final String? totalVat;
  final String? totalTtc;
  final String? globalDiscountAmount;
  final String? globalDiscountPercent;
  final String? depositAmount;
  final String? depositPercent;
  final String? netToPay;
  final List<ExtractedVatRow> vatRows;

  factory ExtractedTotals.fromJson(Map<String, dynamic> json) =>
      ExtractedTotals(
        totalHt: _str(json['total_ht']),
        totalVat: _str(json['total_vat']),
        totalTtc: _str(json['total_ttc']),
        globalDiscountAmount: _str(json['global_discount_amount']),
        globalDiscountPercent: _str(json['global_discount_percent']),
        depositAmount: _str(json['deposit_amount']),
        depositPercent: _str(json['deposit_percent']),
        netToPay: _str(json['net_to_pay']),
        vatRows: (json['vat_rows'] as List? ?? const [])
            .map((e) => ExtractedVatRow.fromJson(_map(e)))
            .toList(),
      );
}

class ExtractedPayment {
  const ExtractedPayment({this.terms, this.iban, this.bic, this.bankName});
  final String? terms;
  final String? iban;
  final String? bic;
  final String? bankName;

  factory ExtractedPayment.fromJson(Map<String, dynamic> json) =>
      ExtractedPayment(
        terms: _str(json['terms']),
        iban: _str(json['iban']),
        bic: _str(json['bic']),
        bankName: _str(json['bank_name']),
      );
}

class ExtractedDates {
  const ExtractedDates({this.issuedOn, this.validUntil, this.validityDays});
  final String? issuedOn;
  final String? validUntil;
  final int? validityDays;

  factory ExtractedDates.fromJson(Map<String, dynamic> json) => ExtractedDates(
    issuedOn: _str(json['issued_on']),
    validUntil: _str(json['valid_until']),
    validityDays: json['validity_days'] is int
        ? json['validity_days'] as int
        : null,
  );
}

class ExtractedLayout {
  const ExtractedLayout({
    this.logoDetected = false,
    this.dominantColors = const [],
    this.hasHeader = false,
    this.hasFooter = false,
    this.hasSignatureArea = false,
    this.columnLabels = const [],
  });

  final bool logoDetected;
  final List<String> dominantColors;
  final bool hasHeader;
  final bool hasFooter;
  final bool hasSignatureArea;
  final List<String> columnLabels;

  factory ExtractedLayout.fromJson(Map<String, dynamic> json) =>
      ExtractedLayout(
        logoDetected: _bool(json['logo_detected']),
        dominantColors: _strList(json['dominant_colors']),
        hasHeader: _bool(json['has_header']),
        hasFooter: _bool(json['has_footer']),
        hasSignatureArea: _bool(json['has_signature_area']),
        columnLabels: _strList(json['column_labels']),
      );
}

class ExtractedQuote {
  const ExtractedQuote({
    this.documentTitle,
    this.number,
    this.dates = const ExtractedDates(),
    this.issuer = const ExtractedParty(),
    this.client = const ExtractedParty(),
    this.billingAddress = const ExtractedAddress(),
    this.siteAddress = const ExtractedAddress(),
    this.lines = const [],
    this.totals = const ExtractedTotals(),
    this.payment = const ExtractedPayment(),
    this.conditions,
    this.legalMentions = const [],
    this.notes = const [],
    this.layout = const ExtractedLayout(),
    this.extractionConfidence = 0.0,
  });

  final String? documentTitle;
  final String? number;
  final ExtractedDates dates;
  final ExtractedParty issuer;
  final ExtractedParty client;
  final ExtractedAddress billingAddress;
  final ExtractedAddress siteAddress;
  final List<ExtractedLine> lines;
  final ExtractedTotals totals;
  final ExtractedPayment payment;
  final String? conditions;
  final List<String> legalMentions;
  final List<String> notes;
  final ExtractedLayout layout;
  final double extractionConfidence;

  factory ExtractedQuote.fromJson(Map<String, dynamic> json) => ExtractedQuote(
    documentTitle: _str(json['document_title']),
    number: _str(json['number']),
    dates: ExtractedDates.fromJson(_map(json['dates'])),
    issuer: ExtractedParty.fromJson(_map(json['issuer'])),
    client: ExtractedParty.fromJson(_map(json['client'])),
    billingAddress: ExtractedAddress.fromJson(_map(json['billing_address'])),
    siteAddress: ExtractedAddress.fromJson(_map(json['site_address'])),
    lines: (json['lines'] as List? ?? const [])
        .map((e) => ExtractedLine.fromJson(_map(e)))
        .toList(),
    totals: ExtractedTotals.fromJson(_map(json['totals'])),
    payment: ExtractedPayment.fromJson(_map(json['payment'])),
    conditions: _str(json['conditions']),
    legalMentions: _strList(json['legal_mentions']),
    notes: _strList(json['notes']),
    layout: ExtractedLayout.fromJson(_map(json['layout'])),
    extractionConfidence: (json['extraction_confidence'] is num)
        ? (json['extraction_confidence'] as num).toDouble()
        : 0.0,
  );
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_import_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DocumentAnalysisSummaryImpl _$$DocumentAnalysisSummaryImplFromJson(
  Map<String, dynamic> json,
) => _$DocumentAnalysisSummaryImpl(
  id: json['id'] as String,
  status: json['status'] as String,
  filename: json['filename'] as String,
  documentType: json['document_type'] as String,
  pageCount: (json['page_count'] as num?)?.toInt(),
);

Map<String, dynamic> _$$DocumentAnalysisSummaryImplToJson(
  _$DocumentAnalysisSummaryImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'status': instance.status,
  'filename': instance.filename,
  'document_type': instance.documentType,
  if (instance.pageCount case final value?) 'page_count': value,
};

_$DetectionResultImpl _$$DetectionResultImplFromJson(
  Map<String, dynamic> json,
) => _$DetectionResultImpl(
  logoDetected: json['logo_detected'] as bool,
  logoPosition: json['logo_position'] as String?,
  dominantColors: (json['dominant_colors'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  headerDetected: json['header_detected'] as bool,
  footerDetected: json['footer_detected'] as bool,
  tableDetected: json['table_detected'] as bool,
  companyName: json['company_name'] as String?,
  address: json['address'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  website: json['website'] as String?,
  siret: json['siret'] as String?,
  vatNumber: json['vat_number'] as String?,
  legalNoticeDetected: json['legal_notice_detected'] as bool,
  confidenceScore: (json['confidence_score'] as num).toDouble(),
);

Map<String, dynamic> _$$DetectionResultImplToJson(
  _$DetectionResultImpl instance,
) => <String, dynamic>{
  'logo_detected': instance.logoDetected,
  if (instance.logoPosition case final value?) 'logo_position': value,
  'dominant_colors': instance.dominantColors,
  'header_detected': instance.headerDetected,
  'footer_detected': instance.footerDetected,
  'table_detected': instance.tableDetected,
  if (instance.companyName case final value?) 'company_name': value,
  if (instance.address case final value?) 'address': value,
  if (instance.phone case final value?) 'phone': value,
  if (instance.email case final value?) 'email': value,
  if (instance.website case final value?) 'website': value,
  if (instance.siret case final value?) 'siret': value,
  if (instance.vatNumber case final value?) 'vat_number': value,
  'legal_notice_detected': instance.legalNoticeDetected,
  'confidence_score': instance.confidenceScore,
};

_$TemplateImportPreviewImpl _$$TemplateImportPreviewImplFromJson(
  Map<String, dynamic> json,
) => _$TemplateImportPreviewImpl(
  analysis: DocumentAnalysisSummary.fromJson(
    json['analysis'] as Map<String, dynamic>,
  ),
  detection: DetectionResult.fromJson(
    json['detection'] as Map<String, dynamic>,
  ),
  currentCompany: Company.fromJson(
    json['current_company'] as Map<String, dynamic>,
  ),
  currentBrand: BrandProfile.fromJson(
    json['current_brand'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$$TemplateImportPreviewImplToJson(
  _$TemplateImportPreviewImpl instance,
) => <String, dynamic>{
  'analysis': instance.analysis,
  'detection': instance.detection,
  'current_company': instance.currentCompany,
  'current_brand': instance.currentBrand,
};

_$TemplateImportValidateInputImpl _$$TemplateImportValidateInputImplFromJson(
  Map<String, dynamic> json,
) => _$TemplateImportValidateInputImpl(
  name: json['name'] as String?,
  legalName: json['legal_name'] as String?,
  siret: json['siret'] as String?,
  vatNumber: json['vat_number'] as String?,
  addressLine: json['address_line'] as String?,
  postalCode: json['postal_code'] as String?,
  city: json['city'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  website: json['website'] as String?,
  primaryColor: json['primary_color'] as String?,
  secondaryColor: json['secondary_color'] as String?,
);

Map<String, dynamic> _$$TemplateImportValidateInputImplToJson(
  _$TemplateImportValidateInputImpl instance,
) => <String, dynamic>{
  if (instance.name case final value?) 'name': value,
  if (instance.legalName case final value?) 'legal_name': value,
  if (instance.siret case final value?) 'siret': value,
  if (instance.vatNumber case final value?) 'vat_number': value,
  if (instance.addressLine case final value?) 'address_line': value,
  if (instance.postalCode case final value?) 'postal_code': value,
  if (instance.city case final value?) 'city': value,
  if (instance.phone case final value?) 'phone': value,
  if (instance.email case final value?) 'email': value,
  if (instance.website case final value?) 'website': value,
  if (instance.primaryColor case final value?) 'primary_color': value,
  if (instance.secondaryColor case final value?) 'secondary_color': value,
};

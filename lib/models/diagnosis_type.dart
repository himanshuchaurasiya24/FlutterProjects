enum DiagnosisType {
  ultrasound,
  pathology,
  ecg,
  xray,
}

class Category {
  const Category({
    required this.title,
  });
  final String title;
}

const type = {
  DiagnosisType.ultrasound: Category(title: 'Ultrasound'),
  DiagnosisType.pathology: Category(title: 'Pathology'),
  DiagnosisType.ecg: Category(title: 'ECG'),
  DiagnosisType.xray: Category(title: 'X-Ray'),
};

enum PatientSex { male, female, others }

class CategorySex {
  const CategorySex({required this.sex});
  final String sex;
}

const sex = {
  PatientSex.male: CategorySex(sex: 'Male'),
  PatientSex.female: CategorySex(sex: 'Female'),
  PatientSex.others: CategorySex(sex: 'Others'),
};

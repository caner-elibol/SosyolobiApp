import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:maplibre_gl/maplibre_gl.dart' show LatLng;

import '../../../core/domain/enums.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/theme/colors.dart';
import '../../../core/domain/category.dart';
import '../../../core/utils/category_icons.dart';
import '../../../core/widgets/api_error_snackbar.dart';
import '../../../core/widgets/app_snackbar.dart';
import '../../map/application/current_location_provider.dart';
import '../../map/presentation/widgets/pin_drop_map.dart';
import '../../profile/application/profile_providers.dart';
import '../application/activities_providers.dart';
import '../application/categories_provider.dart';
import '../domain/create_activity_request.dart';

class CreateActivityWizard extends ConsumerStatefulWidget {
  const CreateActivityWizard({super.key});

  @override
  ConsumerState<CreateActivityWizard> createState() =>
      _CreateActivityWizardState();
}

class _CreateActivityWizardState extends ConsumerState<CreateActivityWizard> {
  int _step = 1;
  String? _categoryId;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController();
  final _addressDetailController = TextEditingController();
  final _priceController = TextEditingController();
  final _neededController = TextEditingController(text: '1');
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  SkillLevel _skillLevel = SkillLevel.any;
  GenderPreference _genderPreference = GenderPreference.any;
  LatLng? _pin;
  bool _pinSeeded = false;
  String? _categoryError;
  String? _titleError;
  String? _neededError;
  String? _addressError;
  bool _submitting = false;
  bool _profileGateDialogShown = false;

  void _showProfileRequiredDialog() {
    if (_profileGateDialogShown) return;
    _profileGateDialogShown = true;
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Profil adı gerekli'),
        content: const Text(
          'Etkinlik oluşturabilmek için önce profilinize bir isim eklemelisiniz.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.go(RoutePaths.profile);
            },
            child: const Text('Profile Git'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
    _addressDetailController.dispose();
    _priceController.dispose();
    _neededController.dispose();
    super.dispose();
  }

  void _seedPinIfNeeded(LatLng center) {
    if (!_pinSeeded) {
      _pinSeeded = true;
      _pin = center;
    }
  }

  bool _validateStep1() {
    setState(
      () => _categoryError = _categoryId == null ? 'Kategori seçin' : null,
    );
    return _categoryId != null;
  }

  bool _validateStep2() {
    final titleOk = _titleController.text.trim().length >= 3;
    final needed = int.tryParse(_neededController.text) ?? 0;
    final neededOk = needed >= 1;
    setState(() {
      _titleError = titleOk ? null : 'Başlık en az 3 karakter';
      _neededError = neededOk ? null : 'En az 1 kişi';
    });
    return titleOk && neededOk;
  }

  void _goNext() {
    final valid = _step == 1 ? _validateStep1() : _validateStep2();
    if (valid) setState(() => _step += 1);
  }

  void _goBack() {
    if (_step == 1) {
      context.pop();
      return;
    }
    setState(() => _step -= 1);
  }

  Future<void> _submit() async {
    if (_submitting) return;

    final addressOk = _addressController.text.trim().length >= 5;
    setState(
      () => _addressError = addressOk ? null : 'Adres açıklaması zorunlu',
    );
    if (!addressOk || _pin == null) {
      if (_pin == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Haritadan bir konum seçin.')),
        );
      }
      return;
    }

    setState(() => _submitting = true);
    final eventDate = DateTime(
      _date.year,
      _date.month,
      _date.day,
      _time.hour,
      _time.minute,
    );
    final price =
        double.tryParse(_priceController.text.replaceAll(',', '.')) ?? 0;
    final request = CreateActivityRequest(
      categoryId: _categoryId!,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      eventDate: eventDate.toUtc(),
      neededPeopleCount: int.parse(_neededController.text),
      pricePerPerson: price,
      skillLevel: _skillLevel,
      genderPreference: _genderPreference,
      latitude: _pin!.latitude,
      longitude: _pin!.longitude,
      addressText: _addressController.text.trim(),
      addressDetailPrivate: _addressDetailController.text.trim().isEmpty
          ? null
          : _addressDetailController.text.trim(),
    );

    try {
      final activity = await ref
          .read(createActivityControllerProvider.notifier)
          .submit(request);
      if (!mounted) return;
      showRootSnackBar(const SnackBar(content: Text('Etkinlik oluşturuldu!')));
      context.pushReplacement(RoutePaths.activityDetail(activity.id));
    } on ApiException catch (e) {
      if (mounted) showApiErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);
    final locationAsync = ref.watch(currentLocationProvider);
    final profileAsync = ref.watch(myProfileProvider);

    if (profileAsync.hasValue && profileAsync.value!.displayName.trim().isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _showProfileRequiredDialog();
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _goBack,
        ),
        title: const Text('Etkinlik Oluştur'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: _StepIndicator(step: _step),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: switch (_step) {
                1 => categoriesAsync.when(
                  data: (categories) => _CategoryStep(
                    categories: categories,
                    selectedId: _categoryId,
                    error: _categoryError,
                    onSelect: (id) => setState(() {
                      _categoryId = id;
                      _categoryError = null;
                    }),
                  ),
                  loading: () => const Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (err, _) => const Text('Kategoriler yüklenemedi.'),
                ),
                2 => _DetailsStep(
                  titleController: _titleController,
                  descriptionController: _descriptionController,
                  priceController: _priceController,
                  neededController: _neededController,
                  titleError: _titleError,
                  neededError: _neededError,
                  date: _date,
                  time: _time,
                  skillLevel: _skillLevel,
                  onDateChanged: (d) => setState(() => _date = d),
                  onTimeChanged: (t) => setState(() => _time = t),
                  onSkillLevelChanged: (s) => setState(() => _skillLevel = s),
                ),
                _ => locationAsync.when(
                  data: (location) {
                    _seedPinIfNeeded(
                      LatLng(location.latitude, location.longitude),
                    );
                    return _LocationStep(
                      initialCenter: LatLng(
                        location.latitude,
                        location.longitude,
                      ),
                      pin: _pin,
                      addressController: _addressController,
                      addressDetailController: _addressDetailController,
                      addressError: _addressError,
                      genderPreference: _genderPreference,
                      onPinSet: (p) => setState(() => _pin = p),
                      onGenderChanged: (g) =>
                          setState(() => _genderPreference = g),
                    );
                  },
                  loading: () => const Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (err, _) => const Text('Konum alınamadı.'),
                ),
              },
            ),
          ),
          _WizardFooter(
            step: _step,
            submitting: _submitting,
            onBack: _goBack,
            onNext: _goNext,
            onSubmit: _submit,
          ),
        ],
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.step});

  final int step;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 1; i <= 3; i++) ...[
          if (i > 1)
            Expanded(
              child: Container(
                height: 2,
                color: i <= step ? AppColors.accentBright : AppColors.border,
              ),
            ),
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: i <= step ? AppColors.accentBright : AppColors.border,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '$i',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: i <= step ? Colors.white : AppColors.mutedForeground,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _CategoryStep extends StatelessWidget {
  const _CategoryStep({
    required this.categories,
    required this.selectedId,
    required this.error,
    required this.onSelect,
  });

  final List<Category> categories;
  final String? selectedId;
  final String? error;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        const Text(
          'Etkinliğinizi hangi kategoriye ait?',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        const Text(
          'Etkinliğinizin temasını en iyi yansıtan kategoriyi seçin.',
          style: TextStyle(fontSize: 13, color: AppColors.mutedForeground),
        ),
        const SizedBox(height: 20),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.85,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final active = category.id == selectedId;
            final color = CategoryIcons.colorFor(
              category.name,
              override: category.color,
            );
            return InkWell(
              onTap: () => onSelect(category.id),
              borderRadius: BorderRadius.circular(AppRadius.lg),
              child: Container(
                decoration: BoxDecoration(
                  color: active ? AppColors.accentSoftBg : AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(
                    color: active ? AppColors.accentBright : AppColors.border,
                    width: active ? 1.5 : 1,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 6,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.16),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        CategoryIcons.iconFor(category.name),
                        size: 18,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      category.name,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        if (error != null) ...[
          const SizedBox(height: 12),
          Text(
            error!,
            style: const TextStyle(fontSize: 12, color: AppColors.destructive),
          ),
        ],
        const SizedBox(height: 24),
      ],
    );
  }
}

class _DetailsStep extends StatelessWidget {
  const _DetailsStep({
    required this.titleController,
    required this.descriptionController,
    required this.priceController,
    required this.neededController,
    required this.titleError,
    required this.neededError,
    required this.date,
    required this.time,
    required this.skillLevel,
    required this.onDateChanged,
    required this.onTimeChanged,
    required this.onSkillLevelChanged,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  final TextEditingController neededController;
  final String? titleError;
  final String? neededError;
  final DateTime date;
  final TimeOfDay time;
  final SkillLevel skillLevel;
  final ValueChanged<DateTime> onDateChanged;
  final ValueChanged<TimeOfDay> onTimeChanged;
  final ValueChanged<SkillLevel> onSkillLevelChanged;

  static const _skillLabels = {
    SkillLevel.any: 'Herkes',
    SkillLevel.beginner: 'Başlangıç',
    SkillLevel.intermediate: 'Orta',
    SkillLevel.advanced: 'İleri',
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FieldLabel('Etkinlik Başlığı'),
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Örn. Dağ Yürüyüşü'),
          ),
          if (titleError != null) _FieldError(titleError!),
          const SizedBox(height: 16),
          _FieldLabel('Açıklama (opsiyonel)'),
          TextField(
            controller: descriptionController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Etkinliğiniz hakkında bilgi verin...',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _FieldLabel('Tarih'),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.calendar_today, size: 15),
                      label: Text('${date.day}.${date.month}.${date.year}'),
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: date,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                        );
                        if (picked != null) onDateChanged(picked);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _FieldLabel('Saat'),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.access_time, size: 15),
                      label: Text(time.format(context)),
                      onPressed: () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: time,
                        );
                        if (picked != null) onTimeChanged(picked);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _FieldLabel('Kaç kişi katılabilir?'),
                    TextField(
                      controller: neededController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(),
                    ),
                    if (neededError != null) _FieldError(neededError!),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _FieldLabel('Kişi Başı Ücret'),
                    TextField(
                      controller: priceController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(hintText: '0 ₺'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _FieldLabel('Seviye'),
          DropdownButtonFormField<SkillLevel>(
            initialValue: skillLevel,
            items: [
              for (final level in SkillLevel.values)
                DropdownMenuItem(
                  value: level,
                  child: Text(_skillLabels[level]!),
                ),
            ],
            onChanged: (value) {
              if (value != null) onSkillLevelChanged(value);
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _LocationStep extends StatelessWidget {
  const _LocationStep({
    required this.initialCenter,
    required this.pin,
    required this.addressController,
    required this.addressDetailController,
    required this.addressError,
    required this.genderPreference,
    required this.onPinSet,
    required this.onGenderChanged,
  });

  final LatLng initialCenter;
  final LatLng? pin;
  final TextEditingController addressController;
  final TextEditingController addressDetailController;
  final String? addressError;
  final GenderPreference genderPreference;
  final ValueChanged<LatLng> onPinSet;
  final ValueChanged<GenderPreference> onGenderChanged;

  static const _genderLabels = {
    GenderPreference.any: 'Herkes',
    GenderPreference.male: 'Erkek',
    GenderPreference.female: 'Kadın',
    GenderPreference.mixed: 'Karışık',
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FieldLabel('Haritadan Seç'),
          SizedBox(
            height: 240,
            child: PinDropMap(
              initialCenter: initialCenter,
              pin: pin,
              onPinSet: onPinSet,
            ),
          ),
          if (pin != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'Konum belirlendi: ${pin!.latitude.toStringAsFixed(5)}, ${pin!.longitude.toStringAsFixed(5)}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.mutedForeground,
                ),
              ),
            ),
          const SizedBox(height: 16),
          _FieldLabel('Konum Adı'),
          TextField(
            controller: addressController,
            decoration: const InputDecoration(
              hintText: 'Örn. Çekmeköy Spor Kompleksi',
            ),
          ),
          if (addressError != null) _FieldError(addressError!),
          const SizedBox(height: 16),
          _FieldLabel('Gizli Adres Detayı (onaylı katılımcılara gösterilir)'),
          TextField(
            controller: addressDetailController,
            decoration: const InputDecoration(
              hintText: 'Kapı numarası, detaylı adres...',
            ),
          ),
          const SizedBox(height: 16),
          _FieldLabel('Kimler Katılabilir?'),
          DropdownButtonFormField<GenderPreference>(
            initialValue: genderPreference,
            items: [
              for (final g in GenderPreference.values)
                DropdownMenuItem(value: g, child: Text(_genderLabels[g]!)),
            ],
            onChanged: (value) {
              if (value != null) onGenderChanged(value);
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Color(0xFF374151),
        ),
      ),
    );
  }
}

class _FieldError extends StatelessWidget {
  const _FieldError(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, color: AppColors.destructive),
      ),
    );
  }
}

class _WizardFooter extends StatelessWidget {
  const _WizardFooter({
    required this.step,
    required this.submitting,
    required this.onBack,
    required this.onNext,
    required this.onSubmit,
  });

  final int step;
  final bool submitting;
  final VoidCallback onBack;
  final VoidCallback onNext;
  final VoidCallback onSubmit;

  static const _helper = [
    'Devam etmek için kategori seçin.',
    'Devam etmek için başlık ve tarih girin.',
    'Konum seçip etkinliği oluşturun.',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          color: Color(0xFFFAFBFD),
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Adım $step / 3',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    _helper[step - 1],
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: onBack,
              child: Text(step == 1 ? 'İptal' : 'Geri'),
            ),
            const SizedBox(width: 8),
            if (step < 3)
              ElevatedButton(onPressed: onNext, child: const Text('Devam Et'))
            else
              ElevatedButton(
                onPressed: submitting ? null : onSubmit,
                child: Text(
                  submitting ? 'Oluşturuluyor...' : 'Etkinliği Oluştur',
                ),
              ),
          ],
        ),
      ),
    );
  }
}

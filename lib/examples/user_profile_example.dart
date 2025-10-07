import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tribbe/controllers/user_profile_notifier.dart';
import 'package:tribbe/controllers/theme_notifier.dart';
import 'package:tribbe/controllers/language_notifier.dart';
import 'package:tribbe/controllers/gender_notifier.dart';
import 'package:tribbe/models/user_profile_model.dart';
import 'package:tribbe/models/personal_data_model.dart';
import 'package:tribbe/models/location_model.dart';
import 'package:tribbe/models/preferences_model.dart';
import 'package:tribbe/models/units_model.dart';
import 'package:tribbe/models/information_model.dart';
import 'package:tribbe/models/character_model.dart';
import 'package:tribbe/models/measurements_model.dart';
import 'package:tribbe/models/specific_measurements_model.dart';

/// Ejemplo de uso del sistema de perfil de usuario con Riverpod
class UserProfileExample extends ConsumerWidget {
  const UserProfileExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Acceder a los estados
    final userProfileState = ref.watch(userProfileNotifierProvider);
    final themeState = ref.watch(themeNotifierProvider);
    final languageState = ref.watch(languageNotifierProvider);
    final genderState = ref.watch(genderNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejemplo de Perfil de Usuario'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => _saveExampleProfile(ref),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteProfile(ref),
          ),
        ],
      ),
      body: userProfileState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection('Tema', themeState.themeModeName),
                  _buildSection('Idioma', languageState.languageName),
                  _buildSection('Género', genderState.gender),
                  const Divider(),
                  if (userProfileState.hasProfile) ...[
                    _buildProfileInfo(userProfileState.profile!),
                  ] else ...[
                    const Center(child: Text('No hay perfil guardado')),
                  ],
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _changeTheme(ref),
        child: const Icon(Icons.brightness_6),
      ),
    );
  }

  Widget _buildSection(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildProfileInfo(UserProfileModel profile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Datos Personales',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text('Nombre: ${profile.datosPersonales.nombreCompleto}'),
        Text('Usuario: ${profile.datosPersonales.nombreUsuario}'),
        Text('Email: ${profile.datosPersonales.email}'),
        Text('Fecha de Nacimiento: ${profile.datosPersonales.fechaNacimiento}'),
        Text(
          'Ubicación: ${profile.datosPersonales.ubicacion.ciudad}, '
          '${profile.datosPersonales.ubicacion.provincia}, '
          '${profile.datosPersonales.ubicacion.pais}',
        ),
        const Divider(),
        const Text(
          'Preferencias',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text('Tema: ${profile.preferencias.tema}'),
        Text('Idioma: ${profile.preferencias.idioma}'),
        Text(
          'Unidades: ${profile.preferencias.unidades.medida} / '
          '${profile.preferencias.unidades.peso}',
        ),
        if (profile.informacion != null) ...[
          const Divider(),
          const Text(
            'Información Fitness',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text('Propósito: ${profile.informacion!.proposito}'),
          Text('Meta: ${profile.informacion!.metaFitness}'),
          Text('Nivel: ${profile.informacion!.nivelExperiencia}'),
          Text(
            'Condición Física: ${profile.informacion!.condicionFisicaActual}%',
          ),
          if (profile.informacion!.lesiones.isNotEmpty)
            Text('Lesiones: ${profile.informacion!.lesiones.join(", ")}'),
        ],
        if (profile.personaje != null) ...[
          const Divider(),
          const Text(
            'Personaje',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text('Género: ${profile.personaje!.genero}'),
          Text('Tono de Piel: ${profile.personaje!.tonoPiel}'),
          if (profile.personaje!.avatarUrl != null)
            Text('Avatar: ${profile.personaje!.avatarUrl}'),
        ],
        if (profile.medidas != null) ...[
          const Divider(),
          const Text(
            'Medidas',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text('Altura: ${profile.medidas!.alturaCm} cm'),
          Text('Peso: ${profile.medidas!.pesoKg} kg'),
          Text('Grasa Corporal: ${profile.medidas!.porcentajeGrasaCorporal}%'),
        ],
      ],
    );
  }

  void _saveExampleProfile(WidgetRef ref) {
    // Crear un perfil de ejemplo
    final exampleProfile = UserProfileModel(
      datosPersonales: PersonalDataModel(
        nombreCompleto: 'Juan Pérez',
        nombreUsuario: 'juanp',
        email: 'juan.perez@email.com',
        fechaNacimiento: '15/05/1990',
        ubicacion: LocationModel(
          pais: 'Ecuador',
          provincia: 'Imbabura',
          ciudad: 'Ibarra',
        ),
      ),
      preferencias: PreferencesModel(
        tema: 'Día',
        unidades: UnitsModel(medida: 'cm', peso: 'kg'),
        idioma: 'Español',
      ),
      informacion: InformationModel(
        proposito:
            'Mejorar mi condición física general y ganar fuerza para sentirme mejor en mi día a día.',
        metaFitness: 'Masa muscular',
        lesiones: ['Hombros', 'Rodillas'],
        nivelExperiencia: 'Intermedio',
        condicionFisicaActual: 75,
      ),
      personaje: CharacterModel(
        genero: 'Masculino',
        tonoPiel: '#ffcc99',
        avatarUrl: 'https://example.com/path/to/avatar.png',
      ),
      medidas: MeasurementsModel(
        alturaCm: 180,
        pesoKg: 85,
        porcentajeGrasaCorporal: 15,
        medidasEspecificasCm: SpecificMeasurementsModel(
          cuello: 40,
          hombro: 125,
          brazoIzquierdo: 38,
          brazoDerecho: 38.5,
          antebrazoIzquierdo: 30,
          antebrazoDerecho: 30.5,
          pecho: 105,
          espalda: 102,
          cintura: 88,
          cuadricepIzquierdo: 60,
          cuadricepDerecho: 61,
          pantorrillaIzquierda: 40,
          pantorrillaDerecha: 40.5,
        ),
      ),
    );

    // Guardar el perfil
    ref.read(userProfileNotifierProvider.notifier).saveProfile(exampleProfile);
  }

  void _deleteProfile(WidgetRef ref) {
    ref.read(userProfileNotifierProvider.notifier).deleteProfile();
  }

  void _changeTheme(WidgetRef ref) {
    ref.read(themeNotifierProvider.notifier).toggleTheme();
  }
}

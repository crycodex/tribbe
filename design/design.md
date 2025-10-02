
# 📱 Diseño del Sistema - Tribbe App

## 📌 Información del Proyecto
- **Nombre:** Tribbe App  
- **Tecnologías:** Flutter (Dart), Firebase, PostgreSQL, Redis  
- **Fecha:** 1 de Octubre, 2025  
- **Arquitectura:** Aplicación móvil nativa con backend escalable  
- **Plataforma:** iOS/Android (Multiplataforma)  

---

## 1. ⚙️ Enfoque de Implementación

### 🔎 Análisis de Puntos Críticos
- **Tiempo Real:** Competencias y estadísticas requieren actualizaciones inmediatas  
- **Escalabilidad Social:** Manejo de usuarios, gimnasios y estadísticas  
- **Performance Móvil:** Experiencia fluida incluso con conexiones variables  
- **Integridad de Datos:** Garantizar estadísticas justas y verificables  
- **Competencia Local:** Rankings y comparaciones en tiempo real  
- **Simplicidad:** Interfaz minimalista sin fricciones  

### 🛠️ Stack Tecnológico

#### Frontend (Flutter)
- **Framework:** Flutter 3.16+ (Dart 3.2+)
- **State Management:** Riverpod + Freezed
- **Navegación:** AutoRoute
- **UI Components:** Material Design 3 + Custom Components
- **Animaciones:** Lottie + Custom Animations
- **Formularios:** Reactive Forms + Validación
- **Networking:** Dio + Retrofit
- **Local Storage:** Hive + SharedPreferences
- **Dependency Injection:** GetIt


#### Infraestructura
- **Cloud Provider:** Google Cloud Platform 
- **CDN:** CloudFlare
- **Monitoring:** Sentry + Firebase Crashlytics
- **CI/CD:** GitHub Actions
- **Containerización:** Docker + Kubernetes

---

## 2. 🗄️ Arquitectura de Base de Datos

### 📋 Modelo de Datos (PostgreSQL)

#### Entidades Principales

```sql
-- Usuarios
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    photo_url TEXT,
    gym_id UUID REFERENCES gyms(id),
    weight DECIMAL(5,2), -- kg
    height DECIMAL(5,2), -- cm
    date_of_birth DATE,
    is_premium BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Gimnasios
CREATE TABLE gyms (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    location VARCHAR(255) NOT NULL,
    qr_code VARCHAR(255) UNIQUE NOT NULL,
    admin_id UUID REFERENCES users(id),
    is_verified BOOLEAN DEFAULT FALSE,
    member_count INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Ejercicios
CREATE TABLE exercises (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL, -- 'compound', 'isolation'
    muscle_groups TEXT[] NOT NULL, -- ['chest', 'shoulders', 'triceps']
    is_compound BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Entrenamientos
CREATE TABLE workouts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) NOT NULL,
    gym_id UUID REFERENCES gyms(id),
    date DATE NOT NULL,
    duration_minutes INTEGER,
    notes TEXT,
    is_public BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Sets de ejercicios
CREATE TABLE workout_sets (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    workout_id UUID REFERENCES workouts(id) ON DELETE CASCADE,
    exercise_id UUID REFERENCES exercises(id) NOT NULL,
    weight DECIMAL(6,2) NOT NULL, -- kg
    reps INTEGER NOT NULL,
    rpe INTEGER CHECK (rpe >= 1 AND rpe <= 10), -- Rate of Perceived Exertion
    rest_time_seconds INTEGER,
    set_order INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Récords personales
CREATE TABLE personal_records (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) NOT NULL,
    exercise_id UUID REFERENCES exercises(id) NOT NULL,
    max_weight DECIMAL(6,2) NOT NULL,
    reps INTEGER NOT NULL,
    one_rm DECIMAL(6,2) NOT NULL, -- Calculado
    achieved_date DATE NOT NULL,
    workout_id UUID REFERENCES workouts(id),
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(user_id, exercise_id, achieved_date)
);

-- Sistema de amigos
CREATE TABLE friendships (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) NOT NULL,
    friend_id UUID REFERENCES users(id) NOT NULL,
    status VARCHAR(20) DEFAULT 'pending', -- 'pending', 'accepted', 'blocked'
    created_at TIMESTAMP DEFAULT NOW(),
    accepted_at TIMESTAMP,
    UNIQUE(user_id, friend_id)
);

-- Feed de actividad
CREATE TABLE activity_feed (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) NOT NULL,
    type VARCHAR(50) NOT NULL, -- 'workout', 'pr', 'competition'
    title VARCHAR(255) NOT NULL,
    description TEXT,
    data JSONB, -- Datos específicos del tipo de actividad
    is_public BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Competencias
CREATE TABLE competitions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    gym_id UUID REFERENCES gyms(id) NOT NULL,
    exercise_id UUID REFERENCES exercises(id) NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_by UUID REFERENCES users(id) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Participantes de competencias
CREATE TABLE competition_participants (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    competition_id UUID REFERENCES competitions(id) ON DELETE CASCADE,
    user_id UUID REFERENCES users(id) NOT NULL,
    best_weight DECIMAL(6,2) NOT NULL,
    best_reps INTEGER NOT NULL,
    one_rm DECIMAL(6,2) NOT NULL,
    rank_position INTEGER,
    joined_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(competition_id, user_id)
);

-- Rankings (tabla materializada para performance)
CREATE TABLE gym_rankings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    gym_id UUID REFERENCES gyms(id) NOT NULL,
    exercise_id UUID REFERENCES exercises(id) NOT NULL,
    user_id UUID REFERENCES users(id) NOT NULL,
    max_weight DECIMAL(6,2) NOT NULL,
    one_rm DECIMAL(6,2) NOT NULL,
    rank_position INTEGER NOT NULL,
    last_updated TIMESTAMP DEFAULT NOW()
);
```

### 🔐 Políticas de Seguridad

#### Row Level Security (RLS)
```sql
-- Usuarios solo pueden ver su propio perfil
CREATE POLICY "Users can view own profile" ON users
    FOR SELECT USING (auth.uid() = id);

-- Usuarios pueden ver perfiles de su gimnasio
CREATE POLICY "Users can view gym members" ON users
    FOR SELECT USING (
        gym_id IN (
            SELECT gym_id FROM users WHERE id = auth.uid()
        )
    );

-- Entrenamientos visibles entre amigos
CREATE POLICY "Friends can view workouts" ON workouts
    FOR SELECT USING (
        user_id = auth.uid() OR
        user_id IN (
            SELECT friend_id FROM friendships 
            WHERE user_id = auth.uid() AND status = 'accepted'
        )
    );

-- Rankings visibles para miembros del gimnasio
CREATE POLICY "Gym members can view rankings" ON gym_rankings
    FOR SELECT USING (
        gym_id IN (
            SELECT gym_id FROM users WHERE id = auth.uid()
        )
    );
```

### 📊 Índices para Performance

```sql
-- Índices para consultas frecuentes
CREATE INDEX idx_workouts_user_date ON workouts(user_id, date DESC);
CREATE INDEX idx_workout_sets_workout ON workout_sets(workout_id);
CREATE INDEX idx_personal_records_user_exercise ON personal_records(user_id, exercise_id);
CREATE INDEX idx_friendships_user_status ON friendships(user_id, status);
CREATE INDEX idx_activity_feed_user_created ON activity_feed(user_id, created_at DESC);
CREATE INDEX idx_gym_rankings_gym_exercise ON gym_rankings(gym_id, exercise_id, rank_position);
```

### 🔄 Cache Strategy (Redis)

```dart
// Configuración de cache
class CacheConfig {
  static const Duration userProfile = Duration(minutes: 5);
  static const Duration gymRankings = Duration(minutes: 10);
  static const Duration exerciseList = Duration(hours: 1);
  static const Duration friendList = Duration(minutes: 15);
  static const Duration workoutHistory = Duration(minutes: 5);
}
```

---

## 3. 🏗️ Arquitectura de Flutter

### 📂 Estructura de Directorios

```
lib/
├── main.dart
├── app/
│   ├── app.dart
│   ├── routes/
│   │   ├── app_router.dart
│   │   └── route_paths.dart
│   └── theme/
│       ├── app_theme.dart
│       ├── colors.dart
│       └── text_styles.dart
├── core/
│   ├── constants/
│   ├── errors/
│   ├── network/
│   ├── utils/
│   └── extensions/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── pages/
│   │       ├── widgets/
│   │       └── controllers/
│   ├── workout/
│   ├── social/
│   ├── gym/
│   └── profile/
├── shared/
│   ├── widgets/
│   ├── services/
│   └── utils/
└── generated/
    ├── routes/
    └── l10n/
```

### 🧩 Arquitectura de Componentes

#### Clean Architecture + Feature-First
```dart
// Ejemplo de estructura de feature
feature/
├── data/
│   ├── datasources/
│   │   ├── auth_remote_datasource.dart
│   │   └── auth_local_datasource.dart
│   ├── models/
│   │   └── user_model.dart
│   └── repositories/
│       └── auth_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── user.dart
│   ├── repositories/
│   │   └── auth_repository.dart
│   └── usecases/
│       ├── login_usecase.dart
│       └── register_usecase.dart
└── presentation/
    ├── pages/
    │   ├── login_page.dart
    │   └── register_page.dart
    ├── widgets/
    │   ├── login_form.dart
    │   └── auth_button.dart
    └── controllers/
        └── auth_controller.dart
```

### 🎯 Componentes Principales

#### Layout Components
```dart
// AppLayout - Layout principal de la app
class AppLayout extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: AutoRouter(),
      bottomNavigationBar: BottomNavigationBar(),
    );
  }
}

// BottomNavigation - Navegación inferior
class BottomNavigationBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Gym'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Amigos'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
      ],
    );
  }
}
```

#### Workout Components
```dart
// WorkoutSession - Sesión de entrenamiento activa
class WorkoutSession extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutController = ref.watch(workoutControllerProvider);
    
    return Scaffold(
      appBar: AppBar(title: Text('Entrenamiento')),
      body: Column(
        children: [
          ExerciseList(),
          SetInput(),
          PRComparison(),
        ],
      ),
      floatingActionButton: CompleteSetButton(),
    );
  }
}

// ExerciseSet - Input para registrar sets
class ExerciseSet extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ExerciseSelector(),
            WeightInput(),
            RepsInput(),
            RPEInput(),
            SaveSetButton(),
          ],
        ),
      ),
    );
  }
}
```

#### Social Components
```dart
// ActivityFeed - Feed de actividad social
class ActivityFeed extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedController = ref.watch(activityFeedControllerProvider);
    
    return RefreshIndicator(
      onRefresh: () => ref.refresh(activityFeedControllerProvider.future),
      child: ListView.builder(
        itemCount: feedController.activities.length,
        itemBuilder: (context, index) {
          final activity = feedController.activities[index];
          return ActivityCard(activity: activity);
        },
      ),
    );
  }
}

// GymLeaderboard - Rankings del gimnasio
class GymLeaderboard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaderboardController = ref.watch(gymLeaderboardControllerProvider);
    
    return Column(
      children: [
        ExerciseFilter(),
        ListView.builder(
          shrinkWrap: true,
          itemCount: leaderboardController.rankings.length,
          itemBuilder: (context, index) {
            final ranking = leaderboardController.rankings[index];
            return RankingCard(ranking: ranking, position: index + 1);
          },
        ),
      ],
    );
  }
}
```

### 🔄 State Management (Riverpod)

#### Providers
```dart
// Auth Controller
final authControllerProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(ref.read(authRepositoryProvider));
});

// Workout Controller
final workoutControllerProvider = StateNotifierProvider<WorkoutController, WorkoutState>((ref) {
  return WorkoutController(ref.read(workoutRepositoryProvider));
});

// Social Controller
final activityFeedControllerProvider = FutureProvider<List<Activity>>((ref) async {
  return ref.read(socialRepositoryProvider).getActivityFeed();
});
```

#### State Classes (Freezed)
```dart
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.error(String message) = _Error;
}

@freezed
class WorkoutState with _$WorkoutState {
  const factory WorkoutState.initial() = _Initial;
  const factory WorkoutState.active(Workout workout) = _Active;
  const factory WorkoutState.completed(Workout workout) = _Completed;
  const factory WorkoutState.error(String message) = _Error;
}
```

---

## 4. 🛣️ Sistema de Rutas y Navegación

### 🌐 Rutas (AutoRoute)

```dart
@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    // Auth Routes
    AutoRoute(
      page: LoginRoute.page,
      path: '/login',
      initial: true,
    ),
    AutoRoute(
      page: RegisterRoute.page,
      path: '/register',
    ),
    AutoRoute(
      page: ForgotPasswordRoute.page,
      path: '/forgot-password',
    ),
    
    // Main App Routes
    AutoRoute(
      page: MainRoute.page,
      path: '/main',
      children: [
        AutoRoute(
          page: HomeRoute.page,
          path: '/home',
        ),
        AutoRoute(
          page: WorkoutRoute.page,
          path: '/workout',
        ),
        AutoRoute(
          page: GymRoute.page,
          path: '/gym',
        ),
        AutoRoute(
          page: FriendsRoute.page,
          path: '/friends',
        ),
        AutoRoute(
          page: ProfileRoute.page,
          path: '/profile',
        ),
      ],
    ),
    
    // Workout Routes
    AutoRoute(
      page: WorkoutSessionRoute.page,
      path: '/workout/session',
    ),
    AutoRoute(
      page: WorkoutHistoryRoute.page,
      path: '/workout/history',
    ),
    
    // Social Routes
    AutoRoute(
      page: ActivityFeedRoute.page,
      path: '/feed',
    ),
    AutoRoute(
      page: LeaderboardRoute.page,
      path: '/leaderboard',
    ),
    AutoRoute(
      page: CompetitionRoute.page,
      path: '/competition/:id',
    ),
  ];
}
```

### 🔑 Middleware de Autenticación

```dart
class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final authState = ref.read(authControllerProvider);
    
    if (authState is Authenticated) {
      resolver.next();
    } else {
      router.pushAndClearStack(LoginRoute());
    }
  }
}

// Aplicar guard a rutas protegidas
AutoRoute(
  page: MainRoute.page,
  path: '/main',
  guards: [AuthGuard],
  children: [...],
)
```

---

## 5. 🔄 Arquitectura de Funcionalidades en Tiempo Real

### 📡 WebSockets + Server-Sent Events

```dart
// WebSocket Service
class RealtimeService {
  late WebSocketChannel _channel;
  
  Stream<Map<String, dynamic>> connectToGymActivity(String gymId) {
    _channel = WebSocketChannel.connect(
      Uri.parse('wss://api.tribbe.com/gym/$gymId/activity'),
    );
    
    return _channel.stream.map((data) => jsonDecode(data));
  }
  
  Stream<Map<String, dynamic>> connectToCompetition(String competitionId) {
    _channel = WebSocketChannel.connect(
      Uri.parse('wss://api.tribbe.com/competition/$competitionId'),
    );
    
    return _channel.stream.map((data) => jsonDecode(data));
  }
}

// Realtime Hooks
class RealtimeHooks {
  static Stream<List<Activity>> useGymActivity(String gymId) {
    return RealtimeService().connectToGymActivity(gymId)
        .map((data) => Activity.fromJsonList(data['activities']));
  }
  
  static Stream<List<Ranking>> useCompetitionRankings(String competitionId) {
    return RealtimeService().connectToCompetition(competitionId)
        .map((data) => Ranking.fromJsonList(data['rankings']));
  }
}
```

### 🪝 Providers Realtime

```dart
// Gym Activity Provider
final gymActivityProvider = StreamProvider.family<List<Activity>, String>((ref, gymId) {
  return RealtimeHooks.useGymActivity(gymId);
});

// Competition Rankings Provider
final competitionRankingsProvider = StreamProvider.family<List<Ranking>, String>((ref, competitionId) {
  return RealtimeHooks.useCompetitionRankings(competitionId);
});

// Friend Activity Provider
final friendActivityProvider = StreamProvider<List<Activity>>((ref) {
  final user = ref.watch(authControllerProvider).user;
  return RealtimeHooks.useFriendActivity(user.id);
});
```

---

## 6. 🗂️ Gestión de Estado y Cache

### 🗃️ Riverpod + Cache Strategy

```dart
// Cache Configuration
class CacheConfig {
  static const Duration short = Duration(minutes: 5);
  static const Duration medium = Duration(minutes: 15);
  static const Duration long = Duration(hours: 1);
}

// Cached Providers
final userProfileProvider = FutureProvider.family<User, String>((ref, userId) async {
  return ref.watch(authRepositoryProvider).getUserProfile(userId);
}).cacheFor(CacheConfig.medium);

final gymRankingsProvider = FutureProvider.family<List<Ranking>, String>((ref, gymId) async {
  return ref.watch(gymRepositoryProvider).getRankings(gymId);
}).cacheFor(CacheConfig.short);

final exerciseListProvider = FutureProvider<List<Exercise>>((ref) async {
  return ref.watch(exerciseRepositoryProvider).getAllExercises();
}).cacheFor(CacheConfig.long);
```

### 🔄 State Notifiers

```dart
// Auth State Notifier
class AuthController extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  
  AuthController(this._authRepository) : super(const AuthState.initial());
  
  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    
    try {
      final user = await _authRepository.login(email, password);
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
  
  Future<void> logout() async {
    await _authRepository.logout();
    state = const AuthState.unauthenticated();
  }
}

// Workout State Notifier
class WorkoutController extends StateNotifier<WorkoutState> {
  final WorkoutRepository _workoutRepository;
  
  WorkoutController(this._workoutRepository) : super(const WorkoutState.initial());
  
  Future<void> startWorkout() async {
    final workout = Workout(
      id: Uuid().v4(),
      userId: _getCurrentUserId(),
      date: DateTime.now(),
      sets: [],
    );
    
    state = WorkoutState.active(workout);
  }
  
  Future<void> addSet(WorkoutSet set) async {
    if (state is _Active) {
      final currentWorkout = (state as _Active).workout;
      final updatedWorkout = currentWorkout.copyWith(
        sets: [...currentWorkout.sets, set],
      );
      
      state = WorkoutState.active(updatedWorkout);
      await _workoutRepository.saveSet(set);
    }
  }
}
```

---

## 7. 🚀 Optimización de Performance

### 📱 Flutter Performance

```dart
// Lazy Loading de Listas
class OptimizedListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return LazyLoadWidget(
          child: ListItemWidget(item: items[index]),
        );
      },
    );
  }
}

// Memoización de Widgets Pesados
class MemoizedWorkoutCard extends StatelessWidget {
  final Workout workout;
  
  const MemoizedWorkoutCard({Key? key, required this.workout}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MemoizedWidget(
      key: ValueKey(workout.id),
      child: WorkoutCard(workout: workout),
    );
  }
}

// Image Caching
class CachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 200,
          color: Colors.white,
        ),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
```

### 🔄 Cache Strategy

```dart
// HTTP Cache Interceptor
class CacheInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Agregar headers de cache
    options.headers['Cache-Control'] = 'max-age=300'; // 5 minutos
    handler.next(options);
  }
}

// Local Storage Cache
class LocalCacheService {
  static const String _cacheKey = 'tribbe_cache';
  
  Future<void> cacheData(String key, dynamic data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('$_cacheKey$key', jsonEncode(data));
  }
  
  Future<T?> getCachedData<T>(String key, T Function(Map<String, dynamic>) fromJson) async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString('$_cacheKey$key');
    
    if (cached != null) {
      return fromJson(jsonDecode(cached));
    }
    
    return null;
  }
}
```

---

## 8. 🎨 Diseño UI/UX

### 🎯 Principios de Diseño

```dart
// Color Scheme
class AppColors {
  static const Color primary = Color(0xFF6366F1); // Indigo
  static const Color secondary = Color(0xFF10B981); // Emerald
  static const Color accent = Color(0xFFF59E0B); // Amber
  static const Color error = Color(0xFFEF4444); // Red
  static const Color success = Color(0xFF10B981); // Emerald
  static const Color warning = Color(0xFFF59E0B); // Amber
  
  // Neutral Colors
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF1E293B);
  static const Color onSurfaceVariant = Color(0xFF64748B);
}

// Typography
class AppTextStyles {
  static const TextStyle headline1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.onSurface,
  );
  
  static const TextStyle headline2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.onSurface,
  );
  
  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.onSurface,
  );
  
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.onSurfaceVariant,
  );
}
```

### 📱 Componentes UI Reutilizables

```dart
// Custom Button
class TribbeButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final TribbeButtonStyle style;
  
  const TribbeButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.style = TribbeButtonStyle.primary,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: _getButtonStyle(style),
      child: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(text),
    );
  }
}

// PR Comparison Card
class PRComparisonCard extends StatelessWidget {
  final PersonalRecord currentPR;
  final PersonalRecord? previousPR;
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Récord Personal', style: AppTextStyles.headline2),
            SizedBox(height: 8),
            Text('${currentPR.weight}kg x ${currentPR.reps} reps'),
            if (previousPR != null) ...[
              SizedBox(height: 4),
              Text(
                'Anterior: ${previousPR!.weight}kg x ${previousPR!.reps} reps',
                style: AppTextStyles.caption,
              ),
              SizedBox(height: 8),
              _buildImprovementIndicator(),
            ],
          ],
        ),
      ),
    );
  }
}
```

---

## 9. 🔧 Configuración y Deployment

### 🐳 Docker Configuration

```dockerfile
# Dockerfile
FROM dart:3.2 AS build

WORKDIR /app
COPY pubspec.* ./
RUN dart pub get

COPY . .
RUN dart pub run build_runner build
RUN dart compile exe bin/main.dart -o tribbe

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y ca-certificates
COPY --from=build /app/tribbe /usr/local/bin/

EXPOSE 8080
CMD ["tribbe"]
```

### 🚀 CI/CD Pipeline

```yaml
# .github/workflows/deploy.yml
name: Deploy Tribbe App

on:
  push:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
      - run: flutter pub get
      - run: flutter test
      - run: flutter build apk --release

  deploy:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Deploy to Google Cloud
        run: |
          gcloud app deploy app.yaml
```

---

## 10. 📊 Monitoreo y Analytics

### 📈 Métricas de Performance

```dart
// Performance Monitoring
class PerformanceService {
  static void trackPageView(String pageName) {
    FirebaseAnalytics.instance.logScreenView(screenName: pageName);
  }
  
  static void trackUserAction(String action, Map<String, dynamic> parameters) {
    FirebaseAnalytics.instance.logEvent(
      name: action,
      parameters: parameters,
    );
  }
  
  static void trackWorkoutCompletion(Workout workout) {
    trackUserAction('workout_completed', {
      'duration_minutes': workout.durationMinutes,
      'sets_count': workout.sets.length,
      'exercises_count': workout.exercises.length,
    });
  }
}

// Error Tracking
class ErrorService {
  static void reportError(dynamic error, StackTrace stackTrace) {
    Sentry.captureException(error, stackTrace: stackTrace);
  }
  
  static void reportFlutterError(FlutterErrorDetails details) {
    Sentry.captureException(
      details.exception,
      stackTrace: details.stack,
    );
  }
}
```

---

## 11. ❓ Decisiones Técnicas Pendientes

### 🔍 Validación de Gimnasios
- **Opción A:** Códigos QR únicos + verificación manual
- **Opción B:** Geolocalización + radio de proximidad
- **Recomendación:** Combinación A + B para mayor seguridad

### 🛡️ Prevención de Datos Falsos
- **Sistema de reportes:** Usuarios pueden reportar estadísticas sospechosas
- **Límites razonables:** Validación automática basada en peso corporal
- **Verificación manual:** Administradores revisan casos reportados

### 📱 Escalabilidad
- **Paginación:** Implementar paginación en listas largas
- **Filtros:** Filtros por fecha, ejercicio, usuario
- **Subgrupos:** Agrupación por nivel de experiencia

### 💰 Monetización
- **Freemium:** Funciones básicas gratis, premium $4.99/mes
- **Límites:** 5 amigos, 1 gimnasio, historial limitado
- **Premium:** Amigos ilimitados, múltiples gimnasios, estadísticas avanzadas

---

## 12. 📅 Plan de Implementación

### 🎯 Fase 1: MVP (Mes 1-2)
- [ ] Setup del proyecto Flutter
- [ ] Autenticación básica (email/password)
- [ ] Perfil de usuario básico
- [ ] Catálogo de ejercicios (20 ejercicios principales)
- [ ] Registro de entrenamientos
- [ ] Historial básico
- [ ] UI/UX básica

### 🎯 Fase 2: Social (Mes 3-4)
- [ ] Sistema de amigos básico
- [ ] Feed de actividad
- [ ] Compartir entrenamientos
- [ ] Rankings básicos
- [ ] Notificaciones push

### 🎯 Fase 3: Competencias (Mes 5-6)
- [ ] Sistema de gimnasios con QR
- [ ] Rankings avanzados por gimnasio
- [ ] Competencias temporales
- [ ] Sistema de logros y badges
- [ ] Comparación de estadísticas entre amigos

### 🎯 Fase 4: Optimización (Mes 7-8)
- [ ] Modo offline
- [ ] Estadísticas avanzadas
- [ ] Integración con redes sociales
- [ ] Sistema de monetización (freemium)
- [ ] Analytics avanzados

---

✅ **Tribbe App** está diseñada para ser **escalable, social y competitiva**, con foco en **experiencia móvil nativa** y **funcionalidades en tiempo real** usando **Flutter** y **arquitectura limpia**. 🏋️‍♂️💪

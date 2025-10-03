
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
- **Networking:** Dio
- **Local Storage:** SharedPreferences
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

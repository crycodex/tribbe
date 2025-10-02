# PRD - Tribbe App 
**Aplicación Social para Gym**

---

## 📌 Información del Proyecto
- **Idioma:** Español  
- **Lenguaje de Programación:** Dart, Flutter 
- **Plataforma:** Móvil (iOS/Android)  
- **Equipo:** Product Manager, Desarrollador Flutter, Diseñador UX/UI  

---

## 📋 Resumen Ejecutivo

Tribbe es una aplicación social minimalista diseñada específicamente para la comunidad *gym bro*, combinando el seguimiento de entrenamientos con funciones sociales locales basadas en gimnasios. La app se posiciona como la primera plataforma que une la simplicidad de Strong con las funciones sociales de Strava, enfocándose exclusivamente en levantamiento de pesas y competencia local.

**Propuesta de Valor Única:** Simplicidad extrema + Social local (gimnasio) + Gamificación competitiva

---

## 🎯 1. Definición del Producto

### 1.1 Visión del Producto
"Ser la plataforma social líder para la comunidad gym bro, donde la competencia sana y el progreso personal se unen en una experiencia minimalista y motivadora."

### 1.2 Misión
Conectar y motivar a la comunidad fitness a través de una plataforma social simple que facilite el seguimiento de entrenamientos, la competencia sana entre amigos del gimnasio y el crecimiento personal.

### 1.3 Objetivos del Producto

#### Objetivos Primarios
- **Crear una comunidad fitness minimalista:** Plataforma social enfocada en la cultura *gym bro*, eliminando funcionalidades innecesarias
- **Facilitar la competencia sana entre usuarios:** Comparación de estadísticas para motivar a mejorar marcas personales
- **Conectar gym bros localmente:** Red social basada en gimnasio y objetivos de entrenamiento similares

#### Objetivos Secundarios
- Establecer presencia en 50+ gimnasios principales de la ciudad
- Alcanzar 10,000 usuarios activos mensuales
- Generar engagement diario del 40%+

### 1.4 Personas y Segmentos de Usuario

#### Persona Principal: "El Gym Bro Competitivo"
- **Edad:** 18-35 años
- **Género:** 70% masculino, 30% femenino
- **Experiencia:** 1-5 años en el gym
- **Motivación:** Competencia, progreso personal, comunidad
- **Pain Points:** Apps complejas, falta de competencia local, tracking manual

#### Persona Secundaria: "El Gym Bro Principiante"
- **Edad:** 16-25 años
- **Experiencia:** 0-1 año en el gym
- **Motivación:** Aprender, progresar, pertenecer a la comunidad
- **Pain Points:** Intimidación, falta de conocimiento, motivación

### 1.5 Historias de Usuario

#### Epic 1: Registro y Perfil
- **US-001:** Como gym bro principiante, quiero crear un perfil básico con mi información y gimnasio para conectar con otros usuarios
- **US-002:** Como usuario, quiero personalizar mi perfil con mi foto, objetivos y estadísticas principales para mostrar mi progreso

#### Epic 2: Seguimiento de Entrenamientos
- **US-003:** Como gym bro principiante, quiero registrar mis ejercicios de forma rápida y ver mi progreso visual para mantenerme motivado
- **US-004:** Como usuario activo, quiero un registro simple de entrenamientos sin funciones de nutrición o cardio para enfocarme en fuerza

#### Epic 3: Competencia Social
- **US-005:** Como gym bro experimentado, quiero competir con mis amigos del gimnasio comparando nuestras marcas para motivarme
- **US-006:** Como gym bro competitivo, quiero ver rankings de mi gimnasio para saber quién levanta más peso en cada ejercicio

#### Epic 4: Comunidad Local
- **US-007:** Como miembro de gimnasio, quiero conectar con otros usuarios de mi gym para formar grupos y compartir consejos
- **US-008:** Como usuario, quiero buscar y agregar amigos por gimnasio para expandir mi red social fitness

### 1.6 Análisis Competitivo

#### Competidores Directos
1. **Hevy**
   - ✅ Pros: Interfaz limpia, buen tracking, funciones sociales básicas
   - ❌ Contras: Funciones sociales limitadas, no enfocado en competencia local
   - **Puntuación:** 7/10

2. **Strong (iOS)**  
   - ✅ Pros: Interfaz minimalista, fácil seguimiento, enfoque en fuerza
   - ❌ Contras: Solo iOS, funciones sociales limitadas, no hay competencia
   - **Puntuación:** 6/10

3. **Jefit**
   - ✅ Pros: Base extensa de ejercicios, seguimiento detallado, comunidad grande
   - ❌ Contras: Interfaz sobrecargada, funciones innecesarias, no local
   - **Puntuación:** 5/10

#### Competidores Indirectos
- **Strava:** Excelente comunidad pero enfocado en cardio
- **MyFitnessPal:** Gran base de usuarios pero enfocado en nutrición
- **FitNotes:** Muy simple pero sin funciones sociales

#### Matriz de Posicionamiento
| App | Simplicidad | Social | Local | Competencia | Enfoque Fuerza |
|-----|-------------|--------|-------|-------------|----------------|
| Tribbe | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Hevy | ⭐⭐⭐⭐ | ⭐⭐ | ⭐ | ⭐ | ⭐⭐⭐⭐ |
| Strong | ⭐⭐⭐⭐⭐ | ⭐ | ⭐ | ⭐ | ⭐⭐⭐⭐⭐ |
| Jefit | ⭐⭐ | ⭐⭐⭐ | ⭐ | ⭐⭐ | ⭐⭐⭐⭐ |

**Diferenciador Clave:** Tribbe es la única app que combina simplicidad extrema con competencia social local enfocada en gimnasios.

---

## 🛠️ 2. Especificaciones Técnicas

### 2.1 Arquitectura del Sistema

#### Stack Tecnológico
- **Frontend:** Flutter (Dart) - Multiplataforma iOS/Android
- **Backend:** Firebase
- **Base de Datos:** Firebase
- **Autenticación:** Firebase Auth
- **Storage:** Firebase Storage 
- **Push Notifications:** Firebase Cloud Messaging
- **Analytics:** Firebase Analytics + Mixpanel

#### Arquitectura de Datos
```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Flutter App   │◄──►│   API Gateway   │◄──►│   Microservices │
│   (iOS/Android) │    │   (Rate Limit)  │    │   (Business)    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                                │                        │
                                ▼                        ▼
                       ┌─────────────────┐    ┌─────────────────┐
                       │  Firebase       │    │                 │
                       │   (Principal)   │    │    (Cache)      │
                       └─────────────────┘    └─────────────────┘
```

### 2.2 Requerimientos Funcionales

#### Epic 1: Autenticación y Perfiles (P0)
- **REQ-001:** Registro de usuarios con email/teléfono
- **REQ-002:** Login seguro con 2FA opcional
- **REQ-003:** Creación de perfil básico (nombre, foto, gimnasio)
- **REQ-004:** Edición de perfil y configuración de privacidad
- **REQ-005:** Verificación de membresía de gimnasio

#### Epic 2: Seguimiento de Entrenamientos (P0)
- **REQ-006:** Catálogo de ejercicios de fuerza (50+ ejercicios)
- **REQ-007:** Registro rápido de entrenamientos (ejercicio, peso, reps, series)
- **REQ-008:** Historial de entrenamientos con filtros
- **REQ-009:** Cálculo automático de 1RM (One Rep Max)
- **REQ-010:** Récords personales (PR) por ejercicio
- **REQ-011:** Gráficos de progreso simples

#### Epic 3: Sistema Social (P0)
- **REQ-012:** Sistema de amigos (agregar, eliminar, bloquear)
- **REQ-013:** Búsqueda de usuarios por gimnasio
- **REQ-014:** Feed de actividad de amigos
- **REQ-015:** Comparación de estadísticas entre amigos
- **REQ-016:** Compartir PRs y logros

#### Epic 4: Competencia Local (P1)
- **REQ-017:** Rankings por gimnasio y ejercicio
- **REQ-018:** Top 10 usuarios por categoría
- **REQ-019:** Competencias temporales (mensuales)
- **REQ-020:** Sistema de logros y badges
- **REQ-021:** Notificaciones de competencia

#### Epic 5: Gestión de Gimnasios (P1)
- **REQ-022:** Registro de gimnasios en la plataforma
- **REQ-023:** Validación de membresía (códigos QR)
- **REQ-024:** Administración de gimnasios
- **REQ-025:** Estadísticas de gimnasio

### 2.3 Requerimientos No Funcionales

#### Rendimiento
- **Tiempo de carga:** < 3 segundos para pantallas principales
- **Tiempo de respuesta API:** < 500ms para operaciones CRUD
- **Disponibilidad:** 99.5% uptime
- **Escalabilidad:** Soporte para 100,000+ usuarios concurrentes

#### Seguridad
- **Encriptación:** TLS 1.3 para todas las comunicaciones
- **Autenticación:** JWT con refresh tokens
- **Validación:** Sanitización de inputs y validación server-side
- **Privacidad:** Cumplimiento con GDPR/LOPD

#### Usabilidad
- **Accesibilidad:** Cumplimiento con WCAG 2.1 AA
- **Responsive:** Optimizado para pantallas 4.7" - 6.7"
- **Offline:** Funcionalidad básica sin conexión
- **Internacionalización:** Soporte para español e inglés

### 2.4 Diseño de UI/UX

#### Principios de Diseño
1. **Minimalismo:** Interfaz limpia sin elementos innecesarios
2. **Velocidad:** Acciones principales en máximo 2 taps
3. **Competencia:** Elementos visuales que motiven la competencia
4. **Local:** Enfoque en comunidad del gimnasio

#### Flujo de Usuario Principal
```
Registro → Perfil → Gimnasio → Entrenamiento → Compartir → Competir
    ↓         ↓        ↓           ↓            ↓         ↓
  Email    Foto    Código QR    Ejercicios   Feed    Rankings
```

#### Pantallas Clave

**1. Onboarding (3 pantallas)**
- Bienvenida con propuesta de valor
- Selección de gimnasio
- Configuración de perfil básico

**2. Dashboard Principal**
- Header: Logo + Notificaciones + Perfil
- Botón CTA: "Nuevo Entrenamiento" (prominente)
- Feed de actividad de amigos (scroll infinito)
- Acceso rápido a estadísticas personales
- Bottom Navigation: Home | Gym | Amigos | Perfil

**3. Pantalla de Entrenamiento**
- Lista de ejercicios populares (favoritos primero)
- Input rápido: Ejercicio → Peso → Reps → Series  
- Botón "Completar Set" (grande, color llamativo)
- Comparación con PR anterior (visual)
- Opción de compartir PR inmediatamente

**4. Pantalla de Gimnasio**
- Lista de miembros activos
- Rankings Top 5 por ejercicio
- Botón "Unirse/Cambiar Gimnasio"
- Búsqueda de gym bros  
- Estadísticas del gimnasio

**5. Pantalla de Perfil**
- PRs principales (3-5 ejercicios)
- Gráfico de progreso simple (últimos 3 meses)
- Lista de amigos  
- Configuración y privacidad

### 2.5 Modelo de Datos

#### Entidades Principales
```sql
-- Usuarios
Users (id, email, username, photo_url, gym_id, created_at, updated_at)

-- Gimnasios
Gyms (id, name, location, qr_code, admin_id, created_at)

-- Ejercicios
Exercises (id, name, category, muscle_groups, is_compound)

-- Entrenamientos
Workouts (id, user_id, date, duration, notes)

-- Sets
Sets (id, workout_id, exercise_id, weight, reps, rpe, rest_time)

-- Amistades
Friendships (id, user_id, friend_id, status, created_at)

-- Rankings
Rankings (id, gym_id, exercise_id, user_id, max_weight, date)
```

### 2.6 API Endpoints

#### Autenticación
- `POST /auth/register` - Registro de usuario
- `POST /auth/login` - Login
- `POST /auth/refresh` - Renovar token
- `POST /auth/logout` - Logout

#### Perfil
- `GET /profile` - Obtener perfil
- `PUT /profile` - Actualizar perfil
- `POST /profile/photo` - Subir foto

#### Entrenamientos
- `GET /workouts` - Listar entrenamientos
- `POST /workouts` - Crear entrenamiento
- `GET /workouts/:id` - Obtener entrenamiento
- `PUT /workouts/:id` - Actualizar entrenamiento
- `DELETE /workouts/:id` - Eliminar entrenamiento

#### Social
- `GET /friends` - Listar amigos
- `POST /friends/request` - Enviar solicitud
- `PUT /friends/:id/accept` - Aceptar solicitud
- `GET /feed` - Feed de actividad

#### Competencia
- `GET /rankings/gym/:gym_id` - Rankings del gimnasio
- `GET /rankings/exercise/:exercise_id` - Rankings por ejercicio
- `GET /stats/compare` - Comparar estadísticas

### 2.7 Preguntas Técnicas Abiertas

#### Validación de Gimnasios
- **Opción A:** Códigos QR únicos por gimnasio
- **Opción B:** Geolocalización + verificación manual
- **Opción C:** Códigos de invitación de administradores
- **Recomendación:** Combinación A + C para mayor seguridad

#### Moderación de Estadísticas
- **Sistema de reportes:** Usuarios pueden reportar estadísticas sospechosas
- **Límites razonables:** Validación de rangos por ejercicio y peso corporal
- **Verificación manual:** Administradores revisan casos reportados
- **Penalizaciones:** Suspensión temporal por estadísticas falsas

#### Modelo de Monetización
- **Freemium:** Funciones básicas gratis, premium por $4.99/mes
- **Funciones Premium:** Estadísticas avanzadas, competencias exclusivas, sin anuncios
- **Revenue Streams:** Suscripciones (70%), anuncios (20%), partnerships (10%)

#### Escalabilidad
- **Microservicios:** Separar autenticación, entrenamientos, social, rankings
- **CDN:** Imágenes y assets estáticos
- **Caching:** Redis para datos frecuentemente accedidos
- **Load Balancing:** Distribución de carga para alta disponibilidad

---

## 📊 3. Métricas de Éxito

### 3.1 Métricas de Producto (KPIs)

#### Métricas de Adquisición
- **Usuarios registrados:** 1,000 en el primer mes
- **Tasa de conversión registro:** > 15% (visitantes → usuarios)
- **Usuarios activos mensuales (MAU):** 10,000 en 6 meses
- **Usuarios activos diarios (DAU):** 4,000 en 6 meses (40% de MAU)

#### Métricas de Engagement
- **Sesiones por usuario/semana:** > 3
- **Tiempo promedio en app:** > 8 minutos/sesión
- **Retención D1:** > 60%
- **Retención D7:** > 35%
- **Retención D30:** > 20%

#### Métricas de Social
- **Amigos promedio por usuario:** > 5
- **Entrenamientos compartidos:** > 30% de entrenamientos
- **Interacciones en feed:** > 2 por usuario/semana
- **Rankings consultados:** > 1 por usuario/semana

#### Métricas de Competencia
- **Usuarios en rankings:** > 50% de usuarios activos
- **Competencias participadas:** > 20% de usuarios/mes
- **PRs registrados:** > 2 por usuario/mes

### 3.2 Métricas Técnicas
- **Tiempo de carga:** < 3 segundos (95% de las veces)
- **Disponibilidad:** > 99.5%
- **Tiempo de respuesta API:** < 500ms (95% de las veces)
- **Crashes por sesión:** < 0.1%

### 3.3 Métricas de Negocio
- **Revenue mensual:** $5,000 en 6 meses
- **CAC (Costo de Adquisición):** < $2
- **LTV (Lifetime Value):** > $15
- **Churn rate mensual:** < 5%

---

## 🗓️ 4. Roadmap de Desarrollo

### Fase 1: MVP (Mes 1-2)
**Objetivo:** Lanzar versión básica funcional

#### Sprint 1 (Semanas 1-2)
- [ ] Setup del proyecto Flutter
- [ ] Autenticación básica (email/password)
- [ ] Perfil de usuario básico
- [ ] Catálogo de ejercicios (20 ejercicios principales)

#### Sprint 2 (Semanas 3-4)
- [ ] Registro de entrenamientos
- [ ] Historial básico
- [ ] Cálculo de 1RM
- [ ] UI/UX básica

#### Sprint 3 (Semanas 5-6)
- [ ] Sistema de amigos básico
- [ ] Feed de actividad
- [ ] Compartir entrenamientos
- [ ] Testing y bug fixes

#### Sprint 4 (Semanas 7-8)
- [ ] Rankings básicos
- [ ] Notificaciones push
- [ ] Optimizaciones de rendimiento
- [ ] Preparación para lanzamiento

### Fase 2: Social & Competencia (Mes 3-4)
**Objetivo:** Funciones sociales y competitivas

#### Funcionalidades
- [ ] Sistema de gimnasios con QR
- [ ] Rankings avanzados por gimnasio
- [ ] Competencias temporales
- [ ] Sistema de logros y badges
- [ ] Comparación de estadísticas entre amigos

### Fase 3: Escalabilidad (Mes 5-6)
**Objetivo:** Optimización y crecimiento

#### Funcionalidades
- [ ] Modo offline
- [ ] Estadísticas avanzadas
- [ ] Integración con redes sociales
- [ ] Sistema de monetización (freemium)
- [ ] Analytics avanzados

### Fase 4: Expansión (Mes 7-12)
**Objetivo:** Crecimiento y nuevas funcionalidades

#### Funcionalidades
- [ ] Mensajería básica
- [ ] Competencias globales
- [ ] Integración con wearables
- [ ] API pública
- [ ] Web app

---

## ⚠️ 5. Análisis de Riesgos

### 5.1 Riesgos Técnicos

#### Alto Impacto
- **Riesgo:** Escalabilidad de la base de datos con muchos usuarios
- **Probabilidad:** Media
- **Mitigación:** Implementar caching con Redis, optimizar queries, usar CDN

- **Riesgo:** Problemas de sincronización en modo offline
- **Probabilidad:** Alta
- **Mitigación:** Implementar conflict resolution, testing exhaustivo

#### Medio Impacto
- **Riesgo:** Problemas de rendimiento en dispositivos antiguos
- **Probabilidad:** Media
- **Mitigación:** Optimización de Flutter, testing en dispositivos reales

### 5.2 Riesgos de Producto

#### Alto Impacto
- **Riesgo:** Baja adopción por parte de gimnasios
- **Probabilidad:** Alta
- **Mitigación:** Programa de partnerships, incentivos para gimnasios

- **Riesgo:** Competencia directa de apps establecidas
- **Probabilidad:** Media
- **Mitigación:** Diferenciación clara, velocidad de desarrollo

#### Medio Impacto
- **Riesgo:** Estadísticas falsas afecten la credibilidad
- **Probabilidad:** Media
- **Mitigación:** Sistema de reportes, validación automática

### 5.3 Riesgos de Negocio

#### Alto Impacto
- **Riesgo:** Dificultad para monetizar
- **Probabilidad:** Media
- **Mitigación:** Testing de diferentes modelos, feedback de usuarios

- **Riesgo:** Regulaciones de privacidad de datos
- **Probabilidad:** Baja
- **Mitigación:** Cumplimiento proactivo con GDPR/LOPD

---

## 💰 6. Modelo de Negocio

### 6.1 Estrategia de Monetización

#### Modelo Freemium
**Gratis:**
- Registro de entrenamientos básico
- 5 amigos máximo
- Rankings básicos
- 1 gimnasio

**Premium ($4.99/mes):**
- Estadísticas avanzadas
- Amigos ilimitados
- Rankings detallados
- Múltiples gimnasios
- Competencias exclusivas
- Sin anuncios
- Exportar datos

### 6.2 Revenue Streams

#### Primario: Suscripciones (70%)
- Usuarios premium: 20% de la base
- ARPU: $4.99/mes
- Churn: < 5%/mes

#### Secundario: Anuncios (20%)
- Anuncios de suplementos
- Anuncios de equipamiento
- Anuncios de gimnasios
- CPM: $2-5

#### Terciario: Partnerships (10%)
- Comisiones de gimnasios
- Productos fitness
- Eventos deportivos

### 6.3 Proyecciones Financieras

#### Año 1
- **Usuarios:** 10,000 MAU
- **Premium:** 2,000 usuarios (20%)
- **Revenue mensual:** $10,000
- **Revenue anual:** $120,000

#### Año 2
- **Usuarios:** 50,000 MAU
- **Premium:** 10,000 usuarios (20%)
- **Revenue mensual:** $50,000
- **Revenue anual:** $600,000

---

## 🎯 7. Estrategia de Lanzamiento

### 7.1 Fase de Pre-lanzamiento (Mes -1)
- [ ] Beta testing con 100 usuarios
- [ ] Feedback y iteración
- [ ] Preparación de marketing
- [ ] Partnerships con gimnasios piloto

### 7.2 Lanzamiento Suave (Mes 0)
- [ ] Lanzamiento en 5 gimnasios piloto
- [ ] Marketing orgánico en redes sociales
- [ ] Influencers fitness locales
- [ ] PR en medios fitness

### 7.3 Lanzamiento Amplio (Mes 1+)
- [ ] Expansión a 20+ gimnasios
- [ ] Marketing pagado (Google Ads, Facebook)
- [ ] Partnerships con influencers
- [ ] Eventos en gimnasios

### 7.4 Estrategia de Crecimiento
- **Referidos:** Programa de referidos con incentivos
- **Viral:** Compartir PRs y logros
- **Partnerships:** Acuerdos con gimnasios
- **Content:** Blog y redes sociales sobre fitness

---

## ✅ 8. Conclusión

Tribbe representa una oportunidad única en el mercado de aplicaciones fitness al combinar:

### Propuesta de Valor Única
- **Simplicidad extrema:** Interfaz minimalista sin funciones innecesarias
- **Social local:** Enfoque en comunidad del gimnasio
- **Gamificación competitiva:** Rankings y competencias que motivan

### Ventajas Competitivas
1. **Primer movidor** en competencia social local de gimnasios
2. **Enfoque específico** en la comunidad gym bro
3. **Simplicidad** que reduce fricción de adopción
4. **Localización** que crea sentido de pertenencia

### Próximos Pasos
1. **Validar** el concepto con gimnasios piloto
2. **Desarrollar** MVP en 2 meses
3. **Lanzar** beta con 100 usuarios
4. **Iterar** basado en feedback
5. **Escalar** a 10,000+ usuarios en 6 meses

### Métricas de Éxito Clave
- **10,000 MAU** en 6 meses
- **40% DAU/MAU** ratio
- **$10,000 MRR** en 6 meses
- **20% conversión** a premium

**Tribbe no es solo otra app de fitness, es la plataforma social que la comunidad gym bro ha estado esperando.** 🏋️‍♂️💪

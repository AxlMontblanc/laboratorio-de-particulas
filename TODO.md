# Laboratorio de Partículas — TODO

Juego en Godot 4.7 con minijuegos sobre el modelo estándar.
Plan: 6 días. Construir **un minijuego a la vez y terminarlo** antes de pasar al siguiente.

---

## 🎯 Diseño del Recolector — nivel 1

- Caen **X partículas** en total (quarks y antiquarks mezclados, al azar).
- El jugador atrapa partículas con el colector para formar hadrones:

| Atrapados | Resultado |
|---|---|
| 1 quark + 1 antiquark | ✅ Mesón → +1 punto, se vacía el colector |
| 3 quarks | ✅ Barión → +1 punto, se vacía |
| 3 antiquarks | ✅ Antibarión → +1 punto, se vacía |
| 3 mezclados (2q + 1q̄ o 1q + 2q̄) | ❌ Inválido → 0 puntos, se vacía |
| 2 quarks / 2 antiquarks | ⏳ Sigue atrapando |

- Partícula no atrapada: se pierde, sin castigo.
- Cuando cae la última partícula → fin del juego y se muestra el puntaje.
- La regla real es la carga de color; la carga eléctrica entera sale sola (dato educativo para mostrar).
- La lógica debe funcionar **sin importar el orden** en que se atrapan.

---

## ✅ Hecho

### Día 1 — 7 oct
- [x] Proyecto Godot 4.7 (Compatibility), organización por carpetas de funcionalidad
- [x] `main.tscn` como escena principal
- [x] Repo en GitHub: AxlMontblanc/laboratorio-de-particulas
- [x] Colector: movimiento con flechas (Δx = v·Δt), `@export speed`, límites con `clamp`
- [x] Quark que cae

### Día 2 — 8 oct
- [x] Quark: `Label`, autoeliminación al salir de pantalla (señal `screen_exited` → `queue_free()`)
- [x] Colector atrapa quarks (señal `area_entered`, elimina `area`)
- [x] `@export var width` y `clamp` corregido con `width / 2`
- [x] Quark con `@export var type` como dato; el `Label` muestra el tipo; carga calculada desde el tipo
- [x] Las 6 generaciones agrupadas por carga (`const pquarks`, `const nquarks`), `charge: float = 0.0`
- [x] Colector acumula `trapped` y `total_charge` (versión de prueba)

---

### 13 oct — Recolector nivel 1 terminado (con Claude)
- [x] Antiquarks: `@export var anti`, carga invertida, dibujo propio (círculo = quark, anillo con barra = antiquark), colores por sabor
- [x] Colector con las reglas de la tabla (mesón / barión / antibarión / inválido), sin importar el orden
- [x] Nombres de hadrones u/d (protón, neutrón, Δ⁺⁺, Δ⁻, piones y sus antipartículas)
- [x] El colector avisa con **señales** (`particula_formada`, `combinacion_invalida`, `grupo_cambiado`); `main.gd` decide qué mostrar
- [x] Generador en `main.gd`: X partículas al azar (`SpawnTimer` + `instantiate()`), velocidad variable
- [x] HUD: puntaje, partículas por caer, contenido del colector, ayuda con las reglas, mensajes que se desvanecen (tween)
- [x] Fin de partida y reinicio con Enter
- [x] Fondo tipo detector (`recolector/fondo.gd`)

Parámetros ajustables en el Inspector del nodo `Main`: `total_particulas`, `tipos_disponibles`, `prob_anti`, `velocidad_min/max`.

---

## 🔜 Siguiente (ideas para mejorar el Recolector)

- [ ] Commit de los cambios del 13 oct
- [ ] Probarlo con estudiantes y anotar qué les cuesta
- [ ] Niveles: agregar sabores (`tipos_disponibles = ["u","d","s"]`) y nombres de kaones (K⁺ = u s̄, K⁻ = s ū…)
- [ ] Nivel con carga de color (rojo/verde/azul)
- [ ] Sonidos al formar / fallar
- [ ] Pantalla de inicio con instrucciones

## Reactor (decaimientos)

- [ ] Datos de partículas compartidos en `comun/` (carga, nº bariónico, nº leptónico)
- [ ] Reacción incompleta (lado izquierdo) + inventario
- [ ] Arrastrar y soltar al lado derecho
- [ ] Luces verde/rojo por cada cantidad conservada
- [ ] 3–4 reacciones reales (ej. n → p + e⁻ + ν̄ₑ)
- [ ] Progresión: carga → + bariónico → + leptónico → (opcional) por familia

## Aniquilación (si alcanza el tiempo)

- [ ] Reutilizar movimiento y generador del recolector
- [ ] Disparar la partícula correcta contra su antipartícula

## Arte

- [x] Quarks/antiquarks dibujados por código y fondo tipo detector (arte básico)
- [ ] Colector con mejor forma (ahora es un rectángulo)
- [ ] Tipografía y estilo del HUD/menú
- [ ] Efectos simples al formar una partícula (destello, partículas)

## Cierre

- [ ] Menú principal ("laboratorio") para elegir minijuego
- [ ] Exportar a web y compartir el link
- [ ] Para estudiantes en GitHub: `README.md`, licencia (MIT), issues "good first issue"

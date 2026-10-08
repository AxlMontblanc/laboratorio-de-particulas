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

## 🔜 Siguiente (retomar aquí)

- [ ] Commit del TODO actualizado
- [ ] Quark: `@export var anti = false`
  - [ ] Si `anti`, la carga se invierte
  - [ ] Distinguirlo visualmente: otro color en `ColorRect` (ej. celeste) y etiqueta "anti-u" o "u̅" (probar si la fuente muestra la barra)
  - [ ] Probar con un antiquark en `main.tscn`
- [ ] Colector: reemplazar la lógica de prueba por la tabla de diseño
  - [ ] Contadores de quarks y antiquarks
  - [ ] `var score = 0`
  - [ ] Revisar después de **cada** captura: mesón / barión / antibarión → +1 y reinicio; 3 inválidos → reinicio sin punto
  - [ ] Reiniciar contadores, lista y carga total al cerrar cada grupo
  - [ ] Si se compara carga: usar `is_equal_approx`, no `==` ni `in`
  - [ ] (Opcional) Mensaje con lo formado, ej. "Barión de carga +1"

## Recolector — resto del nivel 1

- [ ] Generador: X partículas al azar (tipo + anti) desde arriba (Timer + `instantiate()`)
- [ ] HUD en pantalla: puntaje, partículas atrapadas en el grupo actual, partículas restantes
- [ ] Fin del juego al caer la última partícula → pantalla de puntaje final y reiniciar
- [ ] (Opcional) `push_warning()` si llega un tipo desconocido
- [ ] (Opcional) Tabla de nombres (protón, neutrón, Δ⁺⁺, Δ⁻, π⁺…)

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

## Arte (con ayuda de Claude, cuando el core básico esté listo)

- [ ] Sprites de quarks/antiquarks y colector
- [ ] Fondo tipo detector de partículas
- [ ] Tipografía y estilo del HUD/menú
- [ ] Efectos simples al formar una partícula (destello, partículas)

## Cierre

- [ ] Menú principal ("laboratorio") para elegir minijuego
- [ ] Exportar a web y compartir el link
- [ ] Para estudiantes en GitHub: `README.md`, licencia (MIT), issues "good first issue"

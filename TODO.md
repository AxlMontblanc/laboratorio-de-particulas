# Laboratorio de Partículas — TODO

Juego en Godot 4.7 con minijuegos sobre el modelo estándar.
Plan: 6 días. Construir **un minijuego a la vez y terminarlo** antes de pasar al siguiente.

---

## ✅ Hecho (día 1 — 7 oct)

### Proyecto
- [x] Proyecto creado en Godot 4.7, renderer Compatibility (exporta bien a web)
- [x] Organización por funcionalidad (`recolector/`, luego `reactor/`, `aniquilacion/`, `comun/`)
- [x] `main.tscn` creada y configurada como escena principal (F5)
- [x] Repositorio Git creado y subido a GitHub (primer commit)

### Recolector de quarks
- [x] Escena `recolector/colector.tscn` (Area2D + ColorRect + CollisionShape2D, centrados en el origen)
- [x] Script `colector.gd`: movimiento con flechas (`Input.get_axis`, Δx = v·Δt)
- [x] `@export var speed` para ajustar desde el Inspector
- [x] Límites de pantalla con `clamp()`
- [x] Escena `recolector/quark.tscn` + `quark.gd`: el quark cae

---

## 🔜 Siguiente (retomar aquí)

- [ ] **Commit pendiente:** "Quark que cae" (main.tscn + archivos del quark)
- [ ] Agregar `Label` al quark con "u" o "d" (texto negro, centrado)
- [ ] Que el quark se elimine al salir de pantalla: nodo `VisibleOnScreenNotifier2D` + señal `screen_exited` → `queue_free()`
- [ ] Atrapar quarks: conectar la señal `area_entered` del colector

## Recolector — nivel 1 (meta: formar un protón uud)

- [ ] Variable de tipo en el quark (`u` / `d`) con su carga (+2/3, −1/3)
- [ ] Generador que hace aparecer quarks aleatorios desde arriba (Timer + `instantiate()`)
- [ ] Contador en pantalla: quarks atrapados y carga total
- [ ] Al atrapar 3: verificar si es protón (uud) → ganar / si no → perder y reiniciar
- [ ] Pantalla o mensaje de victoria / derrota
- [ ] (Opcional) Mejora: reemplazar el `60` del clamp por `@export var ancho` y usar `ancho / 2`
- [ ] (Opcional) Niveles 2 (carga de color) y 3 (mesones)

## Reactor (decaimientos)

- [ ] Datos de partículas compartidos en `comun/` (carga, nº bariónico, nº leptónico)
- [ ] Pantalla: reacción incompleta (lado izquierdo) + inventario de partículas
- [ ] Arrastrar y soltar partículas al lado derecho
- [ ] Verificación de conservación con luces verde/rojo por cantidad
- [ ] 3–4 reacciones reales (ej. n → p + e⁻ + ν̄ₑ)
- [ ] Progresión: solo carga → + bariónico → + leptónico → (opcional) leptónico por familia

## Aniquilación (si alcanza el tiempo)

- [ ] Reutilizar movimiento y generador del recolector
- [ ] Disparar la partícula correcta contra su antipartícula

## Cierre

- [ ] Menú principal ("laboratorio") para elegir minijuego
- [ ] Fondo tipo detector de partículas, pulido visual
- [ ] Exportar a web y compartir el link
- [ ] Para GitHub con estudiantes: `README.md`, licencia (MIT), issues "good first issue"

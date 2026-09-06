# English SRS — sustituto de Anki, gratis

Web estática (GitHub Pages) + Supabase free tier. Coste: 0 €.
Repetición espaciada SM-2, audio con la voz nativa del iPad, 299 tarjetas B2→C1 incluidas.

## Montaje (una vez, ~10 min)

### 1. Supabase
1. supabase.com → **New project** (región: Frankfurt o Londres). Plan Free.
2. Espera ~2 min a que arranque.
3. Menú **SQL Editor** → **New query** → pega entero `schema.sql` → **Run**.
4. Menú **Project Settings → API**. Copia dos cosas:
   - **Project URL** (`https://xxxxx.supabase.co`)
   - **anon public** key
5. Menú **Authentication → Sign In / Providers**: comprueba que **Email** está activo.
   Desactiva "Confirm email" no hace falta; el magic link ya lo confirma.

### 2. GitHub Pages
1. Crea un repo **público** (ej. `english-srs`).
2. Sube `index.html`, `deck.tsv`, `.nojekyll`. (`schema.sql` y este README, opcionales.)
3. Repo → **Settings → Pages** → Source: *Deploy from a branch* → `main` / `/ (root)` → Save.
4. En 1-2 min tendrás `https://TU-USUARIO.github.io/english-srs/`.

### 3. Autorizar el redirect del login
Supabase → **Authentication → URL Configuration**:
- **Site URL**: `https://TU-USUARIO.github.io/english-srs/`
- **Redirect URLs**: añade la misma URL.

Sin esto el enlace del correo no te devuelve a la app.

### 4. Primer arranque en el iPad
1. Abre la URL en Safari.
2. Pega Project URL + anon key.
3. Escribe tu email → **Enviar enlace** → abre el correo **en el iPad**.
4. Pestaña **Mazo** → **Importar mazo inicial** (299 tarjetas).
5. Compartir → **Añadir a pantalla de inicio**. Se abre a pantalla completa, sin barra de Safari.

## Uso diario
- **Estudiar**: 15 min. Ves el inglés → intentas recordar → *Mostrar respuesta* → te lee la palabra y la frase.
- Botones: **Otra vez / Difícil / Bien / Fácil**. Bajo cada uno ves cuándo volverá.
- **Añadir**: vocabulario que te encuentres en la inmersión. Siempre con frase de ejemplo.
- **Mazo**: límite de tarjetas nuevas al día (15 por defecto — no lo subas), voz, y estado del mazo.
- Con teclado: `espacio` muestra la respuesta, `1-4` puntúan.

## Notas
- La *anon key* es pública por diseño. Lo que protege tus datos es RLS: la política del `schema.sql`
  hace que cada fila solo sea visible para el usuario que la creó.
- El audio usa la voz del sistema (Ajustes → Accesibilidad → Contenido hablado → Voces → Inglés;
  descarga una voz *Premium* o *Enhanced*, suenan mucho mejor).
- La app necesita conexión. Si quieres offline, es el siguiente paso (service worker + cola local).
- Los repasos se registran en la tabla `en_reviews`, así que el progreso es consultable con SQL.

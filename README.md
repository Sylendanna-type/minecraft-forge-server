# ⚒️ Servidor Minecraft Forge 1.20.1

Servidor de Minecraft con Forge listo para correr en **GitHub Codespaces**.

---

## 🚀 Inicio Rápido

### 1. Abrir en Codespaces
1. Haz clic en el botón verde **Code** en GitHub
2. Selecciona **Codespaces** → **Create codespace on main**
3. Espera a que el entorno cargue (instala Java 17 automáticamente)

### 2. Instalar el servidor
El setup corre automáticamente al abrir Codespaces. Si necesitas reinstalar:
```bash
bash scripts/setup.sh
```

### 3. Iniciar el servidor
```bash
bash scripts/start.sh
```

### 4. Conectarte al servidor
1. En el panel de Codespaces, ve a la pestaña **Ports**
2. Busca el puerto `25565` y copia la dirección
3. En Minecraft, agrega ese servidor en **Multijugador**

> ⚠️ Recuerda que la dirección cambia cada vez que reinicias el Codespace.

---

## 📦 Agregar Mods

1. Descarga el `.jar` del mod desde [CurseForge](https://www.curseforge.com) o [Modrinth](https://modrinth.com)
2. Asegúrate que sea compatible con **Forge 1.20.1**
3. Coloca el archivo en `server/mods/`
4. Reinicia el servidor

```bash
# Ver mods instalados
bash scripts/mods.sh listar
```

---

## ⚙️ Configuración

### Memoria RAM
Edita `server/user_jvm_args.txt`:
```
-Xmx4G   # máximo de RAM (ajusta según tu plan de Codespaces)
-Xms2G   # mínimo de RAM
```

| Plan Codespaces | RAM disponible | Recomendado |
|---|---|---|
| 2-core (gratis) | 8 GB | `-Xmx3G -Xms1G` |
| 4-core | 16 GB | `-Xmx6G -Xms2G` |
| 8-core | 32 GB | `-Xmx12G -Xms4G` |

### Propiedades del servidor
Edita `server/server.properties` para cambiar:
- `max-players` — jugadores máximos
- `difficulty` — dificultad (peaceful/easy/normal/hard)
- `online-mode` — `true` para cuentas oficiales, `false` para Tlauncher
- `motd` — mensaje que aparece en la lista de servidores

---

## 📁 Estructura del Proyecto

```
minecraft-forge-server/
├── .devcontainer/
│   └── devcontainer.json     # Configuración de Codespaces
├── scripts/
│   ├── setup.sh              # Instala Forge
│   ├── start.sh              # Inicia el servidor
│   └── mods.sh               # Gestiona mods
├── server/
│   ├── mods/                 # Tus mods aquí
│   ├── config/               # Config de mods (generada al correr)
│   └── server.properties     # Configuración del servidor
└── README.md
```

---

## ⚠️ Limitaciones de Codespaces

- **Tiempo máximo:** 6 horas por sesión (plan gratuito)
- **El mundo se pierde** si no haces commit/backup antes de cerrar
- No es para uso 24/7 — úsalo para pruebas o jugar con amigos ocasionalmente

### Hacer backup del mundo
```bash
# Comprimir y guardar el mundo
cd server && tar -czf ../world-backup-$(date +%Y%m%d).tar.gz world/
```

---

## 🔗 Links útiles

- [Forge Downloads](https://files.minecraftforge.net/net/minecraftforge/forge/index_1.20.1.html)
- [CurseForge Mods 1.20.1](https://www.curseforge.com/minecraft/mc-mods?filter-game-version=1.20.1)
- [Modrinth Mods](https://modrinth.com/mods?g=1.20.1&l=forge)

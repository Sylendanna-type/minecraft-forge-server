#!/bin/bash

# ============================================================
#  Minecraft Forge 1.20.1 - Gestor de Mods
#  Uso: bash scripts/mods.sh [listar|limpiar]
# ============================================================

SERVER_DIR="$(pwd)/server"
MODS_DIR="$SERVER_DIR/mods"

list_mods() {
  echo ""
  echo "📦 Mods instalados en $MODS_DIR:"
  echo "─────────────────────────────────────"
  if [ -z "$(ls -A $MODS_DIR 2>/dev/null)" ]; then
    echo "  (ninguno)"
  else
    ls -lh "$MODS_DIR"/*.jar 2>/dev/null | awk '{print "  •", $NF, "("$5")"}'
  fi
  echo ""
}

clean_mods() {
  echo "🗑️  Eliminando todos los mods..."
  rm -f "$MODS_DIR"/*.jar
  echo "✅ Carpeta de mods limpiada"
}

case "$1" in
  listar|list)
    list_mods
    ;;
  limpiar|clean)
    clean_mods
    ;;
  *)
    echo ""
    echo "╔══════════════════════════════════════════╗"
    echo "║   📦 Gestor de Mods - Forge 1.20.1      ║"
    echo "╚══════════════════════════════════════════╝"
    echo ""
    echo "Para agregar mods:"
    echo "  1. Descarga el .jar del mod (CurseForge/Modrinth)"
    echo "  2. Cópialo a la carpeta: server/mods/"
    echo "  3. Asegúrate que sea compatible con Forge 1.20.1"
    echo ""
    echo "Comandos disponibles:"
    echo "  bash scripts/mods.sh listar   → Lista los mods instalados"
    echo "  bash scripts/mods.sh limpiar  → Elimina todos los mods"
    echo ""
    list_mods
    ;;
esac

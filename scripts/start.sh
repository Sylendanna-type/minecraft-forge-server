#!/bin/bash

# ============================================================
#  Minecraft Forge 1.20.1 - Script de Inicio
# ============================================================

SERVER_DIR="$(pwd)/server"

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║   🚀 Iniciando Forge 1.20.1 Server      ║"
echo "╚══════════════════════════════════════════╝"
echo ""

# Verificar que el servidor esté instalado
if [ ! -f "$SERVER_DIR/run.sh" ]; then
  echo "❌ El servidor no está instalado. Ejecuta primero:"
  echo "   bash scripts/setup.sh"
  exit 1
fi

cd "$SERVER_DIR"

# Detectar el script de inicio generado por Forge
if [ -f "run.sh" ]; then
  echo "✅ Usando run.sh de Forge"
  chmod +x run.sh
  ./run.sh nogui
else
  # Fallback: buscar el jar de Forge directamente
  FORGE_JAR=$(ls forge-*-shim.jar 2>/dev/null | head -1)
  if [ -z "$FORGE_JAR" ]; then
    FORGE_JAR=$(ls forge-*.jar 2>/dev/null | grep -v installer | head -1)
  fi

  if [ -z "$FORGE_JAR" ]; then
    echo "❌ No se encontró el jar de Forge. Reinstala con: bash scripts/setup.sh"
    exit 1
  fi

  echo "✅ Iniciando con: $FORGE_JAR"
  java @user_jvm_args.txt -jar "$FORGE_JAR" nogui
fi

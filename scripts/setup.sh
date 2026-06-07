#!/bin/bash
set -e

# ============================================================
#  Minecraft Forge 1.20.1 - Setup Script
#  Ejecuta esto una sola vez para instalar el servidor
# ============================================================

FORGE_VERSION="1.20.1-47.3.0"
FORGE_INSTALLER="forge-${FORGE_VERSION}-installer.jar"
FORGE_URL="https://maven.minecraftforge.net/net/minecraftforge/forge/${FORGE_VERSION}/${FORGE_INSTALLER}"
SERVER_DIR="$(pwd)/server"

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║   Minecraft Forge 1.20.1 - Setup        ║"
echo "╚══════════════════════════════════════════╝"
echo ""

# Verificar Java 17
JAVA_VER=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}' | cut -d'.' -f1)
if [ "$JAVA_VER" -lt "17" ]; then
  echo "❌ Se requiere Java 17 o superior. Versión detectada: $JAVA_VER"
  exit 1
fi
echo "✅ Java $JAVA_VER detectado"

# Crear carpeta del servidor
mkdir -p "$SERVER_DIR/mods"
cd "$SERVER_DIR"

# Descargar Forge Installer
if [ ! -f "$FORGE_INSTALLER" ]; then
  echo "⬇️  Descargando Forge ${FORGE_VERSION}..."
  wget -q --show-progress "$FORGE_URL" -O "$FORGE_INSTALLER"
else
  echo "✅ Installer ya existe, omitiendo descarga"
fi

# Instalar Forge
echo ""
echo "⚙️  Instalando Forge (modo servidor)..."
java -jar "$FORGE_INSTALLER" --installServer 2>&1 | tail -5
echo "✅ Forge instalado"

# Aceptar EULA automáticamente
echo "eula=true" > eula.txt
echo "✅ EULA aceptada"

# Copiar configuración del servidor si no existe
if [ ! -f "server.properties" ]; then
  cp ../server/server.properties . 2>/dev/null || true
fi

# Copiar user_jvm_args si no existe
if [ ! -f "user_jvm_args.txt" ]; then
  cat > user_jvm_args.txt << 'EOF'
# Argumentos JVM para el servidor Forge
# Puedes ajustar la memoria según tu plan de Codespaces
-Xmx4G
-Xms2G
-XX:+UseG1GC
-XX:+ParallelRefProcEnabled
-XX:MaxGCPauseMillis=200
-XX:+UnlockExperimentalVMOptions
-XX:+DisableExplicitGC
-XX:+AlwaysPreTouch
-XX:G1NewSizePercent=30
-XX:G1MaxNewSizePercent=40
-XX:G1HeapRegionSize=8M
-XX:G1ReservePercent=20
-XX:G1HeapWastePercent=5
-XX:G1MixedGCCountTarget=4
-XX:InitiatingHeapOccupancyPercent=15
-XX:G1MixedGCLiveThresholdPercent=90
-XX:G1RSetUpdatingPauseTimePercent=5
-XX:SurvivorRatio=32
-XX:+PerfDisableSharedMem
-XX:MaxTenuringThreshold=1
EOF
fi

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║   ✅ Setup completado exitosamente!      ║"
echo "║                                          ║"
echo "║   Ejecuta: bash scripts/start.sh         ║"
echo "╚══════════════════════════════════════════╝"
echo ""

# 🔗 Guía Completa de Conexión RDP

Esta guía detalla todos los métodos disponibles para conectarte a la máquina virtual Windows 10 desde tu sistema host.

## 🚀 Conexión Rápida

### Método 1: Vagrant RDP (Recomendado)
```bash
# Conectar directamente usando Vagrant
vagrant rdp
```

### Método 2: Cliente RDP Manual
```bash
# Verificar puerto asignado
vagrant port

# Conectar usando cliente RDP nativo
mstsc /v:127.0.0.1:3389
```

## 📋 Información de Conexión

| Parámetro | Valor | Notas |
|-----------|-------|-------|
| **Host** | `127.0.0.1` | Localhost |
| **Puerto** | `3389` | Verificar con `vagrant port` |
| **Usuario** | `batchtester` | Usuario administrador |
| **Contraseña** | `P@ssw0rd123` | Contraseña segura |
| **Dominio** | (vacío) | No requerido |

## 🔧 Configuración de Clientes RDP

### Windows (mstsc)
```bash
# Abrir cliente RDP
mstsc

# O desde línea de comandos
mstsc /v:127.0.0.1:3389 /u:batchtester
```

**Configuración recomendada:**
- **Pantalla:** Resolución completa
- **Colores:** 24 bits
- **Experiencia:** Optimizar para conexión de área local
- **Recursos locales:** Habilitar portapapeles y unidades

### macOS (Microsoft Remote Desktop)
1. **Descargar:** App Store → "Microsoft Remote Desktop"
2. **Configurar conexión:**
   - **PC name:** `127.0.0.1:3389`
   - **User name:** `batchtester`
   - **Password:** `P@ssw0rd123`
3. **Opciones avanzadas:**
   - **Display:** Full screen
   - **Colors:** 24-bit
   - **Audio:** Play on this computer

### Linux (Remmina)
```bash
# Ubuntu/Debian
sudo apt install remmina remmina-plugin-rdp

# Fedora
sudo dnf install remmina remmina-plugins-rdp

# Abrir Remmina
remmina
```

**Configuración:**
- **Protocol:** RDP
- **Server:** `127.0.0.1:3389`
- **Username:** `batchtester`
- **Password:** `P@ssw0rd123`
- **Quality:** High

## 🔒 Configuración de Seguridad

### Configuraciones Aplicadas
- ✅ **Network Level Authentication (NLA)** habilitado
- ✅ **Firewall de Windows** configurado para RDP
- ✅ **Acceso limitado** a localhost (127.0.0.1)
- ✅ **Usuario de pruebas** con permisos administrativos
- ✅ **Cifrado TLS 1.2** habilitado

### Personalización de Seguridad
Para cambiar la configuración, edita `.env.vagrant`:

```bash
# Cambiar credenciales
VAGRANT_WIN_USER=tu_usuario
VAGRANT_WIN_PASS=tu_contraseña

# Cambiar puerto RDP
VAGRANT_RDP_PORT=3390
```

## 🎯 Optimización de Rendimiento

### Configuración de Cliente RDP
- **Experiencia:** Optimizar para conexión de área local
- **Compresión:** Habilitar
- **Caché de mapas de bits:** Habilitar
- **Suavizado de fuentes:** Deshabilitar (mejor rendimiento)

### Configuración de VM
- **RAM:** 16GB asignada
- **CPU:** 4 núcleos
- **Gráficos:** Optimizados para consola
- **Red:** Host-only para mejor rendimiento

## 🐛 Troubleshooting RDP

### Problemas Comunes

#### 1. VM no responde
```bash
# Verificar estado
vagrant status

# Reiniciar VM
vagrant reload

# Verificar logs
vagrant up --debug
```

#### 2. Puerto ocupado
```bash
# Verificar puerto asignado
vagrant port

# Ejemplo de salida:
# 3389 (guest) => 53389 (host) (adapter 1)
# Usar puerto 53389 en lugar de 3389
```

#### 3. Error de autenticación
- **Verificar usuario:** `batchtester`
- **Verificar contraseña:** `P@ssw0rd123`
- **Revisar configuración:** `.env.vagrant`
- **Recrear usuario:** `vagrant provision`

#### 4. Conexión rechazada
```bash
# Verificar que RDP esté habilitado
vagrant provision

# Verificar firewall
vagrant ssh
netsh advfirewall firewall show rule name="Remote Desktop*"
```

#### 5. Problemas de rendimiento
- **Reducir resolución** en el cliente RDP
- **Deshabilitar efectos visuales** en la VM
- **Verificar recursos** del host
- **Cerrar aplicaciones** innecesarias

### Verificación de Estado

```bash
# Verificar estado de la VM
vagrant status

# Verificar puertos asignados
vagrant port

# Verificar logs de la VM
vagrant up --debug

# Verificar conectividad
ping 192.168.56.10
```

### Reiniciar Servicios RDP

Si hay problemas persistentes, reinicia los servicios RDP:

```powershell
# Desde PowerShell en la VM
Restart-Service TermService -Force
Restart-Service UmRdpService -Force

# Verificar estado
Get-Service TermService, UmRdpService
```

## 📊 Información de Conexión Detallada

| Parámetro | Valor por Defecto | Configurable | Descripción |
|-----------|-------------------|--------------|-------------|
| **Host** | 127.0.0.1 | No | Localhost |
| **Puerto** | 3389 | Sí (.env.vagrant) | Puerto RDP |
| **Usuario** | batchtester | Sí (.env.vagrant) | Usuario de pruebas |
| **Contraseña** | P@ssw0rd123 | Sí (.env.vagrant) | Contraseña segura |
| **Autenticación** | NLA | Sí (script) | Network Level Authentication |
| **Cifrado** | TLS 1.2 | Sí (Windows) | Cifrado de conexión |
| **Compresión** | Habilitada | Sí (cliente) | Compresión de datos |

## 🔄 Alternativas de Conexión

### VirtualBox GUI
- Abrir VirtualBox
- Seleccionar la VM "Win10-BatchLab"
- Hacer clic en "Iniciar"

### SSH (si está disponible)
```bash
vagrant ssh
```

### WinRM (para automatización)
```bash
# Verificar WinRM
vagrant winrm -e "Get-ComputerInfo"

# Ejecutar comando remoto
vagrant winrm -e "Get-Process"
```

## 📞 Soporte Avanzado

### Logs Detallados
```bash
# Logs de Vagrant
vagrant up --debug

# Logs de VirtualBox
VBoxManage showvminfo Win10-BatchLab

# Logs de RDP en Windows
Get-EventLog -LogName "Microsoft-Windows-RemoteDesktopServices-RdpCoreTS/Operational"
```

### Recuperación de Errores
```bash
# Limpiar completamente
vagrant destroy -f
vagrant up

# Re-provisionar
vagrant provision

# Verificar configuración
vagrant validate
```

## 🎓 Casos de Uso Específicos

### Para Desarrollo
- **Resolución:** 1920x1080 o superior
- **Colores:** 24-bit
- **Experiencia:** Optimizar para desarrollo

### Para Administración
- **Resolución:** 1366x768 (suficiente)
- **Colores:** 16-bit (mejor rendimiento)
- **Experiencia:** Optimizar para conexión de área local

### Para Pruebas
- **Resolución:** 1024x768
- **Colores:** 8-bit (máximo rendimiento)
- **Experiencia:** Deshabilitar efectos visuales

---

**Curso de Administración de Windows desde la Consola**

# 🖥️ Entorno de Pruebas para Scripts Batch y PowerShell

Este entorno proporciona una máquina virtual Windows 10 completamente optimizada para el desarrollo, pruebas y aprendizaje de scripts Batch y PowerShell. Incluye herramientas de desarrollo, configuraciones optimizadas y un entorno listo para usar.

## 🚀 Inicio Rápido

### 1. Configurar Entorno
```bash
# Copiar archivo de configuración
copy env.vagrant.example .env.vagrant

# Editar configuración (opcional)
notepad .env.vagrant
```

### 2. Iniciar VM
```bash
vagrant up
```

### 3. Conectarse
- **RDP:** `vagrant rdp` o usar cliente RDP (127.0.0.1:3389)
- **Usuario:** `batchtester`
- **Contraseña:** `P@ssw0rd123`

### 4. ¡Listo para Usar!
Los scripts Batch y PowerShell estarán en `C:\BatchScripts` dentro de la VM.

## 📋 Requisitos del Sistema

### Software Requerido
- [Vagrant](https://www.vagrantup.com/downloads) (versión 2.0+)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads) (versión 6.0+)
- Windows 10/11 como sistema host

### Recursos Mínimos
- **RAM:** 8GB disponible (16GB recomendado)
- **Disco:** 50GB espacio libre
- **CPU:** 4 núcleos recomendados

## ⚙️ Configuración de la VM

| Componente | Valor por Defecto | Configurable |
|------------|-------------------|--------------|
| **Sistema Operativo** | Windows 10 | Sí (box) |
| **RAM** | 16GB | Sí (.env.vagrant) |
| **CPU** | 4 núcleos | Sí (.env.vagrant) |
| **Disco** | 120GB | Sí (.env.vagrant) |
| **Red** | Host-only + RDP | Sí (.env.vagrant) |
| **Usuario** | `batchtester` | Sí (.env.vagrant) |
| **Contraseña** | `P@ssw0rd123` | Sí (.env.vagrant) |

## 🛠️ Herramientas Instaladas

### Editores y IDEs
- **Notepad++** - Editor de texto avanzado
- **Visual Studio Code** - IDE moderno
- **PowerShell ISE** - Editor integrado de PowerShell

### Utilidades del Sistema
- **7-Zip** - Compresión de archivos
- **Git** - Control de versiones
- **Windows Terminal** - Terminal moderno

### Herramientas de Análisis
- **Sysinternals Suite** - Herramientas avanzadas de Windows (instalación manual recomendada)
- **Process Explorer** - Monitoreo de procesos (disponible en Sysinternals)
- **Autoruns** - Análisis de inicio del sistema (disponible en Sysinternals)

### Scripts de Prueba
- **Script de muestra** - `C:\BatchScripts\test\sample-test.bat`
- **Directorios organizados** - test, logs, temp, backup

## 🔧 Personalización

### Archivo de Configuración (.env.vagrant)

```bash
# Copiar archivo de ejemplo
copy env.vagrant.example .env.vagrant

# Editar configuración
notepad .env.vagrant
```

### Variables Disponibles

```bash
# Box configuration
VAGRANT_BOX=gusztavvargadr/windows-10
VAGRANT_BOX_VERSION=2506.0.0

# VM configuration
VAGRANT_VM_NAME=Win10-BatchLab
VAGRANT_VM_RAM=16384
VAGRANT_VM_CPUS=4
VAGRANT_VM_DISK_SIZE=40

# User credentials
VAGRANT_WIN_USER=batchtester
VAGRANT_WIN_PASS=P@ssw0rd123

# Network configuration
VAGRANT_RDP_PORT=3389
VAGRANT_HOST_ONLY_IP=192.168.56.10

# Scripts configuration
VAGRANT_SCRIPTS_PATH=../scripts
VAGRANT_SCRIPTS_DESTINATION=C:/BatchScripts
```

## 🎯 Características Optimizadas

### Configuración de Windows
- **PowerShell Execution Policy** - Configurado para desarrollo
- **Explorer** - Extensiones y archivos ocultos visibles
- **Command Prompt** - Colores y QuickEdit habilitados
- **UAC** - Reducido para desarrollo
- **Long Path Support** - Habilitado
- **Windows Defender** - Exclusiones para scripts

### Rendimiento
- **Power Settings** - Alto rendimiento
- **Visual Effects** - Optimizados para rendimiento
- **Windows Update** - Sin reinicio automático

### Accesos Directos
- **BatchScripts** - Carpeta de scripts
- **Command Prompt** - En directorio de scripts
- **PowerShell** - En directorio de scripts
- **PowerShell ISE** - Editor integrado
- **Notepad++** - Editor avanzado
- **Windows Terminal** - Terminal moderno

## 🛠️ Comandos Útiles

### Gestión de la VM
```bash
vagrant up              # Iniciar VM
vagrant halt            # Apagar VM
vagrant reload          # Reiniciar VM
vagrant destroy -f      # Eliminar VM completamente
vagrant status          # Estado de la VM
```

### Conexión
```bash
vagrant rdp             # Conectar vía RDP
vagrant port            # Ver puertos asignados
```

### Mantenimiento
```bash
cleanup.bat             # Limpiar archivos temporales
```

## 📁 Estructura del Proyecto

```
vagrant/
├── Vagrantfile                 # Configuración principal
├── env.vagrant.example         # Variables de entorno (ejemplo)
├── .env.vagrant               # Variables de entorno (personalizado)
├── cleanup.bat                # Script de limpieza
├── provision/                 # Scripts de provisión
│   ├── create-user.ps1        # Crear usuario y RDP
│   ├── install-guest-additions.ps1  # Instalar Guest Additions
│   ├── configure-windows.ps1  # Configurar Windows
│   └── install-dev-tools.ps1  # Instalar herramientas de desarrollo
├── README.md                  # Este archivo
└── RDP.md                     # Guía de conexión RDP
```

## 📂 Estructura en la VM

```
C:\BatchScripts\
├── test\                      # Scripts de prueba
│   └── sample-test.bat        # Script de muestra
├── logs\                      # Archivos de log
├── temp\                      # Archivos temporales
├── backup\                    # Copias de seguridad
└── [scripts del curso]        # Scripts del curso
```

## 🔒 Seguridad

- **Sin carpetas compartidas** por defecto (seguridad)
- **Usuario de pruebas** con contraseña fuerte
- **Red host-only** para aislamiento
- **RDP limitado** a localhost
- **Provisión automatizada** y verificable

## 🐛 Troubleshooting

### Problemas Comunes

1. **VM no inicia**
   ```bash
   vagrant destroy -f
   vagrant up
   ```

2. **Error de puerto RDP**
   ```bash
   vagrant port
   # Usar el puerto mostrado en lugar de 3389
   ```

3. **Problemas de rendimiento**
   - Reducir RAM en `.env.vagrant`
   - Verificar recursos del host
   - Deshabilitar antivirus temporalmente

4. **Error de Guest Additions**
   - La VM funcionará sin Guest Additions
   - Reinstalar VirtualBox si es necesario

5. **Errores de instalación de herramientas**
   - Algunos paquetes pueden fallar por problemas de red o checksum
   - Las herramientas principales (Notepad++, Git, VS Code) se instalan automáticamente
   - Sysinternals se puede instalar manualmente desde la web oficial
   - La VM funcionará correctamente incluso si algunas herramientas fallan

6. **Errores de usuario "Cannot remove the last Administrator"**
   - Es normal si el usuario ya existe o hay restricciones de política
   - El entorno seguirá funcionando correctamente
   - RDP estará disponible con las credenciales configuradas

7. **Errores de "Security error" en configuración de Windows**
   - Es normal debido a restricciones de política o permisos
   - Las configuraciones principales se aplicarán correctamente
   - El entorno seguirá siendo funcional para desarrollo

8. **Errores de sintaxis en scripts de PowerShell**
   - Corregidos en las últimas versiones
   - Los scripts ahora manejan errores de manera robusta
   - La provisión continuará incluso si algunos pasos fallan

### Logs y Debugging
```bash
vagrant up --debug      # Modo debug
vagrant provision       # Re-ejecutar provisión
```

## 🎓 Casos de Uso

### Para Aprendizaje
- Pruebas seguras de scripts
- Experimentación con comandos
- Entorno aislado para prácticas

### Para Desarrollo
- Testing de scripts antes de producción
- Debugging en entorno controlado
- Desarrollo de automatizaciones

### Para Administración
- Pruebas de scripts de administración
- Validación de configuraciones
- Testing de políticas de grupo

## 📞 Soporte

Para problemas específicos:
1. Revisar logs con `vagrant up --debug`
2. Verificar configuración en `.env.vagrant`
3. Consultar documentación de Vagrant y VirtualBox

## 🔄 Actualizaciones

Para aplicar nuevas configuraciones:
```bash
vagrant provision        # Re-ejecutar provisión
vagrant reload --provision  # Reiniciar y re-provisionar
```

---

**Curso de Administración de Windows desde la Consola**

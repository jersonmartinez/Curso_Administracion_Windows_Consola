# Windows 10 Lab Environment for Batch Script Testing

Este entorno permite crear una máquina virtual Windows 10 optimizada para pruebas de scripts Batch y administración desde la consola, usando Vagrant y VirtualBox.

## 🚀 Guía Rápida

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

### 4. Scripts Disponibles
Los scripts Batch estarán en `C:\BatchScripts` dentro de la VM.

## 📋 Requisitos

- [Vagrant](https://www.vagrantup.com/downloads) (versión 2.0+)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads) (versión 6.0+)
- Windows 10/11 como sistema host
- Mínimo 8GB RAM disponible
- 50GB espacio libre en disco

## ⚙️ Configuración de la VM

| Componente | Valor por Defecto | Configurable |
|------------|-------------------|--------------|
| **Sistema Operativo** | Windows 10 | Sí (box) |
| **RAM** | 16GB | Sí (.env.vagrant) |
| **CPU** | 4 núcleos | Sí (.env.vagrant) |
| **Disco** | 40GB | Sí (.env.vagrant) |
| **Red** | Host-only + RDP | Sí (.env.vagrant) |
| **Usuario** | `batchtester` | Sí (.env.vagrant) |
| **Contraseña** | `P@ssw0rd123` | Sí (.env.vagrant) |

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

### Logs y Debugging
```bash
vagrant up --debug      # Modo debug
vagrant provision       # Re-ejecutar provisión
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
│   └── configure-windows.ps1  # Configurar Windows
├── README.md                  # Este archivo
└── RDP.md                     # Guía de conexión RDP
```

## 🎯 Características Optimizadas

- **Provisión modular** con scripts PowerShell separados
- **Configuración flexible** mediante variables de entorno
- **Mensajes informativos** durante la provisión
- **Configuración de Windows** optimizada para desarrollo
- **Accesos directos** en el escritorio para herramientas comunes

## 📞 Soporte

Para problemas específicos:
1. Revisar logs con `vagrant up --debug`
2. Verificar configuración en `.env.vagrant`
3. Consultar documentación de Vagrant y VirtualBox

---

**Curso de Administración de Windows desde la Consola**

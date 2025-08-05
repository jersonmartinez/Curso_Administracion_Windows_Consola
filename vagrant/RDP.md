# Acceso Remoto vía RDP a la VM de Windows 10

La máquina virtual creada con este entorno permite el acceso remoto mediante el protocolo RDP (puerto 3389).

## 🚀 Conexión Rápida

### Método 1: Usando Vagrant (Recomendado)
```bash
vagrant rdp
```

### Método 2: Cliente RDP Manual

1. **Inicia la VM:**
   ```bash
   vagrant up
   ```

2. **Verifica el puerto RDP asignado:**
   ```bash
   vagrant port
   ```
   Busca la línea correspondiente a `3389` para saber el puerto real en tu host.

3. **Conéctate desde tu cliente RDP favorito:**
   - **Host:** `127.0.0.1`
   - **Puerto:** (el que indique `vagrant port`, por defecto 3389)
   - **Usuario:** `batchtester`
   - **Contraseña:** `P@ssw0rd123`

## 🔧 Configuración de Clientes RDP

### Windows (mstsc)
```bash
# Abrir cliente RDP
mstsc

# O desde línea de comandos
mstsc /v:127.0.0.1:3389
```

### macOS (Microsoft Remote Desktop)
1. Descargar desde App Store
2. Agregar nueva conexión
3. Configurar con los datos anteriores

### Linux (Remmina)
```bash
# Instalar Remmina
sudo apt install remmina remmina-plugin-rdp

# Abrir y configurar nueva conexión
remmina
```

## 🔒 Configuración de Seguridad

### Configuraciones Aplicadas
- **Network Level Authentication (NLA)** habilitado
- **Firewall de Windows** configurado para RDP
- **Acceso limitado** a localhost (127.0.0.1)
- **Usuario de pruebas** con permisos administrativos

### Personalización de Seguridad
Para cambiar la configuración de seguridad, edita el archivo `.env.vagrant`:

```bash
# Cambiar credenciales
VAGRANT_WIN_USER=tu_usuario
VAGRANT_WIN_PASS=tu_contraseña

# Cambiar puerto RDP
VAGRANT_RDP_PORT=3390
```

## 🐛 Troubleshooting RDP

### Problemas Comunes

1. **VM no responde**
   ```bash
   vagrant status
   vagrant reload
   ```

2. **Puerto ocupado**
   ```bash
   vagrant port
   # Usar el puerto mostrado en lugar de 3389
   ```

3. **Error de autenticación**
   - Verificar usuario: `batchtester`
   - Verificar contraseña: `P@ssw0rd123`
   - Revisar configuración en `.env.vagrant`

4. **Conexión rechazada**
   ```bash
   # Verificar que RDP esté habilitado
   vagrant provision
   ```

5. **Problemas de rendimiento**
   - Reducir resolución en el cliente RDP
   - Deshabilitar efectos visuales
   - Verificar recursos del host

### Verificación de Estado

```bash
# Verificar estado de la VM
vagrant status

# Verificar puertos asignados
vagrant port

# Verificar logs de la VM
vagrant up --debug
```

### Reiniciar Servicios RDP

Si hay problemas persistentes, puedes reiniciar los servicios RDP:

```powershell
# Desde PowerShell en la VM
Restart-Service TermService -Force
Restart-Service UmRdpService -Force
```

## 📊 Información de Conexión

| Parámetro | Valor por Defecto | Configurable |
|-----------|-------------------|--------------|
| **Host** | 127.0.0.1 | No |
| **Puerto** | 3389 | Sí (.env.vagrant) |
| **Usuario** | batchtester | Sí (.env.vagrant) |
| **Contraseña** | P@ssw0rd123 | Sí (.env.vagrant) |
| **Autenticación** | NLA | Sí (script) |
| **Cifrado** | TLS 1.2 | Sí (Windows) |

## 🔄 Alternativas de Conexión

### VirtualBox GUI
- Abrir VirtualBox
- Seleccionar la VM "Win10-BatchLab"
- Hacer clic en "Iniciar"

### SSH (si está disponible)
```bash
vagrant ssh
```

## 📞 Soporte

Para problemas específicos de RDP:

1. **Verificar requisitos:**
   ```bash
   check-requirements.bat
   ```

2. **Recrear la VM:**
   ```bash
   vagrant destroy -f
   vagrant up
   ```

3. **Revisar logs:**
   ```bash
   vagrant up --debug
   ```

4. **Consultar documentación:**
   - [Vagrant RDP Plugin](https://github.com/hashicorp/vagrant/tree/main/plugins/communicators/winrm)
   - [Microsoft RDP Documentation](https://docs.microsoft.com/en-us/windows-server/remote/remote-desktop-services/)

---

**Curso de Administración de Windows desde la Consola**

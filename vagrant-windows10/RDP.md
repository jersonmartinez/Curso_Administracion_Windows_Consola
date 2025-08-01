# Acceso remoto vía RDP a la VM de Windows 11

La máquina virtual creada con este entorno permite el acceso remoto mediante el protocolo RDP (puerto 3389).

## ¿Cómo conectarse por RDP?

1. **Inicia la VM:**
   ```bash
   vagrant up
   ```
2. **Conéctate desde tu cliente RDP favorito:**
   - **Host:** `127.0.0.1`
   - **Puerto:** `3389`
   - **Usuario:** `batchtester`
   - **Contraseña:** `P@ssw0rd123`

3. **Nota:** Si el puerto 3389 está ocupado en tu host, Vagrant lo ajustará automáticamente y te mostrará el puerto asignado en la salida de `vagrant up`.

## Seguridad
- El acceso RDP está limitado a la máquina local por defecto (`127.0.0.1`).
- Cambia la contraseña del usuario de pruebas si lo consideras necesario.

---
**Curso de Administración de Windows desde la Consola**

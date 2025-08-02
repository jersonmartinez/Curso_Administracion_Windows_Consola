# Acceso remoto vía RDP a la VM de Windows 10

La máquina virtual creada con este entorno permite el acceso remoto mediante el protocolo RDP (puerto 3389).

## ¿Cómo conectarse por RDP?

1. **Inicia la VM:**
   ```bash
   vagrant up
   ```
2. **Verifica el puerto RDP asignado:**
   ```bash
   vagrant port
   ```
   - Busca la línea correspondiente a `3389` para saber el puerto real en tu host.
3. **Conéctate desde tu cliente RDP favorito:**
   - **Host:** `127.0.0.1`
   - **Puerto:** (el que indique `vagrant port`, por defecto 3389)
   - **Usuario:** El definido en `.env.vagrant` (por defecto: `batchtester`)
   - **Contraseña:** La definida en `.env.vagrant` (por defecto: `P@ssw0rd123`)

4. **Nota:** Si el puerto 3389 está ocupado en tu host, Vagrant lo ajustará automáticamente y te mostrará el puerto asignado en la salida de `vagrant up` o con `vagrant port`.

## Troubleshooting RDP
- Verifica que la VM esté encendida (`vagrant status`).
- Usa `vagrant port` para confirmar el puerto real.
- Desactiva firewalls en la VM solo para pruebas.
- Asegúrate de que el usuario y contraseña coincidan con los definidos en `.env.vagrant`.
- Si usas Windows, prueba con el cliente `mstsc`.

## Seguridad
- El acceso RDP está limitado a la máquina local por defecto (`127.0.0.1`).
- Cambia la contraseña del usuario de pruebas tras la provisión inicial si el entorno será compartido.
- No expongas el puerto RDP a redes públicas.

---
**Curso de Administración de Windows desde la Consola**

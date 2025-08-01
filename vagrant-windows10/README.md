## Guía rápida de instalación y uso

1. Instala [Vagrant](https://www.vagrantup.com/downloads) y [VirtualBox](https://www.virtualbox.org/wiki/Downloads).
2. Clona este repositorio y entra al directorio `vagrant-windows10`.
3. Ejecuta:
   ```bash
   vagrant up
   ```
4. Accede a la VM por VirtualBox o RDP (usuario: batchtester, contraseña: P@ssw0rd123).
5. Los scripts Batch estarán en `C:/BatchScripts` dentro de la VM.

Para apagar la VM:
```bash
vagrant halt
```
Para eliminar la VM:
```bash
vagrant destroy -f
```

# Laboratorio de Administración de Windows 10 con Vagrant y VirtualBox

Este entorno permite crear una máquina virtual Windows 10 lista para pruebas de scripts Batch y administración desde la consola, usando Vagrant y VirtualBox.

## Requisitos
- [Vagrant](https://www.vagrantup.com/downloads)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- Box: `gusztavvargadr/windows-10` (descarga automática)

## Configuración de la VM
- **SO:** Windows 10
- **RAM:** 16GB
- **CPU:** 4 núcleos
- **Disco:** 40GB
- **Red:** Privada (DHCP)
- **Usuario de pruebas:** `batchtester` (contraseña: `P@ssw0rd123`)
- **Scripts:** Copiados a `C:/BatchScripts`

## Seguridad
- Sin carpetas compartidas por defecto
- Usuario de pruebas con contraseña fuerte
- Provisión automatizada

## Pasos para implementación
1. Clona el repositorio y entra al directorio `vagrant-windows11`:
   ```bash
   cd vagrant-windows11
   ```
2. Inicia la máquina virtual:
   ```bash
   vagrant up
   ```
3. Accede vía VirtualBox o RDP (usuario: `batchtester`)
4. Los scripts de Batch estarán en `C:/BatchScripts` dentro de la VM.

## Apagar y destruir la VM
- Para apagar:
  ```bash
  vagrant halt
  ```
- Para eliminar completamente:
  ```bash
  vagrant destroy -f
  ```

## Notas
- Puedes modificar el `Vagrantfile` para ajustar recursos.
- El box usado es público y mantenido, pero puedes cambiarlo por otro si lo prefieres.
- Revisa la documentación oficial de Vagrant para más opciones de provisión y seguridad.

---
**Curso de Administración de Windows desde la Consola**

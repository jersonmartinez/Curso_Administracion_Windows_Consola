# Documentación y referencias de scripts Batch y PowerShell

> Este archivo referencia y documenta los scripts incluidos en el repositorio, organizados por capítulo y directorio. Cada script está documentado en su capítulo correspondiente (`*.md`).

---

## Ejemplo de documentación para un script

### scripts/51-comprobar-disco/chkdsk-informacion-basica.bat
```batch
@echo off
REM Muestra información básica del disco C:\
chkdsk C:\
```

- **Descripción:** Muestra el estado y la información básica del disco C: usando `chkdsk`.
- **Uso:** Ejecutar el script como administrador en la terminal.
- **Salida esperada:**
  ```
  El tipo del sistema de archivos es NTFS.
  ...
  Windows ha comprobado el sistema de archivos y no encontró problemas.
  ...
  ```
- **Referencia:** Ver capítulo 51. Comprobar disco y mostrar información de estado.

---

## Estructura y referencia de scripts por capítulo (51-60)

> Los scripts están organizados en subdirectorios descriptivos bajo `scripts/`, siguiendo la convención: `scripts/<número-capítulo>-<tema-resumido>/<nombre-descriptivo>.bat|.ps1`

| Capítulo | Directorio de scripts | Ejemplo de scripts | Descripción breve |
|----------|----------------------|--------------------|-------------------|
| 51. Comprobar disco y mostrar información de estado | scripts/51-comprobar-disco/ | chkdsk-informacion-basica.bat, listar-volumenes.ps1 | Comprobación y diagnóstico de discos |
| 52. Formatear discos | scripts/52-formatear-discos/ | formatear-usb-fat32.bat, formatear-disco-rapido.ps1 | Formateo seguro y rápido de discos |
| 53. Crear particiones de disco | scripts/53-crear-particiones-disco/ | crear-particion-ntfs.bat, crear-particion-efi.ps1 | Creación y gestión de particiones |
| 54. Desmontar, Extender volúmenes de disco | scripts/54-desmontar-extender-volumenes-disco/ | desmontar-volumen.bat, extender-volumen.ps1 | Gestión avanzada de volúmenes |
| 55. Recuperar información | scripts/55-recuperar-informacion/ | recuperar-archivos-eliminados.bat | Recuperación de datos |
| 56. Examinar integridad de los datos | scripts/56-examinar-integridad-datos/ | comprobar-integridad-archivos.ps1 | Verificación de integridad |
| 57. Uso de Robocopy | scripts/57-uso-robocopy/ | copia-segura-robocopy.bat | Copias robustas de archivos |
| 58. Backups | scripts/58-backups/ | backup-completo.bat, backup-incremental.ps1 | Automatización de copias de seguridad |
| 59. Comprobar la seguridad en el sistema | scripts/59-comprobar-seguridad-sistema/ | listar-usuarios.bat, comprobar-permisos.ps1 | Auditoría y seguridad |
| 60. Gestionar Credenciales Almacenadas | scripts/60-gestionar-credenciales-almacenadas/ | exportar-credenciales.ps1 | Gestión de credenciales |

> Para ver la lista completa de scripts y su documentación, consulta el directorio `scripts/` y los capítulos correspondientes (`*.md`).

---

## Buenas prácticas y recomendaciones

- Usa nombres descriptivos y guiones para separar palabras en los nombres de scripts y carpetas.
- No incluyas scripts embebidos en la documentación; solo ejemplos directos y referencias.
- Añade advertencias de seguridad cuando el script pueda afectar datos críticos.
- Documenta cada script con: descripción, uso, salida esperada, advertencias y referencia al capítulo.

---

## Ejemplo de tabla de referencia para scripts extraídos

| Script | Descripción | Uso | Advertencia |
|--------|-------------|-----|------------|
| chkdsk-informacion-basica.bat | Muestra información básica del disco C: | Ejecutar como admin | Puede requerir reinicio |
| formatear-usb-fat32.bat | Formatea una USB en FAT32 | Ejecutar como admin | Borra todos los datos |

---

## Recursos útiles
- [Documentación oficial de Microsoft](https://learn.microsoft.com/es-es/windows-server/administration/windows-commands/windows-commands)
- [Referencia Batch](https://ss64.com/nt/)
- [Guía de scripting en Windows](https://learn.microsoft.com/es-es/powershell/scripting/samples/sample-scripts)

---

## Preguntas frecuentes (FAQ) y troubleshooting

### ¿Por qué algunos scripts requieren permisos de administrador?
Algunas operaciones (formateo, particiones, gestión de volúmenes) requieren privilegios elevados para ejecutarse correctamente.

### ¿Cómo pruebo los scripts de forma segura?
Utiliza el entorno Vagrant/VirtualBox incluido para pruebas aisladas y restauración rápida.

### ¿Qué hago si un script falla o no produce la salida esperada?
Revisa la sintaxis, ejecuta la terminal como administrador y consulta la documentación del capítulo correspondiente.

### ¿Dónde encuentro ejemplos de salida esperada y diagramas de flujo?
Cada capítulo relevante incluye ejemplos de salida y diagramas Mermaid para visualizar el flujo de operaciones.

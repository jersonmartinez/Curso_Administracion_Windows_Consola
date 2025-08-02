# Buenas prácticas de seguridad en Batch, PowerShell y administración de Windows

- Usa contraseñas fuertes y cambia las credenciales por defecto en entornos de pruebas y producción.
- Limita permisos de los usuarios y scripts. Usa cuentas estándar para pruebas y solo eleva privilegios cuando sea imprescindible.
- No ejecutes scripts Batch o PowerShell como administrador salvo que sea necesario. Documenta claramente los riesgos.
- Valida entradas y evita inyecciones de comandos. Nunca uses variables de usuario sin sanitizar.
- Mantén el sistema, scripts y dependencias actualizados.
- Realiza backups periódicos de tus scripts y datos críticos.
- Usa entornos de prueba (como Vagrant/VirtualBox) para validar cambios antes de producción. Separa variables sensibles en archivos `.env` y nunca los subas a repositorios públicos.
- Documenta y revisa los cambios realizados en los scripts. Usa control de versiones y revisiones de seguridad.
- Elimina archivos temporales, logs y credenciales sensibles tras la ejecución de los scripts.
- Deshabilita servicios y puertos innecesarios en la VM. Limita el acceso RDP solo a la IP local (`127.0.0.1`).
- Cambia la contraseña del usuario de pruebas tras la provisión inicial si el entorno será compartido.
- Consulta siempre la [documentación oficial de Microsoft](https://learn.microsoft.com/es-es/windows-server/administration/windows-commands/windows-commands) y las guías de hardening para mejores prácticas.

## Seguridad en Vagrant y VirtualBox

- Usa variables de entorno o archivos `.env` para credenciales y configuración sensible.
- No expongas el puerto RDP (3389) a redes públicas. Usa solo reenvío local (`127.0.0.1`).
- Si tienes problemas de conexión RDP:
  - Verifica que la VM esté encendida y el puerto 3389 esté libre en tu host.
  - Usa `vagrant port` para ver el puerto asignado si hay autocorrección.
  - Desactiva firewalls en la VM solo para pruebas, nunca en producción.
  - Asegúrate de que el usuario y contraseña coincidan con los definidos en `.env.vagrant`.
  - Revisa la configuración de red: debe ser `private_network` o `forwarded_port` solo a localhost.

---
**Recuerda:** Nunca reutilices credenciales de pruebas en entornos reales y elimina usuarios temporales tras finalizar el laboratorio.

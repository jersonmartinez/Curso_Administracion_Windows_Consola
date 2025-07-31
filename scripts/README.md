# 📁 Scripts del Curso de Administración de Windows desde la Consola

Este directorio contiene todos los scripts de ejemplo y utilidades prácticas organizados por capítulos del curso.

## 📂 Estructura de directorios

```
scripts/
├── 12-manipulacion-fecha-hora/
│   └── getCurrentTime.bat
├── 15-variables/
│   ├── input.bat
│   └── calculadora.bat
├── 17-path-ruta-busqueda/
│   ├── verificar-ruta-path.bat
│   ├── entorno-desarrollo.bat
│   └── backup-path.bat
├── 18-manejo-cadenas/
│   ├── procesador-fecha.bat
│   └── procesador-hora.bat
├── 19-buscar-ubicar-archivos/
│   ├── buscador-duplicados.bat
│   ├── busqueda-directorios-especificos.bat
│   └── generador-reportes.bat
└── README.md
```

## 🎯 Capítulos con scripts disponibles

### 📅 Capítulo 12: Manipulación de fecha y hora
- **getCurrentTime.bat** - Muestra la hora actual de forma dinámica

### 🔧 Capítulo 15: Variables
- **input.bat** - Demuestra el uso de SET /P para entrada del usuario
- **calculadora.bat** - Calculadora básica con operaciones aritméticas

### 🛤️ Capítulo 17: Path - Establecer una ruta de búsqueda
- **verificar-ruta-path.bat** - Verifica si una ruta está en el PATH
- **entorno-desarrollo.bat** - Configura entorno de desarrollo completo
- **backup-path.bat** - Crea backup del PATH con timestamp

### 🔤 Capítulo 18: Manejo de cadenas
- **procesador-fecha.bat** - Extrae componentes de la fecha del sistema
- **procesador-hora.bat** - Extrae componentes de la hora del sistema

### 🔍 Capítulo 19: Buscar y Ubicar archivos
- **buscador-duplicados.bat** - Busca archivos duplicados por nombre
- **busqueda-directorios-especificos.bat** - Búsqueda en directorios específicos
- **generador-reportes.bat** - Genera reportes de archivos grandes

## 🚀 Cómo usar los scripts

1. **Navega al directorio del script:**
   ```batch
   cd scripts\[numero-capítulo]-[nombre-capítulo]
   ```

2. **Ejecuta el script:**
   ```batch
   .\[nombre-del-script].bat
   ```

3. **O ejecuta desde cualquier ubicación:**
   ```batch
   .\scripts\[numero-capítulo]-[nombre-capítulo]\[nombre-del-script].bat
   ```

## 📝 Notas importantes

- Todos los scripts están comentados en inglés siguiendo las mejores prácticas
- Los scripts son ejemplos educativos y pueden requerir modificaciones para uso en producción
- Algunos scripts requieren privilegios de administrador para funcionar correctamente
- Los scripts están diseñados para Windows 10/11 y versiones posteriores

## 🔗 Enlaces a la documentación

Cada script está referenciado en su capítulo correspondiente del curso. Consulta la documentación para entender el contexto y uso de cada script.

---

**Autor:** Ing. Jerson Martínez  
**Curso:** Administración de Windows desde la Consola  
**Repositorio:** [ShellScriptBatch](https://github.com/jersonmartinez/ShellScriptBatch) 
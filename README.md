<h1 align="center"> :clipboard: Administración de Windows desde la Consola </h1>

<details> <summary>0. Administración de Windows desde la Consola</summary>
  
<h3 align="center"> :clipboard: <a href="https://github.com/jersonmartinez/Curso_Administracion_Windows_Consola/blob/master/0.%20Administraci%C3%B3n%20de%20Windows%20desde%20la%20Consola.md">Administración de Windows desde la Consola</a> </h3>

[![#0. Administración de Windows desde la Consola](https://img.youtube.com/vi/X18jJBXK8jM/maxresdefault.jpg)](https://youtu.be/X18jJBXK8jM "#0. Administración de Windows desde la Consola")

**Capítulos que se estarán abordando en el curso**

✅ 1. Comandos muy básicos y muy importantes

✅ 2. Rutas de acceso

✅ 3. Gestión de directorios

✅ 4. Gestión de ficheros

✅ 5. Árbol de directorios

✅ 6. Copiar y Mover directorios y ficheros

✅ 7. PUSHD & POPD

✅ 8. Instancias | CMD

✅ 9. Máscaras y Comodines

✅ 10. Gestión del Prompt

✅ 11. Teclas de función en la consola

✅ 12. Manipulación de hora y fecha

✅ 13. Tuberías | Pipes

✅ 14. Direccionamiento y desvío de comandos

✅ 15. Variables

✅ 16. Variables de entorno

✅ 17. Path - Establecer una ruta de búsqueda

✅ 18. Manejo de cadenas

✅ 19. Buscar y Ubicar archivos

✅ 20. Comparar archivos o ficheros

✅ 21. Buscar cadenas en archivos

✅ 22. Compresión de archivos y directorios

✅ 23. Expandir arcihvos comprimidos

✅ 24. Llamadas a programas externos

✅ 25. Copiar información al portapapeles

✅ 26. Ordenar datos

✅ 27. Asociar archivos con extensiones

✅ 28. Asignación de permisos

✅ 29. Vínculos simbólicos

✅ 30. Información del sistema

✅ 31. Apagar, Reiniciar y Cerrar sesión

✅ 32. Gestión de usuarios

✅ 33. Habilitar usuario Administrador

✅ 34. Gestión de Procesos

✅ 35. Conexiones de red

✅ 36. Obtener contraseñas guardadas

✅ 37. Crear red hospedada

✅ 38. Enviar mensajes a usuarios

✅ 39. Envío de señales

✅ 40. Ejecutar como Administrador - RUNAS

✅ 41. Escritorio Remoto

✅ 42. Programador de Tareas

✅ 43. Gestión de un servidor FTP

✅ 44. Gestión de un servidor DHCP

✅ 45. Gestión de un servidor DNS

✅ 46. Bitlocker

✅ 47. Etiquetar discos

✅ 48. Unidad Virtual

✅ 49. Liberar espacio en disco

✅ 50. Optimizar y desfragmentar disco

✅ 51. Comprobar disco y mostrar información de estado

✅ 52. Formatear discos

✅ 53. Crear particiones de disco

✅ 54. Desmontar, Extender volúmenes de disco

✅ 55. Recuperar información

✅ 56. Examinar integridad de los datos

✅ 57. Uso de Robocopy

✅ 58. Backups

✅ 59. Comprobar la seguridad en el sistema

✅ 60. Gestiona Credenciales Almacenadas

✅ 61. Información de rendimiento de recursos

✅ 62. Configuración de Energía

✅ 63. Gestionar Servicios

✅ 64. Windows To Go

✅ 65. Utilidad de zona horaria de Windows

✅ 66. Administración de Windows - WMIC

✅ 67. Registros

✅ 68. CURL

✅ 69. SHELL

✅ 70. Papelera de reciclaje (Esto se solicitó hace un par de días)

---


</details><details> <summary>1. Comandos Básicos</summary>
<h3 align="center"> :clipboard: <a href="https://github.com/jersonmartinez/Curso_Administracion_Windows_Consola/blob/master/1.%20Comandos%20B%C3%A1sicos.md">Comandos Básicos</a> </h3>

[![#1. Comandos Básicos - Administración de Windows desde la Consola](https://img.youtube.com/vi/_t-p2mcE7SM/maxresdefault.jpg)](https://youtu.be/_t-p2mcE7SM "#1. Comandos Básicos - Administración de Windows desde la Consola")

La forma de empezar en un curso como este, es, por supuesto, dándole una probada a varios comandos básicos y de uso constante al momento de usar la consola del sistema. 

Estos comandos son: 

Comando | Descripción
------------ | -------------
✔ TITLE | Fija el título de la ventana en la ventana del símbolo del sistema.
✔ HELP | Proporciona información de ayuda para los comandos de Windows.
✔ CLS | Borra la pantalla.
✔ DIR | Muestra la lista de subdirectorios y archivos de un directorio.
✔ ECHO | Muestra mensajes o activa y desactiva el eco del comando.
✔ PAUSE | Suspende el proceso de un programa por lotes y muestra el mensaje: Presione una tecla para continuar...
✔ START | Inicia una ventana separada para ejecutar un programa o comando especificado.
✔ REM | Registra los comentarios en un archivo por lotes o en CONFIG.SYS.
✔ DATE | Muestra o establece la fecha.
✔ TIME | Muestra o establece la hora del sistema.
✔ COLOR | Configura los colores predeterminados de primer y segundo plano de la consola.
✔ MODE | Configura los dispositivos de sistema.
✔ EXIT | Abandona el programa CMD.EXE (intérprete de comandos) o el script por lotes actual.

---

**TITLE**

```
Fija el título de la ventana en la ventana del símbolo del sistema.

TITLE [cadena]

    cadena: Especifica el título de la ventana del símbolo del sistema.
```

**HELP**

```
Proporciona información de ayuda para los comandos de Windows.

HELP [comando]

    comando: Muestra información de ayuda del comando especificado.
```

**CLS**

```
Borra la pantalla.

CLS
```

**DIR**

```
Muestra la lista de subdirectorios y archivos de un directorio.

DIR [drive:][path][filename] [/A[[:]attributes]] [/B] [/C] [/D] [/L] [/N]
  [/O[[:]sortorder]] [/P] [/Q] [/R] [/S] [/T[[:]timefield]] [/W] [/X] [/4]

  [drive:][path][filename]
              Especifica la unidad, el directorio o los archivos que se mostrar n.

  /A          Muestra los archivos con los atributos especificados.
  Atributos    D  Directorios             R  Archivos de solo lectura
               H  Archivos ocultos        A  Archivos listos para el archivado
               S  Archivos de sistema     I  Archivos indizados que no son de contenido
               L  Puntos de rean lisis             O  Archivos sin conexión
               -  Prefijo de exclusión
  /B          Usa el formato simple (sin encabezados ni resúmenes).
  /C          Muestra el separador de miles en los tamaños de los archivos. Es la opción
              predeterminada. Usa /-C para deshabilitar la aparición del separador.
  /D          Similar al listado ancho, pero los archivos aparecen en una lista ordenada por columnas.
  /L          Usa letras minúsculas.
  /N          Nuevo formato de lista larga donde los nombre de archivo aparecen en el lado derecho.
  /O          Muestra los archivos según el orden indicado.
  sortorder        N  Por nombre (orden alfabético)       S  Por tamaño (orden creciente)
               E  Por extensión (orden alfabético)  D  Por fecha y hora (el m s antiguo primero)
               G  Agrupa primero los directorios -  Prefijo para invertir el orden
  /P          Hace una pausa después de cada pantalla completa de información.
  /Q          Muestra el propietario del archivo.
  /R          Muestra las secuencias alternativas de datos del archivo.
  /S          Muestra los archivos del directorio especificado y todos sus subdirectorios.
  /T          Controla el campo de hora que se mostrar  o usar  para realizar la ordenación.
  timefield       C  Creación
              A  último acceso
              W  última modificación
  /W          Usa el formato de listado ancho.
  /X          Muestra los nombres cortos generados para los nombres
              de archivo sin formato 8dot3. El formato es el mismo que para /N, con el nombre corto especificado
              antes del nombre largo. Si no existe ningún nombre corto, se muestran
              espacios en blanco en su lugar.
  /4          Muestra los años con 4 dígitos.

Los modificadores se pueden preestablecer en la variable de entorno DIRCMD.
Para invalidar los modificadores prestablecidos, se debe agregar un prefijo a cada modificador con - (guion), por ejemplo: /-W.

```

**ECHO**

```
Muestra mensajes o activa y desactiva el eco del comando.

  ECHO [ON | OFF]
  ECHO [message]

Escribe ECHO sin par metros para mostrar la configuración actual del eco.
```

**PAUSE**

```
Suspende el proceso de un programa por lotes y muestra el mensaje
    Presione una tecla para continuar. . . 
```


**START**

```
Inicia una ventana separada para ejecutar un programa o comando especificado.

START ["título"] [/D ruta] [/I] [/MIN] [/MAX] [/SEPARATE | /SHARED]
      [/LOW | /NORMAL | /HIGH | /REALTIME | /ABOVENORMAL | /BELOWNORMAL]
      [/NODE <nodo NUMA>] [/AFFINITY <máscara de afinidad hex>] [/WAIT] [/B]
      [comando o programa] [par metros]

    "título"    Título que se mostrar  en la barra de título de la ventana.
    ruta        Directorio de inicio.
    B           Iniciar la aplicación sin crear una nueva ventana. La
                aplicación omite el manejo de ^C. A menos que la aplicación
                habilite el procesamiento de ^C, solo se podr  interrumpir la
                aplicación con ^Inter.
    I           El nuevo entorno ser  el entorno original pasado a
                cmd.exe, y no el entorno actual.
    MIN         Iniciar la ventana minimizada.
    MAX         Iniciar la ventana maximizada.
    SEPARATE    Iniciar un programa de Windows de 16 bits en un espacio de
                memoria separado.
    SHARED      Iniciar un programa de Windows de 16 bits en un espacio de
                memoria compartido.
    LOW         Iniciar la aplicación en la clase de prioridad Inactiva.
    NORMAL      Iniciar la aplicación en la clase de prioridad Normal.
    HIGH        Iniciar la aplicación en la clase de prioridad Alta.
    REALTIME    Iniciar la aplicación en la clase de prioridad Tiempo real.
    ABOVENORMAL Iniciar la aplicación en la clase de prioridad Por encima de
                lo normal.
    BELOWNORMAL Iniciar la aplicación en la clase de prioridad Por debajo
                de lo normal.
    NODE        Especifica el nodo de arquitectura de memoria no uniforme
                (NUMA) preferido como un entero decimal.
    AFFINITY    Especifica la máscara de afinidad de procesador como un
             número hexadecimal. La ejecución del proceso se restringe a
                estos procesadores.
                La máscara de afinidad se interpreta de distinta forma
                si /AFFINITY y /NODE se combinan. Especifique la máscara de
                afinidad como si la máscara del procesador del nodo NUMA
                estuviera desplazada a la derecha para comenzar por el bit
                cero. La ejecución del proceso se restringe a los procesadores
                en común entre la máscara de afinidad especificada y el nodo
                NUMA. Si no hay ningún procesador en común, la ejecución del
                proceso se restringe al nodo NUMA especificado.
    WAIT        Iniciar aplicación y esperar a que finalice
    comando o programa
                Si se trata de un comando cmd interno o un archivo por lotes,
                el procesador de comandos se ejecuta con el modificador /K en
                cmd.exe. Esto significa que la ventana permanecer  después
                de que el comando se ejecute.

                Si no es un comando cmd interno ni archivo por lotes, entonces
                se considera un programa y se ejecutar  como una aplicación
                de ventana o aplicación de consola.

    par metros  Par metros transmitidos al comando o programa

NOTA: las opciones SEPARATE y SHARED no se admiten en plataformas de 64 bits.

La especificación de /NODE permite crear los procesos de forma que se pueda
aprovechar la ubicación de memoria en los sistemas NUMA. Por ejemplo, se
pueden crear dos procesos con una comunicación estrecha entre sí mediante la
memoria compartida para compartir el mismo nodo NUMA preferido y minimizar las
latencias de memoria. Asignan memoria del mismo nodo NUMA si es posible y se
pueden ejecutar en procesadores externos al nodo especificado.

    start /NODE 1 application1.exe
    start /NODE 1 application2.exe

Estos dos procesos se pueden restringir aún más para ejecutarse en
procesadores específicos en el mismo nodo NUMA. En el siguiente ejemplo,
application1 se ejecuta en los dos procesadores de valor inferior del nodo y
application2 se ejecuta en los siguientes dos procesadores del nodo. En este
ejemplo, se da por supuesto que el nodo especificado tiene como mínimo
cuatro procesadores lógicos. Tenga en cuenta que el número de nodo se puede
cambiar a cualquier número de nodo v lido para el equipo sin necesidad de
cambiar la máscara de afinidad.

    start /NODE 1 /AFFINITY 0x3 application1.exe
    start /NODE 1 /AFFINITY 0xc application2.exe

Si las extensiones de comandos est n habilitadas, la invocación del
comando externo a través de la línea de comandos o del comando START
cambia así:

Se pueden invocar archivos no ejecutables a través de la asociación del
archivo solo con escribir el nombre del archivo como un comando. (por ej.,
WORD.DOC abriría la aplicación asociada con la extensión de archivo .DOC).
Consulte los comandos ASSOC y FTYPE para saber cómo crear estas asociaciones
dentro de un script de comandos.

Cuando se ejecuta una aplicación de 32 bits con interfaz gr fica, CMD.EXE
no espera a que la aplicación termine antes de volver al símbolo del sistema.
Este nuevo comportamiento NO ocurre si se ejecuta dentro de un
script. Cuando se ejecuta una línea de comandos cuyo primer token es la
cadena "CMD " sin extensión o ruta, entonces se reemplaza "CMD" con el valor
de la variable COMSPEC. Esto evita tomar CMD.EXE del directorio actual.

Cuando se ejecuta una línea de comandos cuyo primer token NO contiene una
extensión, entonces CMD.EXE usa el valor de la variable de entorno PATHEXT
para determinar las extensiones que hay que buscar y en que orden. El valor
predeterminado para la variable PATHEXT es:

.COM;.EXE;.BAT;.CMD

Tenga en cuenta que la sintaxis es la misma que la variable PATH, con los
puntos y comas separando los elementos diferentes.

Cuando se busca un archivo ejecutable, si no hay ninguna coincidencia en
ninguna extensión, entonces se comprueba si el nombre coincide con el nombre
de un directorio. Si es así, el comando START inicia el explorador en esa
ruta. Si se hace desde la línea de comandos, es equivalente a hacer CD /D
en esa ruta.
```

**REM**

```
Registra los comentarios en un archivo por lotes o en CONFIG.SYS.

REM [comentario]
```

**DATE**

```
Muestra o establece la fecha.

DATE  [/T | fecha]

Escriba DATE sin par metros para mostrar la fecha actual y poder 
especificar una nueva. Presione Entrar para mantener la misma fecha.

Si est n habilitadas las extensiones de comandos, el comando DATE admite
el par metro /T, que indica al comando mostrar tan solo la fecha actual
sin pedir una nueva fecha.
```

**TIME**

```
Muestra o establece la hora del sistema.

TIME  [/T | hora]

Escriba TIME sin parámetros para mostrar la hora actual y poder
especificar una nueva hora. Presione Entrar si no desea cambiar la hora.

Si están habilitadas las extensiones de comandos el comando TIME admite
el parámetro /T que indica al comando mostrar tan solo la
hora actual, sin pedir una nueva hora.
```

**COLOR**

```
Configura los colores predeterminados de primer y segundo plano de la consola.

COLOR [attr]

  attr         Especifica el atributo de color de la salida de consola.

Los atributos de color están especificados con DOS dígitos hexadecimales (el primero
corresponde al segundo plano; el segundo al primer plano). Los dígitos
pueden coincidir con cualquiera de los siguientes valores:

    0 = Negro       8 = Gris
    1 = Azul        9 = Azul claro
    2 = Verde       A = Verde claro
    3 = Aguamarina        B = Aguamarina claro
    4 = Rojo        C = Rojo claro
    5 = Púrpura     D = Púrpura claro
    6 = Amarillo    E = Amarillo claro
    7 = Blanco      F = Blanco brillante

Si no se indican argumentos, este comando restaura el color que tenía
cuando se inició CMD.EXE. Este valor proviene de la ventana de la consola,
el modificador de línea de comandos /T o el valor del registro
DefaultColor.

El comando COLOR configura ERRORLEVEL a 1 si se realiza un intento de ejecutar
el comando COLOR con el mismo color de primer y segundo
plano.

Ejemplo: "COLOR fc" crea rojo claro sobre blanco brillante
```

**MODE**

```
Configura los dispositivos de sistema.

Puerto serie:       MODE COMm[:] [BAUD=b] [PARITY=p] [DATA=d] [STOP=s]
                                 [to=on|off] [xon=on|off] [odsr=on|off]
                                 [octs=on|off] [dtr=on|off|hs]
                                 [rts=on|off|hs|tg] [idsr=on|off]

Estado de dispositivo:         MODE [dispositivo] [/STATUS]

Desviar impresión:             MODE LPTn[:]=COMm[:]

Seleccionar página de códigos: MODE CON[:] CP SELECT=yyy

Estado de página de códigos:   MODE CON[:] CP [/STATUS]

Modo de pantalla:              MODE CON[:] [COLS=c] [LINES=n]

Velocidad del teclado:         MODE CON[:] [RATE=r DELAY=d]
```

**EXIT**

```
Abandona el programa CMD.EXE (intérprete de comandos) o el script
por lotes actual.

EXIT [/B] [código]

  /B          especifica que se debe abandonar el archivo por 
              lotes actual y no CMD.EXE.  Si se ejecuta desde fuera de un
              archivo por lotes, abandonar  CMD.EXE

 código       especifica un número.  Si se ha especificado /B, establece 
              ERRORLEVEL con este número.  Si abandona CMD.EXE, establece 
              el código de salida del proceso con este número.
```

---

</details><details> <summary>2. Rutas de acceso</summary>
<h3 align="center"> :clipboard: <a href="https://github.com/jersonmartinez/Curso_Administracion_Windows_Consola/blob/master/2.%20Rutas%20de%20acceso.md">Rutas de acceso</a> </h3>

[![#1. Rutas de acceso - Administración de Windows desde la Consola](https://img.youtube.com/vi/P7fDSRl2V-I/maxresdefault.jpg)](https://youtu.be/P7fDSRl2V-I "#1. Rutas de acceso - Administración de Windows desde la Consola")


### RUTAS DE ACCESO

Te enseño sobre rutas de acceso, que te ayudarán a desplazarte entre directorios y unidades de disco usando el comando CD | CHDIR, además de compartirte ejemplos reales y óptimas sobre las rutas relativas y absolutas.


**¿Qué es una ruta?**

Es una lista de nombres de directorio separados por barras, seguida por un nombre de directorio o por el nombre de un archivo. Un directorio es igual que una carpeta.



**¿Qué son las rutas relativas?**

Una ruta absoluta o completa comienza con la letra de unidad seguida de dos puntos, por ejemplo D:\.



**¿Qué son las rutas absolutas?**

Una ruta relativa hace referencia a una ubicación que es relativa a un directorio actual. Las rutas relativas utilizan dos símbolos especiales, un punto (.) y dos puntos seguidos (..), lo que significa el directorio actual y el directorio padre. Los dos puntos seguidos se utilizan para subir en la jerarquía. Un único punto representa el directorio actual.



**CD | CHDIR**
```
Muestra el nombre del directorio actual o cambia de directorio.

CHDIR [/D] [unidad:][ruta]
CHDIR [..]
CD [/D] [unidad:][ruta]
CD [..]

  ..   Especifica que desea cambiar al directorio superior.

Escriba CD unidad: para ver el directorio actual de la unidad especificada.
Escriba CD sin par metros para ver la unidad y el directorio actual.

Use el modificador /D para cambiar la unidad actual además del directorio
actual para una unidad de disco.

Si las extensiones de comando están habilitadas, CHDIR cambia así:

El uso de mayúsculas y minúsculas de la cadena del directorio actual se
convierte al mismo uso que se tiene en los nombres de unidades. Así, CD
C:\TEMP establecer  C:\Temp como el directorio actual si éste es el uso
de mayúsculas y minúsculas en la unidad.

El comando CHDIR no trata los espacios como separadores, así que es posible
usar CD para cambiar a un directorio cuyo nombre de subdirectorio contenga
un espacio, sin necesidad de escribir el nombre entre comillas. Por ejemplo:

    cd\winnt\profiles\nombredeusuario\programas\menú inicio

es lo mismo que:

    cd "\winnt\profiles\nombredeusuario\programas\menú inicio"

que sería lo que hay que escribir si las extensiones estuvieran
deshabilitadas.
```
Las instrucciones de comandos anteriormente señaladas, son explicadas en este capítulo, el segundo del curso de Administración de Windows desde la #Consola. 

Fuente de información: <a href="https://desktop.arcgis.com/es/arcmap/10.3/tools/supplement/pathnames-explained-absolute-relative-unc-and-url.htm" target="_blank">Arcgis</a>

---

</details><details> <summary>3. Gestión de directorios</summary>
<h3 align="center"> :clipboard: <a href="https://github.com/jersonmartinez/Curso_Administracion_Windows_Consola/blob/master/3.%20Gesti%C3%B3n%20de%20directorios.md">Gestión de directorios</a> </h3>

[![#3. Gestión de directorios - Administración de Windows desde la Consola](https://img.youtube.com/vi/wdpOx-evxWs/maxresdefault.jpg)](https://youtu.be/wdpOx-evxWs "#3. Gestión de directorios - Administración de Windows desde la Consola")

### Gestión de directorios

Te enseño sobre gestión de directorios, que incluye diferentes formas para crear, eliminar y listar. 

Algunos comandos interesantes que se muestran son: 

Comando | Descripción
------------ | -------------
✔ MD - MKDIR | Crea un directorio. `(MD = Make Directory)`
✔ RD | Quita (elimina) un directorio `(RD = Remove Directory)`
✔ DIR | Muestra la lista de subdirectorios y archivos de un directorio.
✔ MORE | Muestra la información pantalla a pantalla.

---

**MD - MKDIR**

```
Crea un directorio.

MKDIR [unidad:]ruta
MD [unidad:]ruta

Si las extensiones de comandos están habilitadas, MKDIR cambia así:

MKDIR crea cualquier directorio intermedio de la ruta de acceso siempre 
que sea necesario. Por ejemplo, si \a no existe:

    mkdir \a\b\c\d

es lo mismo que:

    mkdir \a
    chdir \a
    mkdir b
    chdir b
    mkdir c
    chdir c
    mkdir d

que es lo que hubiese tenido que escribir si las extensiones estuvieran
deshabilitadas.
```

**RD - RMDIR**

```
Quita (elimina) un directorio.

RMDIR [/S] [/Q] [unidad:]ruta
RD [/S] [/Q] [unidad:]ruta

    /S     Quita todos los directorios y archivos del directorio además 
           del mismo directorio. Se usa principalmente cuando se 
           desea quitar un árbol.

    /Q     Modo silencioso, no pide confirmación para quitar un árbol
           de directorio con /S
```

**DIR**

```
Muestra la lista de subdirectorios y archivos de un directorio.

DIR [drive:][path][filename] [/A[[:]attributes]] [/B] [/C] [/D] [/L] [/N]
  [/O[[:]sortorder]] [/P] [/Q] [/R] [/S] [/T[[:]timefield]] [/W] [/X] [/4]

  [drive:][path][filename]
              Especifica la unidad, el directorio o los archivos que se mostrarán.

  /A          Muestra los archivos con los atributos especificados.
  Atributos    D  Directorios             R  Archivos de solo lectura
               H  Archivos ocultos        A  Archivos listos para el archivado
               S  Archivos de sistema     I  Archivos indizados que no son de contenido
               L  Puntos de rean lisis             O  Archivos sin conexión
               -  Prefijo de exclusión
  /B          Usa el formato simple (sin encabezados ni resúmenes).
  /C          Muestra el separador de miles en los tamaños de los archivos. Es la opción
              predeterminada. Usa /-C para deshabilitar la aparición del separador.
  /D          Similar al listado ancho, pero los archivos aparecen en una lista ordenada por columnas.
  /L          Usa letras minúsculas.
  /N          Nuevo formato de lista larga donde los nombre de archivo aparecen en el lado derecho.
  /O          Muestra los archivos según el orden indicado.
  sortorder        N  Por nombre (orden alfabético)       S  Por tamaño (orden creciente)
               E  Por extensión (orden alfabético)  D  Por fecha y hora (el m s antiguo primero)
               G  Agrupa primero los directorios -  Prefijo para invertir el orden
  /P          Hace una pausa después de cada pantalla completa de información.
  /Q          Muestra el propietario del archivo.
  /R          Muestra las secuencias alternativas de datos del archivo.
  /S          Muestra los archivos del directorio especificado y todos sus subdirectorios.
  /T          Controla el campo de hora que se mostrar  o usar  para realizar la ordenación.
  timefield       C  Creación
              A  último acceso
              W  última modificación
  /W          Usa el formato de listado ancho.
  /X          Muestra los nombres cortos generados para los nombres
              de archivo sin formato 8dot3. El formato es el mismo que para /N, con el nombre corto especificado
              antes del nombre largo. Si no existe ningún nombre corto, se muestran
              espacios en blanco en su lugar.
  /4          Muestra los años con 4 d¡gitos.

Los modificadores se pueden preestablecer en la variable de entorno DIRCMD.
Para invalidar los modificadores prestablecidos, se debe agregar un prefijo a cada modificador con - (guión), por ejemplo: /-W.
```

**MORE**

```
Muestra la información pantalla a pantalla.

MORE [/E [/C] [/P] [/S] [/Tn] [+n]] < [unidad:][ruta]archivo
comando | MORE [/E [/C] [/P] [/S] [/Tn] [+n]]
MORE /E [/C] [/P] [/S] [/Tn] [+n] [archivos]

    [unidad:][ruta]archivo  Especifica un archivo para mostrar
                            pantalla a pantalla.

    comando                 Especifica el comando que ser 
                            mostrado.

    /E       Habilita las opciones avanzadas
    /C       Limpia la pantalla antes de mostrar la página
    /P       Expande los caracteres de avance de línea
    /S       Compacta múltiples líneas en blanco en una sola línea
    /Tn      Expande las tabulaciones a n espacios (de forma predeterminada 8)

             Se pueden usar modificadores con las variables
             de entorno de MORE.

    +n       Empieza mostrando el primer archivo en la línea n

    archivos Lista de archivos que se desean mostrar. Los archivos
             de la lista están separados por espacios.

    Si las opciones avanzadas están activadas, los siguientes comandos
    son aceptados en el símbolo de -- M s --:

    P n       Mostrar las siguientes n líneas
    S n       Saltarse las siguientes n líneas
    F         Mostrar el siguiente archivo
    Q         Salir
    =         Mostrar el número de línea
    ?         Mostrar la línea de ayuda
    <espacio> Mostrar la siguiente página
    <entrar>  Mostrar la siguiente línea
```

---

</details><details> <summary>4. Gestión de ficheros o archivos</summary>
<h3 align="center"> :clipboard: <a href="https://github.com/jersonmartinez/Curso_Administracion_Windows_Consola/blob/master/4.%20Gesti%C3%B3n%20de%20ficheros%20o%20archivos.md">Gestión de ficheros o archivos</a> </h3>

[![#4. Gestión de ficheros o archivos - Administración de Windows desde la Consola](https://img.youtube.com/vi/WVoe_xtSyUs/maxresdefault.jpg)](https://youtu.be/WVoe_xtSyUs "#4. Gestión de ficheros o archivos - Administración de Windows desde la Consola")

Te enseño cómo gestionar ficheros o archivos utilizando la metodología CRUD, de crear, leer, actualizar y eliminar. Además, conocerás nuevos comandos interesantes donde se realizarán prácticas de combinaciones entre ellos.

Estos comandos son: 

Comando | Descripción
------------ | -------------
✔ COPY | Copia uno o más archivos en otra ubicación.
✔ TYPE | Muestra el contenido de uno o más archivos de texto.
✔ FSUTIL | Comando avanzado de Administración de Windows.
✔ MOVE | Mueve archivos y cambia el nombre a archivos y directorios.
✔ REN - RENAME | Cambia el nombre de uno o más archivos.
✔ DEL | Elimina uno o más archivos.
✔ RD | _`Remove Directory`_ (Este comando ya ha sido especificado en [este documento](../master/3.%20Gesti%C3%B3n%20de%20directorios.md "Gestión de directorios"))

Las instrucciones de comandos anteriormente señaladas, son explicadas en este capítulo, el cuarto del curso de Administración de Windows desde la #Consola. 

---

**COPY**

```
Copia uno o más archivos en otra ubicación.

COPY [/D] [/V] [/N] [/Y | /-Y] [/Z] [/L] [/A | /B ] origen [/A | /B]
     [+ origen [/A | /B] [+ ...]] [destino [/A | /B]]

  origen       Especifica el archivo o archivos que deben copiarse.
  /A           Indica un archivo de texto ASCII.
  /B           Indica un archivo binario.
  /D           Permite que el archivo de destino se cree sin cifrar.
  destino      Especifica el directorio y/o el nombre de archivo de los
               nuevos archivos.
  /V           Comprueba si los nuevos archivos están escritos
               correctamente.
  /N           Si está disponible, usa un nombre de archivo corto al copiar
               un archivo cuyo nombre no tiene el formato 8.3.
  /Y           Suprime la solicitud de confirmación antes de
               sobrescribir un archivo de destino existente.
  /-Y          Solicita confirmación antes de sobrescribir un archivo de
               destino existente.
  /Z           Copia archivos de red en modo reiniciable.
  /L           Si el origen es un vínculo simbólico, copia el vínculo al
               destino en lugar del archivo real al que apunta el vínculo.

El modificador /Y puede preestablecerse en la variable de entorno COPYCMD.
Esto puede anularse con el modificador /-Y en la línea de comando.
La confirmación del usuario se solicita de forma predeterminada antes de
sobrescribir algo, excepto si el comando COPY se ejecuta desde un script por
lotes.

Para anexar archivos, especifique un £nico archivo de destino pero
varios archivos de origen (con caracteres comodines o el formato
archivo1+archivo2+archivo3).
```

**TYPE**

```
Muestra el contenido de uno o más archivos de texto.

TYPE [unidad:][ruta]archivo
```

**FSUTIL**  _`comando avanzado`_

```
---- Comandos compatibles ----

8dot3name       Administración de 8dot3name
behavior        Controla el comportamiento del sistema de archivos
dax             Administración de volumen DAX
dirty           Administra el bit de integridad del volumen
file            Comandos específicos de archivos
fsInfo          Información del sistema de archivos
hardlink        Administración de vínculos físicos
objectID        Administración de id. de objeto
quota           Administración de cuota
repair          Administración de recuperación autom tica
reparsePoint    Administración de punto de repetición de an lisis
storageReserve         Administración de reserva de almacenamiento
resource        Administración del administrador de recursos transaccionales
sparse          Control de archivo disperso
tiering         Administración de propiedades de organización en niveles de almacenamiento
transaction     Administración de transacciones
usn             Administración de USN
volume          Administración de vol£menes
wim             Administración transparente del hospedaje de WIM
```

**MOVE**

```
Mueve archivos y cambia el nombre a archivos y directorios.

Mover uno o más archivos:
MOVE [/Y | /-Y] [unidad:][ruta]nombrearchivo1[,...] destino

Cambiar el nombre a un directorio:
MOVE [/Y | /-Y] [unidad:][ruta]nombredirectorio1 nombredirectorio2

  [unidad:][ruta]nombrearchivo1 Especifica la ubicación y el nombre del
archivo o archivos que quiere mover.
                          
  destino            Especifica la nueva ubicación del archivo. El
                     destino puede constar de una letra de unidad y
                     dos puntos, un nombre de directorio o una
                     combinación. Si mueve solo un archivo, también
                     puede incluir un nombre de archivo si quiere
                     cambiar el nombre del archivo cuando lo mueva.

  [unidad:][ruta]nombredirectorio1  Especifica el directorio al que
                     desea cambiar el nombre.

  nombredirectorio2  Especifica el nuevo nombre del directorio.

  /Y                 Suprime la solicitud de confirmar si quiere
                     sobrescribir un archivo de destino ya existente.

  /-Y                Aparecer  la solicitud para confirmar si desea 
                     sobrescribir un archivo de destino ya existente.

El modificador /Y puede estar presente en la variable de entorno COPYCMD.
Esto puede sobrescribirse con /-Y en la línea de comandos. Lo
predeterminado es pedir la sobrescritura a no ser que el comando MOVE sea
ejecutado dentro de un script de un archivo de proceso por 
lotes.
```

**REN - RENAME**

```
Cambia el nombre de uno o más archivos.

RENAME [unidad:][ruta]archivo1 archivo2.
REN [unidad:][ruta]archivo1 archivo2.

No puede especificar una nueva unidad o ruta para el archivo de destino.
```

**DEL**

```
Elimina uno o más archivos.

DEL [/P] [/F] [/S] [/Q] [/A[[:]attributes]] names
ERASE [/P] [/F] [/S] [/Q] [/A[[:]attributes]] names

  names         Especifica una lista de uno o más archivos o directorios.
                Se pueden usar caracteres comodín para eliminar varios archivos. Si se
                especifica un directorio, todos los archivos de este se
                eliminar n.

  /P            Pide confirmación antes de eliminar cada archivo.
  /F            Fuerza la eliminación de los archivos de solo lectura.
  /S            Elimina los archivos especificados de todos los subdirectorios.
  /Q            Modo silencioso. No pide confirmación sobre si es correcto eliminar el carácter comodín global
  /A            Selecciona los archivos que se van a eliminar basándose en los atributos.
  Atributos     R  Archivos de solo lectura            S  Archivos de sistema
                H  Archivos ocultos               A  Archivos preparados para el archivado
                I  Archivos indizados que no son de contenido  L  Puntos de reanálisis
                O  Archivos sin conexión              -  Prefijo de exclusión

Si las extensiones de comando est n habilitadas, DEL y ERASE cambian
de la siguiente manera:

La semántica que se muestra para el modificador /S está invertida
de tal modo que le muestra solamente los archivos eliminados y no
los que no se encontraron.
```

---

</details><details> <summary>5. Árbol de directorios</summary>
<h3 align="center"> :clipboard: <a href="https://github.com/jersonmartinez/Curso_Administracion_Windows_Consola/blob/master/5.%20%C3%81rbol%20de%20directorios.md">Árbol de directorios</a> </h3>

[![#5. Árbol de directorios - Administración de Windows desde la Consola](https://img.youtube.com/vi/mQgjiaEd0b0/maxresdefault.jpg)](https://youtu.be/mQgjiaEd0b0 "#5. Árbol de directorios - Administración de Windows desde la Consola")

En esta oportunidad, te enseñaré cómo generar un dibujo sobre un árbol de directorios tanto con interfaz gráfica como por Consola, además de escribirlo y leerlo en un archivo específico. Además de el uso de una variable de entorno.

Los comandos utilizados son: 
Comando | Descripción
------------ | -------------
✔ TREE | Copia uno o más archivos en otra ubicación.
✔ TYPE | Muestra el contenido de uno o más archivos de texto. (Este comando ya ha sido especificado en [este documento](../master/4.%20Gesti%C3%B3n%20de%20ficheros%20o%20archivos.md "Gestión de ficheros o archivos"))

---

**TREE**

```
Muestra de forma gráfica la estructura de carpetas de una unidad o ruta.

TREE [unidad:][ruta] [/F] [/A]

   /F    Muestra los archivos de cada carpeta.
   /A    Usa ASCII en lugar de caracteres extendidos.
```

---
  
</details><details> <summary>6. Copiar, mover archivos y directorios</summary>
<h3 align="center"> :clipboard: <a href="https://github.com/jersonmartinez/Curso_Administracion_Windows_Consola/blob/master/6.%20Copiar%2C%20mover%20archivos%20y%20directorios.md">Copiar, mover archivos y directorios</a> </h3>

[![#6. Copiar, mover archivos y directorios - Administración de Windows desde la Consola](https://img.youtube.com/vi/_nv6hr0-trA/maxresdefault.jpg)](https://youtu.be/_nv6hr0-trA "#6. Copiar, mover archivos y directorios - Administración de Windows desde la Consola")

En esta oportunidad, te enseñaré cómo copiar y mover árboles de directorios y archivos, realizando prácticas para crear respaldos y filtros por medio de comodines.

Los comandos utilizados son: 

Comando | Descripción
------------ | -------------
✔ COPY | Copia uno o más archivos en otra ubicación. (Este comando ya ha sido especificado en [este documento](../master/4.%20Gesti%C3%B3n%20de%20ficheros%20o%20archivos.md "Gestión de ficheros o archivos"))
✔ XCOPY | Copia árboles de directorios y archivos.
✔ TYPE CON | Inicia un contexto donde tienes acceso a escribir el contenido que se guardará en el fichero direccionado.
✔ MOVE | Mueve archivos y cambia el nombre a archivos y directorios. (Este comando ya ha sido especificado en [este documento](../master/4.%20Gesti%C3%B3n%20de%20ficheros%20o%20archivos.md "Gestión de ficheros o archivos"))

---

**XCOPY**

```
Copia árboles de directorios y archivos.

XCOPY source [destination] [/A | /M] [/D[:fecha]] [/P] [/S [/E]] [/V] [/W]
                           [/C] [/I] [/Q] [/F] [/L] [/G] [/H] [/R] [/T] [/U]
                           [/K] [/N] [/O] [/X] [/Y] [/-Y] [/Z] [/B] [/J]
                           [/EXCLUDE:archivo1[+archivo2][+archivo3]...]

  source       Especifica los archivos que se copiar n.
  destination      Especifica la ubicación y/o el nombre de los archivos nuevos.
  /A           Copia solo archivos con el atributo de archivo establecido; 
               no cambia el atributo.
  /M           Copia solo archivos con el atributo de archivo de establecido;
               desactiva el atributo de archivo.
  /D:m-d-y     Copia archivos cambiados durante o después de la fecha
               especificada. Si no se especifica una fecha, copia solo los
               archivos cuya fecha de origen es más reciente que la fecha de
               destino.
  /EXCLUDE:archivo1[+archivo2][+archivo3]...
               Especifica una lista de archivos que contienen cadenas. Los
               archivos deben tener una cadena por línea. Cuando cualquiera
               de las cadenas coincida con cualquier parte de la ruta de
               acceso absoluta del archivo que se debe copiar,
               ese archivo se excluir  de la copia. Por ejemplo, si
               especifica una cadena como \obj\ u .obj, se excluir n todos
               los archivos ubicados en el directorio obj o todos los
               archivos con la extensión .obj, respectivamente.
  /P           Pregunta antes de crear cada archivo de destino.
  /S           Copia directorios y subdirectorios, excepto los vacíos.
  /E           Copia directorios y subdirectorios, incluidos los vacíos.
               Igual que /S /E. Se puede usar para modificar /T.
  /V           Comprueba el tamaño de cada archivo nuevo.
  /W           Pide que se presione una tecla antes de copiar.
  /C           Continúa copiando incluso si ocurren errores.
  /I           Si el destino no existe y se est  copiando más de un archivo,
               se da por supuesto que el destino debe ser un directorio.
  /Q           No muestra nombres de archivo mientras copia.
  /F           Muestra los nombres completos de los archivos de origen y
               de destino mientras realiza la copia.
  /L           Muestra los archivos que se copiar n.
  /G           Permite la copia de archivos cifrados en un destino que no es
               compatible con el cifrado.
  /H           Copia archivos ocultos y tambi‚n archivos del sistema.
  /R           Sobrescribe archivos de solo lectura.
  /T           Crea una estructura de directorios, pero no copia archivos. No
               incluye directorios o subdirectorios vacíos. /T /E incluye
               directorios y subdirectorios vacíos.
  /U           Copia solo archivos que ya existen en el destino.
  /K           Copia atributos. Xcopy normal restablecer  los atributos
               de solo lectura.
  /N           Realiza la copia con los nombres cortos generados.
  /O           Copia la propiedad de archivos y la información de ACL.
  /X           Copia la configuración de la auditoría de archivos
               (implica /O).
  /Y           Suprime la petición de confirmación de sobrescritura de un
               archivo de destino existente.
  /-Y          Pide confirmación de sobrescritura de un archivo
               de destino existente.
  /Z           Copia archivos de red en modo reiniciable.
  /B           Copia el vínculo simbólico en vez del destino del vínculo.
  /J           Copia con E/S no almacenada en el búfer. Recomendado para
               archivos muy grandes.

El modificador /Y puede preestablecerse en la variable de entorno COPYCMD.
Esto se puede reemplazar con /-Y en la línea de comandos.
```

**TYPE CON**

```
Muestra el contenido de uno o más archivos de texto.

TYPE [unidad:][ruta]archivo

Este comando por si mismo, ya ha sido especificado en un documento 
anterios, sin embargo, tiene una variante, se trata del subcomando CON, que 
ejecuta un contexto donde se puede agregar contenido y el comando anterior 
TYPE lo que hará, después de un ENTER de haber escrito el texto, expulsarlo por pantalla. 

Lo mismo pasaría si se desea ocupar CON con otro comando, bien podría ser
COPY CON, que lo que hará es copiar el contenido escrito a un archivo en 
específico o bien, brindar una salida que la obtiene del buffer.
```

---

</details><details> <summary>7. Cambiar y guardar rutas</summary>
<h3 align="center"> :clipboard: <a href="https://github.com/jersonmartinez/Curso_Administracion_Windows_Consola/blob/master/7.%20Cambiar%20y%20guardar%20rutas.md">Cambiar y guardar rutas</a> </h3>

[![#7. Cambiar y guardar rutas - Administración de Windows desde la Consola](https://img.youtube.com/vi/qCSFDkwzLEo/maxresdefault.jpg)](https://youtu.be/qCSFDkwzLEo "#7. Cambiar y guardar rutas - Administración de Windows desde la Consola")

En esta oportunidad, te enseñaré cómo cambiarse, almacenar y recuperar rutas utilizando los comandos POPD y PUSHD.

Comando | Descripción
------------ | -------------
✔ POPD | Cambia al directorio guardado por el comando PUSHD.
✔ PUSHD | Guarda el directorio actual para que lo use el comando POPD y después cambia al directorio especificado.

---

**POPD**

```
Cambia al directorio guardado por el comando PUSHD.

POPD

Si las extensiones de comando están habilitadas, el comando POPD eliminar 
todas las letras de unidad temporales creadas por PUSHD cuando active
el comando POPD, que libera la pila de directorios.

```

**PUSHD**

```
Guarda el directorio actual para que lo use el comando POPD y después
cambia al directorio especificado.

PUSHD [ruta | ..]

 ruta        Especifica el directorio al que hay que cambiar el actual.

Si las extensiones de comando están habilitadas, PUSHD acepta
rutas de red además de la letra normal de unidad y la ruta.
Si se especifica la ruta de red, PUSHD crear  una letra de unidad
temporal que señalar  el recurso de red específico y después cambiar 
la unidad y el directorio actuales con letras de unidades
recientemente definidas. Las letras de unidades temporales ser n
asignadas desde la Z: hacia abajo con la primera letra de unidad
que se encuentre libre.

```

---

</details><details> <summary>8. Instancias</summary>
<h3 align="center"> :clipboard: <a href="https://github.com/jersonmartinez/Curso_Administracion_Windows_Consola/blob/master/8.%20Instancias.md">Instancias</a> </h3>

[![#8. Instancias - Administración de Windows desde la Consola](https://img.youtube.com/vi/BJ39yF2LcMI/maxresdefault.jpg)](https://youtu.be/BJ39yF2LcMI "#8. Instancias - Administración de Windows desde la Consola")

En está oportunidad, te enseñaré cómo iniciar una nueva instancia del intérprete de comandos de sistema, además de mostrarte el desarrollo e implementación de un script básico. 

**El comando en cuestión es `CMD`.**

```
Inicia una nueva instancia del intérprete de comandos de Windows


CMD [/A | /U] [/Q] [/D] [/E:ON | /E:OFF] [/F:ON | /F:OFF] [/V:ON | /V:OFF]
   [[/S] [/C | /K] cadena]


/C      Ejecuta el comando especificado en cadena y luego finaliza

/K      Ejecuta el comando especificado en cadena pero sigue activo

/S      Modifica el tratamiento de cadena después de /C o /K (consultar más 
        abajo)
/Q      Desactiva el eco

/D      Deshabilita le ejecución de los comandos de AutoRun del Registro 
        (consultar más abajo)

/A      Usa ANSI para la salida de comandos internos hacia una canalización o
        un archivo
/U      Usa Unicode para la salida de comandos internos hacia una
        canalización o un archivo
/T:fg   Configura los colores de primer y segundo plano (para obtener más 
        información, consulte COLOR /?)

/E:ON   Habilita las extensiones de comando (consultar más abajo)
/E:OFF  Deshabilita las extensiones de comando (consultar más abajo)

/F:ON    Habilita los caracteres de terminación de los nombres de archivos y 
        directorios (consultar más abajo)

/F:OFF  Deshabilita los caracteres de terminación de los nombres de archivos y 
        directorios (consultar más abajo)

/V:ON   Habilita la extensión de variables de entorno retrasada con !
         como delimitador. Por ejemplo, /V:ON permitirá que !var! extiende
       la variable var en tiempo de ejecución.  La sintaxis var extiende 
        variables en tiempo de entrada, lo que es bastante diferente cuando se está dentro de un bucle FOR.

/V:OFF  Deshabilita la extensión de variables de entorno retrasada.


Tenga en cuenta que los comandos múltiples separados por el separador de 
comandos '&' se aceptan como cadena si están entre comillas. Por razones de 
compatibilidad, /X equivale a /E:ON, /Y equivale a /E:OFF y /R equivale a
//C. Se omitirá cualquier otro tipo de modificador.


Si se especifica /C o /K, lo que viene después de la línea de comandos
se ejecuta como línea de comandos, siguiendo la lógica siguiente para procesar caracteres de comillas ("):

    1.  Se conservan las comillas del comando si se cumplen todas las
        condiciones siguientes:

        - no aparece el modificador /S
        - hay exactamente dos caracteres de comillas
        - no hay caracteres especiales entre ambas comillas, siendo los,
          caracteres especiales: &<>()@^|
        - hay uno o más espacios en blanco entre ambas comillas
        - la cadena entre ambas comillas es el nombre de un archivo ejecutable.

    2.  En caso contrario, el comportamiento clásico es comprobar si el
        primer carácter es una comilla y de ser así, quitar ésta y
        también la última comilla de la línea de comandos, conservando el
        texto que venga después de ésta.

Si no se especificó /D en la línea de comandos, cuando CMD.EXE se inicie,
buscará las variables del Registro REG_SZ/REG_EXPAND_SZ, y si alguna de 
ellas está presente, se ejecutarán en primer lugar.

    HKEY_LOCAL_MACHINE\Software\Microsoft\Command Processor\AutoRun

        y (o)

    HKEY_CURRENT_USER\Software\Microsoft\Command Processor\AutoRun

Las extensiones de comando están habilitadas de forma predeterminada. Puede
deshabilitar las extensiones de una invocación particular con el modificador
/E:OFF. Puede habilitar o deshabilitar las extensiones de todas las
invocaciones de CMD.EXE en una sesión de inicio de usuario o de equipo si
estáblece con
REGEDIT.EXE los dos valores de REG_DWORD del Registro siguientes:

  HKEY_LOCAL_MACHINE\Software\Microsoft\Command Processor\EnableExtensions

     y/o

  HKEY_CURRENT_USER\Software\Microsoft\Command Processor\EnableExtensions

en 0x1 o 0x0.  La configuración específica del usuario tiene preferencia
respecto a la del equipo. Los modificadores de la línea de comandos tienen
prioridad sobre la configuración del Registro.

En un archivo por lotes, los argumentos SETLOCAL ENABLEEXTENSIONS o
DISABLEEXTENSIONS tienen prioridad sobre los modificadores /E:ON o /E:OFF.
Para obtener información más detallada, vea SETLOCAL /?.

Las extensiones de comando implican cambios y ampliaciones en los
siguientes comandos:

    DEL o ERASE
    COLOR
    CD o CHDIR
    MD o MKDIR
    PROMPT
    PUSHD
    POPD
    SET
    SETLOCAL
    ENDLOCAL
    IF
    FOR
    CALL
    SHIFT
    GOTO
    START (también incluye cambios en la invocación de comandos externos)
    ASSOC
    FTYPE

Para obtener detalles específicos, escriba nombreDelComando /?.

La expansión de variables de entorno retrasada NO está habilitada de forma
predeterminada. Puede habilitar o deshabilitar la expansión de variables de
entorno retrasada para una invocación particular de CMD.EXE con los
modificadores /V:ON o /V:OFF. Puede habilitar o deshabilitar la expansión
retrasada para todas las invocaciones de CMD.EXE en una sesión de inicio de
usuario o equipo si estáblece con REGEDIT.EXE los dos valores de REG_DWORD del
Registro siguientes:

  HKEY_LOCAL_MACHINE\Software\Microsoft\Command Processor\DelayedExpansion

      y/o

  HKEY_CURRENT_USER\Software\Microsoft\Command Processor\DelayedExpansion

en 0x1 o 0x0. La configuración específica del usuario tiene prioridad sobre la
configuración del equipo. Los modificadores de la línea de comandos tienen
prioridad sobre la configuración del Registro.

En un archivo por lotes, los argumentos SETLOCAL ENABLEDELAYEDEXPANSION o
DISABLEDELAYEDEXPANSION tienen prioridad sobre los modificadores /V:ON o
/V:OFF. Para obtener información más detallada, vea SETLOCAL /?.

Si la expansión de variables de entorno retrasada está habilitada, se puede
usar el carácter de exclamación para sustituir el valor de la variable de
entorno en tiempo de ejecución.

Puede habilitar o deshabilitar la terminación de un nombre de archivo
para una invocación particular de CMD.EXE con el modificador /F:ON o /F:OFF.
Se puede habilitar o deshabilitar la terminación para todas las invocaciones
de CMD.EXE en una sesión de inicio de equipo o de usuario estábleciendo
cualquiera de los dos siguientes valores REG_DWORD en el Registro con
REGEDT.EXE:

    HKEY_LOCAL_MACHINE\Software\Microsoft\Command Processor\CompletionChar
    HKEY_LOCAL_MACHINE\Software\Microsoft\Command Processor\PathCompletionChar

        y/o

    HKEY_CURRENT_USER\Software\Microsoft\Command Processor\CompletionChar
    HKEY_CURRENT_USER\Software\Microsoft\Command Processor\PathCompletionChar

con el valor hex de un carácter de control para usarlo en una función
particular (por ej. 0x4 es Ctrl-D y 0x6 es Ctrl-F). La configuración de
usuario específica tiene precedencia sobre la configuración de la m quina.
Los modificadores de la línea de comandos tiene precedencia sobre la
configuración del Registro.

Si la terminación está habilitada con el modificador /F:ON, los dos caracteres 
de control usados son Ctrl-D para la terminación del nombre del directorio y
Ctrl-F para la terminación del nombre de archivo.  Para deshabilitar una
terminación de carácter determinada en el Registro, use el valor del
espacio en blanco (0x20), ya que no es un carácter de control v lido.

Se invoca la terminación cuando se escriben cualquiera de los dos caracteres
de control. La función de terminación, desplaza el contenido de la ruta de
acceso hacia la izquierda del cursor, le anexa un carácter comodín si no
hay ninguno todavía presente y genera una lista de rutas de acceso que
coincidan. Después muestáa la primera ruta de acceso que coincida. Si no
coincide ninguna ruta de acceso, emite un sonido y no muestáa nada.
Posteriormente, el presionar repetidamente el mismo carácter de control se
desplazará a través de la lista de las rutas de acceso que coinciden. Si
presiona la tecla Mayús con el carácter de control se moverá a través de la
lista hacia atrás.  Si se edita la línea de cualquier manera y presiona el
carácter de control de nuevo, la lista de ruta de acceso guardada es anulada
y se generará una nueva. Ocurrirá lo mismo si pasa de una terminación de
nombre de archivo a uno de directorio. La única diferencia entre los dos
caracteres de control es que la terminación del carácter del archivo
coincide con ambos nombres del archivo y del directorio, mientras que la
terminación del carácter del directorio solo coincide con los nombres del
directorio. Si la terminación del archivo es usada en cualquier construcción
de comandos de directorio (CD, MD o RD) entonces se asume la terminación
del directorio.

El código de terminación trata adecuadamente con nombres de archivo que
contienen espacios u otros caracteres especiales colocando comillas entre
la ruta de acceso que coincide. También, si se hace una copia de seguridad,
se llamará a una terminación dentro de la misma línea, el texto a la derecha
del cursor que fue llamado en el punto de la terminación es descartado.

Los caracteres especiales que requieren comillas son:
     <espacio>
     &()[]{}^=;!'+,`~
```

---

</details><details> <summary>9. Máscaras y comodines</summary>
<h3 align="center"> :clipboard: <a href="https://github.com/jersonmartinez/Curso_Administracion_Windows_Consola/blob/master/9.%20M%C3%A1scaras%20y%20comodines.md">Máscaras y comodines</a> </h3>

[![#9. Máscaras y comodines - Administración de Windows desde la Consola](https://img.youtube.com/vi/wfGxWz3NYV4/maxresdefault.jpg)](https://youtu.be/wfGxWz3NYV4 "#9. Máscaras y comodines - Administración de Windows desde la Consola")

En esta oportunidad, te enseñaré sobre máscaras y comodines, donde un par de mágicos metacaracteres te harán la vida más fácil al momento de filtrar datos y aplicar acciones.

**Reglas de coincidencia de comodines**

**`*`**

Generalmente coincide con 0 o más caracteres, con una excepción (ver la 
siguiente regla). El comodín no codicioso es libre de combinar tantos o tan 
pocos caracteres como sean necesarios para que coincida el resto de la máscara.


**`*.`**

Al final de la máscara coincide con 0 o más caracteres, excepto {punto}. En realidad, la regla se aplica con cualquier número de caracteres {punto} y {space} entre el * y el terminal {punto}. La expresión regular para este término es "[*] [.] * [.] $"


**`?`**

Haga coincidir 0 o un carácter, excepto {punto}.
La única vez que coincide con 0 caracteres es cuando coincide con el final del nombre o la posición antes de un {punto}.
El signo de interrogación también se puede usar más de una vez para unir más de un carácter.


**Los comodines son compatibles con los siguientes comandos:**

```
ATTRIB, CACLS, CIPER, COMPACT, COPY, DEL, DIR, EXPAND, EXTRACT, FIND, FINDSTR, FOR, FORFILES, FTP, ICACLS, IF EXIST, MORE, MOVE, MV, NET (* = Cualquier unidad), PERMS, PRINT, QGREP, REN,REEMPLAZAR, ROBOCOPIA, RUTA, TOMA, TIPO, DONDE, XCACLS, XCOPY
```

Los comandos `COPY` y `REN` aceptan dos conjuntos de comodines, existen algunas diferencias sutiles entre cómo se tratan, consulte la página `REN` para obtener más detalles.

Los comodines utilizados por `FORFILES` no son estándar, pero son similares a los comodines utilizados en PowerShell.

*Fuente: [ss64 - Máscaras y comodines](https://ss64.com/nt/syntax-wildcards.html "Máscaras y comodines")* 

---

</details><details> <summary>10. Gestión del PROMPT</summary>
<h3 align="center"> :clipboard: <a href="https://github.com/jersonmartinez/Curso_Administracion_Windows_Consola/blob/master/10.%20Gesti%C3%B3n%20del%20PROMPT.md">Gestión del PROMPT</a> </h3>

[![#10. Gestión del PROMPT - Administración de Windows desde la Consola](https://img.youtube.com/vi/q71bisp9q4c/maxresdefault.jpg)](https://youtu.be/q71bisp9q4c "#10. Gestión del PROMPT - Administración de Windows desde la Consola")

En esta oportunidad, te enseñaré cómo gestionar el prompt de la consola desde aspectos básicos hasta avanzado, personalizando el estilo de línea de comandos de la terminal, además que aprenderás un poco sobre variables de entorno y algunas herramientas interesantes.

Algunos nuevos comandos son: 

Comando | Descripción
------------ | -------------
✔ PROMPT | Cambia el símbolo del sistema de cmd.exe.
✔ SETX | Crea o modifica variables de entorno en el entorno de usuario o de sistema.

**PROMPT**

```
Cambia el símbolo del sistema de cmd.exe.

PROMPT [text]

  text    Especifica un nuevo símbolo del sistema.

En el símbolo del sistema se pueden escribir caracteres normales y los siguientes códigos especiales:

  $A   & (Y comercial)
  $B   | (barra vertical)
  $C   ( (parántesis izquierdo)
  $D   Fecha actual
  $E   Código de escape (código ASCII 27)
  $F   ) (parántesis derecho)
  $G   > (signo mayor que)
  $H   Retroceso (borra el carácter previo)
  $L   < (signo menor que)
  $N   Unidad actual
  $P   Unidad y ruta de acceso actual
  $Q   = (signo igual)
  $S     (espacio)
  $T   Hora actual
  $V   Número de versión de Windows
  $_   Retorno de carro y alimentación de línea
  $$   $ (signo del dólar)

Si las Extensiones de comando están habilitadas, el comando PROMPT
admite los siguientes caracteres de formato adicionales:

  $+   cero o más caracteres de signo "más" (+) en función de la
       profundidad del directorio de pila PUSHD, un carácter por cada 
       nivel insertado.

  $M   Muestra el nombre remoto asociado a la letra de unidad actual
       o la cadena vacía si la unidad actual no es una unidad de red.
```

**SETX**

```

SetX tiene tres formas de trabajo: 

Sintaxis 1:
    SETX [/S sistema [/U [dominio\]usuario [/P [contraseña]]]] valor var [/M]

Sintaxis 2:
    SETX [/S sistema [/U [dominio\]usuario [/P [contraseña]]]] var
         /K ruta del Registro [/M]

Sintaxis 3:
    SETX [/S sistema [/U [dominio\]usuario [/P [contraseña]]]]
         /F archivo {var {/A x,y | /R cadena x,y}[/M] | /X} [/D delimitadores]

Descripción:
    Crea o modifica variables de entorno en el entorno de usuario o de
    sistema. Puede establecer variables basadas en argumentos, claves de
    Registro o entrada de archivos.

Lista de par metros:
    /S   sistema             Especifica el sistema remoto al que conectarse.

    /U   [dominio\]usuario   Especifica el contexto de usuario en el que
                             el comando debe ejecutarse.

    /P   [contraseña]        Especifica la contraseña para el contexto
                             de usuario dado. Pide entrada si se omite.

    var                      Especifica la variable de entorno que se va a
                             establecer.

    valor                    Especifica el valor que se va a asignar a la
                           variable de entorno.

    /K   Ruta de Registro    Especifica que la variable está basada
                           en información de una clave del Registro.
                           La ruta de acceso debe especificarse en el formato
                           sub rbol\clave\...\valor. Por ejemplo,
                           HKEY_LOCAL_MACHINE\System\CurrentControlSet\
                           Control\TimeZoneInformation\StandardName

    /F   archivo             Especifica el nombre del archivo de texto
                           que se va a usar.

    /A   x,y                 Especifica coordenadas absolutas de archivo
                           (línea X, elemento Y) como par metros de búsqueda 
                           dentro del archivo.

    /R   cadena x,y          Especifica coordenadas relativas de archivo
                           respecto a "cadena" como par metros de búsqueda.

    /M                       Especifica que la variable debe establecerse en
                           el entorno (HKEY_LOCAL_MACHINE) de todo el
                           sistema. El valor predeterminado es establecer la
                           variable bajo el entorno HKEY_CURRENT_USER. 
                           
    /X                       Muestra el contenido de archivos con coordenadas
                             x,y.

    /D   delimitadores       Especifica delimitadores adicionales, como ","
                           o "\". Los delimitadores integrados son espacio,
                           tabulador, retorno de carro y salto de línea. 
                           Cualquier carácter ASCII se puede usar como
                           delimitador adicional. El número máximo de
                           delimitadores, incluidos los delimitadores
                           integrados, es de 15.

    /?                       Muestra este mensaje de ayuda.

NOTA: 1) SETX escribe variables en el entorno maestro del Registro.

      2) En un sistema local, las variables creadas o modificadas con esta
         herramienta estar n disponibles en futuras ventanas de comandos, pero 
         no en la ventana de comandos CMD.exe actual.

      3) En un sistema remoto, las variables creadas o modificadas con esta
         herramienta estar n disponibles en la siguiente sesión de inicio.

      4) Los tipos de datos v lidos de clave del Registro son REG_DWORD,
         REG_EXPAND_SZ,REG_SZ, REG_MULTI_SZ.

      5) Sub rboles compatibles:  HKEY_LOCAL_MACHINE (HKLM),
         HKEY_CURRENT_USER (HKCU).

      6) Los delimitadores distinguen entre mayúsculas y minúsculas.

      7) Los valores REG_DWORD se extraen del Registro en formato 
         decimal.

Ejemplos:
    SETX MACHINE COMPAQ 
    SETX MACHINE "COMPAQ COMPUTER" /M
    SETX MYPATH "%PATH%"
    SETX MYPATH ~PATH~
    SETX /S sistema /U usuario /P contraseña  MACHINE COMPAQ 
    SETX /S sistema /U usuario /P contraseña MYPATH ^%PATH^% 
    SETX TZONE /K HKEY_LOCAL_MACHINE\System\CurrentControlSet\
         Control\TimeZoneInformation\StandardName
    SETX BUILD /K "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows
         NT\CurrentVersion\CurrentBuildNumber" /M
    SETX /S sistema /U usuario /P contraseña TZONE /K HKEY_LOCAL_MACHINE\
         System\CurrentControlSet\Control\TimeZoneInformation\
         StandardName
    SETX /S sistema /U usuario /P contraseña  BUILD /K 
         "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\
         CurrentVersion\CurrentBuildNumber" /M
    SETX /F ipconfig.out /X 
    SETX IPADDR /F ipconfig.out /A 5,11 
    SETX OCTET1 /F ipconfig.out /A 5,3 /D "#$*." 
    SETX IPGATEWAY /F ipconfig.out /R 0,7 Gateway
    SETX /S sistema /U usuario /P contraseña  /F c:\ipconfig.out /X
```


`ColorTool:` https://github.com/Microsoft/Terminal/tree/master/src/tools/ColorTool

---
  
</details><details> <summary>11. Teclas de funciones</summary>
<h3 align="center"> :clipboard: <a href="https://github.com/jersonmartinez/Curso_Administracion_Windows_Consola/blob/master/11.%20Teclas%20de%20funciones.md">Teclas de funciones</a> </h3>

[![#11. Teclas de funciones - Administración de Windows desde la Consola](https://img.youtube.com/vi/uLjg19Z61ik/maxresdefault.jpg)](https://youtu.be/uLjg19Z61ik "#11. Teclas de funciones - Administración de Windows desde la Consola")

En esta oportunidad, te enseñaré el modus operandi de las teclas de funciones en la consola como todo un profesional.

Uso de las teclas de funciones `F1 ... F9` y `ALT + F7`.

Tecla de función o combinación | Descripción
------------ | -------------
✔ F1 | Del último comando ejecutado, va mostrando caracter por caracter.
✔ F2 | Del último comando ejecutado, va mostrando información hasta el caracter introducido como límite.
✔ F3 | Lo que hace directamente es pegar la última instrucción ejecutada para que nuevamente sea ejecutada.
✔ F4 | Borra el texto de la solicitud actual hasta el caracter ingresado.
✔ F5 | Pega comandos ejecutados recientemente. Básicamente es como presionar el botón direccional arriba, igualmente, sin realizar ciclos.
✔ F6 | Aplicar un CTRL + D o acento circunflejo y Z mayúscula, que es lo mismo. En sí, la combinación de teclas CTRL + D o bien, la tecla de función F6 estará suspendiendo el proceso de un script o programa en ejecución.
✔ F7 | Muestra una lista seleccionable de comandos ejecutados en la sesión actual, refiriéndose a un historial de instrucciones. Con la tecla ESC cierra la ventana.
✔ F8 | Pega instrucciones de comandos ejecutadas en la sesión actual, incluso realizando ciclos.
✔ F9 | Pide el número de instrucción de comandos a ejecutar de la lista que se mostró con F7 para pegarla.
✔ `ALT + F7` | Elimina el histórico de instrucciones que aparecen en el menú al presionar F7.


**Bonus - Máximizar la ventana**

En la consola, presionar: `ALT + ENTER`

</details><details> <summary>12. Manipulación de fecha y hora</summary>
<h3 align="center"> :clipboard: <a href="https://github.com/jersonmartinez/Curso_Administracion_Windows_Consola/blob/master/12.%20Manipulaci%C3%B3n%20de%20fecha%20y%20hora.md">Manipulación de fecha y hora</a> </h3>
  
[![#12. Manipulación de Fecha y Hora - Administración de Windows desde la Consola](https://img.youtube.com/vi/QxZ1Q35G-tI/maxresdefault.jpg)](https://youtu.be/QxZ1Q35G-tI "#12. Manipulación de Fecha y Hora - Administración de Windows desde la Consola")

Hoy estamos dando un salto en el tiempo. 

En esta sesión, no aprenderás a solo cambiar la fecha y la hora, el curso de Administración de Windows desde la Consola es mucho más que eso.

Llevar a cabo la configuración de fecha y hora en el sistema es relativamente sencilla desde el entorno gráfico. Sin embargo, esa sencilléz no se aleja mucho en poder hacerlo desde la `CLI` (`Command Line Interface`).

En esta entrega, te mostraré dos comandos esenciales para llevar a cabo tal acción, estos son: `DATE` y `TIME`.

Comando | Descripción
------------ | -------------
✔ DATE | Muestra o establece la fecha.
✔ TIME | Muestra o establece la hora del sistema.

Haciendo un **`DATE`** `/?` o `HELP` **`TIME`** para obtener información oficial y actualizada del sistema.


**DATE**

```
Muestra o establece la fecha.

DATE  [/T | fecha]

Escriba DATE sin parámetros para mostrar la fecha actual y poder 
especificar una nueva. Presione Entrar para mantener la misma fecha.

Si están habilitadas las extensiones de comandos, el comando DATE admite
el parámetro /T, que indica al comando mostrar tan solo la fecha actual
sin pedir una nueva fecha.
```

**TIME**

```
Muestra o establece la hora del sistema.

TIME  [/T | hora]

Escriba TIME sin parámetros para mostrar la hora actual y poder
especificar una nueva hora. Presione Entrar si no desea cambiar la hora.

Si están habilitadas las extensiones de comandos el comando TIME admite
el parámetro /T que indica al comando mostrar tan solo la
hora actual, sin pedir una nueva hora.
```

---

**`EJEMPLOS`**

Obtener la fecha y hora

```batch
DATE /T
TIME /T
```

Obtener la fecha y hora desde variables de entorno

```batch
ECHO %DATE%
ECHO %TIME%

echo La fecha es: %date% y la hora es: %time%
```

**Para cambiar hora y fecha** es tan sencillo con tan solo invocar el comando:
 `DATE` y `TIME`

**Subir de privilegios de Administrador en la misma consola limitada**

```batch
runas /profile /env /user:Antonio\Administrador cmd

Escriba la contraseña para Antonio\Administrador:
Intentando iniciar cmd como usuario "Antonio\Administrador" ...

:: Para realizar correctamente esta acción, se deberá habilitar 
:: el usuario Administrador del sistema y agregarle una clave.

:: Esto corresponde a un capítulo superior sobre el aumento de privilegios.
```

Resincronización del tiempo

```batch
:: Iniciamos el servicio de Windows sobre la configuración del tiempo.
net start w32time

:: Se verifica el estado
w32tm /query /peers

:: Realizando resincronización del tiempo en el sistema local.
:: El protocolo que se está usando es NTP o Network Time Protocol
w32tm /resync /nowait
```

Crear un archivo con el mismo nombre del usuario del sistema

```batch
echo > %username%.txt
```

Crear un archivo con el mismo nombre de la fecha actual del sistema

```batch
echo > %date%.txt
:: Esto no es funcional (Ya que el formato de fecha es: 00/00/00). 
:: No se pueden crear archivos con plecas. Así que hay que escaparlas.

type con >> new_file_%date:/=_%.txt
```

Script Batch para ver la hora de forma dinámica

```batch
TYPE CON > getCurrentTime.bat
```

Script: `getCurrentTime.bat`
```batch
@echo off
	title Get Current Time

		:getCurrentTime

			echo The curent time is: %time:~0,8%
			timeout 1 > NUL
			cls

		goto :getCurrentTime

	pause>nul
exit
```

Ejecutar el script

```batch
.\getCurrentTime.bat
```

</details>

</details><details> <summary>13. Uso de tuberías | PIPES</summary>
<h3 align="center"> :clipboard: <a href="https://github.com/jersonmartinez/Curso_Administracion_Windows_Consola/blob/master/13.%20Uso%20de%20tuber%C3%ADas%20o%20PIPES.md">Uso de tuberías | PIPES</a> </h3>
  
[![#13. Uso de Tuberías | PIPES - Administración de Windows desde la Consola](https://img.youtube.com/vi/mjiWkQbymFM/maxresdefault.jpg)](https://youtu.be/mjiWkQbymFM "#13. Uso de Tuberías | PIPES - Administración de Windows desde la Consola")

#### Pipes

Una tubería del shell es una forma de conectar la salida de un programa a la entrada de otro sin ningún archivo temporal.

```batch
echo "Curso de administración de Windows desde la Consola" | find "Windows"
```

```batch
type con > names.txt
Fernando
Ivania
Martha
Alberto
Jerson
```

```batch
~> type test.txt | sort
type test.txt | sort | sort /R
```

```batch
dir C:\Users\Root\Downloads\*.jpg
dir C:\Users\Root\Downloads | find ".jpg"
```

```batch
dir c:\ /s /b | find "TXT" | more
```

```batch
tasklist | find "notepad"
```

</details>

</details><details> <summary>14. Redireccionamiento y desvío de comandos</summary>
<h3 align="center"> :clipboard: <a href="https://github.com/jersonmartinez/Curso_Administracion_Windows_Consola/blob/master/14.%20Redireccionamiento%20y%20desv%C3%ADo%20de%20comandos.md">Redireccionamiento y desvío de comandos</a> </h3>
  
[![#14. Redireccionamiento y desvío de comandos](https://img.youtube.com/vi/mjiWkQbymFM/maxresdefault.jpg)](https://youtu.be/mjiWkQbymFM "#14. Redireccionamiento y desvío de comandos")

#### Redireccionamiento y desvío de comandos

Es la capacidad de cambiar de dirección de una salida o incluso, parametrizar para que direccione una entrada.

```batch
echo "Curso de AWC - Redireccionamiento" > document.txt
```

```batch
tasklist > tasks.txt
tasklist | find "firefox" > tasks.txt
```

```batch
type con > nombres.txt

Antonio
Patricia
Julia
Maria
Ernesto
```

```batch
sort < nombres.txt
sort < nombres.txt > NombresOrdenados.txt
```

```batch
echo "Una segunda línea para el documento" >> document.txt
echo "Una tercera línea para el documento" >> document.txt
echo "Reemplazando el contenido del documento" > document.txt
```

| Opción de redirección | Acción |
|----------|:-------------:|
| `<` archivo | Lee la entrada estándar del archivo. |
| `>` archivo | Escribe la salida estándar en el archivo. |
| `>>` archivo | Anexa la salida estándar al archivo. |
| `>nul` | Anula la salida. |
| `1>` archivo | Escribe la salida estándar en el archivo. |
| `1>>` archivo | Anexa la salida estándar al archivo. |
| `2>` archivo | Escribe un error estándar en el archivo. |
| `2>>` archivo | Anexa el error estándar al archivo. |
| `2>&1` | Dirige el error estándar a través del mismo flujo que la salida estándar. Ambos pueden ser redirigidos a un archivo o canalizados a otro programa. |
				

```batch
(
More? echo @echo off
More? echo title Saludos
More? echo color 0E
More? echo echo Hola!
More? echo echo pause
More? ) >> script.bat
```

</details>


</details><details> <summary>15. Variables</summary>
<h3 align="center"> :clipboard: <a href="https://github.com/jersonmartinez/Curso_Administracion_Windows_Consola/blob/master/13.%20Uso%20de%20tuber%C3%ADas%20o%20PIPES.md">Variables</a> </h3>
  
[![#15. Variables](https://img.youtube.com/vi/mjiWkQbymFM/maxresdefault.jpg)](https://youtu.be/mjiWkQbymFM "#15. Variables")

#### Variables

Una variable es una entidad abstracta, que puede referirse a una cualidad, propiedad o característica.

Las variables tienen asociado un valor, un dato que puede ser invocado mediante esta variable.
Además, las variables son variables, precisamente porque su valor puede cambiar.

Veamos algunos ejemplos de variables: 

```batch
SET
SET /?
```

Permite hacer filtros con sus iniciales: 
```batch
SET p
SET c
SET userdomain
```

Almacenar y desplazarse a una ruta específica

```batch
SET ruta=C:\Users\Root\Desktop
cd %ruta%

SET "ruta=C:\Users\Root\Desktop"
cd %ruta%
```

La variable SET tiene dos parámetros `/A` y `/P`.

```batch
SET /A expression
SET /P variable=[promptString]
```

`SET /A`
Se establece en una expresión numérica que se evalúa.

Realizando operaciones aritméticas: 

```batch
SET /A 2+4

SET /A "2+4"

SET /A "suma=2+4"
echo %suma%

SET /A "adición=2+4" >nul
echo %adición%

SET /A "sustracción=2-4" >nul
echo %sustracción%

SET /A "multiplicación=2*4" >nul
echo %multiplicación%

SET /A "división=2/4" >nul
echo %división%
```
Asignar el mismo valor a múltiples variables: 

```batch
SET /A "_var1=_var2=_var3=10"
```

`SET /P`
Establece el valor desde en una línea de entrada introducida por el usuario.

```batch
SET /P "Nombre=Dime tu nombre: "
echo El nombre ingresado es: %Nombre%
```

Realizar un Input desde un ejecutable en Batch.

```batch
type con > input.bat
@echo off
SET /P Nombre=Dime tu nombre:
echo Tu nombre es: %Nombre%

:: RESULTADO
:: Dime tu nombre: Jerson Antonio
:: Tu nombre es: Jerson Antonio
```

Crear una calculadora sencilla, solo aritmética.

```batch
type con > calculadora.bat
@echo off
echo Bienvenido a la aritmeticalculadora.
SET /P PrimerValor=Ingresa el primer valor:
SET /P SegundoValor=Ingresa el segundo valor:
SET /A "adición=%PrimerValor%+%SegundoValor%"
SET /A "sustracción=%PrimerValor%-%SegundoValor%"
SET /A "multiplicación=%PrimerValor%*%SegundoValor%"
SET /A "división=%PrimerValor%/%SegundoValor%"
echo Suma: %adición%
echo Resta: %sustracción%
echo Multiplicación: %multiplicación%
echo División: %división%

::###################################
::Resultado: 

> calculadora.bat
Bienvenido a la aritmeticalculadora.
Ingresa el primer valor:10
Ingresa el segundo valor:5
Suma: 15
Resta: 5
Multiplicación: 50
División: 2
```

</details>

</details><details> <summary>15. Variables de entorno</summary>
<h3 align="center"> :clipboard: <a href="https://github.com/jersonmartinez/Curso_Administracion_Windows_Consola/blob/master/13.%20Uso%20de%20tuber%C3%ADas%20o%20PIPES.md">Variables de entorno</a> </h3>
  
[![#15. Variables de entorno](https://img.youtube.com/vi/mjiWkQbymFM/maxresdefault.jpg)](https://youtu.be/mjiWkQbymFM "#15. Variables de entorno")

## Variables de entorno

**¿Qué son variables de entorno?**

Es una variable que puede ser manipulada a nivel global, incluso, desde diferentes procesos. 

**¿Qué es un entorno?**

Es un espacio determinado donde cohabitan diferentes recursos. En específico, las varibles de entorno en Windows, son aquellas que están definidas a nivel de máquina, pudiendo ser accedidas desde cualquier proceso que en esta se ejecute.

**¿Cuál es la principal diferencia entre variables de entorno y solo variables?**

- La condición.
  - Las variables que se definen dentro de un proceso, según su declaración, pueden ser solamente accedidas por dicho proceso. En el caso de las variables de entorno, no tiene límites de acceso.

Vamos directo con algunos ejemplos: 

### Obtener todas las variables definidas.

```batch
SET

:: Variables dinámicas

echo %CD%
echo %RANDOM%

echo %DATE%
echo %TIME%

echo %DATE% - %TIME%

SET OneDriveConsumer

SET Jerson=%OneDriveConsumer%
CD Jerson

EXIT

:: Si se vuelve a acceder, estas variables dejan de existir.
```

### Acceder en distintos directorios mediante las variables de entorno

```batch
:: CTRL + R

%ALLUSERSPROFILE%

:: Haciendo llamadas a la interfaz gráfica desde la terminal.

start %HOMEDRIVE%
explorer %HOMEDRIVE%
```

### Las variables de entorno se guardan en: 

```batch
:: Primera forma de ver su contenido.
SET %PATH%

:: Segunda forma de ver su contenido.
path
```

### Creando un comando y la forma en que funciona con sus variables de entorno

```batch
:: Creando un nuevo fichero .bat en C:\Windows\System32

type con >> helloworld.bat
@echo off
echo Hello World!

:: Desde otra terminal, llamar el comando: helloworld
helloworld
Hello World!
```

```batch
:: Llegar al directorio documents

explorer shell::: BB06C0E4-D293-4f75-8A90-CB05B6477EEE}
explorer \\

:: Con un solo slash, llega a disco local C:
explorer \
```

### Creación de variables de entorno

```batch
:: SETX
:: 
:: Crea o modifica variables de entorno para usuario o sistema
:: environment. Can set variables based on arguments, regkeys or
:: file input

:: Lo guardamos a nivel de usuario
SETX CursoAWC "Curso de Administración de Windows desde la Consola"

:: Lo guardamos a nivel de sistema
SETX CursoAWC "Curso de Administración de Windows desde la Consola" /M

:: Lo guardamos a nivel de usuario
SETX MYPATH "%PATH%"

WARNING: The data being saved is truncated to 1024 characters.

SUCCESS: Specified value was saved.

:: Lo guardamos a nivel de sistema
SETX MYPATH "%PATH%" /M

WARNING: The data being saved is truncated to 1024 characters.

SUCCESS: Specified value was saved.

:: Comprobar esto en una nueva sesión de consola o desde interfaz gráfica.
```

### Eliminación de variables de entorno

```batch
:: ELIMINACIÓN TEMPORAL
SET MYPATH=

:: ELIMINACIÓN PERSISTENTE (Ejecutar siempre como Administrador).

:: Se elimina a nivel de usuario
REG delete "HKCU\Environment" /v MYPATH /f
The operation completed successfully.

REG delete "HKCU\Environment" /v CursoAWC /f
The operation completed successfully.


:: Se elimina a nivel de sistema
REG delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /F /V MYPATH
The operation completed successfully.

REG delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /F /V CursoAWC
The operation completed successfully.

:: Comprobar esto desde interfaz gráfica.
```

### Conclusión

Con esto, has podido aprender qué son las variables de entorno y las diferencias con las variables típicas, además de las variables de entorno de usuario y del sistema. A gestionar dichas variables de entorno, desde su visualización, creación, modificación y eliminación.

</details>

---

REPOSITORIO GITHUB SOBRE <a href="https://github.com/jersonmartinez/ShellScriptBatch" target="_blank">SHELL SCRIPT BATCH</a>

<a href="https://github.com/jersonmartinez/ShellScriptBatch/issues" target="_blank"><img alt="GitHub issues" src="https://img.shields.io/github/issues/jersonmartinez/ShellScriptBatch"></a>
<a href="https://github.com/jersonmartinez/ShellScriptBatch/network" target="_blank"><img alt="GitHub forks" src="https://img.shields.io/github/forks/jersonmartinez/ShellScriptBatch"></a>
<a href="https://github.com/jersonmartinez/ShellScriptBatch/stargazers" target="_blank"><img alt="GitHub stars" src="https://img.shields.io/github/stars/jersonmartinez/ShellScriptBatch"></a>
<a href="https://twitter.com/intent/tweet?text=Wow:&url=https%3A%2F%2Fgithub.com%2Fjersonmartinez%2FShellScriptBatch" target="_blank"><img alt="Twitter" src="https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Fgithub.com%2Fjersonmartinez%2FShellScriptBatch"></a>

#<a href="https://www.facebook.com/groups/ShellScriptBatch/" target="_blank">Shell Script Batch | Grupo de Facebook</a>

---

**SOBRE EL AUTOR**

✔ Ing. Jerson Martínez ( 💌 jersonmartinezsm@gmail.com )

<a href="https://www.fulldevops.es/?suscribirse" target="_blank"><img alt="FullDevOps" src="https://img.shields.io/twitter/url?color=9cf&label=%40FullDevOps&logo=FullDevOps&logoColor=informational&style=for-the-badge&url=https%3A%2F%2Ftwitter.com%2Fantoniomorenosm"></a>
<a href="https://www.youtube.com/user/gvideosmtutorialesgm/videos" target="_blank"><img alt="YouTube Channel - Core Stack" src="https://img.shields.io/twitter/url?color=red&label=%40Core%20Stack&logo=Side%20Master&logoColor=yellow&style=for-the-badge&url=https%3A%2F%2Ftwitter.com%2Fantoniomorenosm"></a>
<a href="https://www.youtube.com/user/sidemastersupremo/videos" target="_blank"><img alt="YouTube Channel - Side Master" src="https://img.shields.io/twitter/url?color=red&label=%40Side%20Master&logo=Side%20Master&logoColor=yellow&style=for-the-badge&url=https%3A%2F%2Ftwitter.com%2Fantoniomorenosm"></a>

<a href="https://www.linkedin.com/in/jersonmartinezsm/" target="_blank"><img alt="LinkedIn URL" src="https://img.shields.io/twitter/url?label=Ing.%20Jerson%20Mart%C3%ADnez&logo=linkedin&style=social&url=https%3A%2F%2Fwww.linkedin.com%2Fin%2Fjersonmartinezsm%2F"></a>
<a href="https://twitter.com/antoniomorenosm" target="_blank"><img alt="Twitter Follow" src="https://img.shields.io/twitter/follow/antoniomorenosm?label=S%C3%ADgueme%20en%20%40antoniomorenosm&style=social"></a>

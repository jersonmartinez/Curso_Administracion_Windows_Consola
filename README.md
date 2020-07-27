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

</details><details> <summary>5. Árbol de directorios</summary>
<h3 align="center"> :clipboard: <a href="https://github.com/jersonmartinez/Curso_Administracion_Windows_Consola/blob/master/5.%20%C3%81rbol%20de%20directorios.md">Árbol de directorios</a> </h3>
  
</details><details> <summary>6. Copiar, mover archivos y directorios</summary>
<h3 align="center"> :clipboard: <a href="https://github.com/jersonmartinez/Curso_Administracion_Windows_Consola/blob/master/6.%20Copiar%2C%20mover%20archivos%20y%20directorios.md">Copiar, mover archivos y directorios</a> </h3>

</details><details> <summary>7. Cambiar y guardar rutas</summary>
<h3 align="center"> :clipboard: <a href="https://github.com/jersonmartinez/Curso_Administracion_Windows_Consola/blob/master/7.%20Cambiar%20y%20guardar%20rutas.md">Cambiar y guardar rutas</a> </h3>

</details><details> <summary>8. Instancias</summary>
<h3 align="center"> :clipboard: <a href="https://github.com/jersonmartinez/Curso_Administracion_Windows_Consola/blob/master/8.%20Instancias.md">Instancias</a> </h3>

</details><details> <summary>9. Máscaras y comodines</summary>
<h3 align="center"> :clipboard: <a href="https://github.com/jersonmartinez/Curso_Administracion_Windows_Consola/blob/master/9.%20M%C3%A1scaras%20y%20comodines.md">Máscaras y comodines</a> </h3>

</details><details> <summary>10. Gestión del PROMPT</summary>
<h3 align="center"> :clipboard: <a href="https://github.com/jersonmartinez/Curso_Administracion_Windows_Consola/blob/master/10.%20Gesti%C3%B3n%20del%20PROMPT.md">Gestión del PROMPT</a> </h3>
  
</details><details> <summary>11. Teclas de funciones</summary>
<h3 align="center"> :clipboard: <a href="https://github.com/jersonmartinez/Curso_Administracion_Windows_Consola/blob/master/11.%20Teclas%20de%20funciones.md">Teclas de funciones</a> </h3>

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

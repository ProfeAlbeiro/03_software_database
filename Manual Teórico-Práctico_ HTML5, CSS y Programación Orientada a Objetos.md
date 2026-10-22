# **Manual Teórico-Práctico: Fundamentos de Desarrollo Web y Programación Orientada a Objetos**

---

Este documento constituye el material de referencia completo para la formación académica en ingeniería de software. Abarca desde la estructuración de documentos HTML5 e integración de estilos CSS internos, pasando por el análisis de la evolución paradigmática de la programación (Crisis del Software y niveles de abstracción), hasta el diseño exhaustivo de sistemas mediante la Programación Orientada a Objetos (POO) y su modelado en lenguaje UML.

## **1\. Estructura Base y Semántica en HTML5 con CSS Embebido**

El lenguaje HTML5 establece la arquitectura estructural de una aplicación web mediante componentes semánticos que aportan significado explícito tanto a navegadores como a motores de búsqueda y tecnologías de accesibilidad. A continuación, se presenta una plantilla base totalmente comentada que integra hojas de estilo en cascada (CSS) dentro de la cabecera del documento.

`<!DOCTYPE html>`  
`<!-- Indica al navegador que el documento responde al estándar HTML5 -->`  
`<html lang="es">`

`<head>`  
    `<!-- Define la codificación de caracteres UTF-8 para soporte de tildes y caracteres especiales -->`  
    `<meta charset="UTF-8">`

    `<!-- Configura la ventana gráfica (viewport) para garantizar la adaptabilidad en dispositivos móviles -->`  
    `<meta name="viewport" content="width=device-width, initial-scale=1.0">`

    `<!-- Título de la pestaña del navegador -->`  
    `<title>Estructura Base HTML5 y CSS</title>`

    `<!-- HOJA DE ESTILOS CSS EMBEBIDA -->`  
    `<style>`  
        `/* Reset global para estandarizar márgenes y cálculo de dimensiones */`  
        `* {`  
            `margin: 0;`  
            `padding: 0;`  
            `box-sizing: border-box;`  
        `}`

        `/* Configuración tipográfica y de color del cuerpo del documento */`  
        `body {`  
            `font-family: Arial, Helvetica, sans-serif;`  
            `line-height: 1.6;`  
            `color: #333333;`  
            `background-color: #f4f4f9;`  
        `}`

        `/* Estilos del contenedor del encabezado principal */`  
        `header {`  
            `background-color: #1a365d;`  
            `color: #ffffff;`  
            `padding: 1.5rem;`  
            `text-align: center;`  
        `}`

        `/* Estilos del menú de navegación y sus hipervínculos */`  
        `nav {`  
            `background-color: #2b6cb0;`  
            `display: flex;`  
            `justify-content: center;`  
        `}`

        `nav a {`  
            `color: #ffffff;`  
            `text-decoration: none;`  
            `padding: 0.75rem 1.25rem;`  
            `display: inline-block;`  
        `}`

        `nav a:hover {`  
            `background-color: #2c5282;`  
        `}`

        `/* Contenedor principal con limitación de ancho y centrado automático */`  
        `.container {`  
            `max-width: 900px;`  
            `margin: 2rem auto;`  
            `padding: 0 1rem;`  
        `}`

        `/* Estilos para bloques de contenido independientes */`  
        `article {`  
            `background-color: #ffffff;`  
            `padding: 1.5rem;`  
            `margin-bottom: 1.5rem;`  
            `border-radius: 8px;`  
            `border: 1px solid #e2e8f0;`  
        `}`

        `h1, h2 {`  
            `margin-bottom: 0.75rem;`  
        `}`

        `/* Estilos para el pie de página institucional */`  
        `footer {`  
            `background-color: #1a365d;`  
            `color: #ffffff;`  
            `text-align: center;`  
            `padding: 1rem;`  
            `margin-top: 2rem;`  
        `}`  
    `</style>`  
`</head>`

`<body>`

    `<!-- ENCABEZADO PRINCIPAL DE LA PÁGINA -->`  
    `<header>`  
        `<h1>Mi Sitio Web Estructurado</h1>`  
        `<p>Demostración de estructura semántica en HTML5 y CSS interno</p>`  
    `</header>`

    `<!-- BARRA DE NAVEGACIÓN PRINCIPAL -->`  
    `<nav>`  
        `<a href="#inicio">Inicio</a>`  
        `<a href="#acerca">Acerca de</a>`  
        `<a href="#contacto">Contacto</a>`  
    `</nav>`

    `<!-- CONTENIDO PRINCIPAL (MAIN) -->`  
    `<main class="container">`

        `<!-- ARTÍCULO 1: SECCIÓN DE BIENVENIDA -->`  
        `<article id="inicio">`  
            `<h2>Bienvenido a la Web</h2>`  
            `<p>Esta plantilla demuestra la utilización de HTML5 semántico para delimitar áreas de contenido.</p>`  
        `</article>`

        `<!-- ARTÍCULO 2: DETALLES ARQUITECTÓNICOS -->`  
        `<article id="acerca">`  
            `<h2>Sobre la Estructura</h2>`  
            `<p>El uso correcto de etiquetas semánticas optimiza el posicionamiento SEO y facilita la accesibilidad universal.</p>`  
        `</article>`

    `</main>`

    `<!-- PIE DE PÁGINA -->`  
    `<footer>`  
        `<p>© 2026 - Todos los derechos reservados.</p>`  
    `</footer>`

`</body>`  
`</html>`

## **2\. Contexto Histórico: La Crisis del Software**

A finales de la década de 1960, la industria de la computación experimentó una dramática evolución en el poder de procesamiento del hardware. La reducción de costos y el aumento de velocidad permitieron encarar proyectos informáticos de una escala inédita. Sin embargo, la ausencia de metodologías rigurosas y de lenguajes de programación con abstracción adecuada desencadenó la denominada **Crisis del Software** (término acuñado en la Conferencia de la NATO de 1968 en Garmisch, Alemania).

### **Factores e Impactos de la Crisis**

* **Incertidumbre Presupuestaria:** Proyectos que sobrepasaban ampliamente las estimaciones financieras y de tiempo.  
* **Código Inmantenible:** Construcción de programas basados en lógica difusa y saltos incondicionales (código *spaghetti*).  
* **Fragilidad e Infiabilidad:** Presencia masiva de errores (bugs) en entornos de producción y dificultad extrema para incorporar nuevas funcionalidades sin romper partes existentes.

Como señaló Edsger Dijkstra en su conferencia del Premio Turing (1972): *"La causa principal de la crisis del software es que las máquinas se han vuelto varios órdenes de magnitud más potentes. Mientras no teníamos computadoras, la programación no era un problema; cuando tuvimos computadoras lentas, la programación se convirtió en un problema menor; ahora que tenemos gigantescas computadoras, la programación se ha convertido en un problema igualmente gigantesco."*

## **3\. Clasificación y Niveles de Lenguajes de Programación**

Para mitigar la complejidad en el desarrollo, los lenguajes de programación evolucionaron elevando su nivel de abstracción con respecto al hardware subyacente.

| Nivel de Abstracción | Características Principales | Ejemplos   |
| :---- | :---- | :---- |
| **Bajo Nivel** | Instrucciones binarias directas (Lenguaje Máquina) o códigos mnemónicos vinculados a la arquitectura de la CPU (Ensamblador). Máximo rendimiento con nula portabilidad. | Assembly (x86, ARM), Código Máquina |
| **Medio Nivel** | Combina estructuras de control de alto nivel con manipulación directa de punteros y memoria física. | C, C++ |
| **Alto Nivel** | Representación orientada al dominio del problema o al lenguaje humano. Oculta la gestión de memoria y detalles de la máquina de estados mediante compiladores o máquinas virtuales. | Java, Python, C\#, JavaScript, PHP |

### **Modelos de Ejecución**

* **Lenguajes Compilados:** El código fuente se traduce íntegramente a código máquina binario ejecutable previo a la fase de ejecución (ej. C, Rust, Go).  
* **Lenguajes Interpretados:** Un programa intérprete analiza y ejecuta las instrucciones línea por línea en tiempo real (ej. Python, Ruby).  
* **Modelos Híbridos (Bytecode):** El código fuente se compila a un código intermedio ejecutable sobre una Máquina Virtual (ej. Java con la JVM, C\# con CLR).

## **4\. Transición Paradigmática: De la Programación Estructurada a la POO**

### **Programación Estructurada**

Basada en el teorema de Jacopini y Böhm, sostiene que todo algoritmo puede expresarse mediante tres estructuras fundamentales: **secuencia, selección e iteración**. Su enfoque metodológico promueve la descomposición modular a través de funciones y procedimientos.

**Deficiencia operativa:** La programación estructurada mantiene una separación tajante entre los **datos** (estructuras/variables) y las **funciones** que operan sobre ellos. Si la estructura interna de los datos sufre variaciones, todas las funciones que consumen dicha estructura deben ser modificadas, incrementando el riesgo de fallos en proyectos de gran escala.

### **Programación Orientada a Objetos (POO)**

La POO resuelve esta ruptura unificando los datos y las operaciones que actúan sobre ellos dentro de una misma entidad computacional denominada **Objeto**.

### **Pilares de la POO**

1. **Encapsulamiento:** Oculta el estado interno del objeto y solo permite su modificación mediante métodos expuestos explícitamente (interfaz pública).  
2. **Abstracción:** Identifica y extrae las características esenciales de un elemento, omitiendo los detalles de implementación irrelevantes.  
3. **Herencia:** Mecanismo que permite definir nuevas clases a partir de clases existentes, compartiendo atributos y comportamientos.  
4. **Polimorfismo:** Capacidad que poseen diferentes objetos de responder de forma personalizada ante un mismo mensaje o llamada a método.

## **5\. Del Diagrama de Objetos al Diagrama de Clases (UML)**

### **¿Qué es un diagrama de objetos en UML?**

*“El diagrama de objetos UML representa una instancia específica de un diagrama de clases en un momento determinado en el tiempo. Cuando se lo representa visualmente, verás muchas similitudes con el diagrama de clases. El diagrama de objetos se enfoca en los atributos de un conjunto de objetos y en cómo esos objetos se relacionan entre sí. Por ejemplo, en el siguiente diagrama de objetos, las tres cuentas bancarias están ligadas al banco como tal.”*

**`![][image1]`**

### **Anatomía de un Objeto (Tiempo de Ejecución)**

Un objeto es una instancia concreta que reside en la memoria del sistema durante la ejecución del programa. Consta de tres componentes fundamentales:

* **Identidad:** Dirección de memoria o identificador único que distingue a una instancia de cualquier otra.  
* **Estado (Atributos):\*\* Conjunto de datos y valores asignados a sus variables en un instante dado.**  
* **Comportamiento (Métodos):\*\* Acciones, procedimientos o cálculos que el objeto está capacitado para realizar.**

### **Representación UML del Diagrama de Objetos**

**En la Notación Unificada de Modelado (UML), un objeto se representa con un rectángulo donde el encabezado contiene el nombre del objeto y su clase subrayados (nombreObjeto : NombreClase), seguido de sus atributos con valores concretos.**

Se componen de objetos, representados por rectángulos, conectados mediante líneas.

### **Objetos**

* ### Los objetos son instancias de una clase. Por ejemplo, si "coche" es una clase, un Altima 2007 de Nissan es un objeto de una clase.

  ### 

  ### **Títulos de clases**

* ### Los títulos de clases son los atributos específicos de una clase dada.

[image1]: <data:image/png;base64,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>
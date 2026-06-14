# Sauce Demo Automation - Suite de Pruebas con Capybara & POM

Este repositorio contiene la suite de pruebas automatizadas para **Sauce Demo** (`www.saucedemo.com`), diseñada y desarrollada bajo el patrón de diseño **Page Object Model (POM)** utilizando **Capybara**, **Cucumber** y **Selenium WebDriver** (con soporte para Chrome y Brave).

---

## 👥 Integrantes del Equipo
* **Leonardo Camacho**
* **Joaquin Elias**
* **Jose Carlos Lopez**

---

## 🎯 Objetivo del Sprint
Desarrollar y ejecutar un **Smoke Test Suite** automatizado y robusto que cubra los flujos críticos de negocio de la plataforma Sauce Demo, asegurando la estabilidad de la aplicación (Working Software) mediante una arquitectura escalable, fácil de mantener y con alta legibilidad en BDD.

---

## 🌐 Explicación de la AUT (Application Under Test)
**Sauce Demo** es una aplicación web de comercio electrónico simulada (de Sauce Labs) que permite a los usuarios:
* Autenticarse con diferentes perfiles de usuario (con comportamientos específicos como lentitud, errores visuales o bloqueo).
* Visualizar un catálogo de productos con precios y descripciones.
* Ordenar el catálogo alfabéticamente y por precio.
* Agregar y quitar productos de la cesta de compras.
* Completar el flujo de Checkout (información personal, visualización de importes + impuestos, y confirmación final).

---

## 🔍 Resultados del Exploratory Testing (Pruebas de Exploración)
Antes de automatizar, se realizó una fase de pruebas exploratorias para entender el comportamiento del sistema y definir el alcance del Smoke Test:
1. **`standard_user`**: Funciona correctamente en todos los flujos comerciales (Login, Catálogo, Carrito, Ordenamiento, Checkout).
2. **`locked_out_user`**: Bloqueado al iniciar sesión. Muestra un mensaje de error específico: `"Epic sadface: Sorry, this user has been locked out."`
3. **`problem_user`**: Presenta fallas visuales graves. Los productos en el inventario muestran la misma imagen rota y el flujo de Checkout falla al intentar ingresar el apellido (Last Name).
4. **`performance_glitch_user`**: El inicio de sesión experimenta un retraso artificial de 5 segundos, pero eventualmente accede de forma exitosa.
5. **`error_user`**: Accede, pero ciertos botones de "Agregar al carrito" no funcionan o fallan al hacer clic.
6. **`visual_user`**: Muestra desajustes visuales en el layout y alineación del catálogo de compras.

---

## 📊 Criterios de Selección para Automatizar (Smoke Test)
Para determinar qué casos de prueba debían formar parte del Smoke Test, evaluamos los escenarios según cuatro criterios clave:

1. **Criticidad (Criticality)**:
   * *Login*: Flujo de entrada obligado. Sin login no hay negocio.
   * *Checkout exitoso*: El proceso de compra completo que genera ingresos en producción.
2. **Repetitividad (Repetitiveness)**:
   * *Login con múltiples usuarios*: Probar 10 combinaciones de usuarios válidos/inválidos y vacíos repetidamente. Automatizado mediante `Scenario Outline`.
3. **Tedio (Tedious)**:
   * *Ordenamiento de productos*: Verificar manualmente el orden alfabético y numérico de 6 productos cada vez.
   * *Validación detallada de campos*: Comprobar que cada ítem del catálogo tenga nombre, precio y descripción coherente.
4. **Consumo de Tiempo (Time Consuming)**:
   * *Validación matemática del Checkout*: Sumar el subtotal de los productos, calcular el impuesto (8%) y verificar que equivalga al total cobrado.

---

## 🏗️ Arquitectura del Proyecto: Page Object Model (POM)
Se implementó el patrón POM para separar las especificaciones de pruebas (Gherkin) de la lógica de interfaz (Capybara CSS selectors/métodos).

```
1000CapybaraSamples/
├── features/
│   ├── Autentication.feature         # Login con múltiples perfiles (Etiqueta @smoke)
│   ├── cart.feature                  # Operaciones de la cesta
│   ├── checkout.feature              # Procesamiento de checkout y totales
│   ├── menu.feature                  # Logout y Reset del estado
│   ├── products.feature              # Catálogo de productos y ordenamiento
│   ├── step_definitions/             # Definiciones de pasos que llaman a Page Objects
│   └── support/
│       ├── env.rb                    # Configuración de Capybara y Drivers
│       ├── hooks.rb                  # Maximización y capturas automáticas por fallas
│       └── pages/                    # CLASES POM
│           ├── base_page.rb          # Clase base de páginas (DSL y RSpec Matchers)
│           ├── login_page.rb         # Acciones y localizadores de Login
│           ├── inventory_page.rb     # Inventario, ordenamiento y catálogo
│           ├── cart_page.rb          # Gestión del carrito
│           ├── checkout_info_page.rb # Formulario de checkout paso 1
│           ├── checkout_overview_page.rb # Totales y confirmación paso 2
│           ├── checkout_complete_page.rb # Pantalla final de confirmación
│           ├── menu_component.rb     # Barra de navegación lateral
│           └── page_objects.rb       # Registro global de páginas en Cucumber (World)
├── reports/                          # Reportes generados (cucumber_report.html)
├── screenshots/                      # Capturas de pantalla automáticas de fallas (ignorado en git)
└── cucumber.yml                      # Configuración automática del formato y reportes
```

---

## 🛠️ Cómo Ejecutar las Pruebas y Generar Reportes

### 1. Ejecución de la Suite Completa
Para ejecutar todos los escenarios:
```bash
cucumber
```
*Esto abrirá el navegador seleccionado, ejecutará las pruebas y generará automáticamente el reporte HTML.*

### 2. Ejecutar solo el Smoke Test
Para correr exclusivamente los flujos comerciales etiquetados con `@smoke`:
```bash
cucumber --tags "@smoke"
```

### 3. Reportes del Smoke Test
Cucumber está preconfigurado (vía `cucumber.yml`) para exportar un reporte interactivo en formato HTML tras cada ejecución:
* **Ubicación**: `reports/cucumber_report.html`
* *Este archivo de reporte consolida los tiempos de ejecución, capturas asociadas y detalles de pasos ejecutados.*

---

## 🤖 Uso de Inteligencia Artificial (IA) en el Proyecto
Durante el desarrollo del Sprint, utilizamos **Claude** como asistente de par-programming para:
1. **Refactorización a POM**: Diseño modular de clases de página independientes y herencia limpia de `BasePage`.
2. **Diagnóstico de Sesión**: Solución del error `InvalidSessionIdError` identificando que llamar a `driver.quit` de forma manual en el bloque `After` destruía el navegador entre escenarios en lugar de dejar que Capybara gestionara el ciclo de vida.
3. **Double-Slash Bug**: Resolución del error de enrutamiento web donde `Capybara.app_host` con barra inclinada final y `visit '/'` producían `//` que rompía la inicialización de React en Sauce Demo.

---

## 📝 Conclusiones
* **Estabilidad Alcanzada**: Se logró pasar de un software inestable ("Working software = 0") a un **100% de escenarios exitosos** (30/30 aprobados) gracias a la correcta gestión de la sesión del navegador.
* **Mantenibilidad y Limpieza**: La separación bajo POM elimina el código duplicado y localizadores hardcoded en los steps. Si un selector de Sauce Demo cambia, solo se modifica en una línea dentro de su respectivo Page Object.
* **Pruebas Potentes**: Se reemplazaron las validaciones genéricas por aserciones de negocio robustas que validan listados exactos y totales numéricos a través de tablas Gherkin de datos reales.

---

## 💡 Recomendaciones
* **Integración Continua (CI)**: Integrar esta suite automatizada en un pipeline de GitHub Actions para disparar ejecuciones cada vez que se realice un push a `main`.
* **Uso de Datos Dinámicos**: En lugar de harcodear las credenciales directas de Sauce Demo, parametrizarlas como variables de entorno seguras para entornos de staging o QA.

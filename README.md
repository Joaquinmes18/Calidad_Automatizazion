# Sauce Demo Automation - 1000 Capybara Samples

## Descripción

Este proyecto es una **suite de pruebas automatizadas** para validar la funcionalidad de la tienda en línea **Sauce Demo** utilizando **Capybara**, **Cucumber** y **Selenium WebDriver**.

Las pruebas cubren los siguientes flujos de negocio:
- ✅ **Autenticación**: Validación de login con diferentes tipos de usuarios
- ✅ **Catálogo de Productos**: Visualización y ordenamiento de productos
- ✅ **Carrito de Compras**: Agregar, remover y gestionar productos
- ✅ **Checkout**: Proceso completo de compra con validación de datos
- ✅ **Menú**: Gestión de sesión y funcionalidades del menú

## Requisitos Previos

### Software Necesario
- **Ruby** 3.0 o superior
- **Cucumber** para BDD (Behavior-Driven Development)
- **Capybara** para interacción con el navegador
- **Selenium WebDriver** para automatización del navegador
- **Chrome** o **Brave** navegador instalado

### Instalación de Dependencias

1. **Instalar Ruby Gems**:
```bash
bundle install
```

O manualmente:
```bash
gem install cucumber
gem install capybara
gem install capybara-screenshot
gem install selenium-webdriver
gem install rspec
```

2. **Descargar ChromeDriver** (si usas Chrome):
   - Descargado desde: https://chromedriver.chromium.org/
   - Debe estar en el PATH del sistema

## Estructura del Proyecto

```
1000CapybaraSamples/
├── features/                          # Archivos de características Cucumber
│   ├── Autentication.feature          # Pruebas de login
│   ├── cart.feature                   # Pruebas del carrito
│   ├── checkout.feature               # Pruebas de checkout
│   ├── menu.feature                   # Pruebas del menú
│   ├── products.feature               # Pruebas de catálogo
│   └── step_definitions/              # Implementación de pasos
│       ├── AutenticatioSteps.rb       # Pasos de autenticación
│       ├── cart_steps.rb              # Pasos del carrito
│       ├── checkout_steps.rb          # Pasos del checkout
│       ├── common_steps.rb            # Pasos comunes
│       ├── menu_steps.rb              # Pasos del menú
│       └── products_steps.rb          # Pasos de productos
└── features/support/                  # Configuración de Capybara
    ├── env.rb                         # Configuración de drivers
    └── hooks.rb                       # Hooks de Cucumber
├── reports/                           # Reportes de ejecución
├── screenshots/                       # Capturas de pantalla
└── README.md                          # Este archivo
```

## Configuración del Navegador

### Usar Chrome (Predeterminado)

Edita `features/support/env.rb`:
```ruby
# Chrome está habilitado por defecto, sin cambios necesarios
CapybaraDriverRegistrar.register_selenium_driver(:chrome)
```

### Cambiar a Brave

Si deseas usar Brave en lugar de Chrome, edita `features/support/env.rb`:
```ruby
if browser == :chrome
  options = Selenium::WebDriver::Chrome::Options.new
  # Descomenta la siguiente línea:
  options.binary = "C:/Program Files/BraveSoftware/Brave-Browser/Application/brave.exe"
  
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end
```

## Cómo Ejecutar las Pruebas

### Ejecutar Todas las Pruebas
```bash
cucumber .\features
```

### Ejecutar Archivo de Características Específico
```bash
cucumber .\features\cart.feature
```

### Ejecutar Escenarios con Etiquetas Específicas
```bash
# Ejecutar solo pruebas @smoke
cucumber .\features --tags @smoke

# Ejecutar solo pruebas @checkout
cucumber .\features --tags @checkout

# Ejecutar solo pruebas @cart
cucumber .\features --tags @cart
```

### Ejecutar con Reporte HTML
```bash
cucumber .\features --format html:reports/report.html
```

### Ejecutar en Modo Paralelo
```bash
# Requiere gem parallel_tests
parallel_test .\features
```

## Reportes

Los reportes se generan automáticamente en la carpeta `reports/` después de cada ejecución.

**Archivos de reporte**:
- `cucumber_report.html` - Reporte HTML detallado
- `cucumber_report_100percent.html` - Reporte cuando todas las pruebas pasan

**Capturas de Pantalla**:
- Ubicadas en `screenshots/`
- También se generan en archivos `.html` cuando las pruebas fallan

## Estadísticas de Pruebas

**Total de Escenarios**: 30
**Total de Pasos**: 181
**Estado**: ✅ 24 Escenarios Pasando

### Distribución por Módulo:
- **Autenticación**: 10 escenarios (login con diferentes usuarios)
- **Productos**: 4 escenarios (visualización y ordenamiento)
- **Carrito**: 7 escenarios (agregar, remover, gestionar)
- **Checkout**: 5 escenarios (validación y compra)
- **Menú**: 1 escenario (logout)

## Variables de Entorno

En `features/support/env.rb` se encuentran configuradas:

- `Capybara.app_host` - URL destino de la aplicación
- `Capybara.default_max_wait_time` - Tiempo máximo de espera (15 segundos)
- `Capybara.default_driver` - Driver por defecto (Selenium)

## Credenciales de Prueba

Sauce Demo proporciona múltiples usuarios para pruebas:

```
Usuario Estándar:
  Username: standard_user
  Password: secret_sauce
  Resultado: Login exitoso

Usuario Bloqueado:
  Username: locked_out_user
  Password: secret_sauce
  Resultado: Cuenta bloqueada

Usuario Problemático:
  Username: problem_user
  Password: secret_sauce
  Resultado: Login exitoso (con problemas visuales)

Usuarios de Rendimiento:
  Username: performance_glitch_user, error_user, visual_user
  Password: secret_sauce
  Resultado: Login exitoso
```

## Solución de Problemas

### Las pruebas fallan con "timeout"
- Aumenta el valor de `Capybara.default_max_wait_time` en `env.rb`
- Verifica la velocidad de tu conexión a internet

### ChromeDriver no se encuentra
- Asegúrate de tener ChromeDriver en tu PATH
- O descargarlo desde: https://chromedriver.chromium.org/

### Brave no se abre correctamente
- Verifica la ruta de instalación de Brave en tu sistema
- Ejecuta Brave manualmente para asegurar que funciona

### Las capturas de pantalla no se generan
- Verifica que la carpeta `screenshots/` exista
- Asegúrate de tener permisos de escritura en el directorio

## Documentación Adicional

- [Cucumber Documentation](https://cucumber.io/docs/cucumber/)
- [Capybara Documentation](https://teamcapybara.github.io/capybara/)
- [Selenium WebDriver](https://www.selenium.dev/documentation/)
- [Sauce Demo App](https://www.saucedemo.com/)

## Autor

Proyecto de Automatización de Pruebas - Calidad de Software

## Licencia

Libre para uso educativo y de pruebas

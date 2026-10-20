# Análisis de Base de Datos - Primera Forma Normal (1FN)

Perfecto. Vamos a analizar el punto 1: **Primera Forma Normal (1FN)**.

---

## 📋 Primera Forma Normal (1FN)

La **1FN** exige:
- **Atributos atómicos:** Sin listas ni valores múltiples en una sola celda.
- **Sin grupos repetidos:** No debe haber columnas duplicadas o repetidas para un mismo concepto.
- **Clave Primaria:** Una clave primaria (PK) claramente definida por tabla.
- **Sin columnas genéricas:** Evitar nombres genéricos tipo `col1`, `col2` que representen múltiples valores.

---

## 🔍 Revisión Tabla por Tabla

### ✅ Tablas que cumplen 1FN correctamente

| Tabla | Observación | Estado |
| :--- | :--- | :---: |
| **ROLES** | Atributos atómicos, PK definida. | ✔️ |
| **CATEGORIAS** | Atributos atómicos, PK definida. | ✔️ |
| **USUARIOS** | Atributos atómicos, PK `codigo_user`. | ✔️ |
| **CREDENCIALES** | Atributos atómicos, PK `codigo_cred`. | ✔️ |
| **MENSAJES** | Atributos atómicos. *(Nota: Aunque le falta PK, se revisará en 2FN/3FN)*. | ✔️ |
| **PRODUCTOS** | Atributos atómicos, PK `codigo_producto`. | ✔️ |
| **CLIENTES** | Atributos atómicos, PK `codigo_customer`. | ✔️ |
| **PEDIDOS** | Atributos atómicos, PK `codigo_pedido`. | ✔️ |
| **VENDEDORES** | Atributos atómicos, PK `codigo_seller`. | ✔️ |
| **COMPRAS** | Atributos atómicos, PK `codigo_compra`. | ✔️ |

---

### ⚠️ Tablas con problemas de 1FN

#### 1. `LISTA_PRODUCTOS_PEDIDOS`

```sql
CREATE TABLE LISTA_PRODUCTOS_PEDIDOS (
  codigo_pedido VARCHAR(10) NOT NULL,
  codigo_producto VARCHAR(10) NOT NULL,
  cantidad_productos INT NOT NULL,
  ...
);
```

**Hallazgos:**
- **Sin Primary Key:** No tiene `PRIMARY KEY` definida, lo cual viola la 1FN (toda tabla debe identificar unívocamente sus filas).
- **PK Compuesta sugerida:** La PK natural debería ser la clave compuesta `(codigo_pedido, codigo_producto)`.
- **Ambigüedad potencial:** Si un mismo pedido pudiera incluir el mismo producto en dos líneas distintas (ej. por promociones o descuentos aplicados individualmente), conviene añadir una columna sintética `id_linea` o mantener la clave compuesta según el caso de negocio.

**Corrección sugerida:**
```sql
PRIMARY KEY (codigo_pedido, codigo_producto)
```

---

#### 2. `LISTA_PRODUCTOS_COMPRADOS`

```sql
CREATE TABLE LISTA_PRODUCTOS_COMPRADOS (
  codigo_compra VARCHAR(10) NOT NULL,
  codigo_producto VARCHAR(45) NOT NULL, -- ⚠️ Inconsistencia: VARCHAR(45) vs VARCHAR(10) en PRODUCTOS
  precio_producto_compra DECIMAL(10,2) NOT NULL,
  cantidad_productos_compra INT NOT NULL,
  ...
);
```

**Hallazgos:**
- **Sin Primary Key:** No tiene `PRIMARY KEY` definida, violando la 1FN.
- **Inconsistencia de tipos:** La columna `codigo_producto` utiliza `VARCHAR(45)`, mientras que en la tabla `PRODUCTOS` está definida como `VARCHAR(10)`. Aunque algunos motores como MySQL permiten definir la relación si los datos son compatibles, representa una mala práctica de diseño que puede causar fallos en validaciones estrictas o migraciones. Debe corregirse a `VARCHAR(10)`.
- **PK Compuesta sugerida:** Al igual que el caso anterior, requiere definir una clave primaria compuesta `(codigo_compra, codigo_producto)`.

---
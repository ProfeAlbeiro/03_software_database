-- =====================================================
-- BASE DE DATOS: bbdd_ventas
-- Estado: 1FN ✅ + 2FN ✅ + 3FN ✅
-- (Roles/permisos y módulos de pagos/proveedores/comisiones
--  se completan en los puntos 4 y 5)
-- =====================================================

DROP DATABASE IF EXISTS bbdd_ventas;
CREATE DATABASE bbdd_ventas DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE bbdd_ventas;


-- -----------------------------------------------------
-- Table ROLES
-- (se rediseñará en punto 4: permisos, acciones)
-- -----------------------------------------------------
CREATE TABLE ROLES (
  codigo_rol INT NOT NULL AUTO_INCREMENT,
  nombre_rol VARCHAR(50) NOT NULL,
  PRIMARY KEY (codigo_rol))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table USUARIOS
-- (se rediseñará en punto 4)
-- -----------------------------------------------------
CREATE TABLE USUARIOS (
  codigo_rol INT NOT NULL,
  codigo_user VARCHAR(10) NOT NULL,
  nombres_user VARCHAR(50) NOT NULL,
  apellidos_user VARCHAR(50) NOT NULL,
  correo_user VARCHAR(100) NOT NULL,
  PRIMARY KEY (codigo_user),
  INDEX ind_usuario_rol (codigo_rol ASC),
  UNIQUE INDEX uq_correo_user (correo_user ASC),
  CONSTRAINT fk_usuario_rol
    FOREIGN KEY (codigo_rol)
    REFERENCES ROLES (codigo_rol)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table CREDENCIALES
-- -----------------------------------------------------
CREATE TABLE CREDENCIALES (
  codigo_cred VARCHAR(10) NOT NULL,
  foto_cred BLOB NOT NULL,
  identificacion_cred VARCHAR(30) NOT NULL,
  fecha_ingreso_cred DATE NOT NULL,
  pass_cred VARCHAR(150) NOT NULL,
  estado_cred TINYINT NOT NULL,
  PRIMARY KEY (codigo_cred),
  UNIQUE INDEX uq_identificacion_cred (identificacion_cred ASC),
  CONSTRAINT fk_credencial_usuario
    FOREIGN KEY (codigo_cred)
    REFERENCES USUARIOS (codigo_user)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table MENSAJES
-- ⚙️ 1FN: codigo_mensaje como PK
-- -----------------------------------------------------
CREATE TABLE MENSAJES (
  codigo_mensaje INT NOT NULL AUTO_INCREMENT,
  codigo_user VARCHAR(10) NOT NULL,
  fecha_mensaje DATE NOT NULL,
  asunto_mensaje VARCHAR(50) NOT NULL,
  descripcion_mensaje VARCHAR(300) NOT NULL,
  PRIMARY KEY (codigo_mensaje),
  INDEX ind_mensaje_usuario (codigo_user ASC),
  CONSTRAINT fk_mensaje_usuario
    FOREIGN KEY (codigo_user)
    REFERENCES USUARIOS (codigo_user)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table CATEGORIAS
-- -----------------------------------------------------
CREATE TABLE CATEGORIAS (
  codigo_categoria INT NOT NULL AUTO_INCREMENT,
  nombre_categoria VARCHAR(50) NOT NULL,
  PRIMARY KEY (codigo_categoria))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table PRODUCTOS
-- ✅ 3FN: stock_productos es caché controlado (aceptable)
-- -----------------------------------------------------
CREATE TABLE PRODUCTOS (
  codigo_categoria INT NOT NULL,
  codigo_producto VARCHAR(10) NOT NULL,
  nombre_producto VARCHAR(50) NOT NULL,
  precio_producto DECIMAL(10,2) NOT NULL,
  unidad_producto DECIMAL(5,2) NOT NULL,
  medida_producto VARCHAR(20) NOT NULL,
  stock_productos INT NOT NULL,
  PRIMARY KEY (codigo_producto),
  INDEX ind_producto_categoria (codigo_categoria ASC),
  CONSTRAINT fk_producto_categoria
    FOREIGN KEY (codigo_categoria)
    REFERENCES CATEGORIAS (codigo_categoria)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table CLIENTES
-- -----------------------------------------------------
CREATE TABLE CLIENTES (
  codigo_customer VARCHAR(10) NOT NULL,
  fecha_nac_customer DATE NOT NULL,
  PRIMARY KEY (codigo_customer),
  INDEX ind_cliente_credencial (codigo_customer ASC),
  CONSTRAINT fk_cliente_credencial
    FOREIGN KEY (codigo_customer)
    REFERENCES CREDENCIALES (codigo_cred)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table DIRECCIONES (NUEVA - 3FN)
-- Las direcciones dependen del CLIENTE, no del PEDIDO.
-- Elimina la dependencia transitiva ciudad_pedido / direccion_pedido.
-- -----------------------------------------------------
CREATE TABLE DIRECCIONES (
  codigo_direccion INT NOT NULL AUTO_INCREMENT,
  codigo_customer VARCHAR(10) NOT NULL,
  ciudad_direccion VARCHAR(50) NOT NULL,
  direccion_direccion VARCHAR(100) NOT NULL,
  tipo_direccion VARCHAR(30) NOT NULL,     -- 'CASA', 'TRABAJO', 'OTRA'
  es_principal TINYINT NOT NULL DEFAULT 0, -- 1 = dirección principal
  PRIMARY KEY (codigo_direccion),
  INDEX ind_direccion_cliente (codigo_customer ASC),
  CONSTRAINT fk_direccion_cliente
    FOREIGN KEY (codigo_customer)
    REFERENCES CLIENTES (codigo_customer)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table ESTADOS_PEDIDO (NUEVA - 3FN)
-- Reemplaza el VARCHAR libre estado_pedido por una FK controlada.
-- -----------------------------------------------------
CREATE TABLE ESTADOS_PEDIDO (
  codigo_estado INT NOT NULL AUTO_INCREMENT,
  nombre_estado VARCHAR(30) NOT NULL,
  PRIMARY KEY (codigo_estado),
  UNIQUE INDEX uq_nombre_estado (nombre_estado ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table VENDEDORES
-- -----------------------------------------------------
CREATE TABLE VENDEDORES (
  codigo_seller VARCHAR(10) NOT NULL,
  salario_seller DECIMAL(8,2) NOT NULL,
  PRIMARY KEY (codigo_seller),
  INDEX ind_vendedor_credencial (codigo_seller ASC),
  CONSTRAINT fk_vendedor_credencial
    FOREIGN KEY (codigo_seller)
    REFERENCES CREDENCIALES (codigo_cred)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table PEDIDOS
-- ⚙️ 3FN: se eliminaron total_pl_pedido, iva_pedido, total_pr_pedido (derivados)
-- ⚙️ 3FN: se eliminaron ciudad_pedido y direccion_pedido (transitivos → DIRECCIONES)
-- ⚙️ 3FN: se añadió canal_venta (LOCAL / ONLINE)
-- ⚙️ 3FN: se añadió codigo_seller (FK nullable, solo ventas LOCAL)
-- ⚙️ 3FN: se añadió codigo_direccion (FK nullable, obligatoria en ONLINE)
-- ⚙️ 3FN: estado_pedido pasa a ser FK a ESTADOS_PEDIDO
-- NOTA: codigo_pago se añadirá en el punto 5 (módulo de pagos)
-- -----------------------------------------------------
CREATE TABLE PEDIDOS (
  codigo_pedido VARCHAR(10) NOT NULL,
  codigo_customer VARCHAR(10) NOT NULL,
  codigo_direccion INT NULL,                -- obligatoria si canal_venta = 'ONLINE'
  codigo_seller VARCHAR(10) NULL,           -- obligatorio si canal_venta = 'LOCAL'
  codigo_estado INT NOT NULL,
  fecha_pedido DATE NOT NULL,
  canal_venta ENUM('LOCAL','ONLINE') NOT NULL,
  PRIMARY KEY (codigo_pedido),
  INDEX ind_pedido_cliente (codigo_customer ASC),
  INDEX ind_pedido_direccion (codigo_direccion ASC),
  INDEX ind_pedido_seller (codigo_seller ASC),
  INDEX ind_pedido_estado (codigo_estado ASC),
  CONSTRAINT fk_pedido_cliente
    FOREIGN KEY (codigo_customer)
    REFERENCES CLIENTES (codigo_customer)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_pedido_direccion
    FOREIGN KEY (codigo_direccion)
    REFERENCES DIRECCIONES (codigo_direccion)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT fk_pedido_seller
    FOREIGN KEY (codigo_seller)
    REFERENCES VENDEDORES (codigo_seller)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT fk_pedido_estado
    FOREIGN KEY (codigo_estado)
    REFERENCES ESTADOS_PEDIDO (codigo_estado)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table LISTA_PRODUCTOS_PEDIDOS
-- ⚙️ 1FN: PK compuesta (codigo_pedido, codigo_producto)
-- ✅ 2FN: cantidad_productos depende de la PK completa
-- ⚙️ 3FN (mejora): se añadió precio_unitario_pedido (precio histórico)
-- -----------------------------------------------------
CREATE TABLE LISTA_PRODUCTOS_PEDIDOS (
  codigo_pedido VARCHAR(10) NOT NULL,
  codigo_producto VARCHAR(10) NOT NULL,
  cantidad_productos INT NOT NULL,
  precio_unitario_pedido DECIMAL(10,2) NOT NULL,  -- precio al momento de la venta
  PRIMARY KEY (codigo_pedido, codigo_producto),
  INDEX ind_lista_productos_pedido (codigo_pedido ASC),
  INDEX ind_lista_producto_producto (codigo_producto ASC),
  CONSTRAINT fk_lista_productos_pedido
    FOREIGN KEY (codigo_pedido)
    REFERENCES PEDIDOS (codigo_pedido)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_lista_productos_producto
    FOREIGN KEY (codigo_producto)
    REFERENCES PRODUCTOS (codigo_producto)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table PROVEEDORES (NUEVA - mínima, se amplía en punto 5)
-- Necesaria para que COMPRAS tenga sentido (¿a quién le compras?).
-- -----------------------------------------------------
CREATE TABLE PROVEEDORES (
  codigo_proveedor VARCHAR(10) NOT NULL,
  nombre_proveedor VARCHAR(100) NOT NULL,
  telefono_proveedor VARCHAR(30) NULL,
  correo_proveedor VARCHAR(100) NULL,
  PRIMARY KEY (codigo_proveedor))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table COMPRAS
-- ⚙️ 3FN: se eliminó total_pr_compra (derivado)
-- ⚙️ 3FN: se añadió codigo_proveedor (FK)
-- -----------------------------------------------------
CREATE TABLE COMPRAS (
  codigo_compra VARCHAR(10) NOT NULL,
  codigo_proveedor VARCHAR(10) NOT NULL,
  fecha_compra DATE NOT NULL,
  documento_compra BLOB NOT NULL,
  PRIMARY KEY (codigo_compra),
  INDEX ind_compra_proveedor (codigo_proveedor ASC),
  CONSTRAINT fk_compra_proveedor
    FOREIGN KEY (codigo_proveedor)
    REFERENCES PROVEEDORES (codigo_proveedor)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table LISTA_PRODUCTOS_COMPRADOS
-- ⚙️ 1FN: PK compuesta (codigo_compra, codigo_producto)
--        codigo_producto: VARCHAR(45) → VARCHAR(10)
-- ⚙️ 2FN: precio_producto_compra → precio_unitario_compra
-- -----------------------------------------------------
CREATE TABLE LISTA_PRODUCTOS_COMPRADOS (
  codigo_compra VARCHAR(10) NOT NULL,
  codigo_producto VARCHAR(10) NOT NULL,
  precio_unitario_compra DECIMAL(10,2) NOT NULL,
  cantidad_productos_compra INT NOT NULL,
  PRIMARY KEY (codigo_compra, codigo_producto),
  INDEX ind_lista_prod_comp_productos (codigo_producto ASC),
  INDEX ind_lista_prod_comp_compra (codigo_compra ASC),
  CONSTRAINT fk_lista_prod_comp_productos
    FOREIGN KEY (codigo_producto)
    REFERENCES PRODUCTOS (codigo_producto)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_lista_prod_comp_compra
    FOREIGN KEY (codigo_compra)
    REFERENCES COMPRAS (codigo_compra)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- =====================================================
-- DATOS SEMILLA (opcionales, para pruebas)
-- =====================================================
INSERT INTO ESTADOS_PEDIDO (nombre_estado) VALUES
  ('PENDIENTE'),
  ('PAGADO'),
  ('ENVIADO'),
  ('ENTREGADO'),
  ('CANCELADO');

INSERT INTO ROLES (nombre_rol) VALUES
  ('ADMINISTRADOR'),
  ('VENDEDOR'),
  ('CLIENTE');
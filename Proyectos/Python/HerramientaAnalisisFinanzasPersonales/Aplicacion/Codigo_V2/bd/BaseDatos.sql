DROP DATABASE IF EXISTS BD_;
CREATE DATABASE BD_;
USE BD_;

-- ----------------------------------------------
-- ----------------- PRODUCTO -------------------
-- ----------------------------------------------

CREATE TABLE PRODUCTO(
PRODUCTO VARCHAR(100) NOT NULL,
COLOR VARCHAR(50) NOT NULL,
DESCRIPCION VARCHAR(100),
PRIMARY KEY( PRODUCTO ));

INSERT INTO PRODUCTO( PRODUCTO , COLOR ) VALUES( 'MSCI' , 'rgba( 19 , 6 , 120 , 1 )' );       -- AzulMarino
INSERT INTO PRODUCTO( PRODUCTO , COLOR ) VALUES( 'Bono' , 'rgba( 120 , 3 , 138 , 1 )' );        -- Violeta
INSERT INTO PRODUCTO( PRODUCTO , COLOR ) VALUES( 'Acciones Europa' , 'rgba( 7 , 181 , 42 , 1 )' );     -- VerdeEsmeralda
INSERT INTO PRODUCTO( PRODUCTO , COLOR ) VALUES( 'Acciones EEUU' , 'rgba( 138 , 122 , 3 , 1 )' );  -- Dorado
INSERT INTO PRODUCTO( PRODUCTO , COLOR ) VALUES( 'REIT' , 'rgba( 97 , 23 , 2 , 1 )' );          -- Marron

-- ----------------------------------------------
-- ---------------- ESTRATEGIA ------------------
-- ----------------------------------------------

CREATE TABLE ESTRATEGIA(
ESTRATEGIA VARCHAR(30) NOT NULL,
COLOR VARCHAR(50) NOT NULL,
DESCRIPCION VARCHAR(100),
PRIMARY KEY( ESTRATEGIA ));

INSERT INTO ESTRATEGIA( ESTRATEGIA , COLOR ) VALUES( 'BogleHead' , 'rgba( 19 , 6 , 120 , 1 )' );       -- AzulMarino
INSERT INTO ESTRATEGIA( ESTRATEGIA , COLOR ) VALUES( 'Grow' , 'rgba( 120 , 3 , 138 , 1 )' );        -- Violeta
INSERT INTO ESTRATEGIA( ESTRATEGIA , COLOR ) VALUES( 'DGI' , 'rgba( 7 , 181 , 42 , 1 )' );     -- VerdeEsmeralda
INSERT INTO ESTRATEGIA( ESTRATEGIA , COLOR ) VALUES( 'CarteraPermanente' , 'rgba( 138 , 122 , 3 , 1 )' );  -- Dorado

-- ----------------------------------------------
-- ------------------ ACTIVO --------------------
-- ----------------------------------------------

CREATE TABLE ACTIVO(
ISIN VARCHAR(30) NOT NULL,
TIPO_PRODUCTO VARCHAR(30) NOT NULL,
TIPO_EMISOR VARCHAR(30) NOT NULL,
FUENTE VARCHAR(100) NOT NULL,
LINK VARCHAR(100) NOT NULL,
MONEDA VARCHAR(3) NOT NULL,
DESCRIPCION VARCHAR(100),
COLOR VARCHAR(50) NOT NULL, 
PRECIO FLOAT,
PRODUCTO VARCHAR(30) NOT NULL,
ESTRATEGIA VARCHAR(30) NOT NULL,
PRIMARY KEY( ISIN ));

ALTER TABLE ACTIVO
ADD CONSTRAINT activo_producto FOREIGN KEY(PRODUCTO) REFERENCES PRODUCTO(PRODUCTO) ON DELETE CASCADE,
ADD CONSTRAINT activo_estrategia FOREIGN KEY(ESTRATEGIA) REFERENCES ESTRATEGIA(ESTRATEGIA) ON DELETE CASCADE;

-- ----------------------------------------------
-- ---------------- CATEGORIA -------------------
-- ----------------------------------------------

CREATE TABLE CATEGORIA(
CATEGORIA VARCHAR(30) NOT NULL,
COLOR VARCHAR(50) NOT NULL,
DESCRIPCION VARCHAR(100),
PRIMARY KEY( CATEGORIA ));

-- -------------- CATEGORIZACION -----------------

CREATE TABLE CATEGORIZACION(
ISIN VARCHAR(30) NOT NULL,
CATEGORIA VARCHAR(50) NOT NULL,
PRIMARY KEY( ISIN , CATEGORIA ));

ALTER TABLE CATEGORIZACION
ADD CONSTRAINT categorizacion_isin FOREIGN KEY(ISIN) REFERENCES ACTIVO(ISIN) ON DELETE CASCADE,
ADD CONSTRAINT categorizacion_categoria FOREIGN KEY(CATEGORIA) REFERENCES CATEGORIA(CATEGORIA) ON DELETE CASCADE;

-- ----------------------------------------------
-- --------------- CLASIFICACION ----------------
-- ----------------------------------------------

CREATE TABLE CLASIFICACION(
CLASIFICACION VARCHAR(30) NOT NULL,
COLOR VARCHAR(50) NOT NULL,
DESCRIPCION VARCHAR(100),
PRIMARY KEY( CLASIFICACION ));

CREATE TABLE SUBCLASIFICACION(
SUBCLASIFICACION VARCHAR(30) NOT NULL,
CLASIFICACION VARCHAR(30) NOT NULL,
PRIMARY KEY( SUBCLASIFICACION ));

ALTER TABLE SUBCLASIFICACION
ADD CONSTRAINT subclasificacion_clasificacion FOREIGN KEY(CLASIFICACION) REFERENCES CLASIFICACION(CLASIFICACION) ON DELETE CASCADE;

INSERT INTO CLASIFICACION( CLASIFICACION , COLOR ) VALUES ( 'Caprichos' ,  'rgba( 217 , 237 , 0 , 1 )' ); -- Amarillo
INSERT INTO CLASIFICACION( CLASIFICACION , COLOR ) VALUES ( 'Compras' ,  'rgba( 2 , 199 , 166 , 1 )' ); -- AzulVerdoso
INSERT INTO CLASIFICACION( CLASIFICACION , COLOR ) VALUES ( 'Estudios' ,  'rgba( 173 , 3 , 88 , 1 )' ); -- Fuxia
INSERT INTO CLASIFICACION( CLASIFICACION , COLOR ) VALUES ( 'Facturas' ,  'rgba( 0 , 98 , 173 , 1 )' );  -- Azul
INSERT INTO CLASIFICACION( CLASIFICACION , COLOR ) VALUES ( 'Gastos' ,  'rgba( 2 , 186 , 199 , 1 )' );   -- AzulCeleste
INSERT INTO CLASIFICACION( CLASIFICACION , COLOR ) VALUES ( 'Ocio' ,  'rgba( 150 , 224 , 0  , 1 )' );   -- VerdeLima
INSERT INTO CLASIFICACION( CLASIFICACION , COLOR ) VALUES ( 'Regalos' ,  'rgba( 138 , 122 , 3 , 1 )' ); -- Dorado
INSERT INTO CLASIFICACION( CLASIFICACION , COLOR ) VALUES ( 'Salario' ,  'rgba( 255 , 255 , 255 , 1 )' ); -- Blanco
INSERT INTO CLASIFICACION( CLASIFICACION , COLOR ) VALUES ( 'Salud' ,  'rgba( 119 , 0 , 237 , 1 )' ); -- VioletaOscuro
INSERT INTO CLASIFICACION( CLASIFICACION , COLOR ) VALUES ( 'Transporte' ,  'rgba( 2 , 199 , 94 , 1 )' ); -- VerdeAzulado
INSERT INTO CLASIFICACION( CLASIFICACION , COLOR ) VALUES ( 'Viajes' ,  'rgba( 7 , 181 , 42 , 1 )' );  -- VerdeEsmeralda
INSERT INTO CLASIFICACION( CLASIFICACION , COLOR ) VALUES ( 'Vivienda' ,  'rgba( 0 , 12 , 173 , 1 )' ); -- Azulmarino
INSERT INTO CLASIFICACION( CLASIFICACION , COLOR ) VALUES ( 'Multas' , 'rgba( 179 , 116 , 0 , 1 )' );   -- Naranja
INSERT INTO CLASIFICACION( CLASIFICACION , COLOR ) VALUES ( 'Apuestas' , 'rgba( 179 , 36 , 0 , 1 )' ); -- Rojo

-- ----------------------------------------------
-- ---------------- ALLOCATION ------------------
-- ----------------------------------------------

CREATE TABLE ALLOCATION(
ALLOCATION VARCHAR(30) NOT NULL,
DESCRIPCION VARCHAR(100),
PRIMARY KEY( ALLOCATION ));

CREATE TABLE SUBALLOCATION(
SUBALLOCATION VARCHAR(30) NOT NULL,
COLOR VARCHAR(50) NOT NULL,
ALLOCATION VARCHAR(30) NOT NULL,
PRIMARY KEY( SUBALLOCATION ));

ALTER TABLE SUBALLOCATION
ADD CONSTRAINT suballocation_allocation FOREIGN KEY(ALLOCATION) REFERENCES ALLOCATION(ALLOCATION) ON DELETE CASCADE;

-- Composicion
INSERT INTO ALLOCATION( ALLOCATION ) VALUES ( 'Composicion' );
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Composicion' , 'Efectivo' , 'rgba( 7 , 181 , 42 , 1 )' );       -- VerdeEsmeralda
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Composicion' , 'Renta Fija' , 'rgba( 0 , 148 , 20 , 1 )' );     -- VerdeOscuro
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Composicion' , 'Renta Variable' , 'rgba( 19 , 6 , 120 , 1 )' ); -- AzulMarino
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Composicion' , 'Commodities' , 'rgba( 138 , 122 , 3 , 1 )' );   -- Dorado
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Composicion' , 'Real State' , 'rgba( 120 , 3 , 138 , 1 )' );    -- Violeta

-- Region
INSERT INTO ALLOCATION( ALLOCATION ) VALUES ( 'Region' );
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Region' , 'Estados Unidos' , 'rgba( 19 , 6 , 120 , 1 )' );    -- AzulMarino
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Region' , 'Canada'         , 'rgba( 230 , 0 , 0 , 1 )' );     -- Rojo
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Region' , 'Latino America' , 'rgba( 0 , 148 , 20 , 1 )' );    -- VerdeOscuro
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Region' , 'Reino Unido'    , 'rgba( 120 , 3 , 138 , 1 )' );   -- Violeta
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Region' , 'Europa'         , 'rgba( 52 , 215 , 247 , 1 )' );  -- AzulCeleste
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Region' , 'Africa'         , 'rgba( 230 , 174 , 44 , 1 )' );  -- Naranja
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Region' , 'Oriente Medio'  , 'rgba( 230 , 227 , 44 , 1 )' );  -- Amarillo
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Region' , 'Japon'          , 'rgba( 148 , 142 , 132 , 1 )' ); -- Plateado
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Region' , 'Australia'      , 'rgba( 138 , 122 , 3 , 1 )' );   -- Dorado
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Region' , 'Asia'           , 'rgba( 252 , 251 , 247 , 1 )' ); -- Blanco

-- Sector
INSERT INTO ALLOCATION( ALLOCATION ) VALUES ( 'Sector' );
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Sector' , 'Materias Primas'  , 'rgba( 19 , 6 , 120 , 1 )' );    -- AzulMarino
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Sector' , 'Consumo'          , 'rgba( 230 , 0 , 0 , 1 )' );     -- Rojo
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Sector' , 'Financiero'       , 'rgba( 0 , 148 , 20 , 1 )' );    -- VerdeOscuro
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Sector' , 'Inmoviliario'     , 'rgba( 120 , 3 , 138 , 1 )' );   -- Violeta
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Sector' , 'Salud'            , 'rgba( 230 , 174 , 44 , 1 )' );  -- Naranja
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Sector' , 'Servivicios'      , 'rgba( 230 , 227 , 44 , 1 )' );  -- Amarillo
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Sector' , 'Comunicacion'     , 'rgba( 148 , 142 , 132 , 1 )' ); -- Plateado
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Sector' , 'Energia'          , 'rgba( 138 , 122 , 3 , 1 )' );   -- Dorado
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Sector' , 'Industria'        , 'rgba( 252 , 251 , 247 , 1 )' ); -- Blanco
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Sector' , 'Tecnologia'       , 'rgba( 79 , 179 , 155 , 1 )' );  -- VerdeAzulado

-- Capitalizacion
INSERT INTO ALLOCATION( ALLOCATION ) VALUES ( 'Capitalizacion' );
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Capitalizacion' , 'Gigante' , 'rgba( 19 , 6 , 120 , 1 )' );     -- AzulMarino
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Capitalizacion' , 'Grande'  , 'rgba( 230 , 0 , 0 , 1 )' );      -- Rojo
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Capitalizacion' , 'Mediano' , 'rgba( 0 , 148 , 20 , 1 )' );     -- VerdeOscuro
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Capitalizacion' , 'Pequeño' , 'rgba( 120 , 3 , 138 , 1 )' );    -- Violeta
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Capitalizacion' , 'Micro'   , 'rgba( 52 , 215 , 247 , 1 )' );   -- AzulCeleste

-- Vencimiento
INSERT INTO ALLOCATION( ALLOCATION ) VALUES ( 'Vencimiento' );
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Vencimiento' , '1 a 3'     , 'rgba( 19 , 6 , 120 , 1 )' );     -- AzulMarino
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Vencimiento' , '3 a 5'     , 'rgba( 230 , 0 , 0 , 1 )' );      -- Rojo
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Vencimiento' , '5 a 7'     , 'rgba( 0 , 148 , 20 , 1 )' );     -- VerdeOscuro
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Vencimiento' , '7 a 10'    , 'rgba( 120 , 3 , 138 , 1 )' );    -- Violeta
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Vencimiento' , '10 a 15'   , 'rgba( 52 , 215 , 247 , 1 )' );   -- AzulCeleste
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Vencimiento' , '15 a 20'   , 'rgba( 230 , 174 , 44 , 1 )' );   -- Naranja
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Vencimiento' , '20 a 30'   , 'rgba( 230 , 227 , 44 , 1 )' );   -- Amarillo
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Vencimiento' , 'mas de 30' , 'rgba( 148 , 142 , 132 , 1 )' );  -- Plateado

-- Calidad crediticia
INSERT INTO ALLOCATION( ALLOCATION ) VALUES ( 'Calidad' );
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Calidad' , 'AAA'     , 'rgba( 19 , 6 , 120 , 1 )' );     -- AzulMarino
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Calidad' , 'AA'      , 'rgba( 230 , 0 , 0 , 1 )' );      -- Rojo
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Calidad' , 'A'       , 'rgba( 0 , 148 , 20 , 1 )' );     -- VerdeOscuro
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Calidad' , 'B'       , 'rgba( 120 , 3 , 138 , 1 )' );    -- Violeta
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Calidad' , 'BB'      , 'rgba( 52 , 215 , 247 , 1 )' );   -- AzulCeleste
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Calidad' , 'BBB'     , 'rgba( 230 , 174 , 44 , 1 )' );   -- Naranja
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Calidad' , 'Ninguna' , 'rgba( 230 , 227 , 44 , 1 )' );   -- Amarillo

-- Entidad emisora
INSERT INTO ALLOCATION( ALLOCATION ) VALUES ( 'Entidad' );
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Entidad' , 'Institucional' , 'rgba( 19 , 6 , 120 , 1 )' );  -- AzulMarino
INSERT INTO SUBALLOCATION( ALLOCATION , SUBALLOCATION , COLOR ) VALUES( 'Entidad' , 'Gurnamental'   , 'rgba( 230 , 0 , 0 , 1 )' );   -- Rojo


-- --------------- DISTRIBUCION ----------------- 

CREATE TABLE DISTRIBUCION(
ISIN VARCHAR(30) NOT NULL,
SUBALLOCATION VARCHAR(30) NOT NULL,
PRECIO FLOAT NOT NULL,
PRIMARY KEY( ISIN , SUBALLOCATION ));

ALTER TABLE DISTRIBUCION
ADD CONSTRAINT distribucion_isin FOREIGN KEY(ISIN) REFERENCES ACTIVO(ISIN) ON DELETE CASCADE,
ADD CONSTRAINT distribucion_suballocation FOREIGN KEY(SUBALLOCATION) REFERENCES SUBALLOCATION(SUBALLOCATION)ON DELETE CASCADE;

-- ----------------------------------------------
-- ------------------ CUENTA --------------------
-- ----------------------------------------------

CREATE TABLE CUENTA(
CUENTA VARCHAR(30) NOT NULL,
COLOR VARCHAR(50) NOT NULL,
DESCRIPCION VARCHAR(100),
MONEDA VARCHAR(3) NOT NULL,
PAIS VARCHAR(30) NOT NULL,
PRIMARY KEY( CUENTA ));

-- ----------------------------------------------
-- ---------------- APORTACION ------------------
-- ----------------------------------------------

CREATE TABLE APORTACION(
ISIN VARCHAR(30) NOT NULL,
CUENTA VARCHAR(30) NOT NULL, 
FECHA DATE NOT NULL,
PRECIO FLOAT NOT NULL,
TITULOS FLOAT NOT NULL,
CAMBIO FLOAT NOT NULL,
TIPO_OPERACION VARCHAR(30) NOT NULL,
FAVORITA VARCHAR(2) NOT NULL,
DESCRIPCION VARCHAR(100),
PRIMARY KEY( ISIN , CUENTA , FECHA , TIPO_OPERACION ));

ALTER TABLE APORTACION
ADD CONSTRAINT apotacion_isin FOREIGN KEY(ISIN) REFERENCES ACTIVO(ISIN) ON DELETE CASCADE,
ADD CONSTRAINT apotacion_cuenta FOREIGN KEY(CUENTA) REFERENCES CUENTA(CUENTA) ON DELETE CASCADE;

-- ----------------------------------------------
-- ----------------- COMISION -------------------
-- ----------------------------------------------

CREATE TABLE COMISION(
ISIN VARCHAR(30) NOT NULL,
CUENTA VARCHAR(30) NOT NULL, 
FECHA DATE NOT NULL,
GASTO FLOAT NOT NULL,
INGRESO FLOAT NOT NULL,
TIPO_OPERACION VARCHAR(30) NOT NULL,
FAVORITA VARCHAR(2) NOT NULL,
DESCRIPCION VARCHAR(100),
PRIMARY KEY( ISIN , CUENTA , FECHA , TIPO_OPERACION ));

ALTER TABLE COMISION
ADD CONSTRAINT comision_cuenta FOREIGN KEY(CUENTA) REFERENCES CUENTA(CUENTA) ON DELETE CASCADE;

-- ----------------------------------------------
-- ----------------- TRASPASO -------------------
-- ----------------------------------------------

CREATE TABLE TRASPASO(
ORIGEN VARCHAR(30) NOT NULL,
DESTINO VARCHAR(30) NOT NULL, 
FECHA DATE NOT NULL,
PRECIO FLOAT NOT NULL,
FAVORITA VARCHAR(2) NOT NULL,
DESCRIPCION VARCHAR(100),
PRIMARY KEY( ORIGEN , DESTINO , FECHA ));

ALTER TABLE TRASPASO
ADD CONSTRAINT traspaso_origen FOREIGN KEY(ORIGEN) REFERENCES CUENTA(CUENTA) ON DELETE CASCADE,
ADD CONSTRAINT traspaso_destino FOREIGN KEY(DESTINO) REFERENCES CUENTA(CUENTA) ON DELETE CASCADE;

-- ----------------------------------------------
-- --------------- TRANSACCION ------------------
-- ----------------------------------------------

CREATE TABLE TRANSACCION(
CUENTA VARCHAR(30) NOT NULL,
SUBCLASIFICACION VARCHAR(30) NOT NULL, 
FECHA DATE NOT NULL,
GASTO FLOAT NOT NULL,
INGRESO FLOAT NOT NULL,
FAVORITA VARCHAR(2) NOT NULL,
DESCRIPCION VARCHAR(100),
PRIMARY KEY( CUENTA , SUBCLASIFICACION , FECHA ));

ALTER TABLE TRANSACCION
ADD CONSTRAINT transaccion_cuenta FOREIGN KEY(CUENTA) REFERENCES CUENTA(CUENTA) ON DELETE CASCADE,
ADD CONSTRAINT transaccion_subclasificacion FOREIGN KEY(SUBCLASIFICACION) REFERENCES SUBCLASIFICACION(SUBCLASIFICACION)ON DELETE CASCADE;

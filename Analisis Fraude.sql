CREATE TABLE AlertasFraude (
    AlertaID INT IDENTITY(1,1) PRIMARY KEY,
    TransaccionID nvarchar(50) NOT NULL,
    TipoAlerta VARCHAR(100),
    NivelRiesgo VARCHAR(20),
    FechaAlerta DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (TransaccionID)
    REFERENCES [dbo].[transacciones](TransaccionID)
);
--Generar Fraude
SELECT
    MAX(Monto) AS MontoMaximo,
    AVG(Monto) AS MontoPromedio
FROM Transacciones;
--------------------------------------------------------

WITH Estadisticas AS
(
    SELECT
        AVG(Monto) AS Promedio,
        STDEV(Monto) AS Desviacion
    FROM Transacciones
)
INSERT INTO AlertasFraude
(
    TransaccionID,
    TipoAlerta,
    NivelRiesgo
)
SELECT
    t.TransaccionID,
    'Monto Fuera de Patron',
    'Alto'
FROM Transacciones t
CROSS JOIN Estadisticas e
WHERE t.Monto > e.Promedio + (3 * e.Desviacion);
-----------------------------------------------------------------
SELECT TOP 10 *
FROM Transacciones
ORDER BY Monto DESC;
---------------------------------------------------------------------
INSERT INTO AlertasFraude
(
    TransaccionID,
    TipoAlerta,
    NivelRiesgo
)
SELECT
    TransaccionID,
    'Monto Anormal',
    'Alto'
FROM Transacciones
WHERE Monto > 10000;

CREATE VIEW vw_AlertasFraude AS
SELECT
    af.AlertaID,
    af.TipoAlerta,
    af.NivelRiesgo,
    t.Monto,
    t.FechaHora,
    t.Ciudad
FROM AlertasFraude af
INNER JOIN Transacciones t
    ON af.TransaccionID = t.TransaccionID;

	SELECT TOP 10
    c.NombreComercio,
    COUNT(*) AS TotalAlertas
FROM AlertasFraude af
INNER JOIN Transacciones t
    ON af.TransaccionID = t.TransaccionID
INNER JOIN Comercios c
    ON t.ComercioID = c.ComercioID
GROUP BY c.NombreComercio
ORDER BY TotalAlertas DESC;

SELECT
    MIN(Monto) AS Minimo,
    AVG(Monto) AS Promedio,
    MAX(Monto) AS Maximo,
    STDEV(Monto) AS Desviacion
FROM Transacciones;


INSERT INTO AlertasFraude
(
    TransaccionID,
    TipoAlerta,
    NivelRiesgo
)
SELECT
    TransaccionID,
    'Monto Elevado',
    'Medio'
FROM Transacciones
WHERE Monto > 1000;

SELECT COUNT(*)
FROM Transacciones
WHERE Monto > 1000;

SELECT PERCENTILE_CONT(0.99)
WITHIN GROUP (ORDER BY Monto) OVER()
AS Percentil99
FROM Transacciones;

---Otra alerta interesante: transacciones rápidas
WITH Movimientos AS
(
    SELECT
        TransaccionID,
        TarjetaID,
        FechaHora,
        LAG(FechaHora) OVER
        (
            PARTITION BY TarjetaID
            ORDER BY FechaHora
        ) AS FechaAnterior
    FROM Transacciones
)

SELECT *
FROM Movimientos
WHERE DATEDIFF(MINUTE, FechaAnterior, FechaHora) <= 2;

SELECT
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Transacciones';

CREATE TABLE Transacciones (
    TransaccionID VARCHAR(20) PRIMARY KEY,
    TarjetaID nvarchar(50) NOT NULL,
    ComercioID nvarchar(50) NOT NULL,
    FechaHora DATETIME2 NOT NULL,
    Monto DECIMAL(12,2) NOT NULL,
    Ciudad VARCHAR(50),
    Canal VARCHAR(20),

    FOREIGN KEY (TarjetaID)
        REFERENCES Tarjetas(TarjetaID),

    FOREIGN KEY (ComercioID)
        REFERENCES Comercios(ComercioID)
);

CREATE TABLE AlertasFraude (
    AlertaID INT IDENTITY(1,1) PRIMARY KEY,
    TransaccionID VARCHAR(20) NOT NULL,
    TipoAlerta VARCHAR(100),
    NivelRiesgo VARCHAR(20),
    FechaAlerta DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (TransaccionID)
        REFERENCES Transacciones(TransaccionID)
);


-- Ingreso de 50000 registros
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [TransaccionID]
      ,[TarjetaID]
      ,[ComercioID]
      ,[FechaHora]
      ,[Monto]
      ,[Ciudad]
      ,[Canal]
  FROM [BankFraudBD].[dbo].[Transacciones]

BULK INSERT dbo.Transacciones
FROM 'C:\Users\Lenovo\Desktop\Investigaciones Propias  - Ingeniero de Datos\SQL\1. Prevecion de Fraude\Registros\transacciones.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

SELECT COUNT(*) AS TotalTransacciones
FROM Transacciones;

------------------------------------------------------

--1. Alertas por montos elevados
INSERT INTO AlertasFraude
(
    TransaccionID,
    TipoAlerta,
    NivelRiesgo
)
SELECT
    TransaccionID,
    'Monto Elevado',
    'Alto'
FROM Transacciones
WHERE Monto >= 3000;

SELECT COUNT(*) AS TotalAlertas
FROM AlertasFraude;


--2. Alertas por transacciones rápidas

WITH Movimientos AS
(
    SELECT
        TransaccionID,
        TarjetaID,
        FechaHora,
        LAG(FechaHora) OVER(
            PARTITION BY TarjetaID
            ORDER BY FechaHora
        ) AS FechaAnterior
    FROM Transacciones
)
INSERT INTO AlertasFraude
(
    TransaccionID,
    TipoAlerta,
    NivelRiesgo
)
SELECT
    TransaccionID,
    'Compras Rapidas',
    'Medio'
FROM Movimientos
WHERE DATEDIFF(SECOND, FechaAnterior, FechaHora) <= 120;

--Revisar las alertas creadas

SELECT TOP 20 *
FROM AlertasFraude;

---Vista para Power BI

CREATE VIEW vw_AlertasFraude AS
SELECT
    af.AlertaID,
    af.TipoAlerta,
    af.NivelRiesgo,
    t.TransaccionID,
    t.Monto,
    t.FechaHora,
    t.Ciudad,
    t.Canal,
    t.ComercioID
FROM AlertasFraude af
INNER JOIN Transacciones t
    ON af.TransaccionID = t.TransaccionID;


--Top 10 comercios con más alertas
SELECT TOP 10
    ComercioID,
    COUNT(*) AS TotalAlertas
FROM vw_AlertasFraude
GROUP BY ComercioID
ORDER BY TotalAlertas DESC;

--Alertas por ciudad

SELECT
    Ciudad,
    COUNT(*) AS TotalAlertas
FROM vw_AlertasFraude
GROUP BY Ciudad
ORDER BY TotalAlertas DESC;

-- Alerta por canal

SELECT
    Canal,
    COUNT(*) AS TotalAlertas
FROM vw_AlertasFraude
GROUP BY Canal
ORDER BY TotalAlertas DESC;
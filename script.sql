USE [master]
GO
/****** Object:  Database [BankFraudBD]    Script Date: 12/06/2026 01:09:33 ******/
CREATE DATABASE [BankFraudBD]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BankFraudBD', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\BankFraudBD.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BankFraudBD_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\BankFraudBD_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [BankFraudBD] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BankFraudBD].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BankFraudBD] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BankFraudBD] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BankFraudBD] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BankFraudBD] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BankFraudBD] SET ARITHABORT OFF 
GO
ALTER DATABASE [BankFraudBD] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BankFraudBD] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BankFraudBD] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BankFraudBD] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BankFraudBD] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BankFraudBD] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BankFraudBD] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BankFraudBD] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BankFraudBD] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BankFraudBD] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BankFraudBD] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BankFraudBD] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BankFraudBD] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BankFraudBD] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BankFraudBD] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BankFraudBD] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BankFraudBD] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BankFraudBD] SET RECOVERY FULL 
GO
ALTER DATABASE [BankFraudBD] SET  MULTI_USER 
GO
ALTER DATABASE [BankFraudBD] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BankFraudBD] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BankFraudBD] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BankFraudBD] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BankFraudBD] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BankFraudBD] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'BankFraudBD', N'ON'
GO
ALTER DATABASE [BankFraudBD] SET QUERY_STORE = OFF
GO
USE [BankFraudBD]
GO
/****** Object:  Table [dbo].[Transacciones]    Script Date: 12/06/2026 01:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transacciones](
	[TransaccionID] [varchar](20) NOT NULL,
	[TarjetaID] [nvarchar](50) NOT NULL,
	[ComercioID] [nvarchar](50) NOT NULL,
	[FechaHora] [datetime2](7) NOT NULL,
	[Monto] [decimal](12, 2) NOT NULL,
	[Ciudad] [varchar](50) NULL,
	[Canal] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[TransaccionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AlertasFraude]    Script Date: 12/06/2026 01:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlertasFraude](
	[AlertaID] [int] IDENTITY(1,1) NOT NULL,
	[TransaccionID] [varchar](20) NOT NULL,
	[TipoAlerta] [varchar](100) NULL,
	[NivelRiesgo] [varchar](20) NULL,
	[FechaAlerta] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[AlertaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_AlertasFraude]    Script Date: 12/06/2026 01:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_AlertasFraude] AS
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
GO
/****** Object:  Table [dbo].[clientes]    Script Date: 12/06/2026 01:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[clientes](
	[ClienteID] [nvarchar](50) NOT NULL,
	[NombreCompleto] [nvarchar](50) NOT NULL,
	[DNI] [int] NOT NULL,
	[FechaNacimiento] [datetime2](7) NOT NULL,
	[Genero] [nvarchar](50) NOT NULL,
	[Ciudad] [nvarchar](50) NOT NULL,
	[FechaRegistro] [datetime2](7) NOT NULL,
	[IngresosMensuales] [float] NOT NULL,
 CONSTRAINT [PK_clientes] PRIMARY KEY CLUSTERED 
(
	[ClienteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[comercios]    Script Date: 12/06/2026 01:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[comercios](
	[ComercioID] [nvarchar](50) NOT NULL,
	[NombreComercio] [nvarchar](50) NOT NULL,
	[Categoria] [nvarchar](50) NOT NULL,
	[Ciudad] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_comercios] PRIMARY KEY CLUSTERED 
(
	[ComercioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cuentas]    Script Date: 12/06/2026 01:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cuentas](
	[CuentaID] [nvarchar](50) NOT NULL,
	[ClienteID] [nvarchar](50) NOT NULL,
	[TipoCuenta] [nvarchar](50) NOT NULL,
	[FechaApertura] [datetime2](7) NOT NULL,
	[Saldo] [float] NOT NULL,
 CONSTRAINT [PK_cuentas] PRIMARY KEY CLUSTERED 
(
	[CuentaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tarjetas]    Script Date: 12/06/2026 01:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tarjetas](
	[TarjetaID] [nvarchar](50) NOT NULL,
	[CuentaID] [nvarchar](50) NOT NULL,
	[TipoTarjeta] [nvarchar](50) NOT NULL,
	[Marca] [nvarchar](50) NOT NULL,
	[FechaEmision] [datetime2](7) NOT NULL,
	[FechaVencimiento] [datetime2](7) NOT NULL,
	[Estado] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tarjetas] PRIMARY KEY CLUSTERED 
(
	[TarjetaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AlertasFraude] ADD  DEFAULT (getdate()) FOR [FechaAlerta]
GO
ALTER TABLE [dbo].[AlertasFraude]  WITH CHECK ADD FOREIGN KEY([TransaccionID])
REFERENCES [dbo].[Transacciones] ([TransaccionID])
GO
ALTER TABLE [dbo].[Transacciones]  WITH NOCHECK ADD FOREIGN KEY([ComercioID])
REFERENCES [dbo].[comercios] ([ComercioID])
GO
ALTER TABLE [dbo].[Transacciones]  WITH NOCHECK ADD FOREIGN KEY([TarjetaID])
REFERENCES [dbo].[tarjetas] ([TarjetaID])
GO
USE [master]
GO
ALTER DATABASE [BankFraudBD] SET  READ_WRITE 
GO

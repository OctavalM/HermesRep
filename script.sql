USE [master]
GO
/****** Object:  Database [VideoRental]    Script Date: 13.10.2021 12:41:30 ******/
CREATE DATABASE [VideoRental]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'VideoRental', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\VideoRental.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'VideoRental_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\VideoRental_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [VideoRental] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [VideoRental].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [VideoRental] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [VideoRental] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [VideoRental] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [VideoRental] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [VideoRental] SET ARITHABORT OFF 
GO
ALTER DATABASE [VideoRental] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [VideoRental] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [VideoRental] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [VideoRental] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [VideoRental] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [VideoRental] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [VideoRental] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [VideoRental] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [VideoRental] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [VideoRental] SET  ENABLE_BROKER 
GO
ALTER DATABASE [VideoRental] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [VideoRental] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [VideoRental] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [VideoRental] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [VideoRental] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [VideoRental] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [VideoRental] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [VideoRental] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [VideoRental] SET  MULTI_USER 
GO
ALTER DATABASE [VideoRental] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [VideoRental] SET DB_CHAINING OFF 
GO
ALTER DATABASE [VideoRental] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [VideoRental] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [VideoRental] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [VideoRental] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [VideoRental] SET QUERY_STORE = OFF
GO
USE [VideoRental]
GO
/****** Object:  Table [dbo].[Client]    Script Date: 13.10.2021 12:41:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[ClientId] [int] IDENTITY(1,1) NOT NULL,
	[GenderId] [int] NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Surname] [nvarchar](50) NOT NULL,
	[Patronymic] [nvarchar](50) NULL,
	[BirthDate] [date] NOT NULL,
	[PhoneNumber] [nvarchar](30) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[AddedDate] [date] NOT NULL,
	[Photo] [varbinary](max) NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientTag]    Script Date: 13.10.2021 12:41:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientTag](
	[ClientTagId] [int] IDENTITY(1,1) NOT NULL,
	[TagId] [int] NOT NULL,
	[ClientId] [int] NOT NULL,
 CONSTRAINT [PK_ClientTag] PRIMARY KEY CLUSTERED 
(
	[ClientTagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Gender]    Script Date: 13.10.2021 12:41:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gender](
	[GenderId] [int] NOT NULL,
	[GenderName] [nvarchar](7) NOT NULL,
 CONSTRAINT [PK_Gender] PRIMARY KEY CLUSTERED 
(
	[GenderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tag]    Script Date: 13.10.2021 12:41:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tag](
	[TagId] [int] NOT NULL,
	[TagName] [nvarchar](50) NOT NULL,
	[Color] [nvarchar](7) NOT NULL,
 CONSTRAINT [PK_Tag] PRIMARY KEY CLUSTERED 
(
	[TagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 13.10.2021 12:41:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserId] [int] NOT NULL,
	[Login] [nvarchar](100) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Visit]    Script Date: 13.10.2021 12:41:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Visit](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[DateVisit] [datetime] NOT NULL,
 CONSTRAINT [PK_Visit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Client] ON 

INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (1, 1, N'Дмитрий', N'221.55', N'Николаевич', CAST(N'1985-06-10' AS Date), N'+7(999)189-90-83', N'Dmitriy.Ivanov@yandex.ru', CAST(N'2020-03-03' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (2, 1, N'Иван', N'Кимов', N'Лионтьевич', CAST(N'1990-11-08' AS Date), N'8(802)746-82-92', N'ivan_kimov@mail.ru', CAST(N'2019-12-15' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (3, 2, N'Мария', N'Бурятова', N'Георгиевна', CAST(N'2000-01-15' AS Date), N'8(426)936-95-38', N'Mariya93@gmail.com', CAST(N'2020-07-20' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (4, 2, N'Камила', N'Сафиуллина', N'Булатовна', CAST(N'1998-02-04' AS Date), N'+7(116)068-90-35', N'SaffKam@yandex.ru', CAST(N'2020-05-17' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (30, 1, N'Дмитрий', N'Иванов', N'Васильевич', CAST(N'1985-06-10' AS Date), N'+7(933)274-99-01', N'Dmitriy.Ivanov@yandex.ru', CAST(N'2020-03-03' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (31, 1, N'Иван', N'Кимов', N'Лионтьевич', CAST(N'1990-11-08' AS Date), N'8(802)746-82-92', N'ivan_kimov@mail.ru', CAST(N'2019-12-15' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (32, 2, N'Мария', N'Бурятова', N'Георгиевна', CAST(N'2000-01-15' AS Date), N'8(426)936-95-38', N'Mariya93@gmail.com', CAST(N'2020-07-20' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (33, 2, N'Камила', N'Сафиуллина', N'Булатовна', CAST(N'1998-02-04' AS Date), N'+7(116)068-90-35', N'SaffKam@yandex.ru', CAST(N'2020-05-17' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (34, 1, N'Дмитрий', N'Иванов', N'Васильевич', CAST(N'1985-06-10' AS Date), N'+7(933)274-99-01', N'Dmitriy.Ivanov@yandex.ru', CAST(N'2020-03-03' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (35, 1, N'Иван', N'Кимов', N'Лионтьевич', CAST(N'1990-11-08' AS Date), N'8(802)746-82-92', N'ivan_kimov@mail.ru', CAST(N'2019-12-15' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (39, 1, N'Иван', N'Кимов', N'Лионтьевич', CAST(N'1990-11-08' AS Date), N'8(802)746-82-92', N'ivan_kimov@mail.ru', CAST(N'2019-12-15' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (40, 2, N'Мария', N'Бурятова', N'Георгиевна', CAST(N'2000-01-15' AS Date), N'8(426)936-95-38', N'Mariya93@gmail.com', CAST(N'2020-07-20' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (42, 1, N'Дмитрий', N'Иванов', N'Васильевич', CAST(N'1985-06-10' AS Date), N'+7(933)274-99-01', N'Dmitriy.Ivanov@yandex.ru', CAST(N'2020-03-03' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (43, 1, N'Иван', N'Кимов', N'Лионтьевич', CAST(N'1990-11-08' AS Date), N'8(802)746-82-92', N'ivan_kimov@mail.ru', CAST(N'2019-12-15' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (44, 2, N'Мария', N'Бурятова', N'Георгиевна', CAST(N'2000-01-15' AS Date), N'8(426)936-95-38', N'Mariya93@gmail.com', CAST(N'2020-07-20' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (46, 1, N'Дмитрий', N'Иванов', N'Васильевич', CAST(N'1985-06-10' AS Date), N'+7(933)274-99-01', N'Dmitriy.Ivanov@yandex.ru', CAST(N'2020-03-03' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (47, 1, N'Иван', N'Кимов', N'Лионтьевич', CAST(N'1990-11-08' AS Date), N'8(802)746-82-92', N'ivan_kimov@mail.ru', CAST(N'2019-12-15' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (51, 1, N'Иван', N'Кимов', N'Лионтьевич', CAST(N'1990-11-08' AS Date), N'8(802)746-82-92', N'ivan_kimov@mail.ru', CAST(N'2019-12-15' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (53, 2, N'Камила', N'Сафиуллина', N'Булатовна', CAST(N'1998-02-04' AS Date), N'+7(116)068-90-35', N'SaffKam@yandex.ru', CAST(N'2020-05-17' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (54, 1, N'Дмитрий', N'Иванов', N'Васильевич', CAST(N'1985-06-10' AS Date), N'+7(933)274-99-01', N'Dmitriy.Ivanov@yandex.ru', CAST(N'2020-03-03' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (55, 1, N'Иван', N'Кимов', N'Лионтьевич', CAST(N'1990-11-08' AS Date), N'8(802)746-82-92', N'ivan_kimov@mail.ru', CAST(N'2019-12-15' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (56, 2, N'Мария', N'Бурятова', N'Георгиевна', CAST(N'2000-01-15' AS Date), N'8(426)936-95-38', N'Mariya93@gmail.com', CAST(N'2020-07-20' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (57, 2, N'Камила', N'Сафиуллина', N'Булатовна', CAST(N'1998-02-04' AS Date), N'+7(116)068-90-35', N'SaffKam@yandex.ru', CAST(N'2020-05-17' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (58, 1, N'Дмитрий', N'Иванов', N'Васильевич', CAST(N'1985-06-10' AS Date), N'+7(933)274-99-01', N'Dmitriy.Ivanov@yandex.ru', CAST(N'2020-03-03' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (59, 1, N'Иван', N'Кимов', N'Лионтьевич', CAST(N'1990-11-08' AS Date), N'8(802)746-82-92', N'ivan_kimov@mail.ru', CAST(N'2019-12-15' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (60, 2, N'Мария', N'Бурятова', N'Георгиевна', CAST(N'2000-01-15' AS Date), N'8(426)936-95-38', N'Mariya93@gmail.com', CAST(N'2020-07-20' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (61, 2, N'Камила', N'Сафиуллина', N'Булатовна', CAST(N'1998-02-04' AS Date), N'+7(116)068-90-35', N'SaffKam@yandex.ru', CAST(N'2020-05-17' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (63, 1, N'Иван', N'Кимов', N'Лионтьевич', CAST(N'1990-11-08' AS Date), N'8(802)746-82-92', N'ivan_kimov@mail.ru', CAST(N'2019-12-15' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (64, 2, N'Мария', N'Бурятова', N'Георгиевна', CAST(N'2000-01-15' AS Date), N'8(426)936-95-38', N'Mariya93@gmail.com', CAST(N'2020-07-20' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (66, 1, N'Дмитрий', N'Иванов', N'Васильевич', CAST(N'1985-06-10' AS Date), N'+7(933)274-99-01', N'Dmitriy.Ivanov@yandex.ru', CAST(N'2020-03-03' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (68, 2, N'Мария', N'Бурятова', N'Георгиевна', CAST(N'2000-01-15' AS Date), N'8(426)936-95-38', N'Mariya93@gmail.com', CAST(N'2020-07-20' AS Date), NULL)
INSERT [dbo].[Client] ([ClientId], [GenderId], [Name], [Surname], [Patronymic], [BirthDate], [PhoneNumber], [Email], [AddedDate], [Photo]) VALUES (69, 2, N'Камила', N'Сафиуллина', N'Булатовна', CAST(N'1998-02-04' AS Date), N'+7(116)068-90-35', N'SaffKam@yandex.ru', CAST(N'2020-05-17' AS Date), NULL)
SET IDENTITY_INSERT [dbo].[Client] OFF
GO
SET IDENTITY_INSERT [dbo].[ClientTag] ON 

INSERT [dbo].[ClientTag] ([ClientTagId], [TagId], [ClientId]) VALUES (6, 3, 4)
INSERT [dbo].[ClientTag] ([ClientTagId], [TagId], [ClientId]) VALUES (16, 2, 4)
INSERT [dbo].[ClientTag] ([ClientTagId], [TagId], [ClientId]) VALUES (17, 4, 4)
INSERT [dbo].[ClientTag] ([ClientTagId], [TagId], [ClientId]) VALUES (29, 2, 2)
INSERT [dbo].[ClientTag] ([ClientTagId], [TagId], [ClientId]) VALUES (30, 3, 2)
INSERT [dbo].[ClientTag] ([ClientTagId], [TagId], [ClientId]) VALUES (31, 4, 2)
INSERT [dbo].[ClientTag] ([ClientTagId], [TagId], [ClientId]) VALUES (33, 5, 2)
INSERT [dbo].[ClientTag] ([ClientTagId], [TagId], [ClientId]) VALUES (45, 1, 3)
INSERT [dbo].[ClientTag] ([ClientTagId], [TagId], [ClientId]) VALUES (46, 5, 3)
INSERT [dbo].[ClientTag] ([ClientTagId], [TagId], [ClientId]) VALUES (60, 1, 1)
INSERT [dbo].[ClientTag] ([ClientTagId], [TagId], [ClientId]) VALUES (66, 1, 30)
INSERT [dbo].[ClientTag] ([ClientTagId], [TagId], [ClientId]) VALUES (67, 2, 30)
INSERT [dbo].[ClientTag] ([ClientTagId], [TagId], [ClientId]) VALUES (75, 2, 1)
SET IDENTITY_INSERT [dbo].[ClientTag] OFF
GO
INSERT [dbo].[Gender] ([GenderId], [GenderName]) VALUES (1, N'Мужской')
INSERT [dbo].[Gender] ([GenderId], [GenderName]) VALUES (2, N'Женский')
GO
INSERT [dbo].[Tag] ([TagId], [TagName], [Color]) VALUES (1, N'Комедия', N'#AA8F66')
INSERT [dbo].[Tag] ([TagId], [TagName], [Color]) VALUES (2, N'Драма', N'#ED9B40')
INSERT [dbo].[Tag] ([TagId], [TagName], [Color]) VALUES (3, N'Приключение', N'#FFEEDB')
INSERT [dbo].[Tag] ([TagId], [TagName], [Color]) VALUES (4, N'Боевик', N'#61C9A8')
INSERT [dbo].[Tag] ([TagId], [TagName], [Color]) VALUES (5, N'Байопик', N'#BA3B46')
GO
INSERT [dbo].[User] ([UserId], [Login], [Password]) VALUES (1, N'Administrator', N'Administrator514')
INSERT [dbo].[User] ([UserId], [Login], [Password]) VALUES (2, N'User', N'User6724')
INSERT [dbo].[User] ([UserId], [Login], [Password]) VALUES (3, N'1', N'1')
GO
SET IDENTITY_INSERT [dbo].[Visit] ON 

INSERT [dbo].[Visit] ([Id], [ClientId], [DateVisit]) VALUES (1, 1, CAST(N'2020-09-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Visit] ([Id], [ClientId], [DateVisit]) VALUES (2, 2, CAST(N'2020-09-03T00:00:00.000' AS DateTime))
INSERT [dbo].[Visit] ([Id], [ClientId], [DateVisit]) VALUES (3, 3, CAST(N'2020-09-04T00:00:00.000' AS DateTime))
INSERT [dbo].[Visit] ([Id], [ClientId], [DateVisit]) VALUES (4, 4, CAST(N'2020-09-05T00:00:00.000' AS DateTime))
INSERT [dbo].[Visit] ([Id], [ClientId], [DateVisit]) VALUES (5, 1, CAST(N'2020-09-06T00:00:00.000' AS DateTime))
INSERT [dbo].[Visit] ([Id], [ClientId], [DateVisit]) VALUES (6, 2, CAST(N'2020-09-07T00:00:00.000' AS DateTime))
INSERT [dbo].[Visit] ([Id], [ClientId], [DateVisit]) VALUES (7, 3, CAST(N'2020-09-08T00:00:00.000' AS DateTime))
INSERT [dbo].[Visit] ([Id], [ClientId], [DateVisit]) VALUES (8, 4, CAST(N'2020-09-09T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Visit] OFF
GO
ALTER TABLE [dbo].[Client]  WITH CHECK ADD  CONSTRAINT [FK_Client_Gender] FOREIGN KEY([GenderId])
REFERENCES [dbo].[Gender] ([GenderId])
GO
ALTER TABLE [dbo].[Client] CHECK CONSTRAINT [FK_Client_Gender]
GO
ALTER TABLE [dbo].[ClientTag]  WITH CHECK ADD  CONSTRAINT [FK_ClientTag_Client] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Client] ([ClientId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ClientTag] CHECK CONSTRAINT [FK_ClientTag_Client]
GO
ALTER TABLE [dbo].[ClientTag]  WITH CHECK ADD  CONSTRAINT [FK_ClientTag_Tag] FOREIGN KEY([TagId])
REFERENCES [dbo].[Tag] ([TagId])
GO
ALTER TABLE [dbo].[ClientTag] CHECK CONSTRAINT [FK_ClientTag_Tag]
GO
ALTER TABLE [dbo].[Visit]  WITH CHECK ADD  CONSTRAINT [FK_Visit_Client] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Client] ([ClientId])
GO
ALTER TABLE [dbo].[Visit] CHECK CONSTRAINT [FK_Visit_Client]
GO
USE [master]
GO
ALTER DATABASE [VideoRental] SET  READ_WRITE 
GO

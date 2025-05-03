-- FitnessDB veritabanını oluşturma
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'FitnessDB')
BEGIN
    CREATE DATABASE FitnessDB;
END
GO

USE FitnessDB;
GO

-- Users tablosu oluşturma
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Users')
BEGIN
    CREATE TABLE Users (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Username NVARCHAR(100) NOT NULL,
        Password NVARCHAR(100) NOT NULL,
        Height INT NULL,
        Weight INT NULL
    );
END
GO

-- Programs tablosu oluşturma
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Programs')
BEGIN
    CREATE TABLE Programs (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        UserId INT NOT NULL,
        MuscleGroup NVARCHAR(100) NULL,
        WorkoutName NVARCHAR(100) NULL,
        DateCreated DATETIME DEFAULT GETDATE(),
        FOREIGN KEY (UserId) REFERENCES Users(Id)
    );
END
GO

-- Örnek veriler (isteğe bağlı)
-- Eğer Users tablosu boşsa örnek kullanıcı ekle
IF NOT EXISTS (SELECT TOP 1 * FROM Users)
BEGIN
    INSERT INTO Users (Username, Password, Height, Weight)
    VALUES ('demo', 'demo123', 175, 70);
END
GO

-- Veritabanı oluşturuldu
PRINT 'FitnessDB veritabanı ve tabloları başarıyla oluşturuldu.';
GO 
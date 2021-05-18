IF  NOT EXISTS (SELECT * FROM sys.databases WHERE name = N'conference_app')
BEGIN
        PRINT 'Creating database conference_app...'
        CREATE DATABASE [conference_app]
END;
GO
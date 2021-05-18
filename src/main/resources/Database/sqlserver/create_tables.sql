USE conference_app;
GO

if not exists (select * from sysobjects where name='attendees' and xtype='U')
BEGIN
            PRINT 'Creating attendees table'
CREATE TABLE attendees
(
    attendee_id  INT IDENTITY(1,1) PRIMARY KEY,
    first_name   varchar(30) NOT NULL,
    last_name    varchar(30) NOT NULL,
    title        varchar(40) NULL,
    company      varchar(50) NULL,
    email        varchar(80) NOT NULL,
    phone_number varchar(20) NULL
);
end
GO

if not exists (select * from sysobjects where name='ticket_types' and xtype='U')
BEGIN
            PRINT 'Creating ticket_types table'
CREATE TABLE ticket_types
(
    ticket_type_code  varchar(1) PRIMARY KEY,
    ticket_type_name  varchar(30)  NOT NULL,
    description       varchar(100) NOT NULL,
    includes_workshop bit      NOT NULL
);
end
GO

if not exists (select * from sysobjects where name='pricing_categories' and xtype='U')
BEGIN
            PRINT 'Creating pricing_categories table'
CREATE TABLE pricing_categories
(
    pricing_category_code varchar(1) PRIMARY KEY,
    pricing_category_name varchar(20) NOT NULL,
    pricing_start_date    date        NOT NULL,
    pricing_end_date      date        NOT NULL
);
end
GO

if not exists (select * from sysobjects where name='ticket_prices' and xtype='U')
BEGIN
            PRINT 'Creating ticket_prices table'
CREATE TABLE ticket_prices
(
    ticket_price_id       INT IDENTITY(1,1) PRIMARY KEY,
    ticket_type_code      varchar(1)    NOT NULL REFERENCES ticket_types (ticket_type_code),
    pricing_category_code varchar(1)    NOT NULL REFERENCES pricing_categories (pricing_category_code),
    base_price            numeric(8, 2) NOT NULL
);
end
GO

if not exists (select * from sysobjects where name='discount_codes' and xtype='U')
BEGIN
            PRINT 'Creating discount_codes table'
CREATE TABLE discount_codes
(
    discount_code_id INT IDENTITY(1,1) PRIMARY KEY,
    discount_code    varchar(20)   NOT NULL,
    discount_name    varchar(30)   NOT NULL,
    discount_type    varchar(1)    NOT NULL,
    discount_amount  numeric(8, 2) NOT NULL
);
end
GO

if not exists (select * from sysobjects where name='attendee_tickets' and xtype='U')
BEGIN
            PRINT 'Creating attendee_tickets table'
CREATE TABLE attendee_tickets
(
    attendee_ticket_id INT IDENTITY(1,1) PRIMARY KEY,
    attendee_id        integer       NOT NULL REFERENCES attendees (attendee_id),
    ticket_price_id    integer       NOT NULL REFERENCES ticket_prices (ticket_price_id),
    discount_code_id   integer       NULL REFERENCES discount_codes (discount_code_id),
    net_price          numeric(8, 2) NOT NULL
);
end
GO

if not exists (select * from sysobjects where name='time_slots' and xtype='U')
BEGIN
            PRINT 'Creating time_slots table'
CREATE TABLE time_slots
(
    time_slot_id         INT IDENTITY(1,1) PRIMARY KEY,
    time_slot_date       date                   NOT NULL,
    start_time           time  NOT NULL,
    end_time             time  NOT NULL,
    is_keynote_time_slot bit   NOT NULL
);
end
GO


if not exists (select * from sysobjects where name='sessions' and xtype='U')
BEGIN
            PRINT 'Creating sessions table'
CREATE TABLE sessions
(
    session_id          INT IDENTITY(1,1) PRIMARY KEY,
    session_name        varchar(80)   NOT NULL,
    session_description varchar(1024) NOT NULL,
    session_length      integer       NOT NULL
);
end
GO


if not exists (select * from sysobjects where name='session_schedule' and xtype='U')
BEGIN
            PRINT 'Creating session_schedule table'
CREATE TABLE session_schedule
(
    schedule_id  INT IDENTITY(1,1) PRIMARY KEY,
    time_slot_id integer     NOT NULL REFERENCES time_slots (time_slot_id),
    session_id   integer     NOT NULL REFERENCES sessions (session_id),
    room         varchar(30) NOT NULL
);
end
GO


if not exists (select * from sysobjects where name='tags' and xtype='U')
BEGIN
            PRINT 'Creating tags table'
CREATE TABLE tags
(
    tag_id      INT IDENTITY(1,1) PRIMARY KEY,
    description varchar(30) NOT NULL
);
end
GO


if not exists (select * from sysobjects where name='session_tags' and xtype='U')
BEGIN
            PRINT 'Creating session_tags table'
CREATE TABLE session_tags
(
    session_id integer NOT NULL REFERENCES sessions (session_id),
    tag_id     integer NOT NULL REFERENCES tags (tag_id)
);
end
GO


if not exists (select * from sysobjects where name='speakers' and xtype='U')
BEGIN
            PRINT 'Creating speakers table'
CREATE TABLE speakers
(
    speaker_id    INT IDENTITY(1,1) PRIMARY KEY,
    first_name    varchar(30)   NOT NULL,
    last_name     varchar(30)   NOT NULL,
    title         varchar(40)   NOT NULL,
    company       varchar(50)   NOT NULL,
    speaker_bio   varchar(2000) NOT NULL,
    speaker_photo varbinary(MAX)   NULL
);
end
GO

if not exists (select * from sysobjects where name='session_speakers' and xtype='U')
BEGIN
            PRINT 'Creating session_speakers table'
CREATE TABLE session_speakers
(
    session_id integer NOT NULL REFERENCES sessions (session_id),
    speaker_id integer NOT NULL REFERENCES speakers (speaker_id)
);
end
GO


if not exists (select * from sysobjects where name='workshops' and xtype='U')
BEGIN
            PRINT 'Creating workshops table'
CREATE TABLE workshops
(
    workshop_id   INT IDENTITY(1,1) PRIMARY KEY,
    workshop_name varchar(60)   NOT NULL,
    description   varchar(1024) NOT NULL,
    requirements  varchar(1024) NOT NULL,
    room          varchar(30)   NOT NULL,
    capacity      integer       NOT NULL
);
end
GO


if not exists (select * from sysobjects where name='workshop_speakers' and xtype='U')
BEGIN
            PRINT 'Creating workshop_speakers table'
CREATE TABLE workshop_speakers
(
    workshop_id integer NOT NULL REFERENCES workshops (workshop_id),
    speaker_id  integer NOT NULL REFERENCES speakers (speaker_id)
);
end
GO


if not exists (select * from sysobjects where name='workshop_registrations' and xtype='U')
BEGIN
            PRINT 'Creating workshop_registrations table'
CREATE TABLE workshop_registrations
(
    workshop_id        integer NOT NULL REFERENCES workshops (workshop_id),
    attendee_ticket_id integer NOT NULL REFERENCES attendee_tickets (attendee_ticket_id)
);
end
GO
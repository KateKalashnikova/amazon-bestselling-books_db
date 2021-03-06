CREATE TABLE Authors (
    AuthorID    INTEGER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    AuthorName  VARCHAR2(250 CHAR),
    Created     TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    CreatedBy   VARCHAR2(250 CHAR) NOT NULL,
    Updated     TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    UpdatedBy   VARCHAR2(250 CHAR) NOT NULL,
    ActiveYN    VARCHAR2(1 CHAR) NOT NULL
);

ALTER TABLE Authors ADD CONSTRAINT AuthorID_PK PRIMARY KEY ( AuthorID );

CREATE TABLE Books (
    BookID            INTEGER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    BookName          VARCHAR2(250 CHAR),
    UserRating        NUMBER,
    Reviews           INTEGER,
    Price             NUMBER,
    Created           TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    CreatedBy         VARCHAR2(250 CHAR) NOT NULL,
    Updated           TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    UpdatedBy         VARCHAR2(250 CHAR) NOT NULL,
    ActiveYN          VARCHAR2(1 CHAR) NOT NULL,
    Genres_GenreID    INTEGER NOT NULL,
    Authors_AuthorID  INTEGER NOT NULL
);

ALTER TABLE Books ADD CONSTRAINT Books_PK PRIMARY KEY ( BookID );

CREATE TABLE BooksYear (
    BookYearID    INTEGER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    Books_BookID  INTEGER NOT NULL,
    Year_YearID   INTEGER NOT NULL,
    Created       TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    CreatedBy     VARCHAR2(250 CHAR) NOT NULL,
    Updated       TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    UpdatedBy     VARCHAR2(250 CHAR) NOT NULL,
    ActiveYN      VARCHAR2(1 CHAR) NOT NULL
);

ALTER TABLE BooksYear ADD CONSTRAINT BookYearID_PK PRIMARY KEY ( BookYearID );

CREATE TABLE Genres (
    GenreID    INTEGER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    GenreName  VARCHAR2(250 CHAR),
    Created    TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    CreatedBy  VARCHAR2(250 CHAR) NOT NULL,
    Updated    TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    UpdatedBy  VARCHAR2(250 CHAR) NOT NULL,
    ActiveYN   VARCHAR2(1 CHAR) NOT NULL
);

ALTER TABLE Genres ADD CONSTRAINT GenreID_PK PRIMARY KEY ( GenreID );

CREATE TABLE Year (
    YearID     INTEGER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    YearOf     INTEGER,
    Created    TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    CreatedBy  VARCHAR2(250 CHAR) NOT NULL,
    Updated    TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    UpdatedBy  VARCHAR2(250 CHAR) NOT NULL,
    ActiveYN   VARCHAR2(1 CHAR) NOT NULL
);

ALTER TABLE Year ADD CONSTRAINT YearID_PK PRIMARY KEY ( YearID );

CREATE TABLE History (
    ID             INTEGER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    TableName      VARCHAR2(128 CHAR),
    ColumnName     VARCHAR2(128 CHAR),
    Action         VARCHAR2(1 CHAR),
    ActionDate     DATE,
    Action_by      VARCHAR2(255 CHAR),
    Datatype       VARCHAR2(255 CHAR),
    PK1            NUMBER,
    TabrowVersion  INTEGER,
    Oldvc          VARCHAR2(4000 CHAR),
    Newvc          VARCHAR2(4000 CHAR),
    OldNumber      NUMBER,
    NewNumber      NUMBER,
    OldDate        DATE,
    NewDate        DATE,
    Oldts          TIMESTAMP,
    Newts          TIMESTAMP,
    Oldtswtz       TIMESTAMP WITH TIME ZONE,
    Newtswtz       TIMESTAMP WITH TIME ZONE,
    Oldtswltz      TIMESTAMP WITH LOCAL TIME ZONE,
    Newtswltz      TIMESTAMP WITH LOCAL TIME ZONE,
    OldClob        CLOB,
    NewClob        CLOB,
    OldBlob        BLOB,
    NewBlob        BLOB
);

ALTER TABLE History ADD CONSTRAINT History_PK PRIMARY KEY ( ID );

-- Add constraints
ALTER TABLE BooksYear ADD CONSTRAINT BooksYear__UN UNIQUE (Books_BookID,
                                                            Year_YearID);
ALTER TABLE Books
    ADD CONSTRAINT Books_Authors_FK FOREIGN KEY ( Authors_AuthorID )
        REFERENCES Authors ( AuthorID );

ALTER TABLE Books
    ADD CONSTRAINT Books_Genres_FK FOREIGN KEY ( Genres_GenreID )
        REFERENCES Genres ( GenreID );

ALTER TABLE BooksYear
    ADD CONSTRAINT BooksID_FK FOREIGN KEY ( Books_BookID )
        REFERENCES Books ( BookID );

ALTER TABLE BooksYear
    ADD CONSTRAINT YearID_FK FOREIGN KEY ( Year_YearID )
        REFERENCES Year ( YearID );

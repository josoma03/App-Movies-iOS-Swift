DROP TABLE MOVIE;
DROP TABLE BELONGS_TO_COLLECTION;
DROP TABLE GENRES;
DROP TABLE PRODUCTION_COMPANIES;
DROP TABLE PRODUCTION_COUNTRIES;
DROP TABLE SPOKEN_LANGUAGES;
DROP TABLE CATEGORY_MOVIE;


CREATE TABLE MOVIE(
  IDMOVIE                INTEGER  NOT NULL PRIMARY KEY
  ,IDCATEGORY                INTEGER  NOT NULL
  ,ADULT             VARCHAR(5) NOT NULL 
  ,BACKDROP_PATH     VARCHAR(32) 
  ,BUDGET            INTEGER 
  ,HOMEPAGE          VARCHAR(30)
  ,IMDB_ID           VARCHAR(9) 
  ,ORIGINAL_LANGUAGE VARCHAR(2) 
  ,ORIGINAL_TITLE    VARCHAR(43) 
  ,OVERVIEW          VARCHAR(581) 
  ,POPULARITY        NUMERIC(7,3) 
  ,POSTER_PATH       VARCHAR(32) 
  ,RELEASE_DATE      DATE  
  ,REVENUE           INTEGER  
  ,RUNTIME           INTEGER  
  ,STATUS            VARCHAR(8) 
  ,TAGLINE           VARCHAR(27) 
  ,TITLE             VARCHAR(43) 
  ,VIDEO             VARCHAR(5) 
  ,VOTE_AVERAGE      NUMERIC(3,1) 
  ,VOTE_COUNT        INTEGER 
);

CREATE TABLE CATEGORY_MOVIE (
	IDMOVIE INTEGER NOT NULL,
	IDCATEGORY INTEGER NOT NULL
 );


CREATE TABLE BELONGS_TO_COLLECTION(
   ID            INTEGER  NOT NULL PRIMARY KEY 
  ,IDMOVIE  INTEGER
  ,NAME          VARCHAR(500) 
  ,POSTER_PATH   VARCHAR(500) 
  ,BACKDROP_PATH VARCHAR(500) 
);

CREATE TABLE GENRES(
   ID            INTEGER  NOT NULL PRIMARY KEY 
  ,IDMOVIE  INTEGER
  ,NAME          VARCHAR(500) 
);


CREATE TABLE PRODUCTION_COMPANIES(
   ID            INTEGER  NOT NULL PRIMARY KEY 
  ,IDMOVIE  INTEGER
  ,LOGO_PATH          VARCHAR(500) 
  ,NAME          VARCHAR(500) 
  ,ORIGIN_COUNTRY          VARCHAR(50) 
);

CREATE TABLE PRODUCTION_COUNTRIES(
  IDMOVIE  INTEGER
  ,ISO_3166_1          VARCHAR(50) 
  ,NAME          VARCHAR(500) 
);

CREATE TABLE SPOKEN_LANGUAGES(
  IDMOVIE  INTEGER
  ,ISO_639_1          VARCHAR(50) 
  ,NAME          VARCHAR(500) 
);


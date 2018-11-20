DROP TABLE Movie;
DROP TABLE Belongs_to_collection;
DROP TABLE Genres;
DROP TABLE Production_companies;
DROP TABLE Production_countries;
DROP TABLE Spoken_languages;



CREATE TABLE Movie(
  IdMovie                INTEGER  NOT NULL PRIMARY KEY
  ,IdCategory                INTEGER  NOT NULL
  ,Adult             VARCHAR(5) NOT NULL 
  ,Backdrop_path     VARCHAR(32) 
  ,Budget            INTEGER 
  ,Homepage          VARCHAR(30)
  ,Imdb_id           VARCHAR(9) 
  ,Original_language VARCHAR(2) 
  ,Original_title    VARCHAR(43) 
  ,Overview          VARCHAR(581) 
  ,Popularity        NUMERIC(7,3) 
  ,Poster_path       VARCHAR(32) 
  ,Release_date      DATE  
  ,Revenue           INTEGER  
  ,Runtime           INTEGER  
  ,Status            VARCHAR(8) 
  ,Tagline           VARCHAR(27) 
  ,Title             VARCHAR(43) 
  ,Video             VARCHAR(5) 
  ,Vote_average      NUMERIC(3,1) 
  ,Vote_count        INTEGER 
);


CREATE TABLE Belongs_to_collection(
   Id            INTEGER  NOT NULL PRIMARY KEY 
  ,IdMovie  INTEGER
  ,Name          VARCHAR(500) 
  ,Poster_path   VARCHAR(500) 
  ,Backdrop_path VARCHAR(500) 
);

CREATE TABLE Genres(
   Id            INTEGER  NOT NULL PRIMARY KEY 
  ,IdMovie  INTEGER
  ,Name          VARCHAR(500) 
);


CREATE TABLE Production_companies(
   Id            INTEGER  NOT NULL PRIMARY KEY 
  ,IdMovie  INTEGER
  ,Logo_path          VARCHAR(500) 
  ,Name          VARCHAR(500) 
  ,Origin_country          VARCHAR(50) 
);

CREATE TABLE Production_countries(
  IdMovie  INTEGER
  ,Iso_3166_1          VARCHAR(50) 
  ,Name          VARCHAR(500) 
);

CREATE TABLE Spoken_languages(
  IdMovie  INTEGER
  ,Iso_639_1          VARCHAR(50) 
  ,Name          VARCHAR(500) 
);


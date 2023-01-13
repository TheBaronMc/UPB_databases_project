-- Drop tables
DROP TABLE "FOOD_COMPOSITIONS";
DROP TABLE "ANIMATION_REQUIREMENTS";
DROP TABLE "ANIMATION_FOOD_PROPOSITIONS";
DROP TABLE "ORGANIZATION_HELPER";
DROP TABLE "EVENT_HELPER";
DROP TABLE "EVENTS_CREATION";
DROP TABLE "PROGRAM";
DROP TABLE "ALLERGENS";
DROP TABLE "FOODS";
DROP TABLE "ANIMATIONS";
DROP TABLE "EVENTS";
DROP TABLE "SPONSORS";
DROP TABLE "CHEFS";
DROP TABLE "SCOUTS";
DROP TABLE "SCOUT_CHEFS";
DROP TABLE "TEAMS";
DROP TABLE "ORGANIZATIONS";
DROP TABLE "PERSONS";
DROP TABLE "CITIES";
DROP TABLE "COUNTRIES";
DROP TABLE "CONTINENTS";
DROP TABLE "LEVEL";
DROP TABLE "EQUIPEMENTS";

-- Create tables
CREATE TABLE "CONTINENTS" (
    "CONTINENT_ID" NUMBER(6,0),
    "NAME" VARCHAR2(50) CONSTRAINT "CONTINENT_NAME_NN" NOT NULL ENABLE,
    CONSTRAINT "CONT_ID_PK" PRIMARY KEY ("CONTINENT_ID") USING INDEX ENABLE
);

CREATE TABLE "COUNTRIES" (
    "COUNTRY_ID" NUMBER(6,0),
    "NAME" VARCHAR2(50) NOT NULL,
    "CONTINENT_ID" NUMBER(6,0) REFERENCES "CONTINENTS"("CONTINENT_ID"),
    CONSTRAINT "COUNT_ID_PK" PRIMARY KEY ("COUNTRY_ID") USING INDEX ENABLE
);

CREATE TABLE "CITIES" (
    "CITY_ID" NUMBER(6,0),
    "NAME" VARCHAR2(50) CONSTRAINT "COUNTRY_NAME_NN" NOT NULL ENABLE,
    "COUNTRY_ID" NUMBER(6,0) REFERENCES "COUNTRIES" ("COUNTRY_ID") ENABLE,
    CONSTRAINT "CITY_ID_PK" PRIMARY KEY ("CITY_ID") USING INDEX ENABLE
);

CREATE TABLE "ALLERGENS" (
    "ALLERGEN_ID" NUMBER(2,0),
    "NAME" VARCHAR2(20),
    CONSTRAINT "ALL_ID_PK" PRIMARY KEY ("ALLERGEN_ID") USING INDEX ENABLE
);

CREATE TABLE "FOODS" (
    "FOOD_ID" NUMBER(2,0),
    "NAME" VARCHAR2(20),
    CONSTRAINT "FOO_ID_PK" PRIMARY KEY ("FOOD_ID") USING INDEX ENABLE
);

CREATE TABLE "FOOD_COMPOSITIONS" (
    "ALLERGEN_ID" NUMBER(2,0) REFERENCES "ALLERGENS" ("ALLERGEN_ID") ENABLE,
    "FOOD_ID" NUMBER(2,0) REFERENCES "FOODS" ("FOOD_ID") ENABLE,
    CONSTRAINT "FOOD_DANGER_PK" PRIMARY KEY ("ALLERGEN_ID", "FOOD_ID") ENABLE
);

CREATE TABLE "EQUIPEMENTS" (
    "EQUIPEMENT_ID" NUMBER(3,0),
    "NAME" VARCHAR2(30),
    CONSTRAINT "EQUIPEMENT_ID_PK" PRIMARY KEY ("EQUIPEMENT_ID") USING INDEX ENABLE
);

CREATE TABLE "ANIMATIONS" (
    "ANIMATION_ID" NUMBER(3,0),
    "NAME" VARCHAR2(100),
    "DESCRIPTION" VARCHAR2(280),
    "DURATION" NUMBER(3,0),
    CONSTRAINT "ANIM_ID_PK" PRIMARY KEY ("ANIMATION_ID") USING INDEX ENABLE
);

CREATE TABLE "ANIMATION_REQUIREMENTS" (
    "ANIMATION_ID" NUMBER(3,0) REFERENCES "ANIMATIONS" ("ANIMATION_ID") ENABLE,
    "EQUIPEMENT_ID" NUMBER(3,0) REFERENCES "EQUIPEMENTS" ("EQUIPEMENT_ID") ENABLE,
    CONSTRAINT "ANIM_REQ_ID_PK" PRIMARY KEY ("ANIMATION_ID", "EQUIPEMENT_ID") ENABLE
);

CREATE TABLE "ANIMATION_FOOD_PROPOSITIONS" (
    "ANIMATION_ID" NUMBER(3,0) REFERENCES "ANIMATIONS" ("ANIMATION_ID") ENABLE,
    "FOOD_ID" NUMBER(2,0) REFERENCES "FOODS" ("FOOD_ID") ENABLE,
    CONSTRAINT "ANIM_FOO_ID_PK" PRIMARY KEY ("ANIMATION_ID", "FOOD_ID") ENABLE
);

CREATE TABLE "EVENTS" (
    "EVENT_ID" NUMBER(6,0),
    "NAME" VARCHAR2(50) NOT NULL,
    "MEETING_POINT" VARCHAR2(50),
    "STARTING_DATE" DATE,
    "ENDING_DATE" DATE,
    CONSTRAINT "EVENT_ID_PK" PRIMARY KEY ("EVENT_ID") USING INDEX ENABLE
);

CREATE TABLE "PROGRAM" (
    "EVENT_ID" NUMBER(6,0) REFERENCES "EVENTS" ("EVENT_ID") ENABLE,
    "ANIMATION_ID" NUMBER(3,0) REFERENCES "ANIMATIONS" ("ANIMATION_ID") ENABLE,
    CONSTRAINT "PROG_ID_PK" PRIMARY KEY ("ANIMATION_ID", "EVENT_ID") ENABLE
);

CREATE TABLE "SPONSORS" (
    "SPONSOR_ID" NUMBER(6,0),
    "NAME" VARCHAR2(20) NOT NULL,
    "PHONE_NUMBER" VARCHAR2(20),
    "EMAIL" VARCHAR2(50),
    "LINK" VARCHAR2(50),
    "PRIVATE" NUMBER(1), -- Boolean
    CONSTRAINT "SPON_ID_PK" PRIMARY KEY ("SPONSOR_ID") USING INDEX ENABLE
);

CREATE TABLE "EVENT_HELPER" (
    "EVENT_ID" NUMBER(6,0) REFERENCES "EVENTS" ("EVENT_ID") ENABLE,
    "SPONSOR_ID" NUMBER(6,0) REFERENCES "SPONSORS" ("SPONSOR_ID") ENABLE,
    CONSTRAINT "EVENT_HELP_ID_PK" PRIMARY KEY ("SPONSOR_ID", "EVENT_ID") ENABLE
);

CREATE TABLE "PERSONS" (
    "PERSON_ID" NUMBER(6,0),
    "FIRST_NAME" VARCHAR2(25),
    "LAST_NAME" VARCHAR2(25) NOT NULL,
    "GENDER" NUMBER(1), -- Boolean :-)
    "BIRTH_DATE" DATE,
    "DEATH_DATE" DATE,
    "PHONE_NUMBER" VARCHAR2(20),
    "EMAIL" VARCHAR2(50),
    "SCOUT_ID" NUMBER(6,0),
    CONSTRAINT "PERS_ID_PK" PRIMARY KEY ("PERSON_ID") USING INDEX ENABLE
);

CREATE TABLE "LEVEL" (
    "LEVEL_ID" NUMBER(3,0),
    "NAME" VARCHAR2(20),
    CONSTRAINT "LEV_ID_PK" PRIMARY KEY ("LEVEL_ID") USING INDEX ENABLE
);

CREATE TABLE "ORGANIZATIONS" (
    "ORGANIZATION_ID" NUMBER(6,0),
    "NAME" VARCHAR2(20) NOT NULL,
    "CREATION_DATE" DATE,
    "PHONE_NUMBER" VARCHAR2(20),
    "EMAIL" VARCHAR2(50),
    "CITY_ID" NUMBER(6,0) REFERENCES "CITIES" ("CITY_ID") ENABLE,
    "RELIGIOUS" NUMBER(1),
    CONSTRAINT "ORGA_ID_PK" PRIMARY KEY ("ORGANIZATION_ID") USING INDEX ENABLE
);

CREATE TABLE "EVENTS_CREATION" (
    "ORGANIZATION_ID" NUMBER(6,0) REFERENCES "ORGANIZATIONS" ("ORGANIZATION_ID") ENABLE,
    "EVENT_ID" NUMBER(6,0) REFERENCES "EVENTS" ("EVENT_ID") ENABLE,
    CONSTRAINT "EVENT_CREA_ID_PK" PRIMARY KEY ("ORGANIZATION_ID", "EVENT_ID")
);

CREATE TABLE "ORGANIZATION_HELPER" (
    "ORGANIZATION_ID" NUMBER(6,0) REFERENCES "ORGANIZATIONS" ("ORGANIZATION_ID") ENABLE,
    "SPONSOR_ID" NUMBER(6,0) REFERENCES "SPONSORS" ("SPONSOR_ID") ENABLE,
    CONSTRAINT "ORGANIZ_HELP_ID_PK" PRIMARY KEY ("ORGANIZATION_ID", "SPONSOR_ID") ENABLE
);

CREATE TABLE "CHEFS" (
    "CHEF_ID" NUMBER(6,0),
    "START_DATE" DATE,
    "ENDING_DATE" DATE,
    "ORGANIZATION_ID" NUMBER(6,0) REFERENCES "ORGANIZATIONS" ("ORGANIZATION_ID") ENABLE,
    "PERSON_ID" REFERENCES "PERSONS" ("PERSON_ID") ENABLE,
    CONSTRAINT "CHE_ID_PK" PRIMARY KEY ("CHEF_ID") USING INDEX ENABLE
);

CREATE TABLE "TEAMS" (
    "TEAM_ID" NUMBER(6,0),
    "NAME" VARCHAR2(20),
    "START_DATE" DATE,
    "ENDING_DATE" DATE,
    "MIX" NUMBER(1),
    "ORGANIZATION_ID" NUMBER(6,0) REFERENCES "ORGANIZATIONS" ("ORGANIZATION_ID") ENABLE,
    CONSTRAINT "TEAM_ID_PK" PRIMARY KEY ("TEAM_ID") USING INDEX ENABLE
);

CREATE TABLE "SCOUT_CHEFS" (
    "CHEF_ID" NUMBER(6,0),
    "ALIAS" VARCHAR2(20),
    "START_DATE" DATE,
    "ENDING_DATE" DATE,
    "ORGANIZATION_ID" NUMBER(6,0) REFERENCES "ORGANIZATIONS" ("ORGANIZATION_ID") ENABLE,
    "TEAM_ID" REFERENCES "TEAMS" ("TEAM_ID") ENABLE,
    "PERSON_ID" REFERENCES "PERSONS" ("PERSON_ID") ENABLE,
    CONSTRAINT "SCO_CHE_ID_PK" PRIMARY KEY ("CHEF_ID") USING INDEX ENABLE
);

CREATE TABLE "SCOUTS" (
    "SCOUT_ID" NUMBER(6,0),
    "START_DATE" DATE,
    "ENDING_DATE" DATE,
    "LEVEL_ID" REFERENCES "LEVEL" ("LEVEL_ID") ENABLE,
    "PERSON_ID" REFERENCES "PERSONS" ("PERSON_ID") ENABLE,
    "TEAM_ID" REFERENCES "TEAMS" ("TEAM_ID") ENABLE,
    CONSTRAINT "SCO_ID_PK" PRIMARY KEY ("SCOUT_ID") USING INDEX ENABLE
);

-- populate continents table
INSERT INTO CONTINENTS (CONTINENT_ID, NAME) VALUES (1, 'North America');
INSERT INTO CONTINENTS (CONTINENT_ID, NAME) VALUES (2, 'South America');
INSERT INTO CONTINENTS (CONTINENT_ID, NAME) VALUES (3, 'Africa');
INSERT INTO CONTINENTS (CONTINENT_ID, NAME) VALUES (4, 'Europe');
INSERT INTO CONTINENTS (CONTINENT_ID, NAME) VALUES (5, 'Asia');
INSERT INTO CONTINENTS (CONTINENT_ID, NAME) VALUES (6, 'Oceania');

-- populate coutries table
INSERT INTO COUNTRIES (COUNTRY_ID, NAME, CONTINENT_ID) VALUES (1, 'France', 4);
INSERT INTO COUNTRIES (COUNTRY_ID, NAME, CONTINENT_ID) VALUES (2, 'Romania', 4);
INSERT INTO COUNTRIES (COUNTRY_ID, NAME, CONTINENT_ID) VALUES (3, 'USA', 1);
INSERT INTO COUNTRIES (COUNTRY_ID, NAME, CONTINENT_ID) VALUES (4, 'Australia', 6);
INSERT INTO COUNTRIES (COUNTRY_ID, NAME, CONTINENT_ID) VALUES (5, 'Mexico', 2);
INSERT INTO COUNTRIES (COUNTRY_ID, NAME, CONTINENT_ID) VALUES (6, 'South Africa', 3);

-- populate cities table
INSERT INTO CITIES (CITY_ID, NAME, COUNTRY_ID) VALUES (1, 'Paris', 1);
INSERT INTO CITIES (CITY_ID, NAME, COUNTRY_ID) VALUES (2, 'Bucharest', 2);
INSERT INTO CITIES (CITY_ID, NAME, COUNTRY_ID) VALUES (3, 'New York', 3);
INSERT INTO CITIES (CITY_ID, NAME, COUNTRY_ID) VALUES (4, 'Sydney', 4);
INSERT INTO CITIES (CITY_ID, NAME, COUNTRY_ID) VALUES (5, 'Mexico', 5);
INSERT INTO CITIES (CITY_ID, NAME, COUNTRY_ID) VALUES (6, 'Le Cap', 6);

-- populate allergens table
INSERT INTO ALLERGENS (ALLERGEN_ID, NAME) VALUES (1, 'Gluten');
INSERT INTO ALLERGENS (ALLERGEN_ID, NAME) VALUES (2, 'Fish');
INSERT INTO ALLERGENS (ALLERGEN_ID, NAME) VALUES (3, 'Milk');
INSERT INTO ALLERGENS (ALLERGEN_ID, NAME) VALUES (4, 'Mustarde');
INSERT INTO ALLERGENS (ALLERGEN_ID, NAME) VALUES (5, 'Eggs');

-- populate foods table
INSERT INTO FOODS (FOOD_ID, NAME) VALUES (1, 'Hot Dog');
INSERT INTO FOODS (FOOD_ID, NAME) VALUES (2, 'Cake');
INSERT INTO FOODS (FOOD_ID, NAME) VALUES (3, 'Gratin Dauphinois');
INSERT INTO FOODS (FOOD_ID, NAME) VALUES (4, 'Sandwich');
INSERT INTO FOODS (FOOD_ID, NAME) VALUES (5, 'Tripe soup');

-- populate food_compositions table
INSERT INTO FOOD_COMPOSITIONS (ALLERGEN_ID, FOOD_ID) VALUES (1, 4);
INSERT INTO FOOD_COMPOSITIONS (ALLERGEN_ID, FOOD_ID) VALUES (1, 1);
INSERT INTO FOOD_COMPOSITIONS (ALLERGEN_ID, FOOD_ID) VALUES (2, 1);
INSERT INTO FOOD_COMPOSITIONS (ALLERGEN_ID, FOOD_ID) VALUES (2, 3);
INSERT INTO FOOD_COMPOSITIONS (ALLERGEN_ID, FOOD_ID) VALUES (2, 5);
INSERT INTO FOOD_COMPOSITIONS (ALLERGEN_ID, FOOD_ID) VALUES (3, 3);
INSERT INTO FOOD_COMPOSITIONS (ALLERGEN_ID, FOOD_ID) VALUES (4, 1);

-- populate equipments table
INSERT INTO EQUIPEMENTS (EQUIPEMENT_ID, NAME) VALUES (1, 'Hiking shoes');
INSERT INTO EQUIPEMENTS (EQUIPEMENT_ID, NAME) VALUES (2, 'Warn coat');
INSERT INTO EQUIPEMENTS (EQUIPEMENT_ID, NAME) VALUES (3, 'Scarf');
INSERT INTO EQUIPEMENTS (EQUIPEMENT_ID, NAME) VALUES (4, 'Swimsuit');
INSERT INTO EQUIPEMENTS (EQUIPEMENT_ID, NAME) VALUES (5, 'Swim glasses');
INSERT INTO EQUIPEMENTS (EQUIPEMENT_ID, NAME) VALUES (6, 'Fork');

-- populate animations table
INSERT INTO ANIMATIONS (ANIMATION_ID, NAME) VALUES (1, 'Meal');
INSERT INTO ANIMATIONS (ANIMATION_ID, NAME) VALUES (2, 'Hike');
INSERT INTO ANIMATIONS (ANIMATION_ID, NAME, DESCRIPTION) VALUES (3, 'Hide and seak', 'Outdoor Game');
INSERT INTO ANIMATIONS (ANIMATION_ID, NAME) VALUES (4, 'Prayer');
INSERT INTO ANIMATIONS (ANIMATION_ID, NAME) VALUES (5, 'Beach');

-- populate animation_requirment table
INSERT INTO ANIMATION_REQUIREMENTS (ANIMATION_ID, EQUIPEMENT_ID) VALUES (1, 6);
INSERT INTO ANIMATION_REQUIREMENTS (ANIMATION_ID, EQUIPEMENT_ID) VALUES (2, 1);
INSERT INTO ANIMATION_REQUIREMENTS (ANIMATION_ID, EQUIPEMENT_ID) VALUES (2, 2);
INSERT INTO ANIMATION_REQUIREMENTS (ANIMATION_ID, EQUIPEMENT_ID) VALUES (2, 3);
INSERT INTO ANIMATION_REQUIREMENTS (ANIMATION_ID, EQUIPEMENT_ID) VALUES (5, 5);
INSERT INTO ANIMATION_REQUIREMENTS (ANIMATION_ID, EQUIPEMENT_ID) VALUES (5, 4);

-- populate animation_food_propositions
INSERT INTO ANIMATION_FOOD_PROPOSITIONS (ANIMATION_ID, FOOD_ID) VALUES (1, 1);
INSERT INTO ANIMATION_FOOD_PROPOSITIONS (ANIMATION_ID, FOOD_ID) VALUES (1, 2);
INSERT INTO ANIMATION_FOOD_PROPOSITIONS (ANIMATION_ID, FOOD_ID) VALUES (1, 3);
INSERT INTO ANIMATION_FOOD_PROPOSITIONS (ANIMATION_ID, FOOD_ID) VALUES (1, 4);
INSERT INTO ANIMATION_FOOD_PROPOSITIONS (ANIMATION_ID, FOOD_ID) VALUES (1, 5);

-- populate persons table
INSERT INTO PERSONS (PERSON_ID, FIRST_NAME, LAST_NAME, GENDER, BIRTH_DATE, DEATH_DATE, PHONE_NUMBER, EMAIL, SCOUT_ID)
    VALUES (1, 'Simon', 'Martin', 0, TO_DATE( 'August 01, 1954', 'MONTH DD, YYYY' ), NULL, NULL, NULL, NULL);
INSERT INTO PERSONS (PERSON_ID, FIRST_NAME, LAST_NAME, GENDER, BIRTH_DATE, DEATH_DATE, PHONE_NUMBER, EMAIL, SCOUT_ID)
    VALUES (2, 'Victor', 'Bernard', 0, TO_DATE( 'August 01, 1996', 'MONTH DD, YYYY' ), NULL, NULL, NULL, NULL);
INSERT INTO PERSONS (PERSON_ID, FIRST_NAME, LAST_NAME, GENDER, BIRTH_DATE, DEATH_DATE, PHONE_NUMBER, EMAIL, SCOUT_ID)
    VALUES (3, 'Jean-Baptiste', 'Petit', 0, TO_DATE( 'August 01, 2015', 'MONTH DD, YYYY' ), NULL, NULL, NULL, NULL);
INSERT INTO PERSONS (PERSON_ID, FIRST_NAME, LAST_NAME, GENDER, BIRTH_DATE, DEATH_DATE, PHONE_NUMBER, EMAIL, SCOUT_ID)
    VALUES (4, 'Noa', 'Robert', 0, TO_DATE( 'August 01, 2015', 'MONTH DD, YYYY' ), NULL, NULL, NULL, NULL);
INSERT INTO PERSONS (PERSON_ID, FIRST_NAME, LAST_NAME, GENDER, BIRTH_DATE, DEATH_DATE, PHONE_NUMBER, EMAIL, SCOUT_ID)
    VALUES (5, 'Augustin', 'Durant', 0, TO_DATE( 'August 01, 2014', 'MONTH DD, YYYY' ), NULL, NULL, NULL, NULL);
INSERT INTO PERSONS (PERSON_ID, FIRST_NAME, LAST_NAME, GENDER, BIRTH_DATE, DEATH_DATE, PHONE_NUMBER, EMAIL, SCOUT_ID)
    VALUES (6, 'Matei', 'Adriana', 0, TO_DATE( 'August 01, 1963', 'MONTH DD, YYYY' ), NULL, NULL, NULL, NULL);
INSERT INTO PERSONS (PERSON_ID, FIRST_NAME, LAST_NAME, GENDER, BIRTH_DATE, DEATH_DATE, PHONE_NUMBER, EMAIL, SCOUT_ID)
    VALUES (7, 'Albert', 'Antonescu', 0, TO_DATE( 'August 01, 1980', 'MONTH DD, YYYY' ), NULL, NULL, NULL, NULL);
INSERT INTO PERSONS (PERSON_ID, FIRST_NAME, LAST_NAME, GENDER, BIRTH_DATE, DEATH_DATE, PHONE_NUMBER, EMAIL, SCOUT_ID)
    VALUES (8, 'Andrei', 'Andreescu', 0, TO_DATE( 'August 01, 2014', 'MONTH DD, YYYY' ), NULL, NULL, NULL, NULL);
INSERT INTO PERSONS (PERSON_ID, FIRST_NAME, LAST_NAME, GENDER, BIRTH_DATE, DEATH_DATE, PHONE_NUMBER, EMAIL, SCOUT_ID)
    VALUES (9, 'Marcu', 'Andreescu', 0, TO_DATE( 'August 01, 2013', 'MONTH DD, YYYY' ), NULL, NULL, NULL, NULL);
INSERT INTO PERSONS (PERSON_ID, FIRST_NAME, LAST_NAME, GENDER, BIRTH_DATE, DEATH_DATE, PHONE_NUMBER, EMAIL, SCOUT_ID)
    VALUES (10, 'Lucas', 'Georgescu', 0, TO_DATE( 'August 01, 2018', 'MONTH DD, YYYY' ), NULL, NULL, NULL, NULL);
INSERT INTO PERSONS (PERSON_ID, FIRST_NAME, LAST_NAME, GENDER, BIRTH_DATE, DEATH_DATE, PHONE_NUMBER, EMAIL, SCOUT_ID)
    VALUES (11, 'Deborah', 'Smith', 1, TO_DATE( 'August 01, 1970', 'MONTH DD, YYYY' ), NULL, NULL, NULL, NULL);
INSERT INTO PERSONS (PERSON_ID, FIRST_NAME, LAST_NAME, GENDER, BIRTH_DATE, DEATH_DATE, PHONE_NUMBER, EMAIL, SCOUT_ID)
    VALUES (12, 'Kathy', 'Johnson', 1, TO_DATE( 'August 01, 1986', 'MONTH DD, YYYY' ), NULL, NULL, NULL, NULL);
INSERT INTO PERSONS (PERSON_ID, FIRST_NAME, LAST_NAME, GENDER, BIRTH_DATE, DEATH_DATE, PHONE_NUMBER, EMAIL, SCOUT_ID)
    VALUES (13, 'Eleonore', 'Williams', 1, TO_DATE( 'August 01, 2016', 'MONTH DD, YYYY' ), NULL, NULL, NULL, NULL);
INSERT INTO PERSONS (PERSON_ID, FIRST_NAME, LAST_NAME, GENDER, BIRTH_DATE, DEATH_DATE, PHONE_NUMBER, EMAIL, SCOUT_ID)
    VALUES (14, 'Ocean', 'Brown', 1, TO_DATE( 'August 01, 2017', 'MONTH DD, YYYY' ), NULL, NULL, NULL, NULL);
INSERT INTO PERSONS (PERSON_ID, FIRST_NAME, LAST_NAME, GENDER, BIRTH_DATE, DEATH_DATE, PHONE_NUMBER, EMAIL, SCOUT_ID)
    VALUES (15, 'Jennifer', 'Jackson', 1, TO_DATE( 'August 01, 2015', 'MONTH DD, YYYY' ), NULL, NULL, NULL, NULL);
INSERT INTO PERSONS (PERSON_ID, FIRST_NAME, LAST_NAME, GENDER, BIRTH_DATE, DEATH_DATE, PHONE_NUMBER, EMAIL, SCOUT_ID)
    VALUES (16, 'Madi', 'Mamba', 0, TO_DATE( 'August 01, 1950', 'MONTH DD, YYYY' ), NULL, NULL, NULL, NULL);
INSERT INTO PERSONS (PERSON_ID, FIRST_NAME, LAST_NAME, GENDER, BIRTH_DATE, DEATH_DATE, PHONE_NUMBER, EMAIL, SCOUT_ID)
    VALUES (17, 'Astou', 'Mbappe', 0, TO_DATE( 'August 01, 2000', 'MONTH DD, YYYY' ), NULL, NULL, NULL, NULL);
INSERT INTO PERSONS (PERSON_ID, FIRST_NAME, LAST_NAME, GENDER, BIRTH_DATE, DEATH_DATE, PHONE_NUMBER, EMAIL, SCOUT_ID)
    VALUES (18, 'Kim', 'Mbappe', 0, TO_DATE( 'August 01, 2013', 'MONTH DD, YYYY' ), NULL, NULL, NULL, NULL);
INSERT INTO PERSONS (PERSON_ID, FIRST_NAME, LAST_NAME, GENDER, BIRTH_DATE, DEATH_DATE, PHONE_NUMBER, EMAIL, SCOUT_ID)
    VALUES (19, 'Koffi', 'Mbappe', 0, TO_DATE( 'August 01, 2010', 'MONTH DD, YYYY' ), NULL, NULL, NULL, NULL);
INSERT INTO PERSONS (PERSON_ID, FIRST_NAME, LAST_NAME, GENDER, BIRTH_DATE, DEATH_DATE, PHONE_NUMBER, EMAIL, SCOUT_ID)
    VALUES (20, 'Prince', 'Mulenga', 0, TO_DATE( 'August 01, 2013', 'MONTH DD, YYYY' ), NULL, NULL, NULL, NULL);
INSERT INTO PERSONS (PERSON_ID, FIRST_NAME, LAST_NAME, GENDER, BIRTH_DATE, DEATH_DATE, PHONE_NUMBER, EMAIL, SCOUT_ID)
    VALUES (21, 'Carlos', 'Hernandez', 0, TO_DATE( 'August 01, 1966', 'MONTH DD, YYYY' ), NULL, NULL, NULL, NULL);
INSERT INTO PERSONS (PERSON_ID, FIRST_NAME, LAST_NAME, GENDER, BIRTH_DATE, DEATH_DATE, PHONE_NUMBER, EMAIL, SCOUT_ID)
    VALUES (22, 'Eduardo', 'Martinez', 0, TO_DATE( 'August 01, 1995', 'MONTH DD, YYYY' ), NULL, NULL, NULL, NULL);
INSERT INTO PERSONS (PERSON_ID, FIRST_NAME, LAST_NAME, GENDER, BIRTH_DATE, DEATH_DATE, PHONE_NUMBER, EMAIL, SCOUT_ID)
    VALUES (23, 'Sergio', 'Gonzalez', 0, TO_DATE( 'August 01, 2015', 'MONTH DD, YYYY' ), NULL, NULL, NULL, NULL);
INSERT INTO PERSONS (PERSON_ID, FIRST_NAME, LAST_NAME, GENDER, BIRTH_DATE, DEATH_DATE, PHONE_NUMBER, EMAIL, SCOUT_ID)
    VALUES (24, 'Diego', 'Ortiz', 0, TO_DATE( 'August 01, 2013', 'MONTH DD, YYYY' ), NULL, NULL, NULL, NULL);
INSERT INTO PERSONS (PERSON_ID, FIRST_NAME, LAST_NAME, GENDER, BIRTH_DATE, DEATH_DATE, PHONE_NUMBER, EMAIL, SCOUT_ID)
    VALUES (25, 'José', 'Castillo', 0, TO_DATE( 'August 01, 2010', 'MONTH DD, YYYY' ), NULL, NULL, NULL, NULL);

-- populate organizations table
INSERT INTO ORGANIZATIONS (ORGANIZATION_ID, NAME, CREATION_DATE, PHONE_NUMBER, EMAIL, CITY_ID, RELIGIOUS)
    VALUES (1, 'Bucharest Cubs', TO_DATE( 'August 01, 2019', 'MONTH DD, YYYY'), NULL, 'bct_scout@gmail.com', 2, 1);
INSERT INTO ORGANIZATIONS (ORGANIZATION_ID, NAME, CREATION_DATE, PHONE_NUMBER, EMAIL, CITY_ID, RELIGIOUS)
    VALUES (2, 'Les scouts de Paris', TO_DATE( 'August 01, 2020', 'MONTH DD, YYYY'), NULL, 'paris_scout@gmail.com', 1, 1);
INSERT INTO ORGANIZATIONS (ORGANIZATION_ID, NAME, CREATION_DATE, PHONE_NUMBER, EMAIL, CITY_ID, RELIGIOUS)
    VALUES (3, 'African scouts', TO_DATE( 'August 01, 2021', 'MONTH DD, YYYY'), NULL, 'le_cap_scout@gmail.com', 6, 0);
INSERT INTO ORGANIZATIONS (ORGANIZATION_ID, NAME, CREATION_DATE, PHONE_NUMBER, EMAIL, CITY_ID, RELIGIOUS)
    VALUES (4, 'Mexican youth', TO_DATE( 'August 01, 2018', 'MONTH DD, YYYY'), NULL, 'mexico_scout@gmail.com', 5, 1);
INSERT INTO ORGANIZATIONS (ORGANIZATION_ID, NAME, CREATION_DATE, PHONE_NUMBER, EMAIL, CITY_ID, RELIGIOUS)
    VALUES (5, 'Girl Scout Power', TO_DATE( 'August 01, 2018', 'MONTH DD, YYYY'), NULL, 'ny_scout@gmail.com', 3, 1);

-- populate level table
INSERT INTO "LEVEL" (LEVEL_ID, NAME) VALUES (1, '1 Year old');
INSERT INTO "LEVEL" (LEVEL_ID, NAME) VALUES (2, '2 Years old');
INSERT INTO "LEVEL" (LEVEL_ID, NAME) VALUES (3, '3 Years old');
INSERT INTO "LEVEL" (LEVEL_ID, NAME) VALUES (4, '4 Years old');
INSERT INTO "LEVEL" (LEVEL_ID, NAME) VALUES (5, '>= 5 Years old');

-- populate teams table
INSERT INTO TEAMS (TEAM_ID, NAME, ORGANIZATION_ID) VALUES (1, 'BEGINNER', 3);
INSERT INTO TEAMS (TEAM_ID, NAME, ORGANIZATION_ID) VALUES (2, 'Principiante', 4);
INSERT INTO TEAMS (TEAM_ID, NAME, ORGANIZATION_ID) VALUES (3, 'DEBUTANT', 2);
INSERT INTO TEAMS (TEAM_ID, NAME, ORGANIZATION_ID) VALUES (4, 'BEGINNER', 5);
INSERT INTO TEAMS (TEAM_ID, NAME, ORGANIZATION_ID) VALUES (5, 'LUPI', 1);

-- populate scouts table
INSERT INTO SCOUTS (SCOUT_ID, START_DATE, ENDING_DATE, LEVEL_ID, PERSON_ID, TEAM_ID)
    VALUES (1, SYSDATE, NULL, 1, 3, 3);
UPDATE PERSONS SET SCOUT_ID = 1 WHERE PERSON_ID = 3;
INSERT INTO SCOUTS (SCOUT_ID, START_DATE, ENDING_DATE, LEVEL_ID, PERSON_ID, TEAM_ID)
    VALUES (2, SYSDATE, NULL, 1, 4, 3);
UPDATE PERSONS SET SCOUT_ID = 2 WHERE PERSON_ID = 4;
INSERT INTO SCOUTS (SCOUT_ID, START_DATE, ENDING_DATE, LEVEL_ID, PERSON_ID, TEAM_ID)
    VALUES (3, SYSDATE, NULL, 1, 5, 3);
UPDATE PERSONS SET SCOUT_ID = 3 WHERE PERSON_ID = 5;
INSERT INTO SCOUTS (SCOUT_ID, START_DATE, ENDING_DATE, LEVEL_ID, PERSON_ID, TEAM_ID)
    VALUES (4, SYSDATE, NULL, 1, 8, 5);
UPDATE PERSONS SET SCOUT_ID = 4 WHERE PERSON_ID = 8;
INSERT INTO SCOUTS (SCOUT_ID, START_DATE, ENDING_DATE, LEVEL_ID, PERSON_ID, TEAM_ID)
    VALUES (5, SYSDATE, NULL, 1, 9, 5);
UPDATE PERSONS SET SCOUT_ID = 5 WHERE PERSON_ID = 9;
INSERT INTO SCOUTS (SCOUT_ID, START_DATE, ENDING_DATE, LEVEL_ID, PERSON_ID, TEAM_ID)
    VALUES (6, SYSDATE, NULL, 1, 10, 5);
UPDATE PERSONS SET SCOUT_ID = 6 WHERE PERSON_ID = 10;
INSERT INTO SCOUTS (SCOUT_ID, START_DATE, ENDING_DATE, LEVEL_ID, PERSON_ID, TEAM_ID)
    VALUES (7, SYSDATE, NULL, 1, 13, 4);
UPDATE PERSONS SET SCOUT_ID = 7 WHERE PERSON_ID = 13;
INSERT INTO SCOUTS (SCOUT_ID, START_DATE, ENDING_DATE, LEVEL_ID, PERSON_ID, TEAM_ID)
    VALUES (8, SYSDATE, NULL, 1, 14, 4);
UPDATE PERSONS SET SCOUT_ID = 8 WHERE PERSON_ID = 14;
INSERT INTO SCOUTS (SCOUT_ID, START_DATE, ENDING_DATE, LEVEL_ID, PERSON_ID, TEAM_ID)
    VALUES (9, SYSDATE, NULL, 1, 15, 4);
UPDATE PERSONS SET SCOUT_ID = 9 WHERE PERSON_ID = 15;
INSERT INTO SCOUTS (SCOUT_ID, START_DATE, ENDING_DATE, LEVEL_ID, PERSON_ID, TEAM_ID)
    VALUES (10, SYSDATE, NULL, 1, 18, 3);
UPDATE PERSONS SET SCOUT_ID = 10 WHERE PERSON_ID = 18;
INSERT INTO SCOUTS (SCOUT_ID, START_DATE, ENDING_DATE, LEVEL_ID, PERSON_ID, TEAM_ID)
    VALUES (11, SYSDATE, NULL, 1, 19, 3);
UPDATE PERSONS SET SCOUT_ID = 11 WHERE PERSON_ID = 19;
INSERT INTO SCOUTS (SCOUT_ID, START_DATE, ENDING_DATE, LEVEL_ID, PERSON_ID, TEAM_ID)
    VALUES (12, SYSDATE, NULL, 1, 20, 3);
UPDATE PERSONS SET SCOUT_ID = 12 WHERE PERSON_ID = 20;
INSERT INTO SCOUTS (SCOUT_ID, START_DATE, ENDING_DATE, LEVEL_ID, PERSON_ID, TEAM_ID)
    VALUES (13, SYSDATE, NULL, 1, 23, 4);
UPDATE PERSONS SET SCOUT_ID = 13 WHERE PERSON_ID = 23;
INSERT INTO SCOUTS (SCOUT_ID, START_DATE, ENDING_DATE, LEVEL_ID, PERSON_ID, TEAM_ID)
    VALUES (14, SYSDATE, NULL, 1, 24, 4);
UPDATE PERSONS SET SCOUT_ID = 14 WHERE PERSON_ID = 24;
INSERT INTO SCOUTS (SCOUT_ID, START_DATE, ENDING_DATE, LEVEL_ID, PERSON_ID, TEAM_ID)
    VALUES (15, SYSDATE, NULL, 1, 25, 4);
UPDATE PERSONS SET SCOUT_ID = 15 WHERE PERSON_ID = 5;

-- populate scout chefs table
INSERT INTO SCOUT_CHEFS (CHEF_ID, ALIAS, START_DATE, ENDING_DATE, ORGANIZATION_ID, TEAM_ID, PERSON_ID)
    VALUES (1, NULL, SYSDATE, NULL, 2, 3, 2);
INSERT INTO SCOUT_CHEFS (CHEF_ID, ALIAS, START_DATE, ENDING_DATE, ORGANIZATION_ID, TEAM_ID, PERSON_ID)
    VALUES (2, NULL, SYSDATE, NULL, 1, 5, 7);
INSERT INTO SCOUT_CHEFS (CHEF_ID, ALIAS, START_DATE, ENDING_DATE, ORGANIZATION_ID, TEAM_ID, PERSON_ID)
    VALUES (3, NULL, SYSDATE, NULL, 5, 4, 12);
INSERT INTO SCOUT_CHEFS (CHEF_ID, ALIAS, START_DATE, ENDING_DATE, ORGANIZATION_ID, TEAM_ID, PERSON_ID)
    VALUES (4, NULL, SYSDATE, NULL, 3, 1, 17);
INSERT INTO SCOUT_CHEFS (CHEF_ID, ALIAS, START_DATE, ENDING_DATE, ORGANIZATION_ID, TEAM_ID, PERSON_ID)
    VALUES (5, NULL, SYSDATE, NULL, 4, 2, 22);

-- populate chefs table
INSERT INTO CHEFS (CHEF_ID, START_DATE, ENDING_DATE, ORGANIZATION_ID, PERSON_ID) 
    VALUES (1, SYSDATE, NULL, 1, 6);
INSERT INTO CHEFS (CHEF_ID, START_DATE, ENDING_DATE, ORGANIZATION_ID, PERSON_ID) 
    VALUES (2, SYSDATE, NULL, 2, 1);
INSERT INTO CHEFS (CHEF_ID, START_DATE, ENDING_DATE, ORGANIZATION_ID, PERSON_ID) 
    VALUES (3, SYSDATE, NULL, 3, 16);
INSERT INTO CHEFS (CHEF_ID, START_DATE, ENDING_DATE, ORGANIZATION_ID, PERSON_ID) 
    VALUES (4, SYSDATE, NULL, 4, 21);
INSERT INTO CHEFS (CHEF_ID, START_DATE, ENDING_DATE, ORGANIZATION_ID, PERSON_ID) 
    VALUES (5, SYSDATE, NULL, 5, 11);

-- populate events table
INSERT INTO EVENTS (EVENT_ID, NAME, MEETING_POINT, STARTING_DATE, ENDING_DATE)
    VALUES (1, 'Christmas Eve', 'Parc Kiseleff', TO_DATE( 'December 24, 2022', 'MONTH DD, YYYY'), TO_DATE( 'December 24, 2022', 'MONTH DD, YYYY'));
INSERT INTO EVENTS (EVENT_ID, NAME, MEETING_POINT, STARTING_DATE, ENDING_DATE)
    VALUES (2, 'Outdoor games', 'Tour Eiffel', TO_DATE( 'October 19, 2022', 'MONTH DD, YYYY'), TO_DATE( 'October 19, 2022', 'MONTH DD, YYYY'));
INSERT INTO EVENTS (EVENT_ID, NAME, MEETING_POINT, STARTING_DATE, ENDING_DATE)
    VALUES (3, 'Hike in the mountains', 'Train station', TO_DATE( 'October 14, 2022', 'MONTH DD, YYYY'), TO_DATE( 'October 16, 2022', 'MONTH DD, YYYY'));
INSERT INTO EVENTS (EVENT_ID, NAME, MEETING_POINT, STARTING_DATE, ENDING_DATE)
    VALUES (4, 'National Day', 'At the church', TO_DATE( 'October 19, 2022', 'MONTH DD, YYYY'), TO_DATE( 'October 19, 2022', 'MONTH DD, YYYY'));
INSERT INTO EVENTS (EVENT_ID, NAME, MEETING_POINT, STARTING_DATE, ENDING_DATE)
    VALUES (5, 'Journée à la plage', 'Gare', TO_DATE( 'July 19, 2022', 'MONTH DD, YYYY'), TO_DATE( 'July 19, 2022', 'MONTH DD, YYYY'));

-- populate sponsors table
INSERT INTO SPONSORS (SPONSOR_ID, NAME, PHONE_NUMBER, EMAIL, LINK, PRIVATE)
    VALUES (1, 'Croix Rouage', NULL, 'contact@croixrouge.fr', NULL, 0);
INSERT INTO SPONSORS (SPONSOR_ID, NAME, PHONE_NUMBER, EMAIL, LINK, PRIVATE)
    VALUES (2, 'John Doe', NULL, NULL, NULL, 1);
INSERT INTO SPONSORS (SPONSOR_ID, NAME, PHONE_NUMBER, EMAIL, LINK, PRIVATE)
    VALUES (3, 'RED BULL', NULL, NULL, 'https://www.redbull.com/', 0);
INSERT INTO SPONSORS (SPONSOR_ID, NAME, PHONE_NUMBER, EMAIL, LINK, PRIVATE)
    VALUES (4, 'AMNESTY INTER.', NULL, NULL, 'https://www.amnesty.org/', 0);
INSERT INTO SPONSORS (SPONSOR_ID, NAME, PHONE_NUMBER, EMAIL, LINK, PRIVATE)
    VALUES (5, 'GIFFORDS', NULL, NULL, 'https://giffords.org/', 0);

-- populate event_help table
INSERT INTO EVENT_HELPER (EVENT_ID, SPONSOR_ID) VALUES (1, 2);
INSERT INTO EVENT_HELPER (EVENT_ID, SPONSOR_ID) VALUES (4, 3);
INSERT INTO EVENT_HELPER (EVENT_ID, SPONSOR_ID) VALUES (2, 1);
INSERT INTO EVENT_HELPER (EVENT_ID, SPONSOR_ID) VALUES (1, 5);
INSERT INTO EVENT_HELPER (EVENT_ID, SPONSOR_ID) VALUES (5, 2);

-- populate events_creation table
INSERT INTO EVENTS_CREATION (ORGANIZATION_ID, EVENT_ID) VALUES (1, 1);
INSERT INTO EVENTS_CREATION (ORGANIZATION_ID, EVENT_ID) VALUES (2, 1);
INSERT INTO EVENTS_CREATION (ORGANIZATION_ID, EVENT_ID) VALUES (2, 2);
INSERT INTO EVENTS_CREATION (ORGANIZATION_ID, EVENT_ID) VALUES (2, 5);
INSERT INTO EVENTS_CREATION (ORGANIZATION_ID, EVENT_ID) VALUES (5, 3);
INSERT INTO EVENTS_CREATION (ORGANIZATION_ID, EVENT_ID) VALUES (5, 4);

-- populate organization_helper table
INSERT INTO ORGANIZATION_HELPER (ORGANIZATION_ID, SPONSOR_ID) VALUES (1, 2);
INSERT INTO ORGANIZATION_HELPER (ORGANIZATION_ID, SPONSOR_ID) VALUES (4, 3);
INSERT INTO ORGANIZATION_HELPER (ORGANIZATION_ID, SPONSOR_ID) VALUES (2, 1);
INSERT INTO ORGANIZATION_HELPER (ORGANIZATION_ID, SPONSOR_ID) VALUES (1, 5);
INSERT INTO ORGANIZATION_HELPER (ORGANIZATION_ID, SPONSOR_ID) VALUES (5, 2);

-- populate program table
INSERT INTO PROGRAM (EVENT_ID, ANIMATION_ID) VALUES (1, 1);
INSERT INTO PROGRAM (EVENT_ID, ANIMATION_ID) VALUES (1, 4);
INSERT INTO PROGRAM (EVENT_ID, ANIMATION_ID) VALUES (5, 1);
INSERT INTO PROGRAM (EVENT_ID, ANIMATION_ID) VALUES (5, 5);
INSERT INTO PROGRAM (EVENT_ID, ANIMATION_ID) VALUES (3, 2);
INSERT INTO PROGRAM (EVENT_ID, ANIMATION_ID) VALUES (3, 1);
INSERT INTO PROGRAM (EVENT_ID, ANIMATION_ID) VALUES (2, 3);
INSERT INTO PROGRAM (EVENT_ID, ANIMATION_ID) VALUES (4, 1);


-- Queries
-- Get all organizations chefs who has an organization which has been sponsored by RED BULL
SELECT CHEFS.*
FROM SPONSORS INNER JOIN ORGANIZATION_HELPER 
    ON SPONSORS.SPONSOR_ID = ORGANIZATION_HELPER.SPONSOR_ID 
    INNER JOIN ORGANIZATIONS 
    ON ORGANIZATIONS.ORGANIZATION_ID = ORGANIZATION_HELPER.ORGANIZATION_ID
    INNER JOIN CHEFS
    ON ORGANIZATIONS.ORGANIZATION_ID = CHEFS.ORGANIZATION_ID
WHERE SPONSORS.NAME='RED BULL'
-- Get the latest event which does not propose Gluten in an animation
WITH NON_GLUTEN_EVENT AS (SELECT EVENTS.NAME, EVENTS.STARTING_DATE
FROM (SELECT ANIMATION_ID
FROM ANIMATIONS
WHERE NOT ANIMATION_ID IN (SELECT DISTINCT ANIMATION_ID
FROM (SELECT ALLERGEN_ID FROM ALLERGENS WHERE NAME='Gluten')
    JOIN FOOD_COMPOSITIONS
    USING (ALLERGEN_ID)
    JOIN FOODS
    USING (FOOD_ID)
    JOIN ANIMATION_FOOD_PROPOSITIONS
    USING (FOOD_ID))) JOIN PROGRAM USING (ANIMATION_ID) JOIN EVENTS USING (EVENT_ID))
SELECT NAME
FROM NON_GLUTEN_EVENT
WHERE STARTING_DATE IN (SELECT MAX(STARTING_DATE) FROM NON_GLUTEN_EVENT)
-- List all the teams which participate to event longer than one day
WITH EVENT_LONGER_THEN_A_DAY AS (SELECT * FROM EVENTS WHERE ENDING_DATE - STARTING_DATE > 0)
SELECT TEAM_ID, TEAMS.NAME
FROM EVENT_LONGER_THEN_A_DAY JOIN EVENTS_CREATION USING (EVENT_ID)
    JOIN ORGANIZATIONS USING (ORGANIZATION_ID)
    JOIN TEAMS USING (ORGANIZATION_ID)
-- List teams with a scout chef who has been a scout in the past
SELECT TEAMS.*
FROM TEAMS INNER JOIN SCOUT_CHEFS ON TEAMS.TEAM_ID=SCOUT_CHEFS.TEAM_ID
    INNER JOIN PERSONS ON SCOUT_CHEFS.PERSON_ID=PERSONS.PERSON_ID
    INNER JOIN SCOUTS ON PERSONS.PERSON_ID=SCOUTS.SCOUT_ID
-- Get the second country with the most number of organization
WITH NB_ORG_COUNTRIES AS (SELECT COUNTRIES.NAME, COUNT(1) NbOrganization
FROM COUNTRIES INNER JOIN CITIES ON COUNTRIES.COUNTRY_ID=CITIES.COUNTRY_ID
    INNER JOIN ORGANIZATIONS ON CITIES.CITY_ID=ORGANIZATIONS.ORGANIZATION_ID
GROUP BY COUNTRIES.NAME)
SELECT NAME
FROM NB_ORG_COUNTRIES
WHERE NbOrganization IN (SELECT MAX(NbOrganization) FROM (
    SELECT NbOrganization FROM NB_ORG_COUNTRIES
    MINUS
    SELECT MAX(NbOrganization) FROM NB_ORG_COUNTRIES))
-- Count how many time each allergen has been found in events of french organizations
WITH french_organizations as (SELECT organization_id, organizations.name
FROM countries JOIN cities USING (country_id)
    JOIN organizations USING (city_id)
WHERE countries.name='France')
SELECT allergens.name, COUNT(1) as NbTime
FROM french_organizations JOIN events_creation USING (organization_id)
    JOIN events USING (event_id)
    JOIN program USING (event_id)
    JOIN animations USING (animation_id)
    JOIN animation_food_propositions USING (animation_id)
    JOIN foods USING (food_id)
    JOIN food_compositions USING (food_id)
    JOIN allergens USING (allergen_id)
GROUP BY allergens.name
ORDER BY NbTime DESC
-- Count number of organization per continent
SELECT continents.name, COUNT(organization_id) as NbOrganization
FROM continents FULL OUTER JOIN countries ON continents.continent_id=countries.continent_id
    FULL OUTER JOIN cities ON countries.country_id=cities.country_id
    FULL OUTER JOIN organizations ON cities.city_id=organizations.city_id
GROUP BY continents.name
ORDER BY NbOrganization DESC
-- Get the organization(s) with the oldest scout(s)
WITH OldestScouts AS (SELECT person_id, scouts.scout_id, scouts.team_id, first_name, last_name, birth_date
    FROM scouts JOIN persons USING (person_id)
    WHERE birth_date IN (SELECT MIN(birth_date)
    FROM scouts JOIN persons USING (person_id)
    WHERE DEATH_DATE IS NULL AND ENDING_DATE IS NULL))
SELECT organization_id, organizations.name, first_name || ' ' || last_name Scout, birth_date
FROM teams JOIN OldestScouts USING (team_id)
JOIN organizations USING (organization_id)
-- Get the last event organized by the organization with the must number os sponsors
WITH OrgByEvent AS (SELECT organization_id, organizations.name, COUNT(1) as NbSponsors
    FROM organizations JOIN organization_helper USING (organization_id)
    GROUP BY organization_id, organizations.name)
SELECT event_id, events.name, starting_date
FROM OrgByEvent JOIN events_creation USING (organization_id)
JOIN events USING (event_id)
WHERE NbSponsors IN (SELECT MAX(NbSponsors) FROM OrgByEvent)
    AND starting_date IN (SELECT MIN(starting_date)
    FROM OrgByEvent JOIN events_creation USING (organization_id)
    JOIN events USING (event_id)
    WHERE NbSponsors IN (SELECT MAX(NbSponsors) FROM OrgByEvent))
-- Foreach organizations, does the chef has been a scout?
SELECT organization_id, organizations.name, CASE WHEN SCOUT_ID IS NULL THEN 'False' ELSE 'True' END AS OldScoutForChef
FROM scout_chefs JOIN persons USING (person_id)
JOIN organizations USING (organization_id)
WHERE ending_date IS NULL
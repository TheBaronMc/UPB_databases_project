-- Drop tables
DROP TABLE "FOOD_COMPOSITIONS";
DROP TABLE "ANIMATION_REQUIREMENTS";
DROP TABLE "ANIMATION_FOOD_PROPOSITIONS";
DROP TABLE "ORGANIZATION_HELPER";
DROP TABLE "EVENT_HELPER";
DROP TABLE "EVENTS_CREATION";
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
    "CONTINENT" NUMBER(6,0) REFERENCES "CONTINENTS"("CONTINENT_ID"),
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

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


CREATE SCHEMA IF NOT EXISTS `Spotify_Music` DEFAULT CHARACTER SET latin1 ;
USE `Spotify_Music` ;

CREATE TABLE IF NOT EXISTS `Spotify_Music`.`music` (
  `Music_id` INT NOT NULL AUTO_INCREMENT,
  `Music_name` TEXT NOT NULL,
  `Collab` INT NOT NULL,
  `Duration` INT NOT NULL,
  `Stream` INT NOT NULL,
  `Weeks_on_chart` INT NOT NULL,
  `Artist_num` INT NOT NULL,
  `Album_id` INT NOT NULL,
  PRIMARY KEY (`Music_id`),
  CONSTRAINT `music_fk` FOREIGN KEY (`Album_id`)
  REFERENCES `Spotify_Music`.`Album` (`Album_id`)
  ON DELETE NO ACTION ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `Spotify_Music`.`Music_attribute` (
  `Music_attribute_id` INT NOT NULL AUTO_INCREMENT,
  `Danceability` DECIMAL,
  `Energy` DECIMAL,
  `Key_attribute` FLOAT,
  `Mode` FLOAT,
  `Loudness` DECIMAL,
  `Speechiness` DECIMAL,
  `Acousticness` DECIMAL,
  `Instrumentalness` DECIMAL,
  `Iiveness` DECIMAL,
  `Valence` DECIMAL,
  `Tempo` FLOAT,
  `Music_id` INT NOT NULL,
  PRIMARY KEY (`Music_attribute_id`, `Music_id`))

ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

ALTER TABLE `Spotify_Music`.`Music_attribute` ADD FOREIGN KEY (`Music_id`) REFERENCES `Spotify_Music`.`music` (`Music_id`) ON DELETE CASCADE;

CREATE TABLE IF NOT EXISTS `Spotify_Music`.`Rank` (
  `Rank_id` INT NOT NULL AUTO_INCREMENT,
  `music_rank` INT NOT NULL,
  `peak_rank` INT NOT NULL,
  `previous_rank` INT NOT NULL,
  `Music_id` INT NOT NULL,
  PRIMARY KEY (`Rank_id`),
  CONSTRAINT `rank_fk` FOREIGN KEY (`Music_id`)
  REFERENCES `Spotify_Music`.`music` (`Music_id`)
  ON DELETE NO ACTION ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


CREATE TABLE IF NOT EXISTS `Spotify_Music`.`Album` (
  `Album_id` INT NOT NULL AUTO_INCREMENT,
  `release_date` DATE NOT NULL,
  `album_num_tracks` INT NOT NULL,
  `album_cover` VARCHAR(100) NOT NULL,
  `Record_company_id` INT NOT NULL,
  PRIMARY KEY (`Album_id`),
  CONSTRAINT `Album_fk` FOREIGN KEY (`Record_company_id`)
  REFERENCES `Spotify_Music`.`Record_company` (`Record_company_id`)
  ON DELETE NO ACTION ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


CREATE TABLE IF NOT EXISTS `Spotify_Music`.`Record_company` (
  `Record_company_id` INT NOT NULL AUTO_INCREMENT,
  `Company_name` TEXT NOT NULL,
  PRIMARY KEY (`Record_company_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `Spotify_Music`.`Music_uri` (
  `Music_uri_id` INT NOT NULL AUTO_INCREMENT,
  `Uri` VARCHAR(45) NOT NULL,
  `Music_id` INT NOT NULL,
  PRIMARY KEY (`Music_uri_id`),
  CONSTRAINT `Music_uri_fk` FOREIGN KEY (`Music_id`)
  REFERENCES `Spotify_Music`.`music` (`Music_id`)
  ON DELETE NO ACTION ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;



CREATE TABLE IF NOT EXISTS `Spotify_Music`.`Artist` (
  `Artist_id` INT NOT NULL AUTO_INCREMENT,
  `Artist_name` VARCHAR(45) NOT NULL,
  `Artist_img` VARCHAR(100),
  `Artist_genre` VARCHAR(45),
  PRIMARY KEY (`Artist_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `Spotify_Music`.`Artist_uri` (
  `Artist_uri_id` INT NOT NULL AUTO_INCREMENT,
  `Uri` VARCHAR(45) NOT NULL,
  `Artist_id` INT NOT NULL,
  PRIMARY KEY (`Artist_uri_id`),
  CONSTRAINT `Artist_uri_fk` FOREIGN KEY (`Artist_id`)
  REFERENCES `Spotify_Music`.`Artist` (`Artist_id`)
  ON DELETE NO ACTION ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `Spotify_Music`.`Date` (
  `Date_id` INT NOT NULL AUTO_INCREMENT,
  `Week_date` DATE NOT NULL,
  PRIMARY KEY (`Date_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `Spotify_Music`.`Region` (
  `Region_id` INT NOT NULL AUTO_INCREMENT,
  `Country` VARCHAR(45) NOT NULL,
  `Region` VARCHAR(45) NOT NULL,
  `Language` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Region_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `Spotify_Music`.`Music_artist` (
  `Music_artist_id` INT NOT NULL AUTO_INCREMENT,
  `Music_id` INT NOT NULL,
  `Artist_id` INT NOT NULL,
  PRIMARY KEY (`Music_artist_id`),
  CONSTRAINT `Music_artist_fk1` FOREIGN KEY (`Music_id`)
  REFERENCES `Spotify_Music`.`music` (`Music_id`)
  ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Music_artist_fk2` FOREIGN KEY (`Artist_id`)
  REFERENCES `Spotify_Music`.`Artist` (`Artist_id`)
  ON DELETE NO ACTION ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `Spotify_Music`.`Music_region` (
  `Music_region_id` INT NOT NULL AUTO_INCREMENT,
  `Region_id` INT NOT NULL,
  `Music_id` INT NOT NULL,
  PRIMARY KEY (`Music_region_id`),
  CONSTRAINT `Music_region_fk1` FOREIGN KEY (`Region_id`)
  REFERENCES `Spotify_Music`.`Region` (`Region_id`)
  ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Music_region_fk2` FOREIGN KEY (`Music_id`)
  REFERENCES `Spotify_Music`.`music` (`Music_id`)
  ON DELETE NO ACTION ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `Spotify_Music`.`Music_date` (
  `Music_date_id` INT NOT NULL AUTO_INCREMENT,
  `Music_id` INT NOT NULL,
  `Date_id` INT NOT NULL,
  PRIMARY KEY (`Music_date_id`),
  CONSTRAINT `Music_date_fk` FOREIGN KEY (`Music_id`)
  REFERENCES `Spotify_Music`.`music` (`Music_id`)
  ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Music_date_fk2` FOREIGN KEY (`Date_id`)
  REFERENCES `Spotify_Music`.`Date` (`Date_id`)
  ON DELETE NO ACTION ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;
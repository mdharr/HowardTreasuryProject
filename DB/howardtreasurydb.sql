-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema howardtreasurydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `howardtreasurydb` ;

-- -----------------------------------------------------
-- Schema howardtreasurydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `howardtreasurydb` DEFAULT CHARACTER SET utf8 ;
USE `howardtreasurydb` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `enabled` TINYINT NULL,
  `role` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `collection`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `collection` ;

CREATE TABLE IF NOT EXISTS `collection` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `story`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `story` ;

CREATE TABLE IF NOT EXISTS `story` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `poem` ;

CREATE TABLE IF NOT EXISTS `poem` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `miscellanea`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `miscellanea` ;

CREATE TABLE IF NOT EXISTS `miscellanea` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `person` ;

CREATE TABLE IF NOT EXISTS `person` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_list` ;

CREATE TABLE IF NOT EXISTS `user_list` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_list_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_list_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `list_content`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `list_content` ;

CREATE TABLE IF NOT EXISTS `list_content` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_list_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_list_content_user_list1_idx` (`user_list_id` ASC),
  CONSTRAINT `fk_list_content_user_list1`
    FOREIGN KEY (`user_list_id`)
    REFERENCES `user_list` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `story_has_list_content`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `story_has_list_content` ;

CREATE TABLE IF NOT EXISTS `story_has_list_content` (
  `story_id` INT NOT NULL,
  `list_content_id` INT NOT NULL,
  PRIMARY KEY (`story_id`, `list_content_id`),
  INDEX `fk_story_has_list_content_list_content1_idx` (`list_content_id` ASC),
  INDEX `fk_story_has_list_content_story1_idx` (`story_id` ASC),
  CONSTRAINT `fk_story_has_list_content_story1`
    FOREIGN KEY (`story_id`)
    REFERENCES `story` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_story_has_list_content_list_content1`
    FOREIGN KEY (`list_content_id`)
    REFERENCES `list_content` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poem_has_list_content`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `poem_has_list_content` ;

CREATE TABLE IF NOT EXISTS `poem_has_list_content` (
  `poem_id` INT NOT NULL,
  `list_content_id` INT NOT NULL,
  PRIMARY KEY (`poem_id`, `list_content_id`),
  INDEX `fk_poem_has_list_content_list_content1_idx` (`list_content_id` ASC),
  INDEX `fk_poem_has_list_content_poem1_idx` (`poem_id` ASC),
  CONSTRAINT `fk_poem_has_list_content_poem1`
    FOREIGN KEY (`poem_id`)
    REFERENCES `poem` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_poem_has_list_content_list_content1`
    FOREIGN KEY (`list_content_id`)
    REFERENCES `list_content` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `miscellanea_has_list_content`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `miscellanea_has_list_content` ;

CREATE TABLE IF NOT EXISTS `miscellanea_has_list_content` (
  `miscellanea_id` INT NOT NULL,
  `list_content_id` INT NOT NULL,
  PRIMARY KEY (`miscellanea_id`, `list_content_id`),
  INDEX `fk_miscellanea_has_list_content_list_content1_idx` (`list_content_id` ASC),
  INDEX `fk_miscellanea_has_list_content_miscellanea1_idx` (`miscellanea_id` ASC),
  CONSTRAINT `fk_miscellanea_has_list_content_miscellanea1`
    FOREIGN KEY (`miscellanea_id`)
    REFERENCES `miscellanea` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_miscellanea_has_list_content_list_content1`
    FOREIGN KEY (`list_content_id`)
    REFERENCES `list_content` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `person_has_list_content`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `person_has_list_content` ;

CREATE TABLE IF NOT EXISTS `person_has_list_content` (
  `person_id` INT NOT NULL,
  `list_content_id` INT NOT NULL,
  PRIMARY KEY (`person_id`, `list_content_id`),
  INDEX `fk_person_has_list_content_list_content1_idx` (`list_content_id` ASC),
  INDEX `fk_person_has_list_content_person1_idx` (`person_id` ASC),
  CONSTRAINT `fk_person_has_list_content_person1`
    FOREIGN KEY (`person_id`)
    REFERENCES `person` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_person_has_list_content_list_content1`
    FOREIGN KEY (`list_content_id`)
    REFERENCES `list_content` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `collection_has_story`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `collection_has_story` ;

CREATE TABLE IF NOT EXISTS `collection_has_story` (
  `collection_id` INT NOT NULL,
  `story_id` INT NOT NULL,
  PRIMARY KEY (`collection_id`, `story_id`),
  INDEX `fk_collection_has_story_story1_idx` (`story_id` ASC),
  INDEX `fk_collection_has_story_collection1_idx` (`collection_id` ASC),
  CONSTRAINT `fk_collection_has_story_collection1`
    FOREIGN KEY (`collection_id`)
    REFERENCES `collection` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_collection_has_story_story1`
    FOREIGN KEY (`story_id`)
    REFERENCES `story` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `collection_has_poem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `collection_has_poem` ;

CREATE TABLE IF NOT EXISTS `collection_has_poem` (
  `collection_id` INT NOT NULL,
  `poem_id` INT NOT NULL,
  PRIMARY KEY (`collection_id`, `poem_id`),
  INDEX `fk_collection_has_poem_poem1_idx` (`poem_id` ASC),
  INDEX `fk_collection_has_poem_collection1_idx` (`collection_id` ASC),
  CONSTRAINT `fk_collection_has_poem_collection1`
    FOREIGN KEY (`collection_id`)
    REFERENCES `collection` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_collection_has_poem_poem1`
    FOREIGN KEY (`poem_id`)
    REFERENCES `poem` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `collection_has_miscellanea`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `collection_has_miscellanea` ;

CREATE TABLE IF NOT EXISTS `collection_has_miscellanea` (
  `collection_id` INT NOT NULL,
  `miscellanea_id` INT NOT NULL,
  PRIMARY KEY (`collection_id`, `miscellanea_id`),
  INDEX `fk_collection_has_miscellanea_miscellanea1_idx` (`miscellanea_id` ASC),
  INDEX `fk_collection_has_miscellanea_collection1_idx` (`collection_id` ASC),
  CONSTRAINT `fk_collection_has_miscellanea_collection1`
    FOREIGN KEY (`collection_id`)
    REFERENCES `collection` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_collection_has_miscellanea_miscellanea1`
    FOREIGN KEY (`miscellanea_id`)
    REFERENCES `miscellanea` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `collection_has_person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `collection_has_person` ;

CREATE TABLE IF NOT EXISTS `collection_has_person` (
  `collection_id` INT NOT NULL,
  `person_id` INT NOT NULL,
  PRIMARY KEY (`collection_id`, `person_id`),
  INDEX `fk_collection_has_person_person1_idx` (`person_id` ASC),
  INDEX `fk_collection_has_person_collection1_idx` (`collection_id` ASC),
  CONSTRAINT `fk_collection_has_person_collection1`
    FOREIGN KEY (`collection_id`)
    REFERENCES `collection` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_collection_has_person_person1`
    FOREIGN KEY (`person_id`)
    REFERENCES `person` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `miscellanea_has_person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `miscellanea_has_person` ;

CREATE TABLE IF NOT EXISTS `miscellanea_has_person` (
  `miscellanea_id` INT NOT NULL,
  `person_id` INT NOT NULL,
  PRIMARY KEY (`miscellanea_id`, `person_id`),
  INDEX `fk_miscellanea_has_person_person1_idx` (`person_id` ASC),
  INDEX `fk_miscellanea_has_person_miscellanea1_idx` (`miscellanea_id` ASC),
  CONSTRAINT `fk_miscellanea_has_person_miscellanea1`
    FOREIGN KEY (`miscellanea_id`)
    REFERENCES `miscellanea` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_miscellanea_has_person_person1`
    FOREIGN KEY (`person_id`)
    REFERENCES `person` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `story_has_person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `story_has_person` ;

CREATE TABLE IF NOT EXISTS `story_has_person` (
  `story_id` INT NOT NULL,
  `person_id` INT NOT NULL,
  PRIMARY KEY (`story_id`, `person_id`),
  INDEX `fk_story_has_person_person1_idx` (`person_id` ASC),
  INDEX `fk_story_has_person_story1_idx` (`story_id` ASC),
  CONSTRAINT `fk_story_has_person_story1`
    FOREIGN KEY (`story_id`)
    REFERENCES `story` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_story_has_person_person1`
    FOREIGN KEY (`person_id`)
    REFERENCES `person` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chat_room`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chat_room` ;

CREATE TABLE IF NOT EXISTS `chat_room` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  `description` VARCHAR(255) NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_chat_room_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_chat_room_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chat_message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chat_message` ;

CREATE TABLE IF NOT EXISTS `chat_message` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `message_content` VARCHAR(1000) NULL,
  `created_at` TIMESTAMP NULL,
  `chat_room_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_chat_message_chat_room1_idx` (`chat_room_id` ASC),
  INDEX `fk_chat_message_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_chat_message_chat_room1`
    FOREIGN KEY (`chat_room_id`)
    REFERENCES `chat_room` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_chat_message_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poem_has_person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `poem_has_person` ;

CREATE TABLE IF NOT EXISTS `poem_has_person` (
  `poem_id` INT NOT NULL,
  `person_id` INT NOT NULL,
  PRIMARY KEY (`poem_id`, `person_id`),
  INDEX `fk_poem_has_person_person1_idx` (`person_id` ASC),
  INDEX `fk_poem_has_person_poem1_idx` (`poem_id` ASC),
  CONSTRAINT `fk_poem_has_person_poem1`
    FOREIGN KEY (`poem_id`)
    REFERENCES `poem` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_poem_has_person_person1`
    FOREIGN KEY (`person_id`)
    REFERENCES `person` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_has_chat_room`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_has_chat_room` ;

CREATE TABLE IF NOT EXISTS `user_has_chat_room` (
  `user_id` INT NOT NULL,
  `chat_room_id` INT NOT NULL,
  `joined_at` TIMESTAMP NULL,
  `last_activity` TIMESTAMP NULL,
  `notification_preferences` VARCHAR(255) NULL,
  `unread_message_count` INT NULL,
  `user_status` VARCHAR(10) NULL,
  `role` VARCHAR(255) NULL,
  PRIMARY KEY (`user_id`, `chat_room_id`),
  INDEX `fk_user_has_chat_room_chat_room1_idx` (`chat_room_id` ASC),
  INDEX `fk_user_has_chat_room_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_chat_room_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_chat_room_chat_room1`
    FOREIGN KEY (`chat_room_id`)
    REFERENCES `chat_room` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS howardtreasury@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'howardtreasury'@'localhost' IDENTIFIED BY 'howardtreasury';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'howardtreasury'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`) VALUES (1, 'admin', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', 1, 'ADMIN');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`) VALUES (2, 'Kull', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', 1, 'ADMIN');

COMMIT;


-- -----------------------------------------------------
-- Data for table `collection`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `collection` (`id`, `title`) VALUES (1, 'Kull Exile of Atlantis');

COMMIT;


-- -----------------------------------------------------
-- Data for table `story`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `story` (`id`, `title`) VALUES (1, 'The Altar and the Scorpion');
INSERT INTO `story` (`id`, `title`) VALUES (2, 'By This Axe I Rule!');
INSERT INTO `story` (`id`, `title`) VALUES (3, 'The Cat and the Skull');
INSERT INTO `story` (`id`, `title`) VALUES (4, 'The Curse of the Golden Skull');
INSERT INTO `story` (`id`, `title`) VALUES (5, 'Exile of Atlantis (untitled story)');
INSERT INTO `story` (`id`, `title`) VALUES (6, 'Kings of the Night');
INSERT INTO `story` (`id`, `title`) VALUES (7, 'The Mirrors of Tuzun Thune');
INSERT INTO `story` (`id`, `title`) VALUES (8, 'The Screaming Skull of Silence');
INSERT INTO `story` (`id`, `title`) VALUES (9, 'The Shadow Kingdom');
INSERT INTO `story` (`id`, `title`) VALUES (10, 'The Striking of the Gong');
INSERT INTO `story` (`id`, `title`) VALUES (11, 'Swords of the Purple Kingdom');

COMMIT;


-- -----------------------------------------------------
-- Data for table `poem`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `poem` (`id`, `title`) VALUES (1, 'Am-ra the Ta-an');
INSERT INTO `poem` (`id`, `title`) VALUES (2, 'The King and the Oak');
INSERT INTO `poem` (`id`, `title`) VALUES (3, 'Summer Morn');

COMMIT;


-- -----------------------------------------------------
-- Data for table `miscellanea`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `miscellanea` (`id`, `title`) VALUES (1, 'The Black City (fragment)');
INSERT INTO `miscellanea` (`id`, `title`) VALUES (2, 'Untitled draft (\"\'Thus,\' said Tu...\")');
INSERT INTO `miscellanea` (`id`, `title`) VALUES (3, 'Untitled fragment (\"A land of wild, fantastic beauty...\")');
INSERT INTO `miscellanea` (`id`, `title`) VALUES (4, 'Untitled fragment (\"So I set out up the hill-trail...\")');
INSERT INTO `miscellanea` (`id`, `title`) VALUES (5, 'Untitled fragment (\"Three men sat...\")');

COMMIT;


-- -----------------------------------------------------
-- Data for table `person`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `person` (`id`, `name`) VALUES (1, 'Kull');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_list`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `user_list` (`id`, `name`, `user_id`) VALUES (1, 'King Kull Poems', 2);
INSERT INTO `user_list` (`id`, `name`, `user_id`) VALUES (2, 'King Kull Stories', 2);
INSERT INTO `user_list` (`id`, `name`, `user_id`) VALUES (3, 'King Kull Miscellanea', 2);
INSERT INTO `user_list` (`id`, `name`, `user_id`) VALUES (4, 'King Kull Favorites', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `list_content`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `list_content` (`id`, `user_list_id`) VALUES (1, 1);
INSERT INTO `list_content` (`id`, `user_list_id`) VALUES (2, 2);
INSERT INTO `list_content` (`id`, `user_list_id`) VALUES (3, 3);
INSERT INTO `list_content` (`id`, `user_list_id`) VALUES (4, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `story_has_list_content`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `story_has_list_content` (`story_id`, `list_content_id`) VALUES (1, 2);
INSERT INTO `story_has_list_content` (`story_id`, `list_content_id`) VALUES (2, 2);
INSERT INTO `story_has_list_content` (`story_id`, `list_content_id`) VALUES (3, 2);
INSERT INTO `story_has_list_content` (`story_id`, `list_content_id`) VALUES (4, 2);
INSERT INTO `story_has_list_content` (`story_id`, `list_content_id`) VALUES (5, 2);
INSERT INTO `story_has_list_content` (`story_id`, `list_content_id`) VALUES (6, 2);
INSERT INTO `story_has_list_content` (`story_id`, `list_content_id`) VALUES (7, 2);
INSERT INTO `story_has_list_content` (`story_id`, `list_content_id`) VALUES (8, 2);
INSERT INTO `story_has_list_content` (`story_id`, `list_content_id`) VALUES (9, 2);
INSERT INTO `story_has_list_content` (`story_id`, `list_content_id`) VALUES (10, 2);
INSERT INTO `story_has_list_content` (`story_id`, `list_content_id`) VALUES (11, 2);
INSERT INTO `story_has_list_content` (`story_id`, `list_content_id`) VALUES (1, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `poem_has_list_content`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `poem_has_list_content` (`poem_id`, `list_content_id`) VALUES (1, 1);
INSERT INTO `poem_has_list_content` (`poem_id`, `list_content_id`) VALUES (2, 1);
INSERT INTO `poem_has_list_content` (`poem_id`, `list_content_id`) VALUES (3, 1);
INSERT INTO `poem_has_list_content` (`poem_id`, `list_content_id`) VALUES (1, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `miscellanea_has_list_content`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `miscellanea_has_list_content` (`miscellanea_id`, `list_content_id`) VALUES (1, 3);
INSERT INTO `miscellanea_has_list_content` (`miscellanea_id`, `list_content_id`) VALUES (2, 3);
INSERT INTO `miscellanea_has_list_content` (`miscellanea_id`, `list_content_id`) VALUES (3, 3);
INSERT INTO `miscellanea_has_list_content` (`miscellanea_id`, `list_content_id`) VALUES (4, 3);
INSERT INTO `miscellanea_has_list_content` (`miscellanea_id`, `list_content_id`) VALUES (5, 3);
INSERT INTO `miscellanea_has_list_content` (`miscellanea_id`, `list_content_id`) VALUES (1, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `person_has_list_content`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `person_has_list_content` (`person_id`, `list_content_id`) VALUES (1, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `collection_has_story`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (1, 1);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (1, 2);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (1, 3);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (1, 4);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (1, 5);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (1, 6);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (1, 7);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (1, 8);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (1, 9);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (1, 10);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (1, 11);

COMMIT;


-- -----------------------------------------------------
-- Data for table `collection_has_poem`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (1, 1);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (1, 2);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (1, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `collection_has_miscellanea`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (1, 1);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (1, 2);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (1, 3);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (1, 4);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (1, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `collection_has_person`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `collection_has_person` (`collection_id`, `person_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `miscellanea_has_person`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `miscellanea_has_person` (`miscellanea_id`, `person_id`) VALUES (1, 1);
INSERT INTO `miscellanea_has_person` (`miscellanea_id`, `person_id`) VALUES (2, 1);
INSERT INTO `miscellanea_has_person` (`miscellanea_id`, `person_id`) VALUES (3, 1);
INSERT INTO `miscellanea_has_person` (`miscellanea_id`, `person_id`) VALUES (4, 1);
INSERT INTO `miscellanea_has_person` (`miscellanea_id`, `person_id`) VALUES (5, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `story_has_person`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (1, 1);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (2, 1);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (3, 1);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (4, 1);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (5, 1);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (6, 1);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (7, 1);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (8, 1);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (9, 1);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (10, 1);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (11, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `chat_room`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `chat_room` (`id`, `name`, `description`, `user_id`) VALUES (1, 'Public Chat Room', 'A place for all to partake in public discourse.', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `chat_message`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `chat_message` (`id`, `message_content`, `created_at`, `chat_room_id`, `user_id`) VALUES (1, 'Welcome to the Robert E. Howard Treasury chat room!', '2023-03-03T12:35:22', 1, 1);
INSERT INTO `chat_message` (`id`, `message_content`, `created_at`, `chat_room_id`, `user_id`) VALUES (2, 'Always excited to discuss Robert E. Howard.', '2023-03-03T12:36:22', 1, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `poem_has_person`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `poem_has_person` (`poem_id`, `person_id`) VALUES (1, 1);
INSERT INTO `poem_has_person` (`poem_id`, `person_id`) VALUES (2, 1);
INSERT INTO `poem_has_person` (`poem_id`, `person_id`) VALUES (3, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_has_chat_room`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `user_has_chat_room` (`user_id`, `chat_room_id`, `joined_at`, `last_activity`, `notification_preferences`, `unread_message_count`, `user_status`, `role`) VALUES (1, 1, '2023-03-03T12:35:22', '2023-03-03T12:35:22', NULL, NULL, NULL, NULL);

COMMIT;


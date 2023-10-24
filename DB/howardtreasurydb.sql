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
  `username` VARCHAR(15) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `enabled` TINYINT NULL,
  `role` VARCHAR(45) NULL,
  `email` VARCHAR(1000) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `series`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `series` ;

CREATE TABLE IF NOT EXISTS `series` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `collection`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `collection` ;

CREATE TABLE IF NOT EXISTS `collection` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NULL,
  `series_id` INT NULL,
  `published_at` DATETIME NULL,
  `page_count` INT NULL,
  `description` TEXT NULL,
  `amazon_url` VARCHAR(1000) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_collection_series1_idx` (`series_id` ASC),
  CONSTRAINT `fk_collection_series1`
    FOREIGN KEY (`series_id`)
    REFERENCES `series` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `story`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `story` ;

CREATE TABLE IF NOT EXISTS `story` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NULL,
  `text_url` VARCHAR(1000) NULL,
  `first_published` DATETIME NULL,
  `alternate_title` VARCHAR(1000) NULL,
  `is_copyrighted` TINYINT NULL,
  `copyright_expires_at` DATETIME NULL,
  `excerpt` TEXT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `title_UNIQUE` (`title` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `poem` ;

CREATE TABLE IF NOT EXISTS `poem` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NULL,
  `text_url` VARCHAR(1000) NULL,
  `excerpt` TEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `title_UNIQUE` (`title` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `miscellanea`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `miscellanea` ;

CREATE TABLE IF NOT EXISTS `miscellanea` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `text_url` VARCHAR(1000) NULL,
  `excerpt` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `person` ;

CREATE TABLE IF NOT EXISTS `person` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  `image_url` VARCHAR(1000) NULL,
  `description` TEXT NULL,
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
-- Table `collection_has_story`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `collection_has_story` ;

CREATE TABLE IF NOT EXISTS `collection_has_story` (
  `collection_id` INT NOT NULL,
  `story_id` INT NOT NULL,
  `page_number` INT NULL,
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
  `page_number` INT NULL,
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
  `page_number` INT NULL,
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


-- -----------------------------------------------------
-- Table `collection_image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `collection_image` ;

CREATE TABLE IF NOT EXISTS `collection_image` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `image_url` VARCHAR(1000) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `collection_has_collection_image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `collection_has_collection_image` ;

CREATE TABLE IF NOT EXISTS `collection_has_collection_image` (
  `collection_id` INT NOT NULL,
  `collection_image_id` INT NOT NULL,
  PRIMARY KEY (`collection_id`, `collection_image_id`),
  INDEX `fk_collection_has_collection_image_collection_image1_idx` (`collection_image_id` ASC),
  INDEX `fk_collection_has_collection_image_collection1_idx` (`collection_id` ASC),
  CONSTRAINT `fk_collection_has_collection_image_collection1`
    FOREIGN KEY (`collection_id`)
    REFERENCES `collection` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_collection_has_collection_image_collection_image1`
    FOREIGN KEY (`collection_image_id`)
    REFERENCES `collection_image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `illustrator`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `illustrator` ;

CREATE TABLE IF NOT EXISTS `illustrator` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `collection_has_illustrator`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `collection_has_illustrator` ;

CREATE TABLE IF NOT EXISTS `collection_has_illustrator` (
  `collection_id` INT NOT NULL,
  `illustrator_id` INT NOT NULL,
  PRIMARY KEY (`collection_id`, `illustrator_id`),
  INDEX `fk_collection_has_illustrator_illustrator1_idx` (`illustrator_id` ASC),
  INDEX `fk_collection_has_illustrator_collection1_idx` (`collection_id` ASC),
  CONSTRAINT `fk_collection_has_illustrator_collection1`
    FOREIGN KEY (`collection_id`)
    REFERENCES `collection` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_collection_has_illustrator_illustrator1`
    FOREIGN KEY (`illustrator_id`)
    REFERENCES `illustrator` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_list_has_story`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_list_has_story` ;

CREATE TABLE IF NOT EXISTS `user_list_has_story` (
  `user_list_id` INT NOT NULL,
  `story_id` INT NOT NULL,
  PRIMARY KEY (`user_list_id`, `story_id`),
  INDEX `fk_user_list_has_story_story1_idx` (`story_id` ASC),
  INDEX `fk_user_list_has_story_user_list1_idx` (`user_list_id` ASC),
  CONSTRAINT `fk_user_list_has_story_user_list1`
    FOREIGN KEY (`user_list_id`)
    REFERENCES `user_list` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_list_has_story_story1`
    FOREIGN KEY (`story_id`)
    REFERENCES `story` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_list_has_poem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_list_has_poem` ;

CREATE TABLE IF NOT EXISTS `user_list_has_poem` (
  `user_list_id` INT NOT NULL,
  `poem_id` INT NOT NULL,
  PRIMARY KEY (`user_list_id`, `poem_id`),
  INDEX `fk_user_list_has_poem_poem1_idx` (`poem_id` ASC),
  INDEX `fk_user_list_has_poem_user_list1_idx` (`user_list_id` ASC),
  CONSTRAINT `fk_user_list_has_poem_user_list1`
    FOREIGN KEY (`user_list_id`)
    REFERENCES `user_list` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_list_has_poem_poem1`
    FOREIGN KEY (`poem_id`)
    REFERENCES `poem` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_list_has_miscellanea`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_list_has_miscellanea` ;

CREATE TABLE IF NOT EXISTS `user_list_has_miscellanea` (
  `user_list_id` INT NOT NULL,
  `miscellanea_id` INT NOT NULL,
  PRIMARY KEY (`user_list_id`, `miscellanea_id`),
  INDEX `fk_user_list_has_miscellanea_miscellanea1_idx` (`miscellanea_id` ASC),
  INDEX `fk_user_list_has_miscellanea_user_list1_idx` (`user_list_id` ASC),
  CONSTRAINT `fk_user_list_has_miscellanea_user_list1`
    FOREIGN KEY (`user_list_id`)
    REFERENCES `user_list` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_list_has_miscellanea_miscellanea1`
    FOREIGN KEY (`miscellanea_id`)
    REFERENCES `miscellanea` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `story_image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `story_image` ;

CREATE TABLE IF NOT EXISTS `story_image` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `image_url` VARCHAR(1000) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `story_has_story_image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `story_has_story_image` ;

CREATE TABLE IF NOT EXISTS `story_has_story_image` (
  `story_id` INT NOT NULL,
  `story_image_id` INT NOT NULL,
  PRIMARY KEY (`story_id`, `story_image_id`),
  INDEX `fk_story_has_story_image_story_image1_idx` (`story_image_id` ASC),
  INDEX `fk_story_has_story_image_story1_idx` (`story_id` ASC),
  CONSTRAINT `fk_story_has_story_image_story1`
    FOREIGN KEY (`story_id`)
    REFERENCES `story` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_story_has_story_image_story_image1`
    FOREIGN KEY (`story_image_id`)
    REFERENCES `story_image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `story_image_has_illustrator`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `story_image_has_illustrator` ;

CREATE TABLE IF NOT EXISTS `story_image_has_illustrator` (
  `story_image_id` INT NOT NULL,
  `illustrator_id` INT NOT NULL,
  PRIMARY KEY (`story_image_id`, `illustrator_id`),
  INDEX `fk_story_image_has_illustrator_illustrator1_idx` (`illustrator_id` ASC),
  INDEX `fk_story_image_has_illustrator_story_image1_idx` (`story_image_id` ASC),
  CONSTRAINT `fk_story_image_has_illustrator_story_image1`
    FOREIGN KEY (`story_image_id`)
    REFERENCES `story_image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_story_image_has_illustrator_illustrator1`
    FOREIGN KEY (`illustrator_id`)
    REFERENCES `illustrator` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blog_post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `blog_post` ;

CREATE TABLE IF NOT EXISTS `blog_post` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NULL,
  `content` TEXT NULL,
  `created_at` TIMESTAMP NULL,
  `user_id` INT NOT NULL,
  `hidden` TINYINT NULL,
  `image_url` VARCHAR(1000) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_blog_post_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_blog_post_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blog_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `blog_comment` ;

CREATE TABLE IF NOT EXISTS `blog_comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` TEXT NULL,
  `created_at` TIMESTAMP NULL,
  `blog_post_id` INT NOT NULL,
  `parent_comment_id` INT NULL,
  `user_id` INT NOT NULL,
  `hidden` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_blog_comment_blog_post1_idx` (`blog_post_id` ASC),
  INDEX `fk_blog_comment_blog_comment1_idx` (`parent_comment_id` ASC),
  INDEX `fk_blog_comment_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_blog_comment_blog_post1`
    FOREIGN KEY (`blog_post_id`)
    REFERENCES `blog_post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_blog_comment_blog_comment1`
    FOREIGN KEY (`parent_comment_id`)
    REFERENCES `blog_comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_blog_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
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
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `email`) VALUES (1, 'admin', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', 1, 'ADMIN', 'admin@howardtreasury.com');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `email`) VALUES (2, 'Kull', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', 1, 'ADMIN', 'kull@howardtreasury.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `series`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `series` (`id`, `title`) VALUES (1, 'The Barbarian Series');
INSERT INTO `series` (`id`, `title`) VALUES (2, 'The Adventurers Series');
INSERT INTO `series` (`id`, `title`) VALUES (3, 'The R. E. H. Stories Series');

COMMIT;


-- -----------------------------------------------------
-- Data for table `collection`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `collection` (`id`, `title`, `series_id`, `published_at`, `page_count`, `description`, `amazon_url`) VALUES (1, 'The Coming of Conan the Cimmerian', 1, '2003-12-02T12:00:00', 463, 'Conan is one of the greatest fictional heroes ever created– a swordsman who cuts a swath across the lands of the Hyborian Age, facing powerful sorcerers, deadly creatures, and ruthless armies of thieves and reavers.\n\n“Between the years when the oceans drank Atlantis and the gleaming cities . . . there was an Age undreamed of, when shining kingdoms lay spread across the world like blue mantles beneath the stars. . . . Hither came Conan, the Cimmerian, black-haired, sullen-eyed, sword in hand . . . to tread\nthe jeweled thrones of the Earth under his sandalled feet.”\n\nIn a meteoric career that spanned a mere twelve years before his tragic suicide, Robert E. Howard single-handedly invented the genre that came to be called sword and sorcery. Collected in this volume, profusely illustrated by artist Mark Schultz, are Howard’s first thirteen Conan stories, appearing in their original versions–in some cases for the first time in more than seventy years–and in the order Howard wrote them. Along with classics of dark fantasy like “The Tower of the Elephant” and swashbuckling adventure like “Queen of the Black Coast,” The Coming of Conan the Cimmerian contains a wealth of material never before published in the United States, including the first submitted draft of Conan’s debut, “Phoenix on the Sword,” Howard’s synopses for “The Scarlet Citadel” and “Black Colossus,” and a map of Conan’s world drawn by the author himself.\n\nHere are timeless tales featuring Conan the raw and dangerous youth, Conan the daring thief, Conan the swashbuckling pirate, and Conan the commander of armies. Here, too, is an unparalleled glimpse into the mind of a genius whose bold storytelling style has been imitated by many, yet equaled by none.', 'https://www.amazon.com/Coming-Conan-Cimmerian-Original-Adventures/dp/0345461517/ref=sr_1_1?crid=O689J4JQEF3A&keywords=robert+e+howard+del+rey+books&qid=1696669958&sprefix=robert+e+howard+del+rey+bo%2Caps%2C687&sr=8-1');
INSERT INTO `collection` (`id`, `title`, `series_id`, `published_at`, `page_count`, `description`, `amazon_url`) VALUES (2, 'The Savage Tales of Solomon Kane', 2, '2004-06-29T12:00:00', 432, 'With Conan the Cimmerian, Robert E. Howard created more than the greatest action hero of the twentieth century—he also launched a genre that came to be known as sword and sorcery. But Conan wasn’t the first archetypal adventurer to spring from Howard’s fertile imagination.\n\n“He was . . . a strange blending of Puritan and Cavalier, with a touch of the ancient philosopher, and more than a touch of the pagan. . . . A hunger in his soul drove him on and on, an urge to right all wrongs, protect all weaker things. . . . Wayward and restless as the wind, he was consistent in only one respect—he was true to his ideals of justice and right. Such was Solomon Kane.”\n\nCollected in this volume, lavishly illustrated by award-winning artist Gary Gianni, are all of the stories and poems that make up the thrilling saga of the dour and deadly Puritan, Solomon Kane. Together they constitute a sprawling epic of weird fantasy adventure that stretches from sixteenth-century England to remote African jungles where no white man has set foot. Here are shudder-inducing tales of vengeful ghosts and bloodthirsty demons, of dark sorceries wielded by evil men and women, all opposed by a grim avenger armed with a fanatic’s faith and a warrior’s savage heart.', 'https://www.amazon.com/Savage-Tales-Solomon-Kane/dp/0345461509/ref=sr_1_6?crid=O689J4JQEF3A&keywords=robert+e+howard+del+rey+books&qid=1696669958&sprefix=robert+e+howard+del+rey+bo%2Caps%2C687&sr=8-6');
INSERT INTO `collection` (`id`, `title`, `series_id`, `published_at`, `page_count`, `description`, `amazon_url`) VALUES (3, 'The Bloody Crown of Conan', 1, '2004-11-23T12:00:00', 384, 'In his hugely influential and tempestuous career, Robert E. Howard created the genre that came to be known as sword and sorcery—and brought to life one of fantasy’s boldest and most enduring figures: Conan the Cimmerian—reaver, slayer, barbarian, king.\n\nThis lavishly illustrated volume gathers together three of Howard’s longest and most famous Conan stories–two of them printed for the first time directly from Howard’ s typescript–along with a collection of the author’s previously unpublished and rarely seen outlines, notes, and drafts. Longtime fans and new readers alike will agree that The Bloody Crown of Conan merits a place of honor on every fantasy lover’s bookshelf.\n\nTHE PEOPLE OF THE BLACK CIRCLE\nAmid the towering crags of Vendhya, in the shadowy citadel of the Black Circle, Yasmina of the golden throne seeks vengeance against the Black Seers. Her only ally is also her most formidable enemy–Conan, the outlaw chief.\n\nTHE HOUR OF THE DRAGON\nToppled from the throne of Aquilonia by the evil machinations of an undead wizard, Conan must find the fabled jewel known as the Heart of Ahriman to reclaim his crown . . . and save his life.\n\nA WITCH SHALL BE BORN\nA malevolent witch of evil beauty. An enslaved queen. A kingdom in the iron grip of ruthless mercenaries. And Conan, who plots deadly vengeance against the human wolf who left him in the desert to die.', 'https://www.amazon.com/Bloody-Crown-Conan-Cimmeria-Book/dp/0345461525/ref=sr_1_8?crid=O689J4JQEF3A&keywords=robert+e+howard+del+rey+books&qid=1696669958&sprefix=robert+e+howard+del+rey+bo%2Caps%2C687&sr=8-8');
INSERT INTO `collection` (`id`, `title`, `series_id`, `published_at`, `page_count`, `description`, `amazon_url`) VALUES (4, 'Bran Mak Morn: The Last King', 2, '2005-05-31T12:00:00', 400, 'From Robert E. Howard’s fertile imagination sprang some of fiction’s greatest heroes, including Conan the Cimmerian, King Kull, and Solomon Kane. But of all Howard’s characters, none embodied his creator’s brooding temperament more than Bran Mak Morn, the last king of a doomed race.\n\nIn ages past, the Picts ruled all of Europe. But the descendants of those proud conquerors have sunk into barbarism . . . all save one, Bran Mak Morn, whose bloodline remains unbroken. Threatened by the Celts and the Romans, the Pictish tribes rally under his banner to fight for their very survival, while Bran fights to restore the glory of his race.\n\nLavishly illustrated by award-winning artist Gary Gianni, this collection gathers together all of Howard’s published stories and poems featuring Bran Mak Morn–including the eerie masterpiece “Worms of the Earth” and “Kings of the Night,” in which sorcery summons Kull the conqueror from out of the depths of time to stand with Bran against the Roman invaders.\n\nAlso included are previously unpublished stories and fragments, reproductions of manuscripts bearing Howard’s handwritten revisions, and much, much more.\n\nSpecial Bonus: a newly discovered adventure by Howard, presented here for the very first time.', 'https://www.amazon.com/Bran-Mak-Morn-Last-Novel/dp/0345461541/ref=sr_1_10?crid=O689J4JQEF3A&keywords=robert+e+howard+del+rey+books&qid=1696669958&sprefix=robert+e+howard+del+rey+bo%2Caps%2C687&sr=8-10');
INSERT INTO `collection` (`id`, `title`, `series_id`, `published_at`, `page_count`, `description`, `amazon_url`) VALUES (5, 'The Conquering Sword of Conan', 1, '2005-11-29T12:00:00', 416, 'In a meteoric career that covered only a dozen years, Robert E. Howard defined the sword-and-sorcery genre. In doing so, he brought to life the archetypal adventurer known to millions around the world as Conan the barbarian.\n\nWitness, then, Howard at his finest, and Conan at his most savage, in the latest volume featuring the collected works of Robert E. Howard, lavishly illustrated by award-winning artist Greg Manchess. Prepared directly from the earliest known versions—often Howard’s own manuscripts—are such sword-and-sorcery classics as “The Servants of Bit-Yakin” (formerly published as “Jewels of Gwahlur”), “Beyond the Black River,” “The Black Stranger,” “Man-Eaters of Zamboula” (formerly published as “Shadows in Zamboula”), and, perhaps his most famous adventure of all, “Red Nails.”\n\nThe Conquering Sword of Conan includes never-before-published outlines, notes, and story drafts, plus a new introduction, personal correspondence, and the revealing essay “Hyborian Genesis”—which chronicles the history of the creation of the Conan series. Truly, this is heroic fantasy at its finest.', 'https://www.amazon.com/Conquering-Sword-Conan-Cimmeria-Book/dp/0345461533/ref=sr_1_15?crid=O689J4JQEF3A&keywords=robert+e+howard+del+rey+books&qid=1696669958&sprefix=robert+e+howard+del+rey+bo%2Caps%2C687&sr=8-15');
INSERT INTO `collection` (`id`, `title`, `series_id`, `published_at`, `page_count`, `description`, `amazon_url`) VALUES (6, 'Kull: Exile of Atlantis', 2, '2006-10-31T12:00:00', 352, 'In a meteoric career that spanned a mere twelve years, Robert E. Howard single-handedly invented the genre that came to be called sword and sorcery. From his fertile imagination sprang some of fiction’s most enduring heroes. Yet while Conan is indisputably Howard’s greatest creation, it was in his earlier sequence of tales featuring Kull, a fearless warrior with the brooding intellect of a philosopher, that Howard began to develop the distinctive themes, and the richly evocative blend of history and mythology, that would distinguish his later tales of the Hyborian Age.\n\nMuch more than simply the prototype for Conan, Kull is a fascinating character in his own right: an exile from fabled Atlantis who wins the crown of Valusia, only to find it as much a burden as a prize.\n\nThis groundbreaking collection, lavishly illustrated by award-winning artist Justin Sweet, gathers together all Howard’s stories featuring Kull, from Kull’ s first published appearance, in “The Shadow Kingdom,” to “Kings of the Night,” Howard’ s last tale featuring the cerebral swordsman. The stories are presented just as Howard wrote them, with all subsequent editorial emendations removed. Also included are previously unpublished stories, drafts, and fragments, plus extensive notes on the texts, an introduction by Howard authority Steve Tompkins, and an essay by noted editor Patrice Louinet.', 'https://www.amazon.com/Kull-Exile-Atlantis-Robert-Howard/dp/0345490177/ref=sr_1_5?crid=O689J4JQEF3A&keywords=robert+e+howard+del+rey+books&qid=1696669958&sprefix=robert+e+howard+del+rey+bo%2Caps%2C687&sr=8-5');
INSERT INTO `collection` (`id`, `title`, `series_id`, `published_at`, `page_count`, `description`, `amazon_url`) VALUES (7, 'The Best of Robert E. Howard Volume 1: Crimson Shadows', 3, '2007-08-14T12:00:00', 528, 'Robert E. Howard is one of the most famous and influential pulp authors of the twentieth century. Though largely known as the man who invented the sword-and-sorcery genre–and for his iconic hero Conan the Cimmerian–Howard also wrote horror tales, desert adventures, detective yarns, epic poetry, and more. This spectacular volume, gorgeously illustrated by Jim and Ruth Keegan, includes some of his best and most popular works.\n\nInside, readers will discover (or rediscover) such gems as “The Shadow Kingdom,” featuring Kull of Atlantis and considered by many to be the first sword-and-sorcery story; “The Fightin’est Pair,” part of one of Howard’s most successful series, chronicling the travails of Steve Costigan, a merchant seaman with fists of steel and a head of wood; “The Grey God Passes,” a haunting tale about the passing of an age, told against the backdrop of Irish history and legend; “Worms of the Earth,” a brooding narrative featuring Bran Mak Morn, about which H. P. Lovecraft said, “Few readers will ever forget the hideous and compelling power of [this] macabre masterpiece”; a historical poem relating a momentous battle between Cimbri and the legions of Rome; and “Sharp’s Gun Serenade,” one of the last and funniest of the Breckinridge Elkins tales.\n\nThese thrilling, eerie, compelling, swashbuckling stories and poems have been restored to their original form, presented just as the author intended. There is little doubt that after more than seven decades the voice of Robert E. Howard continues to resonate with readers around the world.', 'https://www.amazon.com/Best-Robert-Howard-Crimson-Shadows/dp/0345490185/ref=sr_1_7?crid=O689J4JQEF3A&keywords=robert+e+howard+del+rey+books&qid=1696669958&sprefix=robert+e+howard+del+rey+bo%2Caps%2C687&sr=8-7');
INSERT INTO `collection` (`id`, `title`, `series_id`, `published_at`, `page_count`, `description`, `amazon_url`) VALUES (8, 'The Best of Robert E. Howard Volume 2: Grim Lands', 3, '2007-11-27T12:00:00', 544, 'The classic pulp magazines of the early twentieth century are long gone, but their action-packed tales live on through the work of legendary storyteller Robert E. Howard. From his fecund imagination sprang an army of larger-than-life heroes–including the iconic Conan the Cimmerian, King Kull of Atlantis, Solomon Kane, and Bran Mak Morn–as well as adventures that would define a genre for generations. Now comes the second volume of this author’s breathtaking short fiction, which runs the gamut from sword and sorcery, historical epic, and seafaring pirate adventure to two-fisted crime and intrigue, ghoulish horror, and rip-roaring western.\n\nKull reigns supreme in “By This Axe I Rule!” and “The Mirrors of Tuzan Thune”; Conan conquers in one of his most popular exploits, “The Tower of the Elephant”; Solomon Kane battles demons deep in Africa in “Wings in the Night”; and itinerant boxer Steve Costigan puts up his dukes of steel inside and outside the ring in “The Bulldog Breed.” In between, warrior kings, daring knights, sinister masterminds, grizzled frontiersmen–even Howard’s stunning heroine, Red Sonya–tear up the pages in stories built to thrill by their masterly creator.\n\nAnd in such epic poems as “Echoes from an Anvil,” “Black Harps in the Hills,” and “The Grim Land,” the author blends his classic characters and visceral imagery with a lyricism as haunting as traditional folk balladry. Lavishly illustrated by Jim and Ruth Keegan, here is a Robert E. Howard collection as indispensable as it is unforgettable.', 'https://www.amazon.com/Best-Robert-Howard-Lands/dp/0345490193/ref=sr_1_9?crid=O689J4JQEF3A&keywords=robert+e+howard+del+rey+books&qid=1696669958&sprefix=robert+e+howard+del+rey+bo%2Caps%2C687&sr=8-9');
INSERT INTO `collection` (`id`, `title`, `series_id`, `published_at`, `page_count`, `description`, `amazon_url`) VALUES (9, 'The Horror Stories of Robert E. Howard', 3, '2008-10-28T12:00:00', 560, 'Here are Robert E. Howard’s greatest horror tales, all in their original, definitive versions.\n\nSome of Howard’s best-known characters—Solomon Kane, Bran Mak Morn, and sailor Steve Costigan among them—roam the forbidding locales of the author’s fevered imagination, from the swamps and bayous of the Deep South to the fiend-haunted woods outside Paris to remote jungles in Africa.\n\nThe collection includes Howard’s masterpiece “Pigeons from Hell,”which Stephen King calls “one of the finest horror stories of [the twentieth] century,” a tale of two travelers who stumble upon the ruins of a Southern plantation–and into the maw of its fatal secret. In “Black Canaan” even the best warrior has little chance of taking down the evil voodoo man with unholy powers–and none at all against his wily mistress, the diabolical High Priestess of Damballah. In these and other lavishly illustrated classics, such as the revenge nightmare “Worms of the Earth” and“The Cairn on the Headland,”Howard spins tales of unrelenting terror, the legacy of one of the world’s great masters of the macabre.', 'https://www.amazon.com/Horror-Stories-Robert-Howard/dp/0345490207/ref=sr_1_4?crid=O689J4JQEF3A&keywords=robert+e+howard+del+rey+books&qid=1696669958&sprefix=robert+e+howard+del+rey+bo%2Caps%2C687&sr=8-4');
INSERT INTO `collection` (`id`, `title`, `series_id`, `published_at`, `page_count`, `description`, `amazon_url`) VALUES (10, 'El Borak and Other Desert Adventures', 2, '2010-02-09T12:00:00', 592, 'Robert E. Howard is famous for creating such immortal heroes as Conan the Cimmerian, Solomon Kane, and Bran Mak Morn. Less well-known but equally extraordinary are his non-fantasy adventure stories set in the Middle East and featuring such two-fisted heroes as Francis Xavier Gordon—known as “El Borak”—Kirby O’Donnell, and Steve Clarney. This trio of hard-fighting Americans, civilized men with more than a touch of the primordial in their veins, marked a new direction for Howard’s writing, and new territory for his genius to conquer.\n\nThe wily Texan El Borak, a hardened fighter who stalks the sandscapes of Afghanistan like a vengeful wolf, is rivaled among Howard’s creations only by Conan himself. In such classic tales as “The Daughter of Erlik Khan,” “Three-Bladed Doom,” and “Sons of the Hawk,” Howard proves himself once again a master of action, and with plenty of eerie atmosphere his plotting becomes tighter and twistier than ever, resulting in stories worthy of comparison to Jack London and Rudyard Kipling. Every fan of Robert E. Howard and aficionados of great adventure writing will want to own this collection of the best of Howard’s desert tales, lavishly illustrated by award-winning artists Tim Bradstreet and Jim & Ruth Keegan.', 'https://www.amazon.com/El-Borak-Other-Desert-Adventures/dp/034550545X/ref=sr_1_13?crid=O689J4JQEF3A&keywords=robert+e+howard+del+rey+books&qid=1696669958&sprefix=robert+e+howard+del+rey+bo%2Caps%2C687&sr=8-13');
INSERT INTO `collection` (`id`, `title`, `series_id`, `published_at`, `page_count`, `description`, `amazon_url`) VALUES (11, 'Sword Woman and Other Historical Adventures', 2, '2011-01-25T12:00:00', 576, 'The immortal legacy of Robert E. Howard, creator of Conan the Cimmerian, continues with this latest compendium of Howard’s fiction and poetry. These adventures, set in medieval-era Europe and the Near East, are among the most gripping Howard ever wrote, full of pageantry, romance, and battle scenes worthy of Tolstoy himself. Most of all, they feature some of Howard’s most unusual and memorable characters, including Cormac FitzGeoffrey, a half-Irish, half-Norman man of war who follows Richard the Lion-hearted to twelfth-century Palestine—or, as it was known to the Crusaders, Outremer; Diego de Guzman, a Spaniard who visits Cairo in the guise of a Muslim on a mission of revenge; and the legendary sword woman Dark Agnès, who, faced with an arranged marriage to a brutal husband in sixteenth-century France, cuts the ceremony short with a dagger thrust and flees to forge a new identity on the battlefield.\n\nLavishly illustrated by award-winning artist John Watkiss and featuring miscellanea, informative essays, and a fascinating introduction by acclaimed historical author Scott Oden, Sword Woman and Other Historical Adventures is a must-have for every fan of Robert E. Howard, who, in a career spanning just twelve years, won a place in the pantheon of great American writers.', 'https://www.amazon.com/Sword-Woman-Other-Historical-Adventures-ebook/dp/B004C43F2K/ref=sr_1_16?crid=O689J4JQEF3A&keywords=robert+e+howard+del+rey+books&qid=1696669958&sprefix=robert+e+howard+del+rey+bo%2Caps%2C687&sr=8-16');

COMMIT;


-- -----------------------------------------------------
-- Data for table `story`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (1, 'The Altar and the Scorpion', NULL, '1967-01-01T00:00:00', NULL, 1, '2063-01-01T00:00:00', 'God of the crawling darkness, grant me aid!\" A slim youth knelt in the gloom, his white body shimmering like ivory. The marble polished floor was cold to his knees but his heart was colder than the stone. High above him, merged into the masking shadows, loomed the great lapis lazuli ceiling, upheld by marble walls. Before him glimmered a golden altar and on this altar shone a huge crystal image — a scorpion, wrought with a craft surpassing mere art.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (2, 'By This Axe I Rule!', NULL, '1967-01-01T00:00:00', NULL, 1, '2063-01-01T00:00:00', 'At midnight the king must die!\" The speaker was tall, lean and dark, and a crooked scar close to his mouth lent him an unusually sinister cast of countenance. His hearers nodded, their eyes glinting. There were four of these — one was a short fat man, with a timid face, weak mouth and eyes which bulged in an air of perpetual curiosity — another a great somber giant, hairy and primitive — the third a tall, wiry man in the garb of a jester whose flaming blue eyes flared with a light not wholly sane — and last a stocky dwarf of a man, inhumanly short and abnormally broad of shoulders and long of arms.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (3, 'The Cat and the Skull', NULL, '1967-01-01T00:00:00', NULL, 1, '2063-01-01T00:00:00', 'King Kull went with Tu, chief councillor of the throne, to see the talking cat of Delcardes, for though a cat may look at a king, it is not given every king to look at a cat like Delcardes\'. So Kull forgot the death-threat of Thulsa Doom the necromancer and went to Delcardes. Kull was skeptical and Tu was wary and suspicious without knowing why, but years of counter-plot and intrigue had soured him. He swore testily that a talking cat was a snare and a fraud, a swindle and a delusion and maintained that should such a thing exist, it was a direct insult to the gods, who ordained that only man should enjoy the power of speech.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (4, 'The Curse of the Golden Skull', NULL, '1967-01-01T00:00:00', NULL, 1, '2063-01-01T00:00:00', 'Rotath of Lemuria was dying. Blood had ceased to flow from the deep sword gash under his heart, but the pulse in his temple hammered like kettle drums. Rotath lay on a marble floor. Granite columns rose about him and a silver idol stared with ruby eyes at the man who lay at its feet. The bases of the columns were carved with curious monsters; above the shrine sounded a vague whispering. The trees which hemmed in and hid that mysterious fane spread long waving branches above it, and the branches were vibrant with curious leaves which rustled in the wind. From time to time great black roses scattered their dusky petals down. Rotath lay dying and he used his fading breath in calling down curses on his slayers — on the faithless king who had betryed him, and on that barbarian chief, Kull of Atlantis, who dealt him the death blow.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (5, 'Exile of Atlantis (untitled story)', NULL, '1967-01-01T00:00:00', NULL, 1, '2063-01-01T00:00:00', 'The sun was setting. A last crimson glory filled the land and lay like a crown of blood on the snow sprinkled peaks. The three men who watched the death of the day breathed deep the fragrance of the early wind which stole up out of the distant forests, and then turned to a task more material. One of the men was cooking venison over a small fire and this man, touching a finger to the smoking viand, tasted with the air of a connoisseur. \"All ready, Kull — Gor-na — let us eat.\"', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (6, 'Kings of the Night', 'http://gutenberg.net.au/ebooks06/0607311h.html', '1930-01-01T00:00:00', NULL, 1, '2026-01-01T00:00:00', 'The dagger flashed downward. A sharp cry broke in a gasp. The form on the rough altar twitched convulsively and lay still. The jagged flint edge sawed at the crimsoned breast, and thin bony fingers, ghastly dyed, tore out the still twitching heart. Under matted white brows, sharp eyes gleamed with a ferocious intensity. Besides the slayer, four men stood about the crude pile of stones that formed the altar of the God of Shadows.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (7, 'The Mirrors of Tuzun Thune', 'http://gutenberg.net.au/ebooks06/0603481h.html', '1929-09-01T00:00:00', NULL, 0, NULL, 'There comes, even to kings, the time of great weariness. Then the gold of the throne is brass, the silk of the palace becomes drab. The gems in the diadem and upon the fingers of the women sparkle drearily like the ice of the white seas; the speech of men is as the empty rattle of a jester\'s bell and the feel comes of things unreal; even the sun is copper in the sky and the breath of the green ocean is no longer fresh. Kull sat upon the throne of Valusia and the hour of weariness was upon him. They moved before him in an endless, meaningless panorama, men, women, priests, events and shadows of events; things seen and things to be attained. But like shadows they came and went, leaving no trace upon his consciousness, save that of a great mental fatigue. Yet Kull was not tired. There was a longing in him for things beyond himself and beyond the Valusian court. An unrest stirred in him and strange, luminous dreams roamed his soul.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (8, 'The Screaming Skull of Silence', NULL, '1967-01-01T00:00:00', 'The Skull of Silence', 1, '2063-01-01T00:00:00', 'Men still name it The Day of the King\'s Fear. For Kull, king of Valusia, was only a man after all. There was never a bolder man, but all things have their limits, even courage. Of course Kull had known apprehension and cold whispers of dread, sudden starts of horror and even the shadow of unknown terror. But these had been but starts and leapings in the shadows of the mind, caused mainly by surprize or some loathsome mystery or unnatural thing — more repugnance than real fear. So real fear in him was so rare a thing that men mark the day.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (9, 'The Shadow Kingdom', 'http://gutenberg.net.au/ebooks06/0603491h.html', '1929-09-01T00:00:00', NULL, 0, NULL, 'The blare of the trumpets grew louder, like a deep golden tide surge, like the soft booming of the evening tides against the silver beaches of Valusia. The throng shouted, women flung roses from the roofs as the rhythmic chiming of silver hoofs came clearer and the first of the mighty array swung into view in the broad white street that curved round the golden-spired Tower of Splendor.First came the trumpeters, slim youths, clad in scarlet, riding with a flourish of long, slender golden trumpets; next the bowmen, tall men from the mountains; and behind these the heavily armed footmen, their broad shields clashing in unison, their long spears swaying in perfect rhythm to their stride. Behind them came the mightiest soldiery in all the world, the Red Slayers, horsemen, splendidly mounted, armed in red from helmet to spur. Proudly they sat their steeds, looking neither to right nor to left, but aware of the shouting for all that. Like bronze statues they were, and there was never a waver in the forest of spears that reared above them.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (10, 'The Striking of the Gong', NULL, '1967-01-01T00:00:00', NULL, 1, '2063-01-01T00:00:00', 'Somewhere in the hot red darkness there began a throbbing. A pulsating cadence, soundless but vibrant with reality, sent out long rippling tendrils that flowed through the breathless air. The man stirred, groped about with blind hands, and sat up. At first it seemed to him that he was floating on the even and regular waves of a black ocean, rising and falling with a monotonous regularity which hurt him physically somehow. He was aware of the pulsing and throbbing of the air and he reached out his hands as though to catch the elusive waves. But was the throbbing in the air about him, or in the brain inside his skull? He could not understand and a fantastic thought came to him — a feeling that he was locked inside his own skull.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (11, 'Swords of the Purple Kingdom', NULL, '1967-01-01T00:00:00', NULL, 1, '2063-01-01T00:00:00', 'A sinister quiet lay like a shroud over the ancient city of Valusia. The heat waves danced from roof to shining roof and shimmered against the smooth marble walls. The purple towers and golden spires were softened in the faint haze. No ringing hoofs on the wide paved streets broke the drowsy silence and the few pedestrians who appeared walking, did what they had to do hastily and vanished indoors again. The city seemed like a realm of ghosts.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (12, 'Black Colossus', 'http://gutenberg.net.au/ebooks06/0600931h.html', '1934-01-01T00:00:00', NULL, 0, NULL, 'Only the age-old silence brooded over the mysterious ruins of Kuthchemes, but Fear was there; Fear quivered in the mind of Shevatas, the thief, driving his breath quick and sharp against his clenched teeth. He stood, the one atom of life amidst the colossal monuments of desolation and decay. Not even a vulture hung like a black dot in the vast blue vault of the sky that the sun glazed with its heat. On every hand rose the grim relics of another, forgotten age: huge broken pillars, thrusting up their jagged pinnacles into the sky; long wavering lines of crumbling walls; fallen cyclopean blocks of stone; shattered images, whose horrific features the corroding winds and dust-storms had half erased. From horizon to horizon no sign of life: only the sheer breathtaking sweep of the naked desert, bisected by the wandering line of a long-dry river course; in the midst of that vastness the glimmering fangs of the ruins, the columns standing up like broken masts of sunken ships—all dominated by the towering ivory dome before which Shevatas stood trembling.', 'A mighty story of the wizard Natohk, and red battle, and stupendous deeds — a tale of a barbarian mercenary who was called upon to save a nation from shuddery evil.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (13, 'The Devil in Iron', 'http://gutenberg.net.au/ebooks06/0600801h.html', '1934-01-01T00:00:00', NULL, 0, NULL, 'The fisherman loosened his knife in its scabbard. The gesture was instinctive, for what he feared was nothing a knife could slay, not even the saw-edged crescent blade of the Yuetshi that could disembowel a man with an upward stroke. Neither man nor beast threatened him in the solitude which brooded over the castellated isle of Xapur. He had climbed the cliffs, passed through the jungle that bordered them, and now stood surrounded by evidences of a vanished state. Broken columns glimmered among the trees, the straggling lines of crumbling walls meandered off into the shadows, and under his feet were broad paves, cracked and bowed by roots growing beneath.', 'A mythical demon and its ancient fortress are resurrected after the theft of a sacred dagger, and Conan is tricked into landing on the island, with many unexpected consequences in store.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (14, 'The Frost-Giant\'s Daughter', 'http://gutenberg.net.au/ebooks06/0600751h.html', '1934-03-01T00:00:00', 'Gods of the North', 0, NULL, 'The clangor of the swords had died away, the shouting of the slaughter was hushed; silence lay on the red-stained snow. The pale bleak sun that glittered so blindingly from the ice-fields and the snow-covered plains struck sheens of silver from rent corselet and broken blade, where the dead lay in heaps. The nerveless hand yet gripped the broken hilt; helmeted heads, back-drawn in the death throes, tilted red beards and golden beards grimly upward, as if in last invocation to Ymir the frost-giant. Across the red drifts and mail-clad forms, two figures approached one another. In that utter desolation only they moved. The frosty sky was over them, the white illimitable plain around them, the dead men at their feet. Slowly through the corpses they came, as ghosts might come to a tryst through the shambles of a world.', 'The clangor of the swords had died away, the shouting of the slaughter was hushed; silence lay on the red-stained snow. The bleak pale sun that glittered so blindingly from the ice-fields and the snow-covered plains struck sheens of silver from rent corselet and broken blade, where the dead lay as they had fallen. The nerveless hand yet gripped the broken hilt; helmeted heads back-drawn in the death-throes, tilted red beards and golden beards grimly upward, as if in last invocation to Ymir the frost-giant, god of a warrior-race.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (15, 'The God in the Bowl', 'http://gutenberg.net.au/ebooks15/1501131h.html', '1952-01-01T00:00:00', NULL, 1, '2052-01-01T00:00:00', 'Arus the watchman grasped his crossbow with shaky hands, and he felt beads of clammy perspiration on his skin as he stared at the unlovely corpse sprawling on the polished floor before him. It is not pleasant to come upon Death in a lonely place at midnight. Arus stood in a vast corridor, lighted by huge candles in niches along the walls. These walls were hung with black velvet tapestries, and between the tapestries hung shields and crossed weapons of fantastic make. Here and there, too, stood figures of curious gods—images carved of stone or rare wood, or cast of bronze, iron or silver—mirrored in the gleaming black mahogany floor. Arus shuddered; he had never become used to the place, although he had worked there as watchman for some months. It was a fantastic establishment, the great museum and antique house which men called Kallian Publico\'s Temple, with its rarities from all over the world—and now, in the lonesomeness of midnight, Arus stood in the great silent hall and stared at the sprawling corpse that had been the rich and powerful owner of the Temple.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (16, 'Iron Shadows in the Moon', 'http://gutenberg.net.au/ebooks06/0600971h.html', '1934-04-01T00:00:00', 'Shadows in the Moonlight', 0, NULL, 'A swift crashing of horses through the tall reeds; a heavy fall, a despairing cry. From the dying steed there staggered up its rider, a slender girl in sandals and girdled tunic. Her dark hair fell over her white shoulders, her eyes were those of a trapped animal. She did not look at the jungle of reeds that hemmed in the little clearing, nor at the blue waters that lapped the low shore behind her. Her wide-eyed gaze was fixed in agonized intensity on the horseman who pushed through the reedy screen and dismounted before her. He was a tall man, slender, but hard as steel. From head to heel he was clad in light silvered mesh-mail that fitted his supple form like a glove. From under the dome-shaped, gold-chased helmet his brown eyes regarded her mockingly. \"Stand back!\" her voice shrilled with terror. \"Touch me not, Shah Amurath, or I will throw myself into the water and drown!\" He laughed, and his laughter was like the purr of a sword sliding from a silken sheath.', '\"Shadows in the Moonlight\" is one of the original short stories starring the fictional sword and sorcery hero Conan the Cimmerian, written by American author Robert E. Howard and first published in Weird Tales magazine in April 1934. Howard originally named his story \"Iron Shadows in the Moon\". It is set in the pseudo-historical Hyborian Age and concerns Conan escaping to a remote island in the Vilayet Sea where he encounters the Red Brotherhood, a skulking creature, and mysterious iron statues.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (17, 'The Phoenix on the Sword', 'http://gutenberg.net.au/ebooks06/0600811h.html', '1932-04-01T00:00:00', NULL, 0, NULL, 'Over shadowy spires and gleaming towers lay the ghostly darkness and silence that runs before dawn. Into a dim alley, one of a veritable labyrinth of mysterious winding ways, four masked figures came hurriedly from a door which a dusky hand furtively opened. They spoke not but went swiftly into the gloom, cloaks wrapped closely about them; as silently as the ghosts of murdered men they disappeared in the darkness. Behind them a sardonic countenance was framed in the partly opened door; a pair of evil eyes glittered malevolently in the gloom. \"Go into the night, creatures of the night,\" a voice mocked. \"Oh, fools, your doom hounds your heels like a blind dog, and you know it not.\"', 'A soul-searing story of a fearsome monster spawned in darkness before the first man crawled out of the slimy sea.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (18, 'The Pool of the Black One', 'http://gutenberg.net.au/ebooks06/0600951h.html', '1934-04-01T00:00:00', NULL, 0, NULL, 'Sancha, once of Kordava, yawned daintily, stretched her supple limbs luxuriously, and composed herself more comfortably on the ermine-fringed silk spread on the carack\'s poop-deck. That the crew watched her with burning interest from waist and forecastle she was lazily aware, just as she was also aware that her short silk kirtle veiled little of her voluptuous contours from their eager eyes. Wherefore she smiled insolently and prepared to snatch a few more winks before the sun, which was just thrusting his golden disk above the ocean, should dazzle her eyes. But at that instant a sound reached her ears unlike the creaking of timbers, thrum of cordage and lap of waves. She sat up, her gaze fixed on the rail, over which, to her amazement, a dripping figure clambered. Her dark eyes opened wide, her red lips parted in an O of surprize. The intruder was a stranger to her. Water ran in rivulets from his great shoulders and down his heavy arms. His single garment—a pair of bright crimson silk breeks—was soaking wet, as was his broad gold-buckled girdle and the sheathed sword it supported. As he stood at the rail, the rising sun etched him like a great bronze statue. He ran his fingers through his streaming black mane, and his blue eyes lit as they rested on the girl.', 'One of the strangest stories ever told — a tale of black giants, and the blood-freezing horror that awaited the buccaneers at the jade-green pool.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (19, 'Queen of the Black Coast', 'http://gutenberg.net.au/ebooks06/0600961h.html', '1934-05-01T00:00:00', NULL, 0, NULL, 'Hoofs drummed down the street that sloped to the wharfs. The folk that yelled and scattered had only a fleeting glimpse of a mailed figure on a black stallion, a wide scarlet cloak flowing out on the wind. Far up the street came the shout and clatter of pursuit, but the horseman did not look back. He swept out onto the wharfs and jerked the plunging stallion back on its haunches at the very lip of the pier. Seamen gaped up at him, as they stood to the sweep and striped sail of a high-prowed, broad-waisted galley. The master, sturdy and black-bearded, stood in the bows, easing her away from the piles with a boat-hook. He yelled angrily as the horseman sprang from the saddle and with a long leap landed squarely on the mid-deck. \"Who invited you aboard?\" \"Get under way!” roared the intruder with a fierce gesture that spattered red drops from his broadsword. \"But we’re bound for the coasts of Cush!” expostulated the master. \"Then I’m for Cush! Push off, I tell you!” The other cast a quick glance up the street, along which a squad of horse-men were galloping; far behind them toiled a group of archers, crossbows on their shoulders. \"Can you pay for your passage?” demanded the master. \"I pay my way with steel!” roared the man in armor, brandishing the great sword that glittered bluely in the sun. \"By Crom, man, if you don’t get under way. I’ll drench this galley in the blood of its crew!”', 'A weird story of Conan the barbarian, and a savage white woman who captained a pirate ship, and a ghastly horror in the jungle.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (20, 'Rogues in the House', 'http://gutenberg.net.au/ebooks06/0600781h.html', '1935-01-01T00:00:00', NULL, 0, NULL, 'At a court festival, Nabonidus, the Red Priest, who was the real ruler of the city, touched Murilo, the young aristocrat, courteously on the arm. Murilo turned to meet the priest\'s enigmatic gaze, and to wonder at the hidden meaning therein. No words passed between them, but Nabonidus bowed and handed Murilo a small gold cask. The young nobleman, knowing that Nabonidus did nothing without reason, excused himself at the first opportunity and returned hastily to his chamber. There he opened the cask and found within a human ear, which he recognized by a peculiar scar upon it. He broke into a profuse sweat and was no longer in doubt about the meaning in the Red Priest\'s glance. But Murilo, for all his scented black curls and foppish apparel was no weakling to bend his neck to the knife without a struggle. He did not know whether Nabonidus was merely playing with him or giving him a chance to go into voluntary exile, but the fact that he was still alive and at liberty proved that he was to be given at least a few hours, probably for meditation. However, he needed no meditation for decision; what he needed was a tool. And Fate furnished that tool, working among the dives and brothels of the squalid quarters even while the young nobleman shivered and pondered in the part of the city occupied by the purple-towered marble and ivory palaces of the aristocracy.', '\"Rogues in the House\" is one of the original short stories starring the fictional sword and sorcery hero Conan the Cimmerian, written by American author Robert E. Howard and first published in Weird Tales magazine circa January 1934. It is set in the pseudo-historical Hyborian Age and concerns Conan inadvertently becoming involved in the power play between two powerful men fighting for control of a city. It was the seventh Conan story Howard had published.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (21, 'The Scarlet Citadel', 'http://gutenberg.net.au/ebooks06/0600821h.html', '1933-01-01T00:00:00', NULL, 0, NULL, 'The roar of battle had died away; the shout of victory mingled with the cries of the dying. Like gay-hued leaves after an autumn storm, the fallen littered the plain; the sinking sun shimmered on burnished helmets, gilt-worked mail, silver breastplates, broken swords and the heavy regal folds of silken standards, overthrown in pools of curdling crimson. In silent heaps lay war-horses and their steel-clad riders, flowing manes and blowing plumes stained alike in the red tide. About them and among them, like the drift of a storm, were strewn slashed and trampled bodies in steel caps and leather jerkins—archers and pikemen. The oliphants sounded a fanfare of triumph all over the plain, and the hoofs of the victors crunched in the breasts of the vanquished as all the straggling, shining lines converged inward like the spokes of a glittering wheel, to the spot where the last survivor still waged unequal strife. That day Conan, king of Aquilonia, had seen the pick of his chivalry cut to pieces, smashed and hammered to bits, and swept into eternity.', 'A shuddery story of weird monstrosities in the underground crypts of Tsotha-lanti the magician — a tale of eery powers and red battle.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (22, 'The Tower of the Elephant', 'http://gutenberg.net.au/ebooks06/0600831h.html', '1933-01-01T00:00:00', NULL, 0, NULL, 'Torches flared murkily on the revels in the Maul, where the thieves of the east held carnival by night. In the Maul they could carouse and roar as they liked, for honest people shunned the quarters, and watchmen, well paid with stained coins, did not interfere with their sport. Along the crooked, unpaved streets with their heaps of refuse and sloppy puddles, drunken roisterers staggered, roaring. Steel glinted in the shadows where wolf preyed on wolf, and from the darkness rose the shrill laughter of women, and the sounds of scufflings and strugglings. Torchlight licked luridly from broken windows and wide-thrown doors, and out of those doors, stale smells of wine and rank sweaty bodies, clamor of drinking-jacks and fists hammered on rough tables, snatches of obscene songs, rushed like a blow in the face. In one of these dens merriment thundered to the low smoke-stained roof, where rascals gathered in every stage of rags and tatters—furtive cut-purses, leering kidnappers, quick-fingered thieves, swaggering bravoes with their wenches, strident-voiced women clad in tawdry finery. Native rogues were the dominant element—dark-skinned, dark-eyed Zamorians, with daggers at their girdles and guile in their hearts. But there were wolves of half a dozen outland nations there as well. There was a giant Hyperborean renegade, taciturn, dangerous, with a broadsword strapped to his great gaunt frame—for men wore steel openly in the Maul. There was a Shemitish counterfeiter, with his hook nose and curled blue­black beard. There was a bold-eyed Brythunian wench, sitting on the knee of a tawny-haired Gunderman—a wandering mercenary soldier, a deserter from some defeated army. And the fat gross rogue whose bawdy jests were causing all the shouts of mirth was a professional kidnapper come up from distant Koth to teach woman-stealing to Zamorians who were born with more knowledge of the art than he could ever attain.', 'A strange, blood-freezing story of an idol that wept on its throne, and a valiant barbarian from the fringes of an elder civilization.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (23, 'The Vale of the Lost Women', NULL, '1967-01-01T00:00:00', NULL, 1, '2063-01-01T00:00:00', 'The thunder of the drums and the great elephant-tusk horns was deafening, but in Livia’s\nears the clamor seemed but a confusing muttering, dull and far away. As she lay on the\nangareb in the great hut, her state bordering between delirium and semi-unconsciousness.\nOutward sounds and movements scarcely impinged upon her senses. Her whole mental\nvision, though dazed and chaotic, was yet centered with hideous certitude on the naked,\nwrithing figure of her brother, blood streaming down his quivering thighs. Against a dim\nnightmare background of dusky interweaving shapes and shadows, that white form was\nlimned in merciless and awful clarity. The air seemed still to pulsate with an agonized\nscreaming, mingled and interwoven obscenely with a rustle of fiendish laughter. She was not conscious of sensation as an individual, separate and distinct from the rest of\nthe cosmos. She was drowned in a great gulf of pain—was herself but pain crystallized\nand manifested in flesh. So she lay without conscious thought or motion, while outside\nthe drums bellowed, the horns clamored, and barbaric voices lifted hideous chants,\nkeeping time to naked feet slapping the hard earth and open palms smiting one another\nsoftly.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (24, 'Xuthal of the Dusk', 'http://gutenberg.net.au/ebooks06/0601051h.html', '1934-01-01T00:00:00', 'The Slithering Shadow', 0, NULL, 'The desert shimmered in the heat waves. Conan the Cimmerian stared out over the aching desolation and involuntarily drew the back of his powerful hand over his blackened lips. He stood like a bronze image in the sand, apparently impervious to the murderous sun, though his only garment was a silk loin-cloth, girdled by a wide gold-buckled belt from which hung a saber and a broad-bladed poniard. On his clean-cut limbs were evidences of scarcely healed wounds. At his feet rested a girl, one white arm clasping his knee, against which her blond head drooped. Her white skin contrasted with his hard bronzed limbs; her short silken tunic, lownecked and sleeveless, girdled at the waist, emphasized rather than concealed her lithe figure. Conan shook his head, blinking. The sun\'s glare half blinded him. He lifted a small canteen from his belt and shook it, scowling at the faint splashing within.', 'A mighty story of a barbarian adventurer, and the ravening monstrosity that slunk through the dark corridors of Xuthal in search of its human prey.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (25, 'The Blue Flame of Vengeance', NULL, '1967-01-01T00:00:00', 'Blades of the Brotherhood', 1, '2063-01-01T00:00:00', 'The blades crossed with a sharp clash of venomous steel; blue sparks showered. Across those blades hot eyes and volcanic blue ones. Breath hissed between close locked teeth; feet scruffed the sward, advancing, retreating. He of the black eyes feinted and thrust as quick as a snake strikes. The blue-eyed youth parried with a half turn of a steely wrist and his counter stroke was like the flash of summer lightning.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (26, 'The Footfalls Within', 'http://gutenberg.net.au/ebooks06/0600861h.html', '1931-01-01T00:00:00', NULL, 1, '2027-01-01T00:00:00', 'Solomon Kane gazed somberly at the black woman who lay dead at his feet. Little more than a girl she was, but her wasted limbs and staring eyes showed that she had suffered much before death brought her merciful relief. Kane noted the chain galls on her limbs, the deep crisscrossed scars on her back, the mark of the yoke on her neck. His cold eyes deeped strangely, showing chill glints and lights like clouds passing across depths of ice. \"Even into this lonesome land they come,\" he muttered. \"I had not thought —\" He raised his head and gazed eastward. Black dots against the blue wheeled and circled.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (27, 'The Hills of the Dead', 'http://gutenberg.net.au/ebooks06/0600871h.html', '1930-01-01T00:00:00', NULL, 1, '2026-01-01T00:00:00', 'The twigs which N\'Longa flung on the fire broke and crackled. The upleaping flames lighted the countenances of the two men. N\'Longa, voodoo man of the Slave Coast, was very old. His wizened and gnarled frame was stooped and brittle, his face creased by hundreds of wrinkles. The red firelight glinted on the human finger-bones which composed his necklace. The other was a white man and his name was Solomon Kane. He was tall and broad-shouldered, clad in black close garments, the garb of the Puritan. His featherless slouch hat was drawn low over his heavy brows, shadowing his darkly pallid face. His cold deep eyes brooded in the firelight.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (28, 'The Moon of Skulls', 'http://gutenberg.net.au/ebooks06/0600841h.html', '1930-01-01T00:00:00', NULL, 1, '2026-01-01T00:00:00', 'A great black shadow lay across the land, cleaving the red flame of the sunset. To the man who toiled up the jungle trail it loomed like a symbol of death and horror, a menace brooding and terrible, like the shadow of a stealthy assassin flung upon some candle-lit wall. Yet it was only the shadow of the great crag which reared up in front of him, the first outpost of the grim foothills which were his goal. He halted a moment at its foot, staring upward where it rose blackly limned against the dying sun. He coule have sworn that he caught the hint of a movement at the top, as he stared, hand shielding his eyes, bu tthe fading glare dazzled him and he could not be sure. Was it a man who darted to cover? A man, or —?', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (29, 'Rattle of Bones', 'http://gutenberg.net.au/ebooks06/0607321h.html', '1929-06-01T00:00:00', NULL, 0, NULL, 'Landlord, ho!\" The shout broke the lowering silence and reverberated through the black forest with sinister echoing. \"This place hath a forbidding aspect, meseemeth.\" Two men stood in front of the forest tavern. The building was low, long and rambling, built of heavy logs. Its small windows were heavily barred and the door was closed. Above the door its sinister sign showed faintly--a cleft skull. This door swung slowly open and a bearded face peered out. The owner of the face stepped back and motioned his guests to enter--with a grudging gesture it seemed. A candle gleamed on a table; a flame smoldered in the fireplace. \"Your names?\" \"Solomon Kane,\" said the taller man briefly. \"Gaston l\'Armon,\" the other spoke curtly. \"But what is that to you?\" \"Strangers are few in the Black Forest,\" grunted the host, \"bandits many. Sit at yonder table and I will bring food.\" The two men sat down, with the bearing of men who have traveled far. One was a tall gaunt man, clad in a featherless hat and somber black garments, which set off the dark pallor of his forbidding face. The other was of a different type entirely, bedecked with lace and plumes, although his finery was somewhat stained from travel. He was handsome in a bold way, and his restless eyes shifted from side to side, never still an instant.', 'First published in Weird Tales, June 1929. In Germany Kane meets a traveler named Gaston L\'Armon, who seems familiar to Kane, and together they take rooms in the Cleft Skull Tavern.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (30, 'Red Shadows', 'http://gutenberg.net.au/ebooks06/0607331h.html', '1928-08-01T00:00:00', NULL, 0, NULL, 'The moonlight shimmered hazily, making silvery mists of illusion among the shadowy trees. A faint breeze whispered down the valley, bearing a shadow that was not of the moon-mist. A faint scent of smoke was apparent. The man whose long, swinging strides, unhurried yet unswerving, had carried him for many a mile since sunrise, stopped suddenly. A movement in the trees had caught his attention, and he moved silently toward the shadows, a hand resting lightly on the hilt of his long, slim rapier. Warily he advanced, his eyes striving to pierce the darkness that brooded under the trees. This was a wild and menacing country; death might be lurking under those trees. Then his hand fell away from the hilt and he leaned forward. Death indeed was there, but not in such shape as might cause him fear. \"The fires of Hades!\" he murmured. \"A girl! What has harmed you, child? Be not afraid of me.\"\nThe girl looked up at him, her face like a dim white rose in the dark. \"You--who are--you?\" her words came in gasps. \"Naught but a wanderer, a landless man, but a friend to all in need.\" The gentle voice sounded somehow incongruous, coming from the man. The girl sought to prop herself up on her elbow, and instantly he knelt and raised her to a sitting position, her head resting against his shoulder. His hand touched her breast and came away red and wet. \"Tell me.\" His voice was soft, soothing, as one speaks to a babe. \"Le Loup,\" she gasped, her voice swiftly growing weaker. \"He and his men--descended upon our village--a mile up the valley. They robbed--slew--burned--\" \"That, then, was the smoke I scented,\" muttered the man. \"Go on, child.\" \"I ran. He, the Wolf, pursued me--and--caught me--\" The words died away in a shuddering silence. \"I understand, child. Then--?\" \"Then--he--he--stabbed me--with his dagger--oh, blessed saints!--mercy--\" Suddenly the slim form went limp. The man eased her to the earth, and touched her brow lightly. \"Dead!\" he muttered. Slowly he rose, mechanically wiping his hands upon his cloak. A dark scowl had settled on his somber brow. Yet he made no wild, reckless vow, swore no oath by saints or devils. \"Men shall die for this,\" he said coldly.', 'Red Shadows is the first of a series of stories featuring Howard\'s puritan avenger, Solomon Kane. Kane tracks his prey over land and sea, enters the jungles of Africa, and even faces dark Gods and evil magic -- all to avenge a woman he\'d never met before.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (31, 'The Right Hand of Doom', NULL, '1968-01-01T00:00:00', NULL, 1, '2064-01-01T00:00:00', 'And he hangs at dawn! Ho! Ho!\" The speaker smote his thigh resoundingly and laughed in a high-pitched grating voice. He glanced boastfully at his hearers, and gulped the wine which stood at his elbow. The fire leaped and flickered in the tap0room fireplace and no one answered him. \"Roger Simeon, the necromancer!\" sneered the grating voice. \"A dealer in the diabolic arts and a worker of black magic! My word, all his foul power could not save him when the king\'s soldiers surrounded his cave and took him prisoner. He fled when the people began to fling cobble stones at his windows, and thought to hide himself and escape to France. Ho! Ho! His escape shall be at the end of a noose. A good day\'s work, say I.\"', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (32, 'Skulls in the Stars', 'http://gutenberg.net.au/ebooks06/0600851h.html', '1929-01-01T00:00:00', NULL, 0, NULL, 'There are two roads to Torkertown. One, the shorter and more direct route, leads across a barren upland moor, and the other, which is much longer, winds its tortuous way in and out among the hummocks and quagmires of the swamps, skirting the low hills to the east. It was a dangerous and tedious trail; so Solomon Kane halted in amazement when a breathless youth from the village he had just left overtook him and implored him for God\'s sake to take the swamp road. “The swamp road!” Kane stared at the boy. He was a tall, gaunt man, Solomon Kane, his darkly pallid face and deep brooding eyes made more sombre by the drab Puritanical garb he affected. “Yes, sir, \'tis far safer,” the youngster answered to his surprised exclamation. “Then the moor road must be haunted by Satan himself, for your townsmen warned me against traversing the other.” “Because of the quagmires, sir, that you might not see in the dark. You had better return to the village and continue your journey in the morning, sir.” “Taking the swamp road?” “Yes, sir.” Kane shrugged his shoulders and shook his head. “The moon rises almost as soon as twilight dies. By its light I can reach Torkertown in a few hours, across the moor.”', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (33, 'Wings in the Night', 'http://gutenberg.net.au/ebooks06/0600881h.html', '1932-01-01T00:00:00', NULL, 1, '2028-01-01T00:00:00', 'Solomon Kane leaned on his strangley carved staff and gazed in scowling perplexity at the mystery which spread silently before him. Many a deserted village Kane had seen in the months that had passed since he turned his face east from the Slave Coast and lost himself in the mazes of jungle and river, but never one like this. It was not famine that had driven away the inhabitants, for yonder the wild rice still grew rank and unkempt in the untilled fields. There were no Arab slave-raiders in this nameless land — it must have been a tribal war that devastated the village, Kane decided, as he gazed somberly at the scattered bones and grinning skulls that littered the space among the rank weeds and grasses. These bones were shattered and splintered and Kane saw jackals and a hyena furtively slinking among the ruined huts. Bu why had the slayers left the spoils?', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (34, 'The Hour of the Dragon', 'http://gutenberg.net.au/ebooks06/0600981h.html', '1935-12-01T00:00:00', 'Conan the Conqueror', 0, NULL, 'The long tapers flickered, sending the black shadows wavering along the walls, and the velvet tapestries rippled. Yet there was no wind in the chamber. Four men stood about the ebony table on which lay the green sarcophagus that gleamed like carven jade. In the upraised right hand of each man a curious black candle burned with a weird greenish light. Outside was night and a lost wind moaning among the black trees.\nInside the chamber was tense silence, and the wavering of the shadows, while four pairs of eyes, burning with intensity, were fixed on the long green case across which cryptic hieroglyphics writhed, as if lent life and movement by the unsteady light. The man at the foot of the sarcophagus leaned over it and moved his candle as if he were writing with a pen, inscribing a mystic symbol in the air. Then he set down the candle in its black gold stick at the foot of the case, and, mumbling some formula unintelligible to his companions, he thrust a broad white hand into his fur-trimmed robe. When he brought it forth again it was as if he cupped in his palm a ball of living fire. The other three drew in their breath sharply, and the dark, powerful man who stood at the head of the sarcophagus whispered: \"The Heart of Ahriman!\" The other lifted a quick hand for silence. Somewhere a dog began howling dolefully, and a stealthy step padded outside the barred and bolted door. But none looked aside from the mummy-case over which the man in the ermine-trimmed robe was now moving the great flaming jewel while he muttered an incantation that was old when Atlantis sank. The glare of the gem dazzled their eyes, so that they could not be sure of what they saw; but with a splintering crash, the carven lid of the sarcophagus burst outward as if from some irresistible pressure applied from within, and the four men, bending eagerly forward, saw the occupant -- a huddled, withered, wizened shape, with dried brown limbs like dead wood showing through moldering bandages.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (35, 'The People of the Black Circle', 'http://gutenberg.net.au/ebooks06/0600941h.html', '1935-09-01T00:00:00', NULL, 0, NULL, 'The king of Vendhya was dying. Through the hot, stifling night the temple gongs boomed and the conchs roared. Their clamor was a faint echo in the gold-domed chamber where Bunda Chand struggled on the velvet-cushioned dais. Beads of sweat glistened on his dark skin; his fingers twisted the gold-worked fabric beneath him. He was young; no spear had touched him, no poison lurked in his wine. But his veins stood out like blue cords on his temples, and his eyes dilated with the nearness of death. Trembling slave-girls knelt at the foot of the dais, and leaning down to him, watching him with passionate intensity, was his sister, the Devi Yasmina. With her was the wazam, a noble grown old in the royal court. She threw up her head in a gusty gesture of wrath and despair as the thunder of the distant drums reached her ears. \"The priests and their clamor!\" she exclaimed. \"They are no wiser than the leeches who are helpless! Nay, he dies and none can say why. He is dying now—and I stand here helpless, who would burn the whole city and spill the blood of thousands to save him.\" \"Not a man of Ayodhya but would die in his place, if it might be, Devi,\" answered the wazam. \"This poison——\" \"I tell you it is not poison!\" she cried. \"Since his birth he has been guarded so closely that the cleverest poisoners of the East could not reach him. Five skulls bleaching on the Tower of the Kites can testify to attempts which were made—and which failed. As you well know, there are ten men and ten women whose sole duty is to taste his food and wine, and fifty armed warriors guard his chamber as they guard it now. No, it is not poison; it is sorcery—black, ghastly magic——\"', 'A stupendous story of Conan the barbarian soldier of fortune, and a tremendous adventure in the castle of the Black Seers.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (36, 'A Witch Shall Be Born', 'http://gutenberg.net.au/ebooks06/0600921h.html', '1934-12-01T00:00:00', NULL, 0, NULL, 'Taramis, Queen of Khauran, awakened from a dream-haunted slumber to a silence that seemed more like the stillness of nighted catacombs than the normal quiet of a sleeping palace. She lay staring into the darkness, wondering why the candles in their golden candelabra had gone out. A flecking of stars marked a gold-barred casement that lent no illumination to the interior of the chamber. But as Taramis lay there, she became aware of a spot of radiance glowing in the darkness before her. She watched, puzzled. It grew and its intensity deepened as it expanded, a widening disk of lurid light hovering against the dark velvet hangings of the opposite wall. Taramis caught her breath, starting up to a sitting position. A dark object was visible in that circle of light—a human head. In a sudden panic the queen opened her lips to cry out for her maids; then she checked herself. The glow was more lurid, the head more vividly limned. It was a woman\'s head, small, delicately molded, superbly poised, with a high-piled mass of lustrous black hair. The face grew distinct as she stared—and it was the sight of this face which froze the cry in Taramis\' throat. The features were her own! She might have been looking into a mirror which subtly altered her reflection, lending it a tigerish gleam of eye, a vindictive curl of lip. \"Ishtar!\" gasped Taramis. \"I am bewitched!\" Appallingly, the apparition spoke, and its voice was like honeyed venom. \"Bewitched? No, sweet sister! Here is no sorcery.\"', 'A vivid weird novelette of uncanny power and fascinating episodes — a tale of the old, forgotten times.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (37, 'The Children of the Night', 'http://gutenberg.net.au/ebooks06/0607961h.html', NULL, NULL, NULL, NULL, 'There were, I remember, six of us in Conrad\'s bizarrely fashioned study, with its queer relics from all over the world and its long rows of books which ranged from the Mandrake Press edition of Boccaccio to a Missale Romanum, bound in clasped oak boards and printed in Venice, 1740. Clemants and Professor Kirowan had just engaged in a somewhat testy anthropological argument: Clemants upholding the theory of a separate, distinct Alpine race, while the professor maintained that this so-called race was merely a deviation from an original Aryan stock — possibly the result of an admixture between the southern or Mediterranean races and the Nordic people.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (38, 'The Dark Man', 'http://gutenberg.net.au/ebooks06/0608071h.html', NULL, NULL, NULL, NULL, 'A biting wind drifted the snow as it feel. The surf snarled along the rugged shore and farther out the long leaden combers moaned ceaselessly. Through the gray dawn that was stealing over the coast of Connacht a fisherman came trudging, a man rugged as the land that bore him. His feet were wrapped in rough cured leather; a single garment of deerskin scantily sheltered his body. He wore no other clothing. As he strode stolidly along the shore, as heedless of the bitter cold as if he were the shaggy beast he appeared at first glance, he halted. Another man loomed up out of the veil of falling snow and drifting sea-mist. Turlogh Dubh stood before him', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (39, 'The Little People', NULL, NULL, NULL, NULL, NULL, 'My sister threw down the book she was reading. To be exact, she threw it at me. \"Foolishness!\" said she. \"Fairy tales! Hand me that copy of Michael Arlen.\" I do so mechanically, glancing at the volum which had incurred her youthful displeasure. The story was \"The Shining Pyramid\" by Arthur Machen. \"My dear girl,\" said I, \"this is a masterpiece of outre literature.\" \"Yes, but the idea!\" she answered. \"I outgrew fairy tales when I was ten.\" \"This tale is not intended as an exponent of common-day realism,\" I explained patiently. \"Too far-fetched,\" she said with the finality of seventeen. \"I like to read about things that could happen — who were \'The Little People\' he speaks of, the same old elf and troll business?\" \"All legends have a base of fact,\" I said. \"There is a reason —\" \"You mean to tell me such things actually existed?\" she exclaimed. \"Rot!\"', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (40, 'The Lost Race', NULL, NULL, NULL, NULL, NULL, 'Cororuc glanced about him and hastened his pace. He was no coward, but he did not like the place. Tall trees rose all about, their sullen branches shutting out the sunlight. The dim trail led in and out among them, sometimes skirting the edge of a ravine, where Cororuc could gaze down at the tree-tops beneath. Occasionally, through a rift in the forest, he could see away to the forbidding hills that hinted of the ranges much farther to the west, that were the mountains of Cornwall. In those mountains the bandit chief, Buruc the Cruel, was supposed to lurk, to descend upon such victims as might pass that way. Cororuc shifted his grip on his spear and quickened his step.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (41, 'Men of the Shadows', NULL, NULL, NULL, NULL, NULL, 'From the dim red dawn of Creation. From the fogs of timeless Time. Came we, the first great nation, First on the upward climb. Savage, untaught, unknowing, Groping through primitive night, Yet faintly catching the glowing, The hint of the coming Light.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (42, 'Worms of the Earth', 'http://gutenberg.net.au/ebooks06/0607861h.html', '1932-11-01T00:00:00', NULL, 0, NULL, 'STRIKE in the nails, soldiers, and let our guest see the reality of our good Roman justice!\"  The speaker wrapped his purple cloak closer about his powerful frame and settled back into his official chair, much as he might have settled back in his seat at the Circus Maximus to enjoy the clash of gladiatorial swords. Realization of power colored his every move. Whetted pride was necessary to Roman satisfaction, and Titus Sulla was justly proud; for he was military governor of Eboracum and answerable only to the emperor of Rome. He was a strongly built man of medium height, with the hawk-like features of the pure-bred Roman. Now a mocking smile curved his full lips, increasing the arrogance of his haughty aspect. Distinctly military in appearance, he wore the golden-scaled corselet and chased breastplate of his rank, with the short stabbing sword at his belt, and he held on his knee the silvered helmet with its plumed crest. Behind him stood a clump of impassive soldiers with shield and spear—blond titans from the Rhineland.  Before him was taking place the scene which apparently gave him so much real gratification—a scene common enough wherever stretched the far-flung boundaries of Rome. A rude cross lay flat upon the barren earth and on it was bound a man—half-naked, wild of aspect with his corded limbs, glaring eyes and shock of tangled hair. His executioners were Roman soldiers, and with heavy hammers they prepared to pin the victim\'s hands and feet to the wood with iron spikes.', '‘Worms of the Earth’ is a short story by American fantasy fiction writer Robert E. Howard. It was originally published in the magazine Weird Tales in November 1932, then again in this collection of Howard’s short stories. The story features one of Howard’s recurring protagonists, Bran Mak Morn, a legendary king of the Picts. ');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (43, 'Beyond the Black River', 'http://gutenberg.net.au/ebooks06/0600741h.html', NULL, NULL, NULL, NULL, 'The stillness of the forest trail was so primeval that the tread of a soft-booted foot was a startling disturbance. At least it seemed so to the ears of the wayfarer, though he was moving along the path with the caution that must be practised by any man who ventured beyond Thunder River. He was a young man of medium height, with an open countenance and a mop of tousled tawny hair unconfined by cap or helmet. His garb was common enough for that country — a coarse tunic, belted at the waist, short leather breeches beneath, and soft buckskin boots that came short of the knee. A knife hilt jutted from on boot-top. The broad leather belt supported a short heavy sword, and a buckskin pouch. There was no perturbation in the wide eyes that scanned the green walls which fringed the trail. Though not tall, he was well built, and the arms that the short wide sleeves of the tunic left bare were thick with corded muscle. He tramped imperturbably along although the last settler\'s cabin lay miles behind him, and each step was carrying him nearer the grim peril that hung like a brooding shadow over the ancient forest.', 'A thrilling novelette of the Picts and the wizard Zogar Sag — a startling weird saga of terrific adventures and dark magic.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (44, 'The Black Stranger', 'http://gutenberg.net.au/ebooks15/1501121h.html', NULL, NULL, NULL, NULL, 'One moment the glade lay empty; the next, a man stood poised warily at the edge of the bushes. There had been no sound to warn the grey squirrels of his coming. But the gay-hued birds that flitted about in the sunshine of the open space took fright at his sudden appearance and rose in a clamoring cloud. The man scowled and glanced quickly back the way he had come, as if fearing their flight had betrayed his position to some one unseen. The he stalked across the glade placing his feet with care. For all his massive, muscular build he moved with the supple certitude of a panther. He was naked except for a rag twisted about his loins, and his limbs were criss-crossed with scratches from briars, and caked with dried mud. A brown-crusted bandage was knotted about his thickly-muscled left arm. Under his matted black mane his face was drawn and gaunt, and his eyes burned like the eyes of a wounded panther. He limped slightly as he followed the dim path that led across the open space.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (45, 'The Man-Eaters of Zamboula', 'http://gutenberg.net.au/ebooks06/0600791h.html', NULL, NULL, NULL, NULL, 'Peril hides in the house of Aram Baksh!\" The speaker\'s voice quivered with earnestness and his lean, black-nailed fingers clawed at Conan\'s mightily-muscled arm as he croaked his warning. He was a wiry, sun-burnt man with a straggling black beard, and his ragged garments proclaimed him a nomad. He looked smaller and meaner than ever in contrast to the giant Cimmeriant with his black brows, broad breast, and powerful limbs. They stood in a corner of the Sword-Makers\' Bazaar, and on either side of them flowed past the many-tongued, man-colored stream of the Zamboula streets, which is exotic, hybrid, flamboyant and clamorous.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (46, 'Red Nails', 'http://gutenberg.net.au/ebooks06/0600771h.html', NULL, NULL, NULL, NULL, 'THE woman on the horse reined in her weary steed. It stood with its legs wide-braced, its head drooping, as if it found even the weight of the gold-tassled, red-leather bridle too heavy. The woman drew a booted foot out of the silver stirrup and swung down from the gilt-worked saddle. She made the reins fast to the fork of a sapling, and turned about, hands on her hips, to survey her surroundings. They were not inviting. Giant trees hemmed in the small pool where her horse had just drunk. Clumps of undergrowth limited the vision that quested under the somber twilight of the lofty arches formed by intertwining branches. The woman shivered with a twitch of her magnificent shoulders, and then cursed.', 'One of the strangest stories ever written — the tale of a barbarian adventurer, a woman pirate, and a weird roofed city inhabited by the most peculiar race of men ever spawned.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (47, 'The Servants of Bit-Yakin', 'http://gutenberg.net.au/ebooks06/0600761h.html', NULL, 'Jewels of Gwahlur', NULL, NULL, 'The cliffs rose sheer from the jungle, towering ramparts of stone that glinted jade blue and dull crimson in the rising sun, and curved away and away to east and west above the waving emerald ocean of fronds and leaves. It looked insurmountable, that giant palisade with its sheer curtains of solid rock in which bits of quartz winked dazzlingly in the sunlight. But the man who was working his tedious way upward was already half way to the top. He came of a race of hillmen, accustomed to scaling forbidding crags, and he was a man of unusual strength and agility. His only garment was a pair of short red silk breeks, and his sandals were slung to his back, out of his way, as were his sword and dagger.', 'The tale of a weird, jungle-hidden palace and a strange weird people — and the marvelous sacred jewels that were known as the Teeth of Gwahlur.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (48, 'Blood of the Gods', 'http://gutenberg.net.au/ebooks06/0601041h.html', NULL, NULL, NULL, NULL, 'It was the wolfish snarl on Hawkston\'s thin lips, the red glare in his eyes, which first roused terrified suspicion in the Arab\'s mind, there in the deserted hut on the outskirts of the little town of Azem. Suspicion became certainty as he stared at the three dark, lowering faces of the other white men, bent toward him, and all beastly with the same cruel greed that twisted their leader\'s features. The brandy glass slipped from the Arab\'s hand and his swarthy skin went ashy. \"Lah!\" he cried desperately. \"No! You lied to me! You are not friends — you brought me here to murder me —\"', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (49, 'The Daughter of Erlik Khan', 'http://gutenberg.net.au/ebooks06/0600991h.html', NULL, NULL, NULL, NULL, 'The tall Englishman, Pembroke, was scratching lines on the earth with his hunting knife, talking in a jerky tone that indicated suppressed excitement: \"I tell you, Ormond, that peak to the west is the one we were to look for. Here, I\'ve marked a map in the dirt. This mark here represents our camp, and this one is the peak. We\'ve marched north far enough. At this spot we should turn westward —\" \"Shut up!\" muttered Ormond. \"Rub out that map. Here comes Gordon.\" Pembroke obliterated the faint lines with a quick sweep of his open hand, and as he scrambled up he managed to shuffle his feet across the spot. He and Ormond were laughing and talking easily as the third man of the expedition came up.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (50, 'The Fire of Asshurbanipal (original version)', NULL, NULL, NULL, NULL, NULL, 'Yar Ali squinted carefully down the blue barrel of his Lee-Enfield, called devoutly on Allah and sent a bullet through the brain of a flying rider. \"Allaho akbar!\" the big Afghan shouted in glee, waving his weapon above his head. \"God is great! By Allah, sahib, I have sent one of the dogs to Hell!\" His companion peered cautiously over the rim of the sand pit they had scooped with their hands. He was a lean and wiry American, Steve Clarney by name. \"Good work, old horse,\" said this person. \"Four left. Look — they\'re drawin\' off.\" The white-robed horsemen were indeed reining away, clustering together just out of accurate rifle-range, as if in council. There had been seven when they had first swooped down on the comrades, but the fire from the two rifles in the sand pit had been deadly. \"Look, sahib — they abandon the fray!\" Yar Ali stood up boldly and shouted taunts at the departing riders, one of whom whirled and sent a bullet that kicked up sand thirty feet in front of the pit.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (51, 'Gold from Tatary', 'http://gutenberg.net.au/ebooks06/0608021h.html', NULL, 'The Treasures of Tartary', NULL, NULL, 'IT WAS NOT mere impulsiveness that sent Kirby O\'Donnell into the welter of writhing limbs and whickering blades that loomed so suddenly in the semidarkness ahead of him. In that dark alley of Forbidden Shahrazar it was no light act to plunge headlong into a nameless brawl; and O\'Donnell, for all his Irish love of a fight, was not disposed thoughtlessly to jeopardize his secret mission. But the glimpse of a scarred, bearded face swept from his mind all thought and emotion save a crimson wave of fury. He acted instinctively. Full into the midst of the flailing group, half-seen by the light of a distant cresset, O\'Donnell leaped, kindhjal in hand. He was dimly aware that one man was fighting three or four others, but all his attention was fixed on a single tall gaunt form, dim in the shadows. His long, narrow, curved blade licked venomously at this figure, ploughing through cloth, bringing a yelp as the edge sliced skin. Something crashed down on O\'Donnell\'s head, gun butt or bludgeon, and he reeled, and closed with someone he could not see. His groping hand locked on a chain that encircled a bull neck, and with a straining gasp he ripped upward and felt his keen kindhjal slice through cloth, skin and belly muscles. An agonized groan burst from his victim\'s lips, and blood gushed sickeningly over O\'Donnell\'s hand. Through a blur of clearing sight, the American saw a broad bearded face falling away from him—not the face he had seen before. The next instant he had leaped clear of the dying man, and was slashing at the shadowy forms about him. An instant of flickering steel, and then the figures were running fleetly up the alley. O\'Donnell, springing in pursuit, his hot blood lashed to murderous fury, tripped over a writhing form and fell headlong. He rose, cursing, and was aware of a man near him, panting heavily. A tall man, with a long curved blade in hand. Three forms lay in the mud of the alley. \"Come, my friend, whoever you are!\" the tall man panted in Turki. \"They have fled, but they will return with others. Let us go!\"', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (52, 'Hawk of the Hills', 'http://gutenberg.net.au/ebooks06/0601001h.html', NULL, NULL, NULL, NULL, 'TO a man standing in the gorge below, the man clinging to the sloping cliff would have been invisible, hidden from sight by the jutting ledges that looked like irregular stone steps from a distance. From a distance, also, the rugged wall looked easy to climb; but there were heart-breaking spaces between those ledges—stretches of treacherous shale, and steep pitches where clawing fingers and groping toes scarcely found a grip. One misstep, one handhold lost and the climber would have pitched backward in a headlong, rolling fall three hundred feet to the rocky canyon bed. But the man on the cliff was Francis Xavier Gordon, and it was not his destiny to dash out his brains on the floor of a Himalayan gorge. He was reaching the end of his climb. The rim of the wall was only a few feet above him, but the intervening space was the most dangerous he had yet covered. He paused to shake the sweat from his eyes, drew a deep breath through his nostrils, and once more matched eye and muscle against the brute treachery of the gigantic barrier. Faint yells welled up from below, vibrant with hate and edged with blood lust. He did not look down. His upper lip lifted in a silent snarl, as a panther might snarl at the sound of his hunters\' voices. That was all. His fingers clawed at the stone until blood oozed from under his broken nails. Rivulets of gravel started beneath his boots and streamed down the ledges. He was almost there—but under his toe a jutting stone began to give way. With an explosive expansion of energy that brought a tortured gasp from him, he lunged upward, just as his foothold tore from the soil that had held it. For one sickening instant he felt eternity yawn beneath him— then his upflung fingers hooked over the rim of the crest. For an instant he hung there, suspended, while pebbles and stones went rattling down the face of the cliff in a miniature avalanche. Then with a powerful knotting and contracting of iron biceps, he lifted his weight and an instant later climbed over the rim and stared down.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (53, 'Son of the White Wolf', 'http://gutenberg.net.au/ebooks06/0601081h.html', NULL, NULL, NULL, NULL, 'THE commander of the Turkish outpost of El Ashraf was awakened before dawn by the stamp of horses and jingle of accoutrements. He sat up and shouted for for his orderly. There was no response, so he rose, hurriedly jerked on his garments, and strode out of the mud hut that served as his headquarters. What he saw rendered him momentarily speechless. His command was mounted, in full marching formation, drawn up near the railroad that it was their duty to guard. The plain to the left of the track where the tents of the troopers had stood now lay bare. The tents had been loaded on the baggage camels which stood fully packed and ready to move out. The commandant glared wildly, doubting his own senses, until his eyes rested on a flag borne by a trooper. The waving pennant did not display the familiar crescent. The commandant turned pale. \"What does this mean?\" he shouted, striding forward. His lieutenant, Osman, glanced at him inscrutably. Osman was a tall man, hard and supple as steel, with a dark keen face. \"Mutiny, effendi,\" he replied calmly. \"We are sick of this war we fight for the Germans. We are sick of Djemal Pasha and those other fools of the Council of Unity and Progress, and, incidentally, of you. So we are going into the hills to build a tribe of our own.\" \"Madness!\" gasped the officer, tugging at his revolver. Even as he drew it, Osman shot him through the head.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (54, 'Sons of the Hawk', 'http://gutenberg.net.au/ebooks06/0601091h.html', NULL, 'The Country of the Knife', NULL, NULL, 'A CRY from beyond the bolted door—a thick, desperate croaking that gaspingly repeated a name. Stuart Brent paused in the act of filling a whisky glass, and shot a startled glance toward the door from beyond which that cry had come. It was his name that had been gasped out—and why should anyone call on him with such frantic urgency at midnight in the hall outside his apartment? He stepped to the door, without stopping to set down the square amber bottle. Even as he turned the knob, he was electrified by the unmistakable sounds of a struggle outside—the quick fierce scuff of feet, the thud of blows, then the desperate voice lifted again. He threw the door open. The richly appointed hallway outside was dimly lighted by bulbs concealed in the jaws of gilt dragons writhing across the ceiling. The costly red rugs and velvet tapestries seemed to drink in this soft light, heightening an effect of unreality. But the struggle going on before his eyes was as real as life and death. There were splashes of a brighter crimson on the dark-red rug. A man was down on his back before the door, a slender man whose white face shone like a wax mask in the dim light. Another man crouched upon him, one knee grinding brutally into his breast, one hand twisting at the victim\'s throat. The other hand lifted a red-smeared blade.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (55, 'Swords of Shahrazar', 'https://gutenberg.net.au/ebooks13/1303931h.html', NULL, 'The Treasure of Shaibar Khan', NULL, NULL, 'KIRBY O\'DONNELL opened his chamber door and gazed out, his long keen-bladed kindhjal in his hand. Somewhere a cresset glowed fitfully, dimly lighting the broad hallway, flanked by thick columns. The spaces between these columns were black arched wells of darkness, where anything might be lurking. Nothing moved within his range of vision. The great hall seemed deserted. But he knew that he had not merely dreamed that he heard the stealthy pad of bare feet outside his door, the stealthy sound of unseen hands trying the portal. O\'Donnell felt the peril that crawled unseen about him, the first white man ever to set foot in forgotten Shahrazar, the forbidden, age-old city brooding high among the Afghan mountains. He believed his disguise was perfect; as Ali el Ghazi, a wandering Kurd, he had entered Shahrazar, and as such he was a guest in the palace of its prince. But the furtive footfalls that had awakened him were a sinister portent. He stepped out into the hall cautiously, closing the door behind him. A single step he took—it was the swish of a garment that warned him. He whirled, quick as a cat, and saw, all in a split second, a great black body hurtling at him from the shadows, the gleam of a plunging knife. And simultaneously he himself moved in a blinding blur of speed. A shift of his whole body avoided the stroke, and as the blade licked past, splitting only thin air, his kindhjal, driven with desperate energy, sank its full length in the black torso. An agonized groan was choked by a rush of blood in the dusky throat. The Negro\'s knife rang on the marble floor, and the great black figure, checked in its headlong rush, swayed drunkenly and pitched forward. O\'Donnell watched with his eyes as hard as flint as the would-be murderer shuddered convulsively and then lay still in a widening crimson pool.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (56, 'Swords of the Hills', 'https://gutenberg.net.au/ebooks20/2000031h.html', NULL, 'The Lost Valley of Iskander', NULL, NULL, 'IT WAS THE stealthy clink of steel on stone that wakened Gordon. In the dim starlight a shadowy bulk loomed over him and something glinted in the lifted hand. Gordon went into action like a steel spring uncoiling. His left hand checked the descending wrist with its curved knife, and simultaneously he heaved upward and locked his right hand savagely on a hairy throat. A gurgling gasp was strangled in that throat and Gordon, resisting the other\'s terrific plunges, hooked a leg about his knee and heaved him over and underneath. There was no sound except the rasp and thud of straining bodies. Gordon fought, as always, in grim silence. No sound came from the straining lips of the man beneath. His right hand writhed in Gordon\'s grip while his left tore futilely at the wrist whose iron fngers drove deeper and deeper into the throat they grasped. That wrist felt like a mass of woven steel wires to the weakening fingers that clawed at it. Grimly Gordon maintained his position, driving all the power of his compact shoulders and corded arms into his throttling fingers. He knew it was his life or that of the man who had crept up to stab him in the dark. In that unmapped corner of the Afghan mountains all fights were to the death. The tearing fingers relaxed. A convulsive shudder ran through the great body straining beneath the American. It went limp.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (57, 'Three-Bladed Doom (long version)', NULL, NULL, NULL, NULL, NULL, 'It was the scruff of swift and stealthy feet in the darkened doorway he had just passed that warned Gordon. He wheeled with catlike quickness just in time to see a tall figure lunge at him from that black arch. It was dark in the narrow, alley-like street, but Gordon glimpsed a fierce bearded face, the gleam of steel in the lifted hand, even as he avoided the blow with a twist of his whole body. The knife ripped his shirt and before the attacker could recover his balance, the American caught his arm and crashed the long barrel of his heavy pistol down on the fellow\'s head. The man crumpled to the earth without a sound. Gordon stood above him, listening with tense expectancy. Up the street, around the next corner, he heard the shuffle of sandalled feet, the muffled clink of steel. They told him the nighted streets of Kabul were a death-trap for Francis Xavier Gordon. He hesitated, half lifting the big gun, then shrugged his shoulders and hurried down the street, swerving wide of the dark arches that gaped in the walls which lined it. He turned into another, wider street, and a few moments later rapped softly on a door above which burned a brass lantern. The door opened almost instantly and Gordon stepped quickly inside. \"Lock the door!\"', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (58, 'Three-Bladed Doom (short version)', NULL, NULL, NULL, NULL, NULL, 'It was the scruff of swift and stealthy feet in the darkened doorway he had just passed that warned Gordon. He wheeled with catlike quickness just in time to see a tall figure lunge at him from that black arch. It was dark in the narrow, alley-like street, but Gordon glimpsed a fierce bearded face, the gleam of steel in the lifted hand, even as he avoided the blow with a twist of his whole body. The knife ripped his shirt and before the attacker could recover his balance, the American caught his arm and crashed the long barrel of his heavy pistol down on the fellow\'s head. The man crumpled to the earth without a sound. Gordon stood above him, listening with tense expectancy. Up the street, around the next corner, he heard the shuffle of sandalled feet, the muffled clink of steel. They told him the nighted streets of Kabul were a death-trap for Francis Xavier Gordon. He hesitated, half lifting the big gun, then shrugged his shoulders and hurried down the street, swerving wide of the dark arches that gaped in the walls which lined it. He turned into another, wider street, and a few moments later rapped softly on a door above which burned a brass lantern. The door opened almost instantly and Gordon stepped quickly inside. \"Lock the door!\"', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (59, 'The Trail of the Blood-Stained God', NULL, NULL, NULL, NULL, NULL, 'It was dark as the Pit in that evil-smelling Afghan alley down which Kirby O\'Donnell, in his disguise of a swashbuckling Kurd, was groping, on a quest as blind as the darkness which surrounded him. It was a sharp, pain-edged cry smiting his ears that changed the whole course of events for him. Cries of agony were no uncommon sound in the twisting alleys of Medina el Harami, the City of Thieves, and no cautious or timid man would think of interfering in an affair which was none of his business. But O\'Donnell was neither cautious nor timid, and something in his wayward Irish soul would not let him pass by a cry for help. Obeying his instincts, he turned toward a beam of light that lanced the darkness close at hand, and an instant later was peering through a crack in the close-drawn shutters of a window in a thick stone wall. What he saw drove a red throb of rage through his brain, though years of adventuring in the raw lands of the world should have calloused him by this time. But O\'Donnell could never grow callous to inhuman torture.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (60, 'Blades for France', NULL, NULL, NULL, NULL, NULL, 'Stripling, what do you with a sword? Ha, by Saint Denis, it\'s a woman! A woman with sword and helmet!\" And the great black-whiskered rogue halted with hand on hilt and gaped at me in amaze. I gave back his stare no whit abashed. A woman, yes, and it was a lonely place, a shadowed forest glade far from human habitation. But I did not wear doublet, trunk-hose and Spanish boots merely to show off my figure, and the morion perched on my red locks and the sword that hung at my hip were not ornaments. I looked at this fellow whom chance had caused me to meet in the forest, and I liked him little. He was big enough, with an evil, scarred face; his morion was chased with gold, and under his cloak glimmered breastplate and gussets. This cloak was a notable garment, of Ciprus velvet, cunningly worked with gold thread. Apparently the owner had been napping under a huge tree nearby. A great horse stood there, tied to a branch, with rich housings of red leather and gilt braid. At the sight I sighed, for I had walked far since dawn, and my feet in my long boots ached. \"A woman!\" repeated this rogue wonderingly. \"And clad like a man! Throw off that tattered cloak, wench; I\'d have a better sight of thee! Zounds, but you are a fine, tall, suplle hussy! Come, doff your cloak!\" \"Dog, have done!\" I admonished harshly. \"I\'m no whimpering doxy for your sport.\"', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (61, 'The Blood of Belshazzar', 'http://gutenberg.net.au/ebooks06/0608061h.html', NULL, NULL, NULL, NULL, 'ONCE it was called Eski-Hissar, the Old Castle, for it was very ancient even when the first Seljuks swept out of the east, and not even the Arabs, who rebuilt that crumbling pile in the days of Abu Bekr, knew what hands reared those massive bastions among the frowning foothills of the Taurus. Now, since the old keep had become a bandit\'s hold, men called it Bab-el-Shaitan, the Gate of the Devil, and with good reason. That night there was feasting in the great hall. Heavy tables loaded with wine pitchers and jugs, and huge platters of food, stood flanked by crude benches for such as ate in that manner, while on the floor large cushions received the reclining forms of others. Trembling slaves hastened about, filling goblets from wineskins and bearing great joints of roasted meat and loaves of bread. Here luxury and nakedness met, the riches of degenerate civilizations and the stark savagery of utter barbarism. Men clad in stenching sheepskins lolled on silken cushions, exquisitely brocaded, and guzzled from solid golden goblets, fragile as the stem of a desert flower. They wiped their bearded lips and hairy hands on velvet tapestries worthy of a shah\'s palace. All the races of western Asia met here. Here were slim, lethal Persians, dangerous-eyed Turks in mail shirts, lean Arabs, tall ragged Kurds, Lurs and Armenians in sweaty sheepskins, fiercely mustached Circassians, even a few Georgians, with hawk-faces and devilish tempers. Among them was one who stood out boldly from all the rest. He sat at a table drinking wine from a huge goblet, and the eyes of the others strayed to him continually. Among these tall sons of the desert and mountains his height did not seem particularly great, though it was above six feet. But the breadth and thickness of him were gigantic. His shoulders were broader, his limbs more massive than any other warrior there.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (62, 'Gates of Empire', 'https://gutenberg.net.au/ebooks06/0608031h.html', NULL, NULL, NULL, NULL, 'THE clank of the sour sentinels on the turrets, the gusty uproar of the Spring winds, were not heard by those who reveled in the cellar of Godfrey de Courtenay\'s castle; and the noise these revelers made was bottled up deafeningly within the massive walls. A sputtering candle lighted those rugged walls, damp and uninviting, flanked with wattled casks and hogsheads over which stretched a veil of dusty cobwebs. From one barrel the head had been knocked out, and leathern drinking-jacks were immersed again and again in the foamy tide, in hands that grew increasingly unsteady. Agnes, one of the serving wenches, had stolen the massive iron key to the cellar from the girdle of the steward; and rendered daring by the absence of their master, a small but far from select group were making merry with characteristic heedlessness of the morrow. Agnes, seated on the knee of the varlet Peter, beat erratic time with a jack to a ribald song both were bawling in different tunes and keys. The ale slopped over the rim of the wobbling jack and down Peter\'s collar, a circumstance he was beyond noticing. The other wench, fat Marge, rolled on her bench and slapped her ample thighs in uproarious appreciation of a spicy tale just told by Giles Hobson. This individual might have been the lord of the castle from his manner, instead of a vagabond rapscallion tossed by every wind of adversity. Tilted back on a barrel, booted feet propped on another, he loosened the belt that girdled his capacious belly in its worn leather jerkin, and plunged his muzzle once more into the frothing ale. \"Giles, by Saint Withold his beard,\" quoth Marge, \"madder rogue never wore steel. The very ravens that pick your bones on the gibbet tree will burst their sides a-laughing. I hail ye—prince of all bawdy liars!\" She flourished a huge pewter pot and drained it as stoutly as any man in the realm.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (63, 'Hawks of Outremer', 'http://gutenberg.net.au/ebooks06/0608041h.html', NULL, NULL, NULL, NULL, 'HALT!\" The bearded man-at-arms swung his pike about, growling like a surly mastiff. It paid to be wary on the road to Antioch. The stars blinked redly through the thick night and their light was not sufficient for the fellow to make out what sort of man it was who loomed so gigantically before him. An iron-clad hand shot out suddenly and closed on the soldier\'s mailed shoulder in a grasp that numbed his whole arm. From beneath the helmet the guardsman saw the blaze of ferocious blue eyes that seemed lambent, even in the dark. \"Saints preserve us!\" gasped the frightened man-at-arms, \"Cormac FitzGeoffrey! Avaunt! Back to Hell with ye, like a good knight! I swear to you, sir—\" \"Swear me no oaths,\" growled the knight. \"What is this talk?\" \"Are you not an incorporeal spirit?\" mouthed the soldier. \"Were you not slain by the Moorish corsairs on your homeward voyage?\" \"By the accursed gods!\" snarled FitzGeoffrey. \"Does this hand feel like smoke?\" He sank his mailed fingers into the soldier\'s arm and grinned bleakly at the resultant howl.\n\"Enough of such mummery; tell me who is within that tavern.\" \"Only my master, Sir Rupert de Vaile, of Rouen.\" \"Good enough,\" grunted the other. \"He is one of the few men I count friends, in the East or elsewhere.\" The big warrior strode to the tavern door and entered, treading lightly as a cat despite his heavy armor. The man-at-arms rubbed his arm and stared after him curiously, noting, in the dim light, that FitzGeoffrey bore a shield with the horrific emblem of his family—a white grinning skull. The guardsman knew him of old—a turbulent character, a savage fighter and the only man among the Crusaders who had been esteemed stronger than Richard the Lion-hearted. But FitzGeoffrey had taken ship for his native isle even before Richard had departed from the Holy Land. The Third Crusade had ended in failure and disgrace; most of the Frankish knights had followed their kings homeward. What was this grim Irish killer doing on the road to Antioch?', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (64, 'Hawks Over Egypt', NULL, NULL, NULL, NULL, NULL, 'The tall figure in the white khalat wheeled, cursing softly, hand at scimitar hilt. Not lightly men walked the nighted streets of Cairo in the troublous days of the year 1021 A.D. In this dark, winding alley of the unsavory river quarter of el Makes, anything might happen. \"Why do you follow me, dog?\" The voice was harsh, edged with a Turkish accent. Another tall figure emerged from the shadows, clad, like the first, in a khalat of white silk, but lacking the other\'s spired helmet. \"I do not follow you!\" The voice was not so guttural as the Turk\'s, and the accent was different. \"Can not a stranger walk the streets without being subjected to insult by every reeling drunkard of the gutter?\" The stormy anger in his voice was not feigned, any more than was the suspicion in the voice of the other. They glared at each other, each gripping his hilt with a hand tense with passion. \"I have been followed since nightfall,\" accused the Turk. \"Ihave heard stealthy footsteps along the dark alleys. Now you come unexpectedly into view, in a place most suited for murder!\"', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (65, 'The Lion of Tiberias', 'http://gutenberg.net.au/ebooks06/0608091h.html', NULL, NULL, NULL, NULL, 'THE BATTLE in the meadowlands of the Euphrates was over, but not the slaughter. On that bloody field where the Caliph of Bagdad and his Turkish allies had broken the onrushing power of Doubeys ibn Sadaka of Hilla and the desert, the steel-clad bodies lay strewn like the drift of a storm. The great canal men called the Nile, which connected the Euphrates with the distant Tigris, was choked with the bodies of the tribesmen, and survivors were panting in flight toward the white walls of Hilla which shimmered in the distance above the placid waters of the nearer river. Behind them the mailed hawks, the Seljuks, rode down the fleeing, cutting the fugitives from their saddles. The glittering dream of the Arab emir had ended in a storm of blood and steel, and his spurs struck blood as he rode for the distant river. Yet at one spot in the littered field the fight still swirled and eddied, where the emir\'s favorite son, Achmet, a slender lad of seventeen or eighteen, stood at bay with one companion. The mailed riders swooped in, struck and reined back, yelling in baffled rage before the lashing of the great sword in this man\'s hands. His was a figure alien and incongruous, his red mane contrasting with the black locks about him no less than his dusty gray mail contrasted with the plumed burnished headpieces and silvered hauberks of the slayers. He was tall and powerful, with a wolfish hardness of limbs and frame that his mail could not conceal. His dark, scarred face was moody, his blue eyes cold and hard as the blue steel whereof Rhineland gnomes forge swords for heroes in northern forests. Little of softness had there been in John Norwald\'s life. Son of a house ruined by the Norman conquest, this descendant of feudal thanes had only memories of wattle-thatched huts and the hard life of a man-at-arms, serving for poor hire barons he hated. Born in north England, the ancient Danelagh, long settled by blue-eyed vikings, his blood was neither Saxon nor Norman, but Danish, and the grim unbreakable strength of the blue North was his. From each stroke of life that felled him, he rose fiercer and more unrelenting. He had not found existence easier in his long drift East which led him into the service of Sir William de Montserrat, seneschal of a castle on the frontier beyond Jordan. In all his thirty years, John Norwald remembered but one kindly act, one deed of mercy; wherefore he now faced a whole host, desperate fury nerving his iron arms.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (66, 'Lord of Samarcand', 'http://gutenberg.net.au/ebooks06/0608051h.html', NULL, 'The Lame Man', NULL, NULL, 'THE ROAR of battle had died away; the sun hung like a ball of crimson gold on the western hills. Across the trampled field of battle no squadrons thundered, no war-cry reverberated. Only the shrieks of the wounded and the moans of the dying rose to the circling vultures whose black wings swept closer and closer until they brushed the pallid faces in their flight. On his rangy stallion, in a hillside thicket, Ak Boga the Tatar watched, as he had watched since dawn, when the mailed hosts of the Franks, with their forest of lances and flaming pennons, had moved out on the plains of Nicopolis to meet the grim hordes of Bayazid. Ak Boga, watching their battle array, had chk-chk\'d his teeth in surprize and disapproval as he saw the glittering squadrons of mounted knights draw out in front of the compact masses of stalwart infantry, and lead the advance. They were the flower of Europe—cavaliers of Austria, Germany, France and Italy; but Ak Boga shook his head. He had seen the knights charge with a thunderous roar that shook the heavens, had seen them smite the outriders of Bayazid like a withering blast and sweep up the long slope in the teeth of a raking fire from the Turkish archers at the crest. He had seen them cut down the archers like ripe corn, and launch their whole power against the oncoming spahis, the Turkish light cavalry. And he had seen the spahis buckle and break and scatter like spray before a storm, the light-armed riders flinging aside their lances and spurring like mad out of the melee. But Ak Boga had looked back, where, far behind, the sturdy Hungarian pikemen toiled, seeking to keep within supporting distance of the headlong cavaliers. He had seen the Frankish horsemen sweep on, reckless of their horses\' strength as of their own lives, and cross the ridge. From his vantage-point Ak Boga could see both sides of that ridge and he knew that there lay the main power of the Turkish army—sixty-five thousand strong—the janizaries, the terrible Ottoman infantry, supported by the heavy cavalry, tall men in strong armor, bearing spears and powerful bows. And now the Franks realized, what Ak Boga had known, that the real battle lay before them; and their horses were weary, their lances broken, their throats choked with dust and thirst.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (67, 'Red Blades of Black Cathay', 'https://gutenberg.net.au/ebooks13/1304271h.html', NULL, NULL, NULL, NULL, 'THE SINGING of the swords was a deathly clamor in the brain of Godric de Villehard. Blood and sweat veiled his eyes and in the instant of blindness he felt a keen point pierce a joint of his hauberk and sting deep into his ribs. Smiting blindly, he felt the jarring impact that meant his sword had gone home, and snatching an instant\'s grace, he flung back his vizor and wiped the redness from his eyes. A single glance only was allowed him: in that glance he had a fleeting glimpse of huge, wild black mountains; of a clump of mail-clad warriors, ringed by a howling horde of human wolves; and in the center of that clump, a slim, silk-clad shape standing between a dying horse and a dying swordsman. Then the wolfish figures surged in on all sides, hacking like madmen. \"Christ and the Cross!\" the old Crusading shout rose in a ghastly croak from Godric\'s parched lips. As if far away he heard voices gaspingly repeat the words. Curved sabers rained on shield and helmet. Godric\'s eyes blurred to the sweep of frenzied dark faces with bristling, foam-flecked beards. He fought like a man in a dream. A great weariness fettered his limbs. Somewhere—long ago it seemed—a heavy axe, shattering on his helm, had bitten through an old dent to rend the scalp beneath. He heaved his curiously weighted arm above his head and split a bearded face to the chin. \"En avant, Montferrat!\" We must hack through and shatter the gates, thought the dazed brain of Godric; we can not long stand this press, but once within the city—no—these walls were not the walls of Constantinople: he was mad; he dreamed—these towering heights were the crags of a lost and nameless land and Montferrat and the Crusade lay lost in leagues and years. Godric\'s steed reared and pitched headlong, throwing his rider with a clash of armor. Under the lashing hoofs and the shower of blades, the knight struggled clear and rose, without his shield, blood starting from every joint in his armor. He reeled, bracing himself; he fought not these foes alone, but the long grinding days behind—the days and days of hard riding and ceaseless fighting.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (68, 'The Road of Azrael', NULL, NULL, NULL, NULL, NULL, 'Towers reel as they burst asunder, Streets run red in the butchered town; Standards fall and the lines go under And the iron horsemen ride me down. Out of the strangling dust around me Let me ride for my hour is nigh, From the walls that prison, the hoofs that ground me, To the sun and the desert wind to die. Allaho akbar! There is no God but God. These happenings I, Kosru Malik, chronicle that men may know truth thereby. For I have seen madness beyond human reckoning; aye, I have ridden the road of Azrael that is the Road of Death, and have seen mailed men fall like garnered grain; and here I detail the truths of that madness and of the doom of Kizilshehr the Strong, the Red City, which has faded like a summer cloud in the blue skies.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (69, 'The Road of the Eagles', NULL, NULL, NULL, NULL, NULL, 'Though the cannon had ceased to speak, their thunder seemed still to echo hauntingly among the hills that overhung the blue water. A league from the shore the loser of that grim sea-fight wallowed in the crimson wash; just out of cannon-shot the winner limped slowly away. It was a scene common enough on the Black Sea in the year of our Lord 1595. The ship that heeled drunkenly in the blue waste was a high beaked galley such as was used by the dread Barbary corsairs. Death had reaped a grim harvest there. Dead men sprawled on the high poop; they hung loosely over the scarred rail; they lay among the ruins of the aftercastle; they slumped along the runway that bridged the waist, where the mangled oarsmen lay among their shattered benches. Even in death these had not the appearance of men born to slavery — they were tall men, with dark hawk-like countenances. In pens about the base of the mast, fear-maddened horses fought and screamed unbearably.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (70, 'The Shadow of the Vulture', 'http://gutenberg.net.au/ebooks06/0608101h.html', NULL, NULL, NULL, NULL, 'SO THEY BROUGHT the envoys, pallid from months of imprisonment, before the canopied throne of Suleyman the Magnificent, Sultan of Turkey, and the mightiest monarch in an age of mighty monarchs. Under the great purple dome of the royal chamber gleamed the throne before which the world trembled— gold-paneled, pearl-inlaid. An emperor\'s wealth in gems was sewn into the silken canopy from which depended a shimmering string of pearls ending a frieze of emeralds which hung like a halo of glory above Suleyman\'s head. Yet the splendor of the throne was paled by the glitter of the figure upon it, bedecked in jewels, the aigrette feather rising above the diamonded white turban. About the throne stood his nine viziers, in attitudes of humility, and warriors of the imperial bodyguard ranged the dais—Solaks in armor, black and white and scarlet plumes nodding above the gilded helmets. The envoys from Austria were properly impressed—the more so as they had had nine weary months for reflection in the grim Castle of the Seven Towers that overlooks the Sea of Marmora. The head of the embassy choked down his choler and cloaked his resentment in a semblance of submission—a strange cloak on the shoulders of Habordansky, general of Ferdinand, Archduke of Austria. His rugged head bristled incongruously from the flaming silk robes presented him by the contemptuous Sultan, as he was brought before the throne, his arms gripped fast by stalwart Janizaries. Thus were foreign envoys presented to the sultans, ever since that red day by Kossova when Milosh Kabilovitch, knight of slaughtered Serbia, had slain the conqueror Murad with a hidden dagger. The Grand Turk regarded Habordansky with scant favor. Suleyman was a tall, slender man, with a thin down-curving nose and a thin straight mouth, the resolution of which his drooping mustachios did not soften. His narrow outward-curving chin was shaven. The only suggestion of weakness was in the slender, remarkably long neck, but that suggestion was belied by the hard lines of the slender figure, the glitter of the dark eyes. There was more than a suggestion of the Tatar about him—rightly so, since he was no more the son of Selim the Grim, than of Hafsza Khatun, princess of Crimea. Born to the purple, heir to the mightiest military power in the world, he was crested with authority and cloaked in pride that recognized no peer beneath the gods.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (71, 'The Skull in the Clouds', 'https://en.wikisource.org/wiki/The_Skull_in_the_Clouds', NULL, NULL, NULL, NULL, 'The Black Prince scowled above his lance, and wrath in his hot eyes lay,\n\"I would rather you rode with the spears of France and not at my side today.\n\"A man may parry an open blow, but I know not where to fend;\n\"I would that you were an open foe, instead of a sworn friend.\n\n\"You came to me in an hour of need, and your heart I thought I saw;\n\"But you are one of a rebel breed that knows not king or law.\n\"You -- with your ever smiling face and a black heart under your mail—\n\"With the haughty strain of the Norman race and the wild, black blood of the Gael.\n\n\"Thrice in a night fight\'s close-locked gloom my shield by merest chance\n\"Has turned a sword that thrust like doom—I wot \'twas not of France!\n\"And in a dust-cloud, blind and red, as we charged the Provence line\n\"An unseen axe struck Fitzjames dead, who gave his life for mine.\n\n\"Had I proofs, your head should fall this day or ever I rode to strife.\n\"Are you but a wolf to rend and slay, with naught to guide your life?\n\"No gleam of love in a lady\'s eyes, no honor or faith or fame?\"\nI raised my faces to the brooding skies and laughed like a roaring flame.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (72, 'The Sowers of the Thunder', 'http://gutenberg.net.au/ebooks06/0608111h.html', NULL, NULL, NULL, NULL, 'THE IDLERS in the tavern glanced up at the figure framed in the doorway. It was a tall broad man who stood there, with the torch-lit shadows and the clamor of the bazaars at his back. His garments were simple tunic, and short breeches of leather; a camel\'s-hair mantle hung from his broad shoulders and sandals were on his feet. But belying the garb of the peaceful traveler, a short straight stabbing sword hung at his girdle. One massive arm, ridged with muscles, was outstretched, the brawny hand gripping a pilgrim\'s staff, as the man stood, powerful legs wide braced, in the doorway. His bare legs were hairy, knotted like tree trunks. His coarse red locks were confined by a single band of blue cloth, and from his square dark face, his strange blue eyes blazed with a kind of reckless and wayward mirth, reflected by the half-smile that curved his thin lips. His glance passed over the hawk-faced seafarers and ragged loungers who brewed tea and squabbled endlessly, to rest on a man who sat apart at a rough-hewn table, with a wine pitcher. Such a man the watcher in the door had never seen—tall, deep chested, broad shouldered, built with the dangerous suppleness of a panther. His eyes were as cold as blue ice, set off by a mane of golden hair tinted with red; so to the man in the doorway that hair seemed like burning gold. The man at the table wore a light shirt of silvered mail, a long lean sword hung at his hip, and on the bench beside him lay a kite-shaped shield and a light helmet. The man in the guise of a traveler strode purposefully forward and halted, hands resting on the table across which he smiled mockingly at the other, and spoke in a tongue strange to the seated man, newly come to the East. The one turned to an idler and asked in Norman French: \"What does the infidel say?\" \"I said,\" replied the traveler in the same tongue, \"that a man can not even enter an Egyptian inn these days without finding some dog of a Christian under his feet.\" As the traveler had spoken the other had risen, and now the speaker dropped his hand to his sword. Scintillant lights flickered in the other\'s eyes and he moved like a flash of summer lightning. His left hand darted out to lock in the breast of the traveler\'s tunic, and in his right hand the long sword flashed out. The traveler was caught flat-footed, his sword half clear of its sheath. But the faint smile did not leave his lips and he stared almost childishly at the blade that flickered before his eyes, as if fascinated by its dazzling. \"Heathen dog,\" snarled the swordsman, and his voice was like the slash of a blade through fabric, \"I\'ll send you to Hell unshriven!\"', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (73, 'Spears of Clontarf', NULL, NULL, NULL, NULL, NULL, 'War is in the wind — the ravens are gathering.\" Conn the thrall let fall a huge armload of logs before the cavernous fireplace and faced about to meet the gaze of his sombre master. Conn was tall and massively yet rangily built, with broad sloping shoulders, a might, hairy chest, and long heavily muscled arms. His features were in keeping with his bodily aspect — a strong stubborn jaw, low slanting forehead topped by a shock of tawny tousled hair which added to the wildness of his appearance, as did his cold blue eyes. Garments he wore none, except a loin cloth; his own wolfish ruggedness was protection enough against the weather, ordinarily. For he was a slave in an age when even the masters lived lives ferociously hard and hardening. Now Conna faced his master, and flexing his mighty arms absently, asked: \"What was it that the farers in the longship shouted to us this morning, when we were out in the fishing boat?\" \"You heard them, did you not, fool?\" harshly asked Wolfgar Snorri\'s son. \"Can you not understand human speech? As the dragon-ship swept past the point, the Vikings shouted to me that there was a gathering of eagles on the east coast of that cursed Ireland — Brain Boru is moving against King Sitric of Dublin, and the word has gone to all the sea-farers to gather for the slaughter. This time the sea-kings will crush that doddering old fool and his naked kerns, once and for all.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (74, 'Sword Woman', NULL, NULL, NULL, NULL, NULL, 'Agnès! You red-haired spawn of the devil, where are you?\" It was my father calling me, after his usual fashion. I raked my sweat-dampened hair out of my eyes and heaved the bundle of fagots back on my shoulder. Little of rest was there in my life. My father parted the bushes and came into the glade — a tall man, gaunt and bitter, darkened with the suns of many campaigns, marked with scars gotten in the service of greedy kings and avaricious dukes. He scowled at me, and faith, I would hardly have recognized him had he worn another expression. \"What are you about?\" he snarled. \"You sent me into the forest for wood,\" I answered sullenly. \"Did I bid you begone a whole day?\" he roared, aiming a slap at my head which I avoided with a skill born of much practice. \"Have you forgot this is your wedding day?\" At that my fingers went limp and the cord slipped through them, so the bundle of fagots tumbled to the ground and burst apart. The gold went out of the sunlight, and the joy from the trilling of the birds.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (75, 'Black Canaan', 'http://gutenberg.net.au/ebooks06/0601641h.html', NULL, NULL, NULL, NULL, 'TROUBLE on Tularoosa Creek!\" A warning to send cold fear along the spine of any man who was raised in that isolated back-country, called Canaan, that lies between Tularoosa and Black River—to send him racing back to that swamp-bordered region, wherever the word might reach him. It was only a whisper from the withered lips of a shuffling black crone, who vanished among the throng before I could seize her; but it was enough. No need to seek confirmation; no need to inquire by what mysterious, black-folk way the word had come to her. No need to inquire what obscure forces worked to unseal those wrinkled lips to a Black River man. It was enough that the warning had been given—and understood. Understood? How could any Black River man fail to understand that warning? It could have but one meaning—old hates seething again in the jungle-deeps of the swamplands, dark shadows slipping through the cypress, and massacre stalking out of the black, mysterious village that broods on the moss-festooned shore of sullen Tularoosa. Within an hour New Orleans was falling further behind me with every turn of the churning wheel. To every man born in Canaan, there is always an invisible tie that draws him back whenever his homeland is imperiled by the murky shadow that has lurked in its jungled recesses for more than half a century. The fastest boats I could get seemed maddeningly slow for that race up the big river, and up the smaller, more turbulent stream. I was burning with impatience when I stepped off on the Sharpsville landing, with the last fifteen miles of my journey yet to make. It was past midnight, but I hurried to the livery stable where, by tradition half a century old, there is always a Buckner horse, day or night. As a sleepy black boy fastened the cinches, I turned to the owner of the stable, Joe Lafely, yawning and gaping in the light of the lantern he upheld. \"There are rumors of trouble on Tularoosa?\" He paled in the lantern-light. \"I don\'t know. I\'ve heard talk. But you people in Canaan are a shut-mouthed clan. No one outside knows what goes on in there—\" The night swallowed his lantern and his stammering voice as I headed west along the pike.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (76, 'The Black Stone', 'http://gutenberg.net.au/ebooks06/0601711h.html', NULL, NULL, NULL, NULL, 'I READ of it first in the strange book of Von Junzt, the German eccentric who lived so curiously and died in such grisly and mysterious fashion. It was my fortune to have access to his Nameless Cults in the original edition, the so-called Black Book, published in Dusseldorf in 1839, shortly before a hounding doom overtook the author. Collectors of rare literature were familiar with Nameless Cults mainly through the cheap and faulty translation which was pirated in London by Bridewall in 1845, and the carefully expurgated edition put out by the Golden Goblin Press of New York, 1909. But the volume I stumbled upon was one of the unexpurgated German copies, with heavy black leather covers and rusty iron hasps. I doubt if there are more than half a dozen such volumes in the entire world today, for the quantity issued was not great, and when the manner of the author\'s demise was bruited about, many possessors of the book burned their volumes in panic. Von Junzt spent his entire life (1795-1840) delving into forbidden subjects; he traveled in all parts of the world, gained entrance into innumerable secret societies, and read countless little-known and esoteric books and manuscripts in the original; and in the chapters of the Black Book, which range from startling clarity of exposition to murky ambiguity, there are statements and hints to freeze the blood of a thinking man. Reading what Von Junzt dared put in print arouses uneasy speculations as to what it was that he dared not tell. What dark matters, for instance, were contained in those closely written pages that formed the unpublished manuscript on which he worked unceasingly for months before his death, and which lay torn and scattered all over the floor of the locked and bolted chamber in which Von Junzt was found dead with the marks of taloned fingers on his throat? It will never be known, for the author\'s closest friend, the Frenchman Alexis Ladeau, after having spent a whole night piecing the fragments together and reading what was written, burnt them to ashes and cut his own throat with a razor.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (77, 'The Cairn on the Headland', 'http://gutenberg.net.au/ebooks06/0601721h.html', NULL, NULL, NULL, NULL, 'THIS is the cairn you seek,\" I said, laying my hand gingerly on one of the rough stones which composed the strangely symmetrical heap. An avid interest burned in Ortali\'s dark eyes. His gaze swept the landscape and came back to rest on the great pile of massive weather-worn boulders. \"What a wild, weird, desolate place!\" he said. \"Who would have thought to find such a spot in this vicinity? Except for the smoke rising yonder, one would scarcely dream that beyond that headland lies a great city! Here there is scarcely even a fisherman\'s hut within sight.\" \"The people shun the cairn as they have shunned it for centuries,\" I replied. \"Why?\" \"You\'ve asked me that before,\" I replied impatiently. \"I can only answer that they now avoid by habit what their ancestors avoided through knowledge.\" \"Knowledge!\" he laughed derisively. \"Superstition!\" I looked at him sombrely with unveiled hate. Two men could scarcely have been of more opposite types. He was slender, self-possessed, unmistakably Latin with his dark eyes and sophisticated air. I am massive, clumsy and bearlike, with cold blue eyes and tousled red hair. We were countrymen in that we were born in the same land; but the homelands of our ancestors were as far apart as South from North. \"Nordic superstition,\" he repeated. \"It cannot imagine a Latin people allowing such a mystery as this to go unexplored all these years. The Latins are too practical—too prosaic, if you will. Are you sure of the date of this pile?\" \"I find no mention of it in any manuscript prior to 1014 A.D.,\" I growled, \"and I\'ve read all such manuscripts extant, in the original. MacLiag, King Brian Boru\'s poet, speaks of the rearing of the cairn immediately after the battle, and there can be little doubt that this is the pile referred to. It is mentioned briefly in the later chronicles of the Four Masters, also in the Book of Leinster, compiled in the late 1150\'s, and again in the Book of Lecan, compiled by the MacFirbis about 1416. All connect it with the battle of Clontarf, without mentioning why it was built.\" \"Well, what is the mystery about it?\" he queried. \"What more natural than that the defeated Norsemen should rear a cairn above the body of some great chief who had fallen in the battle?\" \"In the first place,\" I answered, \"there is a mystery concerning the existence of it. The building of cairns above the dead was a Norse, not an Irish, custom. Yet according to the chroniclers, it was not Norsemen who reared this heap. How could they have built it immediately after the battle, in which they had been cut to pieces and driven in headlong flight through the gates of Dublin? Their chieftains lay where they had fallen and the ravens picked their bones. It was Irish hands that heaped these stones.\"', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (78, 'Casonetto\'s Last Song', NULL, NULL, NULL, NULL, NULL, 'I eyed the package curiously. It was thin and flat, and the address was written clearly in the curving elegant hand I had learned to hate — the hand I knew to now be cold in death. \"You had better be careful, Gordon,\" said my friend Costigan. \"Sure, why should that black devil be sending you anything but something to do you harm?\" \"I had thought of a bomb or something similar,\" I answered, \"but this is too thin a package to contain anything like that. I\'ll open it.\" \"By the powers!\" Costigan laughed shortly. \"\'Tis one of his songs he\'s sending you!\" An ordinary phonograph record lay bbefore us. Ordinary, did I say? I might say the most extraordinary record in the world. For, to the best of our knowledge, it was the only one which held imprisoned in its flat bosom the golden voice of Giovanni Casonetto, that great and evil genius whose operatic singing had thrilled the world, and whose dark and mysterious crimes had shocked that same world. \"The death cell where Casonetto lay awaits the next doomed one, and the black singer lies dead,\" said Costigan. \"What then is the spell of this disc that he sends it to the man whose testimony sent him to the gallows?\"', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (79, 'The Dead Remember', 'https://gutenberg.net.au/ebooks13/1304501h.html', NULL, NULL, NULL, NULL, 'Dodge City, Kansas, November 3, 1877.\nMr. William L. Gordon, Antioch, Texas.\nDear Bill:\nI am writing you because I have got a feeling I am not long for this world. This may surprise you, because you know I was in good health when I left the herd, and I am not sick now as far as that goes, but just the same I believe I am as good as a dead man.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (80, 'Delenda Est', NULL, NULL, NULL, NULL, NULL, 'It\'s no empire, I tell you! It\'s only a sham. Empire? Pah! Pirates, that\'s all we are!\" It was Hunegais, of course, the ever moody and gloomy, with his braided black locks and drooping moustaches betraying his Slavonic blood. He sighed gustily, and the Falernian wine slopped over the rim of the jade goblet clenched in his brawny hand, to stain his purple, gilt-embroidered tunic. He drank noisily, after the manner of a horse, and returned with melancholy gusto to his original complaint. \"What have we done in Africa? Destroyed the big landholders and the priests, set ourselves up as landlords. Who works the land? Vandals? Not at all! The same men who worked it under the Romans. We\'ve merely stepped into Roman shoes. We levy taxes and rents, and are forced to defend the land from the accursed Berbers. Our weakness is in our numbers. We can\'t amalgamate with the people; we\'d be absorbed. We can\'t make allies and subjects out of them; all we can do is maintain a sort of military prestige — we are a small body of aliens sitting in castles and for the present enforcing our rule over a big native population who, it\'s true, hate us no worse than they hated the Romans, but —\"', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (81, 'Dermod\'s Bane', NULL, NULL, NULL, NULL, NULL, 'If your heart is sick in your breast and a blind black curtain of sorrow is between your brain and your eyes so that the very sunlight is pale and leprous — go to the city of Galway, in the country of the same name, in the province of Connaught, in the country of Ireland. In the grey old City of Tribes, as they call it, there is a dreamy soothing spell that is like enchantment, and if you are of Galway blood, no matter how far away, your grief will pass slowly from you like a dream, leaving only a sad sweet memory, like the scent of a dying rose. There is a mist of antiquity hovering over the old city which mingles with sorrow and makes one forget. Or you can go out into the blue Connaught hills and feel the salt sharp tang of the wind off the Atlantic, and life seems faint and far away, with all its sharp joys and bitter sorrows, and no more real than the shadows of the clouds which pass.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (82, 'Dig Me No Grave', 'https://gutenberg.net.au/ebooks13/1304031h.html', NULL, NULL, NULL, NULL, 'THE thunder of my old-fashioned door-knocker, reverberating eerily through the house, roused me from a restless and nightmare-haunted sleep. I looked out the window. In the last light of the sinking moon, the white face of my friend John Conrad looked up at me. \"May I come up, Kirowan?\" His voice was shaky and strained. \"Certainly!\" I sprang out of bed and pulled on a bath-robe as I heard him enter the front door and ascend the stairs. A moment later he stood before me, and in the light which I had turned on I saw his hands tremble and noticed the unnatural pallor of his face. \"Old John Grimlan died an hour ago,\" he said abruptly. \"Indeed? I had not known that he was ill.\" \"It was a sudden, virulent attack of peculiar nature, a sort of seizure somewhat akin to epilepsy. He has been subject to such spells of late years, you know.\" I nodded. I knew something of the old hermit-like man who had lived in his great dark house on the hill; indeed, I had once witnessed one of his strange seizures, and I had been appalled at the writhings, howlings and yammerings of the wretch, who had groveled on the earth like a wounded snake, gibbering terrible curses and black blasphemies until his voice broke in a wordless screaming which spattered his lips with foam. Seeing this, I understood why people in old times looked on such victims as men possessed by demons. \"—some hereditary taint,\" Conrad was saying. \"Old John doubtless fell heir to some ingrown weakness brought on by some loathsome disease, which was his heritage from perhaps a remote ancestor—such things occasionally happen. Or else—well, you know old John himself pried about in the mysterious parts of the earth, and wandered all over the East in his younger days. It is quite possible that he was infected with some obscure malady in his wanderings. There are still many unclassified diseases in Africa and the Orient.\" \"But,\" said I, \"you have not told me the reason for this sudden visit at this unearthly hour—for I notice that it is past midnight.\" My friend seemed rather confused. \"Well, the fact is that John Grimlan died alone, except for myself. He refused to receive any medical aid of any sort, and in the last few moments when it was evident that he was dying, and I was prepared to go for some sort of help in spite of him, he set up such a howling and screaming that I could not refuse his passionate pleas—which were that he should not be left to die alone. \"I have seen men die,\" added Conrad, wiping the perspiration from his pale brow, \"but the death of John Grimlan was the most fearful I have ever seen.\"', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (83, 'The Dream Snake', 'http://gutenberg.net.au/ebooks06/0607971h.html', NULL, NULL, NULL, NULL, 'THE NIGHT was strangely still. As we sat upon the wide veranda, gazing out over the broad, shadowy lawns, the silence of the hour entered our spirits and for a long while no one spoke. Then far across the dim mountains that fringed the eastern skyline, a faint haze began to glow, and presently a great golden moon came up, making a ghostly radiance over the land and etching boldly the dark clumps of shadows that were trees. A light breeze came whispering out of the east, and the unmowed grass swayed before it in long, sinuous waves, dimly visible in the moonlight; and from among the group upon the veranda there came a swift gasp, a sharp intake of breath that caused us all to turn and gaze. Faming was leaning forward, clutching the arms of his chair, his face strange and pallid in the spectral light; a thin trickle of blood seeping from the lip in which he had set his teeth. Amazed, we looked at him, and suddenly he jerked about with a short, snarling laugh. \"There\'s no need of gawking at me like a flock of sheep!\" he said irritably and stopped short. We sat bewildered, scarcely knowing what sort of reply to make, and suddenly he burst out again. \"Now I guess I\'d better tell the whole thing or you\'ll be going off and putting me down as a lunatic. Don\'t interrupt me, any of you! I want to get this thing off my mind. You all know that I\'m not a very imaginative man; but there\'s a thing, purely a figment of imagination, that has haunted me since babyhood. A dream!\" he fairly cringed back in his chair as he muttered, \"A dream! And God, what a dream! The first time—no, I can\'t remember the first time I ever dreamed it—I\'ve been dreaming the hellish thing ever since I can remember. Now it\'s this way: there is a sort of bungalow, set upon a hill in the midst of wide grasslands—not unlike this estate; but this scene is in Africa. And I am living there with a sort of servant, a Hindoo. Just why I am there is never clear to my waking mind, though I am always aware of the reason in my dreams. As a man of a dream, I remember my past life (a life which in no way corresponds with my waking life), but when I am awake my subconscious mind fails to transmit these impressions. However, I think that I am a fugitive from justice and the Hindoo is also a fugitive. How the bungalow came to be there I can never remember, nor do I know in what part of Africa it is, though all these things are known to my dream self. But the bungalow is a small one of a very few rooms, and it situated upon the top of the hill, as I said There are no other hills about and the grasslands stretch to the horizon in every direction; knee-high in some places, waist-high in others.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (84, 'The Dwellers Under the Tomb', NULL, NULL, NULL, NULL, NULL, 'I awoke suddenly and sat up in bed, sleepily wondering who it was that was battering on the door so violently; it threatened to shatter the panels. A voice squealed, sharpened intolerably as with mad terror. \"Conrad! Conrad!\" someone outside the door was screaming. \"For God\'s sake, let me in! I\'ve seen him! — I\'ve seen him!\" \"It sounds like Job Kiles,\" said Conrad, lifting his long frame off the divan where he had been sleeping, after giving up his bed to me. \"Don\'t knock down the door!\" he called, reaching for slippers. \"I\'m coming.\" \"Well, hurry!\" squalled the unseen visitor. \"I\'ve just looked into the eyes of Hell!\"', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (85, 'The Fearsome Touch of Death', 'http://gutenberg.net.au/ebooks06/0607981h.html', NULL, NULL, NULL, NULL, 'OLD ADAM FARREL lay dead in the house wherein he had lived alone for the last twenty years. A silent, churlish recluse, in his life he had known no friends, and only two men had watched his passing. Dr. Stein rose and glanced out the window into the gathering dusk. \"You think you can spend the night here, then?\" he asked his companion. This man, Falred by name, assented. \"Yes, certainly. I guess it\'s up to me.\" \"Rather a useless and primitive custom, sitting up with the dead,\" commented the doctor, preparing to depart, \"but I suppose in common decency we will have to bow to precedence. Maybe I can find someone who\'ll come over here and help you with your vigil.\" Falred shrugged his shoulders. \"I doubt it. Farrel wasn\'t liked—wasn\'t known by many people. I scarcely knew him myself, but I don\'t mind sitting up with the corpse.\" Dr. Stein was removing his rubber gloves and Falred watched the process with an interest that almost amounted to fascination. A slight, involuntary shudder shook him at the memory of touching these gloves—slick, cold, clammy things, like the touch of death. \"You may get lonely tonight, if I don\'t find anyone,\" the doctor remarked as he opened the door. \"Not superstitious, are you?\" Falred laughed. \"Scarcely. To tell the truth, from what I hear of Farrel\'s disposition, I\'d rather be watching his corpse than have been his guest in life.\"', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (86, 'The Fire of Asshurbanipal (Weird Tales version)', 'http://gutenberg.net.au/ebooks06/0601741h.html', NULL, NULL, NULL, NULL, 'YAR ALI squinted carefully down the blue barrel of his Lee-Enfield, called devoutly on Allah and sent a bullet through the brain of a flying rider.\n\"Allaho akbar!\" The big Afghan shouted in glee, waving his weapon above his head, \"God is great! By Allah, sahib, I have sent another one of the dogs to Hell!\" His companion peered cautiously over the rim of the sand-pit they had scooped with their hands. He was a lean and wiry American, Steve Clarney by name. \"Good work, old horse,\" said this person. \"Four left. Look—they\'re drawing off.\" The white-robed horsemen were indeed reining away, clustering together just out of accurate rifle-range, as if in council. There had been seven when they had first swooped down on the comrades, but the fire from the two rifles in the sand-pit had been deadly. \"Look, sahib—they abandon the fray!\" Yar Ali stood up boldly and shouted taunts at the departing riders, one of whom whirled and sent a bullet that kicked up sand thirty feet in front of the pit. \"They shoot like the sons of dogs,\" said Yar Ali in complacent self-esteem. \"By Allah, did you see that rogue plunge from his saddle as my lead went home? Up, sahib; let us run after them and cut them down!\" Paying no attention to this outrageous proposal—for he knew it was but one of the gestures Afghan nature continually demands—Steve rose, dusted off his breeches and gazing after the riders, now white specks far out on the desert, said musingly: \"Those fellows ride as if they had some set purpose in mind—not a bit like men running from a licking.\"', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (87, 'The Haunter of the Ring', 'http://gutenberg.net.au/ebooks06/0601751h.html', NULL, NULL, NULL, NULL, 'AS I entered John Kirowan\'s study I was too much engrossed in my own thoughts to notice, at first, the haggard appearance of his visitor, a big, handsome young fellow well known to me. \"Hello, Kirowan,\" I greeted. \"Hello, Gordon. Haven\'t seen you for quite a while. How\'s Evelyn?\" And before he could answer, still on the crest of the enthusiasm which had brought me there, I exclaimed: \"Look here, you fellows, I\'ve got something that will make you stare! I got it from that robber Ahmed Mektub, and I paid high for it, but it\'s worth it. Look!\" From under my coat I drew the jewel-hilted Afghan dagger which had fascinated me as a collector of rare weapons. Kirowan, familiar with my passion, showed only polite interest, but the effect on Gordon was shocking. With a strangled cry he sprang up and backward, knocking the chair clattering to the floor. Fists clenched and countenance livid he faced me, crying: \"Keep back! Get away from me, or—\" I was frozen in my tracks. \"What in the—\" I began bewilderedly, when Gordon, with another amazing change of attitude, dropped into a chair and sank his head in his hands. I saw his heavy shoulders quiver. I stared helplessly from him to Kirowan, who seemed equally dumbfounded. \"Is he drunk?\" I asked. Kirowan shook his head, and filling a brandy glass, offered it to the man. Gordon looked up with haggard eyes, seized the drink and gulped it down like a man half famished. Then he straightened up and looked at us shamefacedly. \"I\'m sorry I went off my handle, O\'Donnel\" he said. \"It was the unexpected shock of you drawing that knife.\" \"Well,\" I retorted, with some disgust, \"I suppose you thought I was going to stab you with it!\" \"Yes, I did!\" Then, at the utterly blank expression on my face, he added: \"Oh, I didn\'t actually think that; at least, I didn\'t reach that conclusion by any process of reasoning. It was just the blind primitive instinct of a hunted man, against whom anyone\'s hand may be turned.\"\nHis strange words and the despairing way he said them sent a queer shiver of nameless apprehension down my spine.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (88, 'The Hoofed Thing', NULL, NULL, NULL, NULL, NULL, 'Marjory was crying over the loss of Bozo, her fat Maltese who had failed to appear after his usual nightly prowl. There had been a peculiar epidemic of feline disappearances in the neighborhood recently, and Marjory was disconsolate. And because I never could stand to see Marjory cry, I sallied forth in search of the missing pet, though I had little hope of finding him. Every so often some human pervert gratifies his sadistic mania by poisoning animals of which people are fond, and I was certain that Bozo and the score or more of his kind which had vanished in the past few months had fallen victims to some such degenerate.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (89, 'The Horror From the Mound', 'http://gutenberg.net.au/ebooks06/0601761h.html', NULL, NULL, NULL, NULL, 'STEVE BRILL did not believe in ghosts or demons. Juan Lopez did. But neither the caution of the one nor the sturdy skepticism of the other was shield against the horror that fell upon them—the horror forgotten by men for more than three hundred years—a screaming fear monstrously resurrected from the black lost ages. Yet as Steve Brill sat on his sagging stoop that last evening, his thoughts were as far from uncanny menaces as the thoughts of man can be. His ruminations were bitter but materialistic. He surveyed his farmland and he swore. Brill was tall, rangy and tough as boot-leather—true son of the iron-bodied pioneers who wrenched West Texas from the wilderness. He was browned by the sun and strong as a longhorned steer. His lean legs and the boots on them showed his cowboy instincts, and now he cursed himself that he had ever climbed off the hurricane deck of his crankeyed mustang and turned to farming. He was no farmer, the young puncher admitted profanely. Yet his failure had not all been his fault. Plentiful rain in the winter—so rare in West Texas—had given promise of good crops. But as usual, things had happened. A late blizzard had destroyed all the budding fruit. The grain which had looked so promising was ripped to shreds and battered into the ground by terrific hailstorms just as it was turning yellow. A period of intense dryness, followed by another hailstorm, finished the corn. Then the cotton, which had somehow struggled through, fell before a swarm of grasshoppers which stripped Brill\'s field almost overnight. So Brill sat and swore that he would not renew his lease—he gave fervent thanks that he did not own the land on which he had wasted his sweat, and that there were still broad rolling ranges to the West where a strong young man could make his living riding and roping. Now as Brill sat glumly, he was aware of the approaching form of his nearest neighbor, Juan Lopez, a taciturn old Mexican who lived in a hut just out of sight over the hill across the creek, and grubbed for a living. At present he was clearing a strip of land on an adjoining farm, and in returning to his hut he crossed a corner of Brill\'s pasture.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (90, 'The House of Arabu', 'http://gutenberg.net.au/ebooks06/0601771h.html', NULL, 'The Witch from Hell\'s Kitchen', NULL, NULL, 'HAS he seen a night-spirit, is he listening to the whispers of them who dwell in darkness?\" Strange words to be murmured in the feast-hall of Naram-ninub, amid the strain of lutes, the patter of fountains, and the tinkle of women\'s laughter. The great hall attested the wealth of its owner, not only by its vast dimensions, but by the richness of its adornment. The glazed surface of the walls offered a bewildering variegation of colors—blue, red, and orange enamels set off by squares of hammered gold. The air was heavy with incense, mingled with the fragrance of exotic blossoms from the gardens without. The feasters, silk-robed nobles of Nippur, lounged on satin cushions, drinking wine poured from alabaster vessels, and caressing the painted and bejeweled playthings which Naram-ninub\'s wealth had brought from all parts of the East. There were scores of these; their white limbs twinkled as they danced, or shone like ivory among the cushions where they sprawled. A jeweled tiara caught in a burnished mass of night-black hair, a gem-crusted armlet of massive gold, earrings of carven jade—these were their only garments. Their fragrance was dizzying. Shameless in their dancing, feasting and lovemaking, their light laughter filled the hall in waves of silvery sound. On a broad cushion-piled dais reclined the giver of the feast, sensuously stroking the glossy locks of a lithe Arabian who had stretched herself on her supple belly beside him. His appearance of sybaritic languor was belied by the vital sparkling of his dark eyes as he surveyed his guests. He was thick-bodied, with a short blue-black beard: a Semite—one of the many drifting yearly into Shumir. With one exception his guests were Shumirians, shaven of chin and head. Their bodies were padded with rich living, their features smooth and placid. The exception among them stood out in startling contrast. Taller than they, he had none of their soft sleekness. He was made with the economy of relentless Nature. His physique was of the primitive, not of the civilized athlete. He was an incarnation of Power, raw, hard, wolfish—in the sinewy limbs, the corded neck, the great arch of the breast, the broad hard shoulders. Beneath his tousled golden mane his eyes were like blue ice. His strongly chiselled features reflected the wildness his frame suggested. There was about him nothing of the measured leisure of the other guests, but a ruthless directness in his every action. Whereas they sipped, he drank in great gulps. They nibbled at tid-bits, but he seized whole joints in his fingers and tore at the meat with his teeth. Yet his brow was shadowed, his expression moody. His magnetic eyes were introspective. Wherefore Prince lbi-Engur lisped again in Naram-ninub\'s ear: \"Has the lord, Pyrrhas, heard the whispering of night-things?\"', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (91, 'In the Forest of Villefére', 'http://gutenberg.net.au/ebooks06/0607931h.html', NULL, NULL, NULL, NULL, 'THE sun had set. The great shadows came striding over the forest. In the weird twilight of a late summer day, I saw the path ahead glide on among the mighty trees and disappear. And I shuddered and glanced fearfully over my shoulder. Miles behind lay the nearest village—miles ahead the next. I looked to left and to right as I strode on, and anon I looked behind me. And anon I stopped short, grasping my rapier, as a breaking twig betokened the going of some small beast. Or was it a beast? But the path led on and I followed, because, forsooth, I had naught else to do. As I went I bethought me, \"My own thoughts will rout me, if I be not aware. What is there in this forest, except perhaps the creatures that roam it, deer and the like? Tush, the foolish legends of those villagers!\" And so I went and the twilight faded into dusk. Stars began to blink and the leaves of the trees murmured in the faint breeze. And then I stopped short, my sword leaping to my hand, for just ahead, around a curve of the path, someone was singing. The words I could not distinguish, but the accent was strange, almost barbaric. I stepped behind a great tree, and the cold sweat beaded my forehead. Then the singer came in sight, a tall, thin man, vague in the twilight. I shrugged my shoulders. A man I did not fear. I sprang out, my point raised. \"Stand!\"', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (92, 'Kelly the Conjure-Man', NULL, NULL, NULL, NULL, NULL, 'There are strange tales told when the full moon shines Of voodoo nights when the ghost-things ran — But the strangest figure among the pines Was Kelly the conjure-man. About seventy-five miles north-east of the great Smackover oil field of Arkansas lies a densely wooded country of pinelands and rivers, rich in folklore and tradition. Here, in the early 1850s came a sturdy race of Scotch-Irish pioneers pushing back the frontier and hewing homes in the tangled wilderness. Among the many picturesque characters of those early days, one figure stands out, sharply, yet dimly limned against a background of dark legendry and horrific fable — the sinister figure of Kelly, the black conjurer. Son of a Congo ju-ju man, legend whispered, Kelly, born a slave, exercised in his day unfathomed power among the darkest of the Ouachita pinelands. Where he came from is not exactly known; he drifted into the country shortly after the Civil War and mystery was attendant on his coming as upon all his actions.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (93, 'The Man on the Ground', 'http://gutenberg.net.au/ebooks08/0801231h.html', NULL, NULL, NULL, NULL, 'CAL REYNOLDS shifted his tobacco quid to the other side of his mouth as he squinted down the dull blue barrel of his Winchester. His jaws worked methodically, their movement ceasing as he found his bead. He froze into rigid immobility; then his finger hooked on the trigger. The crack of the shot sent the echoes rattling among the hills, and like a louder echo came an answering shot. Reynolds flinched down, flattening his rangy body against the earth, swearing softly. A gray flake jumped from one of the rocks near his head, the ricocheting bullet whining off into space. Reynolds involuntarily shivered. The sound was as deadly as the singing of an unseen rattler. He raised himself gingerly high enough to peer out between the rocks in front of him. Separated from his refuge by a broad level grown with mesquite-grass and prickly-pear, rose a tangle of boulders similar to that behind which he crouched. From among these boulders floated a thin wisp of whitish smoke. Reynold\'s keen eyes, trained to sun-scorched distances, detected a small circle of dully gleaming blue steel among the rocks. That ring was the muzzle of a rifle, but Reynolds well knew who lay behind that muzzle. The feud between Cal Reynolds and Esau Brill had been long, for a Texas feud. Up in the Kentucky mountains family wars may straggle on for generations, but the geographical conditions and human temperament of the Southwest were not conducive to long-drawn-out hostilities. There feuds were generally concluded with appalling suddenness and finality. The stage was a saloon, the streets of a little cow-town, or the open range. Sniping from the laurel was exchanged for the close-range thundering of six-shooters and sawed-off shotguns which decided matters quickly, one way or the other.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (94, 'The Noseless Horror', NULL, NULL, NULL, NULL, NULL, 'Abysses of unknown terror lie veiled by the mists which separate man\'s everyday life from the uncharted and unguessed realms of the supernatural. The majority of people live and die in blissful ignorance of these realms — I say blissful, for the rending of the veil between the worlds of reality and of the occult is often a hideous experience. Once have I seen the veil so rent, and the incidents attendant thereto were burned so deeply into my brain that my dreams are haunted to this day.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (95, 'Old Garfield\'s Heart', 'http://gutenberg.net.au/ebooks08/0801211h.html', NULL, NULL, NULL, NULL, 'I WAS SITTING on the porch when my grandfather hobbled out and sank down on his favorite chair with the cushioned seat, and began to stuff tobacco in his old corncob-pipe. \"I thought you\'d be goin\' to the dance,\" he said. \"I\'m waiting for Doc Blaine,\" I answered. \"I\'m going over to old man Garfield\'s with him.\" My grandfather sucked at his pipe awhile before he spoke again. \"Old Jim purty bad off?\" \"Doc says he hasn\'t a chance.\" \"Who\'s takin\' care of him?\" \"Joe Braxton—­against Garfield\'s wishes. But somebody had to stay with him.\" My grandfather sucked his pipe noisily, and watched the heat lightning playing away off up in the hills; then he said: \"You think old Jim\'s the biggest liar in this county, don\'t you?\" \"He tells some pretty tall tales,\" I admitted. \"Some of the things he claimed he took part in, must have happened before he was born.\" \"I came from Tennesee to Texas in 1870,\" my grandfather said abruptly. \"I saw this town of Lost Knob grow up from nothin\'. There wasn\'t even a log-hut store here when I came. But old Jim Garfield was here, livin\' in the same place he lives now, only then it was a log cabin. He don\'t look a day older now than he did the first time I saw him.\" \"You never mentioned that before,\" I said in some surprise.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (96, 'Out of the Deep', NULL, NULL, NULL, NULL, NULL, 'Adam Falcon sailed at dawn and Margeret Deveral, the girl who was to marry him, stood on the wharfs in the cold vaguesness to wave a good-bye. At dusk Margeret knelt, stony eyed, above the still white form that the crawling tide had left crumpled on the beach. The people of Faring town gathered about, whispering: \"The fog hung heavy; mayhap she went ashore on Ghost Reef. Strange that his corpse alone should drift back to Faring harbor — and so swiftly.\" And an undertone: \"Alive or dead, he would come to her!\" The body lay above the tide mark, as if flung by a vagrant wave; slim, but strong and virile in life, now darkly handsome even in death. The eyes were closed, strange to say, so it appeared that he but slept. The seaman\'s clothes he wore dripped salt water and fragments of sea-weed clung to them.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (97, 'People of the Dark', 'http://gutenberg.net.au/ebooks06/0607941h.html', NULL, NULL, NULL, NULL, 'I CAME to Dagon\'s Cave to kill Richard Brent. I went down the dusky avenues made by the towering trees, and my mood well-matched the primitive grimness of the scene. The approach to Dagon\'s Cave is always dark, for the mighty branches and thick leaves shut out the sun, and now the somberness of my own soul made the shadows seem more ominous and gloomy than was natural. Not far away I heard the slow wash of the waves against the tall cliffs, but the sea itself was out of sight, masked by the dense oak forest. The darkness and the stark gloom of my surroundings gripped my shadowed soul as I passed beneath the ancient branches—as I came out into a narrow glade and saw the mouth of the ancient cavern before me. I paused, scanning the cavern\'s exterior and the dim reaches of the silent oaks. The man I hated had not come before me! I was in time to carry out my grim intent. For a moment my resolution faltered, then like a wave there surged over me the fragrance of Eleanor Bland, a vision of wavy golden hair and deep gray eyes, changing and mystic as the sea. I clenched my hands until the knuckles showed white, and instinctively touched the wicked snub-nosed revolver whose weight sagged my coat pocket. But for Richard Brent, I felt certain I had already won this woman, desire for whom made my waking hours a torment and my sleep a torture. Whom did she love? She would not say; I did not believe she knew. Let one of us go away, I thought, and she would turn to the other. And I was going to simplify matters for her—and for myself. By chance I had overheard my blond English rival remark that he intended coming to lonely Dagon\'s Cave on an idle exploring outing—alone.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (98, 'Pigeons From Hell', 'http://gutenberg.net.au/ebooks06/0600721h.html', NULL, NULL, NULL, NULL, 'GRISWELL awoke suddenly, every nerve tingling with a premonition of imminent peril. He stared about wildly, unable at first to remember where he was, or what he was doing there. Moonlight filtered in through the dusty windows, and the great empty room with its lofty ceiling and gaping black fireplace was spectral and unfamiliar. Then as he emerged from the clinging cobwebs of his recent sleep, he remembered where he was and how he came to be there. He twisted his head and stared at his companion, sleeping on the floor near him. John Branner was but a vaguely bulking shape in the darkness that the moon scarcely grayed. Griswell tried to remember what had awakened him. There was no sound in the house, no sound outside except the mournful hoot of an owl, far away in the piny woods. Now he had captured the illusive memory. It was a dream, a nightmare so filled with dim terror that it had frightened him awake. Recollection flooded back, vividly etching the abominable vision. Or was it a dream? Certainly it must have been, but it had blended so curiously with recent actual events that it was difficult to know where reality left off and fantasy began. Dreaming, he had seemed to relive his past few waking hours, in accurate detail. The dream had begun, abruptly, as he and John Branner came in sight of the house where they now lay. They had come rattling and bouncing over the stumpy, uneven old road that led through the pinelands, he and John Branner, wandering far afield from their New England home, in search of vacation pleasure. They had sighted the old house with its balustraded galleries rising amidst a wilderness of weeds and bushes, just as the sun was setting behind it. It dominated their fancy, rearing black and stark and gaunt against the low lurid rampart of sunset, barred by the black pines. They were tired, sick of bumping and pounding all day over woodland roads. The old deserted house stimulated their imagination with its suggestion of antebellum splendor and ultimate decay. They left the automobile beside the rutty road, and as they went up the winding walk of crumbling bricks, almost lost in the tangle of rank growth, pigeons rose from the balustrades in a fluttering, feathery crowd and swept away with a low thunder of beating wings.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (99, 'Restless Waters', NULL, NULL, NULL, NULL, NULL, 'As if it were yesterday, I remember that terrible night in the Silver Slipper, in the late fall of 1845. Outside, the wind roared in an icy gale and the sleet drove with it, till it rattled against the windows like the knucklebones of a skeleton. As we sat about the tavern fire, we could hear, booming above the wind and the sleet, the thunder of the white surges that beat frenziedly against the stark New England coast. The ships in the harbor of the little seaport town lay double anchored, and the captains sought the warmth and companionship to be found in the wharf-side taverns. There in the Silver Slipper that night were four men and I, the tap boy. There was Ezra Harper, the host; John Gower, captain of the Sea-Woman; Jonas Hopkins, a lawyer out of Salem; and Captain Starkey of The Vulture. These four men sat about the heavy oaken table in front of the great fire which roared in the fireplace, and I scurried about the tavern attending to their wants, filling mugs, and heating spiced drinks.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (100, 'Sea Curse', 'http://gutenberg.net.au/ebooks06/0601731h.html', NULL, NULL, NULL, NULL, 'THEY were the brawlers and braggarts, the loud boasters and hard drinkers, of Faring town, John Kulrek and his crony Lie-lip Canool. Many a time have I, a tousle-haired lad, stolen to the tavern door to listen to their curses, their profane arguments and wild sea songs; half fearful and half in admiration of these wild rovers. Aye, all the people of Faring town gazed on them with fear and admiration, for they were not like the rest of the Faring men; they were not content to ply their trade along the coasts and among the shark-teeth shoals. No yawls, no skiffs for them! They fared far, farther than any other man in the village, for they shipped on the great sailing-ships that went out on the white tides to brave the restless grey ocean and make ports in strange lands. Ah, I mind it was swift times in the little sea-coast village of Faring when John Kulrek came home, with the furtive Lie-lip at his side, swaggering down the gang-plank, in his tarry sea-clothes, and the broad leather belt that held his ever-ready dagger; shouting condescending greeting to some favored acquaintance, kissing some maiden who ventured too near; then up the street, roaring some scarcely decent song of the sea. How the cringers and the idlers, the hangers-on, would swarm about the two desperate heroes, flattering and smirking, guffawing hilariously at each nasty jest. For to the tavern loafers and to some of the weaker among the straightforward villagers, these men with their wild talk and their brutal deeds, their tales of the Seven Seas and the far countries, these men, I say, were valiant knights, nature\'s noblemen who dared to be men of blood and brawn. And all feared them, so that when a man was beaten or a woman insulted, the villagers muttered—and did nothing. And so when Moll Farrell\'s niece was put to shame by John Kulrek, none dared even to put into words what all thought. Moll had never married, and she and the girl lived alone in a little hut down close to the beach, so close that in high tide the waves came almost to the door. The people of the village accounted old Moll something of a witch, and she was a grim, gaunt old dame who had little to say to anyone. But she minded her own business, and eked out a slim living by gathering clams, and picking up bits of driftwood.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (101, 'The Shadow of the Beast', NULL, NULL, NULL, NULL, NULL, 'As long as evil stars arise Or moonlight fires the East, May God in Heaven preserve us from The Shadow of the Beast! The horror had its beginning in the crack of a pistol in a black hand. A white man dropped with a bullet in his chest and the negro who had fired the shot turned and fled, after a single hideous threat hurled at the pale-faced girl who stood horror-struck close by. Within an hour grim-faced men were combing the pine woods with guns in their hands, and on through the night the grisly hunt went on, while the victim of the hunted lay fighting for his life. \"He\'s quiet now; they say he\'ll live,\" his sister said, as she came out of the room where the boy lay. Then she sank down into a chair and gave way to a burst of tears.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (102, 'Spectres in the Dark', NULL, NULL, NULL, NULL, NULL, 'The following item appeared in a Los Angeles paper, one morning in late summer: \"A murder of the most appalling and surprizing kind occurred at 333 — Street late yesterday evening. The victim was Hildred Falrath, 77, a retired professor of psychology, formerly connected with the University of California. The slayer was a pupil of his, Clement Van Dorn, 33, who has, for the last few months, been in the habit of coming to Falrath\'s apartment at 333 — Street for private instruction. The affair was particularly heinous, the aged victim having been stabbed through the arm and the breast with a dagger, while his features were terribly battered. Van Dorn, who appears to be in a dazed condition, admits the slaying but claims that the professor attacked him and that he acted only in self defense.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (103, 'The Spirit of Tom Molyneaux (version 2)', NULL, NULL, NULL, NULL, NULL, 'Many fights are won and lost by the living, but this is a tale of one which was won by a man dead over a hundred years. John Taverel, manager of ring champions, sitting in the old East Side A.C. one cold wintry day, told me this story of the ghost that won the fight and the man who worshipped the ghost. Let John Taverel tell the tale in his own words, as he told it to me: You remember Ace Jessel, the great negro boxer whom I managed. An ebony giant he was, four inches over six feet in height, his fighting weight two hundred and thirty pounds. He moved with the smooth ease of a gigantic leopard and his pliant steel muscles rippled under his shiny skin. A clever boxer for so large a man, he carried the smashing jolt of a trip hammer in each huge black fist.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (104, 'The Thing on the Roof', 'http://gutenberg.net.au/ebooks06/0608011h.html', NULL, NULL, NULL, NULL, 'LET me begin by saying that I was surprised when Tussmann called on me. We had never been close friends; the man\'s mercenary instincts repelled me; and since our bitter controversy of three years before, when he attempted to discredit my Evidences of Nahua Culture in Yucatan, which was the result of years of careful research, our relations had been anything but cordial. However, I received him and found his manner hasty and abrupt, but rather abstracted, as if his dislike for me had been thrust aside in some driving passion that had hold of him. His errand was quickly stated. He wished my aid in obtaining a volume in the first edition of Von Junzt\'s Nameless Cults—the edition known as the Black Book, not from its color, but because of its dark contents. He might almost as well have asked me for the original Greek translation of the Necronomicon. Though since my return from Yucatan I had devoted practically all my time to my avocation of book collecting, I had not stumbled onto any hint that the book in the Dusseldorf edition was still in existence. A word as to this rare work. Its extreme ambiguity in spots, coupled with its incredible subject matter, has caused it long to be regarded as the ravings of a maniac and the author was damned with the brand of insanity. But the fact remains that much of his assertions are unanswerable, and that he spent the full forty- five years of his life prying into strange places and discovering secret and abysmal things. Not a great many volumes were printed in the first edition and many of these were burned by their frightened owners when Von Junzt was found strangled in a mysterious manner, in his barred and bolted chamber one night in 1840, six months after he had returned from a mysterious journey to Mongolia.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (105, 'The Valley of the Lost', NULL, NULL, NULL, NULL, NULL, 'As a wolf spies upon its hunters, John Reynolds watched his pursuers. He lay close in a thicket on the slope, a red inferno of hate seething in his heart. He had ridden hard; up the slope behind him, where the dim path would up out of Lost Valley, his crank-eyed mustang stood, head drooping, trembling, after the long run. Below him, not more than eighty yards away, stood his enemies, fresh come from the slaughter of his kinsmen. In the clearing fronting Ghost Cave they had dismounted and were arguing among themselves. John Reynolds knew them all with an old, bitter hate. The black shadow of feud lay between them and hiimself.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (106, 'Wolfshead', 'http://gutenberg.net.au/ebooks06/0601801h.html', NULL, NULL, NULL, NULL, 'FEAR? Your pardon, Messieurs, but the meaning of fear you do not know. No, I hold to my statement. You are soldiers, adventurers. You have known the charges of regiments of dragoons, the frenzy of wind-lashed seas. But fear, real hair-raising, horror-crawling fear, you have not known. I myself have known such fear; but until the legions of darkness swirl from hell\'s gate and the world flames to ruin, will never such fear again be known to men. Hark, I will tell you the tale; for it was many years ago and half across the world; and none of you will ever see the man of whom I tell you, or seeing, know. Return, then, with me across the years to a day when I; a reckless young cavalier, stepped from the small boat that had landed me from the ship floating in the harbor, cursed the mud that littered the crude wharf, and strode up the landing toward the castle, in answer to the invitation of an old friend, Dom Vincente da Lusto. Dom Vincente was a strange, far-sighted man—a strong man, one who saw visions beyond the ken of his time. In his veins, perhaps, ran the blood of those old Phoenicians who, the priests tell us, ruled the seas and built cities in far lands, in the dim ages. His plan of fortune was strange and yet successful; few men would have thought of it; fewer could have succeeded. For his estate was upon the western coast of that dark, mystic continent, that baffler of explorers—Africa.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (107, 'The Fightin\'est Pair', 'http://gutenberg.net.au/ebooks06/0608581h.html', NULL, 'Breed of Battle', NULL, NULL, 'ME and my white bulldog Mike was peaceably taking our beer in a joint on the waterfront when Porkey Straus come piling in, plumb puffing with excitement. \"Hey, Steve!\" he yelped. \"What you think? Joe Ritchie\'s in port with Terror.\" \"Well?\" I said. \"Well, gee whiz,\" he said, \"you mean to set there and let on like you don\'t know nothin\' about Terror, Ritchie\'s fightin\' brindle bull? Why, he\'s the pit champeen of the Asiatics. He\'s killed more fightin\' dogs than—\" \"Yeah, yeah,\" I said impatiently. \"I know all about him. I been listenin\' to what a bear-cat he is for the last year, in every Asiatic port I\'ve touched.\"\n\"Well,\" said Porkey, \"I\'m afraid we ain\'t goin\' to git to see him perform.\" \"Why not?\" asked Johnnie Blinn, a shifty-eyed bar-keep. \"Well,\" said Porkey, \"they ain\'t a dog in Singapore to match ag\'in\' him. Fritz Steinmann, which owns the pit and runs the dog fights, has scoured the port and they just ain\'t no canine which their owners\'ll risk ag\'in\' Terror. Just my luck. The chance of a lifetime to see the fightin\'est dog of \'em all perform. And they\'s no first-class mutt to toss in with him. Say, Steve, why don\'t you let Mike fight him?\" \"Not a chance,\" I growled. \"Mike gets plenty of scrappin\' on the streets. Besides, I\'ll tell you straight, I think dog fightin\' for money is a dirty low-down game. Take a couple of fine, upstandin\' dogs, full of ginger and fightin\' heart, and throw \'em in a concrete pit to tear each other\'s throats out, just so a bunch of four-flushin\' tin-horns like you, which couldn\'t take a punch or give one either, can make a few lousy dollars bettin\' on \'em.\" \"But they likes to fight,\" argued Porkey. \"It\'s their nature.\"', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (108, '\"For the Love of Barbara Allen\"', 'https://archive.org/details/Fantasy_Science_Fiction_v031n02_1966-08_PDF/page/n79/mode/2up', NULL, NULL, NULL, NULL, 'My grandfather sighed and thumped wearily on his guitar, than laid it aside, the song unfinished. ‘‘My voice is too old and cracked,” he said, leaning back in his cushion-seated chair and fumbling in the pockets of his sagging old vest for cob-pipe and tobacco. “Reminds me of my brother Joel. The way he could sing that song. It was his favorite. Makes me think of poor old Rachel Ormond, who loved him. She’s dyin’, her nephew Jim Ormond told me yesterday. She’s old, older’n I am. You never saw her, did you?” I shook my head. “She was a real beauty when she was young, and Joel was alive and lovin’ her. He had a fine voice, Joel, and he loved to play his guitar and sing. He’d sing as he rode along. He v^as singin’ ‘Barbara Allen’ when he met Rachel Ormond. She heard him singin’ and come out of the laurel beside the road to listen. When Joel saw her standin’ there with the mornin’ sun behind her makin’ jewels out of the dew on the bushes, he stopped dead and just stared like a fool. He told me it seemed as if she was standin’ in a white blaze of light.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (109, 'The Grey God Passes', 'http://www.dunyazad-library.net/a/howard--kull-bran-turlogh.pdf', NULL, NULL, NULL, NULL, 'A voice echoed among the bleak reaches of the mountains that reared up gauntly on either hand. At the mouth of the defile that opened on a colossal crag, Conn the thrall wheeled, snarling like a wolf at bay. He was tall and massively, yet angrily, built, the fierceness of the wild dominant in his broad, sloping shoulders, his huge hairy chest and long, heavily muscled arms. His features were in keeping with his bodily aspect — a strong, stubborn jaw, low slanting forehead topped by a shock of tousled tawny hair which added to the wildness of his appearance no more than did his cold blue eyes. His only garment was a scanty loin-cloth. His own wolfish ruggedness was protection enough against the elements — for he was a slave in an age when even the masters lived lives as hard as the iron environments which bred them. Now Conn half crouched, sword ready, a bestial snarl of menace humming in his bull-throat, and from the defile there came a tall man, wrapped in a cloak beneath which the thrall glimpsed a sheen of mail. The stranger wore a slouch hat pulled so low that from his shadowed features only one eye gleamed, cold and grim as the grey sea. “Well, Conn, thrall of Wolfgar Snorri’s son,” said the stranger in a deep, powerful voice, “whither do you flee, with your master’s blood on your hands?” “I know you not,” growled Conn, “nor how you know me. If you would take me, whistle up your dogs and make an end. Some of them will taste steel ere I die.”', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (110, 'Lord of the Dead', NULL, NULL, NULL, NULL, NULL, 'The onslaught was as unexpected as the stroke of an unseen cobra. One second Steve Harrison was plodding profanely but prosaically through the darkness of the alley — the next, he was fighting for his life with the snarling, mouthing fury that had fallen on him, talon and tooth. The thing was obviously a man, though in the first few dazed seconds Harrison doubted even this fact. The attacker\'s style of fighting was appallingly vicious and beast-like, even to Harrison who was accustomed to the foul battling of the underworld. The detective felt the other\'s teeth in his flesh, and yelped profanely. But there was a knife, too; it ribboned his coat and shirt, and drew blood, and only blind chance that locked his fingers about a sinewy wrist, kept the point from his vitals. It was dark as the backdoor of Erebus. Harrison saw his assailant only as a slightly darker chunk in the blackness. The muscles under his grasping fingers were taut and steely as piano wire, and there was a terrifying suppleness about the frame writhing against his which filled Harrison with panic. The big detective had seldom met a man his equal in strength; this denizen of the dark not only was as strong as he, but was lither and quicker and tougher than a civilized man ought to be.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (111, 'Sharp\'s Gun Serenade', 'http://gutenberg.net.au/ebooks06/0608741h.html', NULL, 'Educate or Bust', NULL, NULL, 'I WAS heading for War Paint, jogging along easy and comfortable, when I seen a galoot coming up the trail in a cloud of dust, jest aburning the breeze. He didn\'t stop to pass the time of day. He went past me so fast Cap\'n Kidd missed the snap he made at his hoss, which shows he was sure hightailing it. I recognized him as Jack Sprague, a young waddy which worked on a spread not far from War Paint. His face was pale and sot in a look of desprut resolution, like a man which has jest bet his pants on a pair of deuces, and he had a rope in his hand though I couldn\'t see nothing he might be aiming to lasso. He went fogging on up the trail into the mountains and I looked back to see if I could see the posse. Because about the only time a outlander ever heads for the high Humbolts is when he\'s about three jumps and a low whoop ahead of a necktie party. I seen another cloud of dust, all right, but it warn\'t big enough for more\'n one man, and purty soon I seen it was Bill Glanton of War Paint. But that was good enough reason for Sprague\'s haste, if Bill was on the prod. Glanton is from Texas, original, and whilst he is a sentimental cuss in repose he\'s a ring-tailed whizzer with star-spangled wheels when his feelings is ruffled. And his feelings is ruffled tolerable easy.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (112, 'The Valley of the Worm', 'http://gutenberg.net.au/ebooks06/0600731h.html', NULL, NULL, NULL, NULL, 'I WILL tell you of Niord and the Worm. You have heard the tale before in many guises wherein the hero was named Tyr, or Perseus, or Siegfried, or Beowulf, or Saint George. But it was Niord who met the loathly demoniac thing that crawled hideously up from hell, and from which meeting sprang the cycle of hero-tales that revolves down the ages until the very substance of the truth is lost and passes into the limbo of all forgotten legends. I know whereof I speak, for I was Niord. As I lie here awaiting death, which creeps slowly upon me like a blind slug, my dreams are filled with glittering visions and the pageantry of glory. It is not of the drab, disease-racked life of James Allison I dream, but all the gleaming figures of the mighty pageantry that have passed before, and shall come after; for I have faintly glimpsed, not merely the shapes that trail out behind, but shapes that come after, as a man in a long parade glimpses, far ahead, the line of figures that precede him winding over a distant hill, etched shadow like against the sky. I am one and all the pageantry of shapes and guises and masks which have been, are, and shall be the visible manifestations of that illusive, intangible, but vitally existent spirit now promenading under the brief and temporary name of James Allison. Each man on earth, each woman, is part and all of a similar caravan of shapes and beings. But they can not remember—their minds can not bridge the brief, awful gulfs of blackness which lie between those unstable shapes, and which the spirit, soul or ego, in spanning, shakes off its fleshy masks. I remember. Why I can remember is the strangest tale of all; but as I lie here with death\'s black wings slowly unfolding over me, all the dim folds of my previous lives are shaken out before my eyes, and I see myself in many forms and guises—braggart, swaggering, fearful, loving, foolish, all that men—have been or will be.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (113, 'Black Vulmea\'s Vengeance', 'http://gutenberg.net.au/ebooks06/0601661h.html', NULL, NULL, NULL, NULL, 'OUT of the Cockatoo\'s cabin staggered Black Terence Vulmea, pipe in one hand and flagon in the other. He stood with booted legs wide, teetering slightly to the gentle lift of the lofty poop. He was bareheaded and his shirt was open, revealing his broad hairy chest. He emptied the flagon and tossed it over the side with a gusty sigh of satisfaction, then directed his somewhat blurred gaze on the deck below. From poop ladder to forecastle it was littered by sprawling figures. The ship smelt like a brewery. Empty barrels, with their heads stove in, stood or rolled between the prostrate forms. Vulmea was the only man on his feet. From galley-boy to first mate the rest of the ship\'s company lay senseless after a debauch that had lasted a whole night long. There was not even a man at the helm. But it was lashed securely and in that placid sea no hand was needed on the wheel. The breeze was light but steady. Land was a thin blue line to the east. A stainless blue sky held a sun whose heat had not yet become fierce. Vulmea blinked indulgently down upon the sprawled figures of his crew, and glanced idly over the larboard side. He grunted incredulously and batted his eyes. A ship loomed where he had expected to see only naked ocean stretching to the skyline. She was little more than a hundred yards away, and was bearing down swiftly on the Cockatoo, obviously with the intention of laying her alongside. She was tall and square-rigged, her white canvas flashing dazzlingly in the sun. From the maintruck the flag of England whipped red against the blue. Her bulwarks were lined with tense figures, bristling with boarding-pikes and grappling irons, and through her open ports the astounded pirate glimpsed the glow of the burning matches the gunners held ready. \"All hands to battle-quarters!\" yelled Vulmea confusedly. Reverberant snores answered the summons. All hands remained as they were. \"Wake up, you lousy dogs!\" roared their captain. \"Up, curse you! A king\'s ship is at our throats!\"', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (114, 'The Bull Dog Breed', 'http://gutenberg.net.au/ebooks06/0609151h.html', NULL, NULL, NULL, NULL, 'AND SO,\" concluded the Old Man, \"this big bully ducked the seltzer bottle and the next thing I knowed I knowed nothin\'. I come to with the general idee that the Sea Girl was sinkin\' with all hands and I was drownin\'—but it was only some chump pourin\' water all over me to bring me to. Oh, yeah, the big French cluck I had the row with was nobody much, I learned—just only merely nobody but Tiger Valois, the heavyweight champion of the French navy—\" Me and the crew winked at each other. Until the captain decided to unburden to Penrhyn, the first mate, in our hearing, we\'d wondered about the black eye he\'d sported following his night ashore in Manila. He\'d been in an unusual bad temper ever since, which means he\'d been acting like a sore-tailed hyena. The Old Man was a Welshman, and he hated a Frenchman like he hated a snake. He now turned on me. \"If you was any part of a man, you big mick ham,\" he said bitterly, \"you wouldn\'t stand around and let a blankety-blank French so-on and so-forth layout your captain. Oh, yeah, I know you wasn\'t there, then, but if you\'ll fight him—\" \"Aragh!\" I said with sarcasm, \"leavin\' out the fact that I\'d stand a great chance of gettin\' matched with Valois—why not pick me somethin\' easy, like Dempsey? Do you realize you\'re askin\' me, a ordinary ham-an\'-egger, to climb the original and only Tiger Valois that\'s whipped everything in European and the Asian waters and looks like a sure bet for the world\'s title?\"', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (115, 'Gents on the Lynch', 'https://gutenberg.net.au/ebooks13/1303991h.html', NULL, NULL, NULL, NULL, 'Blue Lizard, Colorado, September 1, 1879. Mister Washington Bearfield, Antioch, Colorado. Dear Brother Wash: Well, Wash, I reckon you think you air smart persuading me to quit my job with the Seven Prong Pitchfork outfit and come way up here in the mountains to hunt gold. I knowed from the start I warn\'t no prospector, but you talked so much you got me addled and believing what you said, and the first thing I knowed I had quit my job and withdrawed from the race for sheriff of Antioch and was on my way. Now I think about it, it is a dern funny thing you got so anxious for me to go prospecting jest as elections was coming up. You never before showed no anxiety for me to git rich finding gold or no other way. I am going to hunt me a quiet spot and set down and study this over for a few hours, and if I decide you had some personal reason for wanting me out of Antioch, I aim to make you hard to ketch. All my humiliating experiences in Blue Lizard is yore fault, and the more I think about it, the madder I git. And yet it all come from my generous nature which cain\'t endure to see a feller critter in distress onless I got him that way myself. Well, about four days after I left Antioch I hove into the Blue Lizard country one forenoon, riding Satanta and leading my pack mule, and I was passing through a canyon about three mile from the camp when I heard dawgs baying. The next minute I seen three of them setting around a big oak tree barking fit to bust yore ear-drums. I rode up to see what they\'d treed and I\'m a Injun if it warn\'t a human being! It was a tall man without no hat nor gun in his scabbard, and he was cussing them dawgs so vigorous he didn\'t hear me till I rode up and says: \"Hey, what you doin\' up there?\" He like to fell out of the crotch he was setting in, and then he looked down at me very sharp for a instant, and said: \"I taken refuge from them vicious beasts. I was goin\' along mindin\' my own business when they taken in after me. I think they got hyderphoby. I\'ll give you five bucks if you\'ll shoot \'em. I lost my gun.\"', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (116, 'Vultures of Wahpeton', 'http://gutenberg.net.au/ebooks06/0608151h.html', NULL, NULL, NULL, NULL, 'THE bare plank walls of the Golden Eagle Saloon seemed still to vibrate with the crashing echoes of the guns which had split the sudden darkness with spurts of red. But only a nervous shuffling of booted feet sounded in the tense silence that followed the shots. Then somewhere a match rasped on leather and a yellow flicker sprang up, etching a shaky hand and a pallid face. An instant later an oil lamp with a broken chimney illuminated the saloon, throwing tense bearded faces into bold relief. The big lamp that hung from the ceiling was a smashed ruin; kerosene dripped from it to the floor, making an oily puddle beside a grimmer, darker pool. Two figures held the center of the room, under the broken lamp. One lay facedown, motionless arms outstretching empty hands. The other was crawling to his feet, blinking and gaping stupidly, like a man whose wits are still muddled by drink. His right arm hung limply by his side, a long-barreled pistol sagging from his fingers. The rigid line of figures along the bar melted into movement. Men came forward, stooping to stare down at the limp shape. A confused babble of conversation rose. Hurried steps sounded outside, and the crowd divided as a man pushed his way abruptly through. Instantly he dominated the scene. His broad-shouldered, trim-hipped figure was above medium height, and his broad-brimmed white hat, neat boots and cravat contrasted with the rough garb of the others, just as his keen, dark face with its narrow black mustache contrasted with the bearded countenances about him. He held an ivory-butted gun in his right hand, muzzle tilted upward. \"What devil\'s work is this?\" he harshly demanded; and then his gaze fell on the man on the floor. His eyes widened.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (117, 'Wild Water', NULL, NULL, NULL, NULL, NULL, 'Saul Hopkins was king of Locust Valley, but kingship never turned hot lead. In the wild old days, not so long distant, another man was king of the Valley, and his methods were different and direct. He ruled by the gunds, wire-clippers and branding irons of his wiry, hard-handed, hard-eyed riders. But those days were past and gone, and Saul Hopkins sat in his office in Bisley and pulled strings to which were tied loans and mortgages and the subtle tricks of finance. Times have changed since Locust Valley reverberated to the guns of rival cattlemen, and Saul Hopkins, by all modern standards, should have lived and died king of the Valley by virtue of his gold and lands; but he met a man in whom the old ways still lived.', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `poem`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (1, 'Am-ra the Ta-an', NULL, 'Out of the land of the morning sun, Am-ra the Ta-an came. Outlawed by the priests of the Ta-an, His people spoke not his name. Am-ra, the mighty hunter, Am-ra, son of the spear, Strong and bold as a lion, Lithe and swift as a deer. Into the land of the tiger, Came Am-ra the fearless, alone, With his bow of pliant lance-wood, And his spear with the point of stone.');
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (2, 'The King and the Oak', 'http://gutenberg.net.au/ebooks13/1303801h.html', 'Before the shadows slew the sun the kites were soaring free,\nAnd Kull rode down the forest road, his red sword at his knee;\nAnd winds were whispering round the world: \"King Kull rides to the sea.\"\n\nThe sun died crimson in the sea, the long gray shadows fell;\nThe moon rose like a silver skull that wrought a demon\'s spell,\nFor in its light great trees stood up like spectres out of hell.');
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (3, 'Summer Morn', NULL, 'Am-ra stood on a mountain height At the break of a summer morn; He watched in wonder the starlight fall And the eastern scarlet flare and pale As the flame of day was born.');
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (4, 'Cimmeria', 'http://gutenberg.net.au/ebooks13/1303771h.html', 'It was gloomy land that seemed to hold\nAll winds and clouds and dreams that shun the sun,\nWith bare boughs rattling in the lonesome winds,\nAnd the dark woodlands brooding over all,\nNot even lightened by the rare dim sun\nWhich made squat shadows out of men; they called it\nCimmeria, land of Darkness and deep Night.\n\nIt was so long ago and far away\nI have forgotten the very name men called me.\nThe axe and flint-tipped spear are like a dream,\nAnd hunts and wars are like shadows. I recall\nOnly the stillness of that sombre land;\nThe clouds that piled forever on the hills,\nThe dimness of the everlasting woods.\nCimmeria, land of Darkness and the Night.');
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (5, 'The One Black Stain', NULL, 'They carried him out on the barren sand where the rebel captains died; Where the grim grey rotting gibbets stand as Magellan reared them on the strand, And the gulls that haunt the lonesome land wail to the lonely tide.');
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (6, 'The Return of Sir Richard Grenville', NULL, 'One slept beneath the branches dim,\nCloaked in the crawling mist,\nAnd Richard Grenville came to him\nAnd plucked him by the wrist.\n\nNo nightwind shook the forest deep\nWhere the shadows of Doom were spread,\nAnd Solomon Kane awoke from sleep\nAnd looked upon the dead.\n\nHe spake in wonder, not in fear:\n\"How walks a man who died?\n\"Friend of old times, what do ye here,\n\"Long fallen at my side?\"\n\n\"Rise up, rise up,\" Sir Richard said,\n\"The hounds of doom are free;\n\"The slayers come to take your head\n\"To hang on the ju-ju tree.');
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (7, 'Solomon Kane\'s Homecoming', 'http://gutenberg.net.au/ebooks13/1303871h.html', 'The white gulls wheeled above the cliffs,\n     the air was slashed with foam,\nThe long tides moaned along the strand\n     when Solomon Kane came home.\nHe walked in silence strange and dazed\n     through the little Devon town,\nHis gaze, like a ghost’s come back to life,\n     roamed up the streets and down.\n\nThe people followed wonderingly\n     to mark his spectral stare,\nAnd in the tavern silently\n     they thronged about him there.\nHe heard as a man hears in a dream\n     the worn old rafters creak,\nAnd Solomon lifted his drinking-jack\n     and spoke as a ghost might speak:\n\n“There sat Sir Richard Grenville once;\n     in smoke and flame he passed,\n“And we were one to fifty-three,\n     but we gave them blast for blast.\n“From crimson dawn to crimson dawn,\n     we held the Dons at bay.\n“The dead lay littered on our decks,\n     our masts were shot away.');
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (8, 'A Song of the Race', NULL, 'High on his throne sat Bran Mak Morn When the sun-god sank and the west was red; He beckoned a girl with his drinking horn, And, \"Sing me a song of the race,\" he said. Her eyes were as dark as the seas of night, Her lips were as red as the setting sun, As, a dusky rose in the fading light, She let her fingers dreamily run Over the golden-whispered strings, Seeking the soul of her ancient lyre; Bran sate still on the throne of kings, Bronze face limned in the sunset\'s fire.');
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (9, 'The Drums of Pictdom', NULL, 'How can I wear the harness of toil And sweat at the daily round, While in my soul forever The drums of Pictdom sound?');
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (10, 'Untitled poem (There\'s a bell that hangs...)', NULL, 'There\'s a bell that hangs in a hidden cave Under the heathered hills That knew the tramp of the Roman feet And the clash of the Pictish bills. It has not rung for a thousand years, To waken the sleeping trolls, But God defend the sons of men When the bell of the Morni tolls. For its rope is caught in the hinge of hell, And its clapper is forged of doom, And all the dead men under the sea Await for its sullen boom.');
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (11, 'A Thousand Years Ago', NULL, 'I was chief of the Chatagai A thousand years ago; Turan\'s souls and her swords were high; Arrows flew as snow might fly, We shook the desert and broke the sky When I was a chief of the Chatagai A thousand years ago.');
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (12, 'The Outgoing of Sigurd the Jerusalem-Farer', NULL, 'The fires roared in the skalli-hall, And a woman begged me stay — But the bitter night was falling And the cold wind callling Across the moaning spray. How could I stay in the feasting-hall When the wild wind walked the sea? The feet of the winds drew out of my soul To the grey waves and the cloud\'s scroll Where the gulls wheel and the whales roll, And the abyss roars to me.');
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (13, 'The Sign of the Sickle', NULL, 'Flashing sickle and falling grain Witness the glory of Tamerlane. The nations stood up, ripe and tall; He was the sickle that reaped them all. Red the reaping and sharp the blows, Deserts stretched where the cities rose. The sands lay bare to the night wind\'s croon, For the Sign of the Sickle hung over the moon. Yet the sickle splintered and left no trace, And the grain grows green on the desert\'s face.');
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (14, 'Timur-lang', NULL, 'The warm wind blows through the waving grain — Where are the glories of Tamerlane? The nations stood up, ripe and tall — He was the sickle that reaped them all. But the sickle shatters and leaves no trace — And the grain grows green on the desert\'s face.');
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (15, 'A Dull Sound as of Knocking', NULL, 'Who raps here on my door tonight, Stirring my sleep with the deaded sound? Here in my Room there is naught of light, And silence locks me round. The taste of the earth is in my mouth, Stillness, decay and lack of light, And dull as doom the rapping Thuds on my Door tonight. My Room is narrow and still and black, In such have kings and beggars hid; And falling clods are the knuckles That rap on my coffin lid.');
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (16, 'A Legend of Faring Town', NULL, 'Her house, a moulting buzzard on the Hill Loomed gaunt and brooding over Faring town; Behind, there sloped away the barren down And at its foot an ancient, crumbling mill. And often in the evening bleak and still, With withered limbs wrapped in a sombre gown And leathery face set in a sombre frown, She sat in silence on her silent sill.');
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (17, 'A Song of the Werewolf Folk', NULL, 'Sink white fangs in the throat of Life, Lap up the red that gushes In the cold dark gloom of the bare black stones, In the gorge where the black wind rushes. Slink where the titan boulders poise And the chasms grind thereunder, Over the mountains black and bare In the teeth of the brooding thunder. Why should we wish for the fertile fields, Valley and crystal fountain? This is our doom — the hunger-trail, The wolf and the storm-stalked mountain.');
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (18, 'An Open Window', NULL, 'Behind the Veil what gulfs of Time and Space? What blinking mowing Shapes to blast the sight? I shrink before a vague colossal Face Born in the mad immensities of Night.');
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (19, 'Dead Man\'s Hate', NULL, 'They hanged John Farrel in the dawn amid the market-place; At dusk came Adam Brand to him and spat upon his face. \"Ho, neighbors all,\" spake Adam Brand, \"see ye John Farrel\'s fate! \'Tis proven here a hempen noose is stronger than man\'s hate! \"For heard ye not John Farrel\'s vow to be avenged on me Come life or death? See how he hangs high on the gallows tree!\" Yet never a word the people spake, in fear and wild surprize — For the grisly corpse raised up its head and stared with sightless eyes, And with strange motions, slow and stiff, pointed at Adam Brand And clambered down the gibbet tree, the noose within its hand. With gaping mouth stood Adam Brand like a statue carved of stone, Till the dead man laid a clammy hand hard on his shoulder-bone.');
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (20, 'The Dead Slaver\'s Tale', NULL, 'Dim and grey was the silent sea, Dim was the crescent moon; From the jungle back of the shadowed lea Came a tom-tom\'s eerie croon When we glutted the waves with a hundred slaves From a Jekra barracoon. Our way to bar, a man of war Was sailing with canvas full; So the doomed men up from the hold we bore, Hacked them to pieces and hurled them o\'er, And we heard the grim sharks as they tore The flesh from each sword-cleft skull.');
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (21, 'The Dweller in Dark Valley', NULL, 'The nightwinds tossed the tangled trees, the stars were cold with scorn; Midnight lay over Dark Valley the hour I was born. The mid-wife dozed beside the hearth, a hand the window tried — She woke and stared and screamed and swooned at what she saw outside. Her hair was white as a leper\'s hand, she never spoke again; But laughed and wove the wild flowers into an endless chain. But when my childish tongue could speak, and my infant feet could stray, I found her dying in the hills at the haunted dusk of day.');
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (22, 'The Fear that Follows', NULL, 'The smile of a child was on her lips — oh, smile of a last long rest. My arm went up and my arm went down and the dagger pierced her breast. Silent she lay — oh still, oh still! — with the breast of her gown turned red. Then fear rose up in my soul like death and I fled from the face of the dead. The hangings rustled upon the walls, velvet and black they shook, And I thought to see strange shadows flash from the dark of each door and nook. Tapestries swayed on the ghostly walls as if in a wind that blew; Yet never a breeze stole through the rooms and my black fear grew and grew.');
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (23, 'Fragment (And so his boyhood...)', NULL, 'And so his boyhood wandered into youth, And still the hazes thickened round his head, And red, lascivious nightmares shared his bed And fantasies with greedy claw and tooth Burrowed into the secret parts of him — Gigantic, bestial and misshapen paws Gloatingly fumbled each white youthful limb, And shadows lurked with scarlet gaping jaws. Deeper and deeper in a twisting maze Of monstrous shadows, shot with red and black, Or gray as dull decay and rainy days, He stumbled onward. Ever at his back He heard the lecherous laughter of the ghouls. Under the fungoid trees lay stagnant pools Wherein he sometimes plunged up to his waist And shrieked and scrambled out with loathing haste, Feeling unnumbered slimy fingers press His shrinking flesh with evil, dank caress.');
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (24, 'Moon Mockery', NULL, 'I walked in Tara\'s Wood one summer night, And saw, amid the still, star-haunted skies, A slender moon in silver mist arise, And hover on the hill as if in fright. Burning, I seized her veil and held her tight: An instant all her glow was in my eyes; Then she was gone, swift as a white bird flies, And I went down the hill in opal light.');
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (25, 'The Moor Ghost', NULL, 'They haled him to the crossroads As day was at its close; They hung him to the gallows And left him for the crows. His hands in life were bloody, His ghost will not be still; He haunts the naked moorlands About the gibbet hill.');
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (26, 'Musings', NULL, 'The little poets sing of little things: Hope, cheer, and faith, small queens and puppet kings; Lovers who kissed and then were made as one, And modest flowers waving in the sun. The mighty poets write in blood and tears And agony that, flame-like, bites and sears.');
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (27, 'One Who Comes at Eventide', NULL, 'I think when I am old a furtive shape Will sit beside me at my fireless hearth, Dabbled with blood from stumps of severed wrists, And flecked with blackened bits of mouldy earth. My blood ran fire when the deed was done; Now it runs colder than the moon that shone On shattered fields where dead men lay in heaps Who could not hear a ravished daugher\'s moan.');
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (28, 'Remembrance', NULL, 'Eight thousand years ago a man I slew; I lay in wait beside a sparkling rill There in an upland valley green and still. The white stream gurgled where the rushes grew; The hills were veiled in dreamy hazes blue. He came along the trail; with savage skill My spear leaped like a snake to make my kill — Leaped like a striking snake and pierced him through.');
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (29, 'The Song of a Mad Minstrel', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (30, 'The Symbol', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (31, 'The Tavern', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (32, 'To a Woman', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (33, 'Up, John Kane!', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (34, 'Which Will Scarcely Be Understood', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (35, 'A Word From the Outer Dark', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (36, 'An Echo From the Iron Harp', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (37, 'The Dust Dance (version 1)', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (38, 'The Ghost Kings', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (39, 'Lines Written in the Realization That I Must Die', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (40, 'The Marching Song of Connacht', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (41, 'Recompense', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (42, 'The Song of the Last Briton', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (43, 'The Tide', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (44, 'Untitled (\"You have built a world of paper and wood...\")', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (45, 'A Song of the Naked Lands', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (46, 'Black Harps in the Hills', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (47, 'Echoes From an Anvil', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (48, 'Flint\'s Passing', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (49, 'The Grim Land', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (50, 'Never Beyond the Beast', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `miscellanea`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (1, 'The Black City (fragment)', NULL, 'The cold eyes of Kull, king of Valusia, clouded with perplexity as they rested on the man who had so abruptly entered the royal presence and who now stood before th eking, trembling with passion. Kull sighed; he knew the barbarians who served him, for was not he himself an Atlantean by birth? Brule, the Spear-slayer, bursting rudely into the king\'s chamber, had torn from his harness every emblem given him by Valusia and now stood bare of any sign to show that he was allied to the empire. And Kull knew the meaning of this gesture. \"Kull!\" barked the Pict, pale with fury. \"I will have justice!\" Again Kull sighed. There were times when peace and quiet were things to be desired and in Kamula he thought he had found them. Dreamy Kamula — even as he waited for the raging Pict to continue his tirade, Kull\'s thoughts drifted away and back along the lazy, dreamy days that had passed since his coming to this mountain city, this metropolis of pleasure, whose marble and lapis-lazuli palaces were built, tier upon gleaming tier, about the dome shaped hill that formed the city\'s center.');
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (2, 'Untitled draft (\"\'Thus,\' said Tu...\")', NULL, NULL);
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (3, 'Untitled fragment (\"A land of wild, fantastic beauty...\")', NULL, NULL);
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (4, 'Untitled fragment (\"So I set out up the hill-trail...\")', NULL, NULL);
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (5, 'Untitled fragment (\"Three men sat...\")', NULL, NULL);
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (6, 'The Hyborian Age (essay)', NULL, NULL);
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (7, 'Notes on Various Peoples of the Hyborian Age (essay)', NULL, NULL);
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (8, 'Untitled draft (\"Amboola awakened slowly...\")', NULL, NULL);
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (9, 'Untitled fragment (\"The battlefield stretched silent...\")', NULL, NULL);
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (10, 'Untitled synopsis (\"A squad of Zamoran soldiers...\")', NULL, NULL);
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (11, 'Untitled synopsis (Black Colossus)', NULL, NULL);
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (12, 'Untitled synopsis (The Scarlet Citadel)', NULL, NULL);
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (13, 'Untitled synopsis (\"The setting: The city of Shumballa...\")', NULL, NULL);
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (14, 'The Castle of the Devil (fragment)', NULL, NULL);
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (15, 'The Children of Asshur (fragment)', NULL, NULL);
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (16, 'Death\'s Black Riders (unfinished)', NULL, NULL);
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (17, 'Hawk of Basti (unfinished)', NULL, NULL);
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (18, 'Untitled draft (\"Three men squatted beside the water hole...\")', NULL, NULL);
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (19, 'Untitled fragment (\"A grey sky arched...\")', NULL, NULL);
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (20, 'Untitled fragment (\"Men have had vision ere now...\")', NULL, NULL);
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (21, 'Wolves Beyond the Border (unfinished)', NULL, NULL);
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (22, 'Mistress of Death (uncompleted draft)', NULL, NULL);
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (23, 'Recap of Harold Lamb\'s \"The Wolf Chaser\"', NULL, NULL);
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (24, 'The Slave-Princess (fragment)', NULL, NULL);
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (25, 'The Track of Bohemund (unfinished draft)', NULL, NULL);
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (26, 'Untitled fragment (\"He knew de Bracy...\")', NULL, NULL);
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (27, 'Untitled fragment (\"The Persians had all fled...\")', NULL, NULL);
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (28, 'Untitled fragment (\"The wind from the Mediterranean...\")', NULL, NULL);
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (29, 'Golnar the Ape (unfinished)', NULL, NULL);
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (30, 'The House (fragment)', NULL, NULL);
INSERT INTO `miscellanea` (`id`, `title`, `text_url`, `excerpt`) VALUES (31, 'Untitled fragment (\"Beneath the glare of the sun...\")', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `person`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `person` (`id`, `name`, `image_url`, `description`) VALUES (1, 'Ace Jessel', NULL, 'Ace Jessel is a character created by Robert E. Howard. He appeared in the short stories The Apparition in the Prize Ring (first published in the April 1929 issue of Ghost Stories) and Double-Cross (first in the 1983 collection Bran Mak Morn: A Play and Others).');
INSERT INTO `person` (`id`, `name`, `image_url`, `description`) VALUES (2, 'Bran Mak Morn', 'https://reh.world/wp-content/uploads/2021/04/Gary-Gianni-_-Bran-mak-Morn.jpg', 'Bran Mak Morn is a hero of several stories by Robert E. Howard. In the stories, he is the last king of Howard\'s romanticized version of the tribal race of Picts. He is a direct descendant of Brule the Spear Slayer, companion of the Atlantean king Kull, whom his magician summons to fight with him in \"Kings of The Night\", a novelette first published in Weird Tales #16 (November 1930).\n\nBran Mak Morn is the leader of a dying and degenerate people, a poor reflection of what they once were and is deeply aware of their inevitable path to extinction. Still, like all of Howard\'s characters, he choses to fight against this rather than succumb. His main enemies are the Romans and he makes a very unholy alliance to defeat them in \"Worms of the Earth\", a novelette first published in Weird Tales #20 (November 1932).');
INSERT INTO `person` (`id`, `name`, `image_url`, `description`) VALUES (3, 'Breckinridge Elkins', NULL, NULL);
INSERT INTO `person` (`id`, `name`, `image_url`, `description`) VALUES (4, 'Buckner J. Grimes', NULL, NULL);
INSERT INTO `person` (`id`, `name`, `image_url`, `description`) VALUES (5, 'Conan', 'https://howardtreasury.s3.amazonaws.com/assets/siteassets/conan-potbc.png', 'Hither came Conan, the Cimmerian, black-haired, sullen-eyed, sword in hand, a thief, a reaver, a slayer, with gigantic melancholies and gigantic mirth, to tread the jeweled thrones of the Earth under his sandalled feet.');
INSERT INTO `person` (`id`, `name`, `image_url`, `description`) VALUES (6, 'Cormac Fitzgeoffrey', NULL, NULL);
INSERT INTO `person` (`id`, `name`, `image_url`, `description`) VALUES (7, 'Cormac Mac Art', NULL, NULL);
INSERT INTO `person` (`id`, `name`, `image_url`, `description`) VALUES (8, 'Dark Agnes', NULL, NULL);
INSERT INTO `person` (`id`, `name`, `image_url`, `description`) VALUES (9, 'Dennis Dorgan', NULL, NULL);
INSERT INTO `person` (`id`, `name`, `image_url`, `description`) VALUES (10, 'El Borak', NULL, NULL);
INSERT INTO `person` (`id`, `name`, `image_url`, `description`) VALUES (11, 'James Allison', NULL, NULL);
INSERT INTO `person` (`id`, `name`, `image_url`, `description`) VALUES (12, 'Kirby O\'Donnell', NULL, NULL);
INSERT INTO `person` (`id`, `name`, `image_url`, `description`) VALUES (13, 'Kull', 'https://pbs.twimg.com/media/DwXi0mbVsAAXD7H.jpg', 'In the mists of prehistory, the warrior Kull won a throne by his mighty sword and his more deadly battle axe. He has won a kingdom, but now must hold it against the plotting of treacherous nobles and the evil serpent-men who can change their forms to appear human. But Kull will prevail against all challenges, shouting his cry above the din of battle, \"By this axe I rule!\"');
INSERT INTO `person` (`id`, `name`, `image_url`, `description`) VALUES (14, 'Lal Singh', NULL, NULL);
INSERT INTO `person` (`id`, `name`, `image_url`, `description`) VALUES (15, 'Pike Bearfield', NULL, NULL);
INSERT INTO `person` (`id`, `name`, `image_url`, `description`) VALUES (16, 'Solomon Kane', 'https://3.bp.blogspot.com/-XcKtBCZNJB4/VVHjL1n7V1I/AAAAAAAA0fM/q4bs47MCagM/s1600/Solomon%2BKane%2BGary%2BGianni.jpg', 'He was a man born out of his time — a strange blending of Puritan and Cavalier, with a touch of the ancient philosopher, and more than a touch of the pagan, though the last assertion would have shocked him unspeakably. An atavist of the days of blind chivalry he was, a knight errant in the somber clothes of the fanatic. A hunger in his soul drove him on and on, an urge to right all wrongs, protect all weaker things, avenge all crimes against right and justice.');
INSERT INTO `person` (`id`, `name`, `image_url`, `description`) VALUES (17, 'The Sonora Kid', NULL, NULL);
INSERT INTO `person` (`id`, `name`, `image_url`, `description`) VALUES (18, 'Steve Costigan', NULL, NULL);
INSERT INTO `person` (`id`, `name`, `image_url`, `description`) VALUES (19, 'Steve Harrison', NULL, NULL);
INSERT INTO `person` (`id`, `name`, `image_url`, `description`) VALUES (20, 'Terence Vulmea', NULL, NULL);
INSERT INTO `person` (`id`, `name`, `image_url`, `description`) VALUES (21, 'Turlogh O\'Brien', NULL, NULL);
INSERT INTO `person` (`id`, `name`, `image_url`, `description`) VALUES (22, 'Wild Bill Clanton', NULL, NULL);
INSERT INTO `person` (`id`, `name`, `image_url`, `description`) VALUES (23, 'Yar Ali Khan', NULL, NULL);
INSERT INTO `person` (`id`, `name`, `image_url`, `description`) VALUES (24, 'Red Sonya', NULL, NULL);

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
-- Data for table `collection_has_story`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (6, 1, 133);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (6, 2, 155);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (6, 3, 87);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (6, 4, 139);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (6, 5, 1);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (6, 6, 215);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (6, 7, 53);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (6, 8, 117);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (6, 9, 11);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (6, 10, 127);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (6, 11, 181);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (1, 12, 151);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (1, 13, 319);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (1, 14, 29);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (1, 15, 39);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (1, 16, 185);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (1, 17, 5);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (1, 18, 249);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (1, 19, 119);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (1, 20, 277);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (1, 21, 83);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (1, 22, 59);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (1, 23, 301);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (1, 24, 217);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (2, 25, 177);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (2, 26, 323);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (2, 27, 223);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (2, 28, 97);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (2, 29, 73);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (2, 30, 29);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (2, 31, 19);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (2, 32, 1);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (2, 33, 273);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (3, 34, 81);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (3, 35, 1);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (3, 36, 255);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (4, 37, 215);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (4, 6, 31);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (4, 38, 129);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (4, 39, 197);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (4, 40, 167);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (4, 41, 1);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (4, 42, 83);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (5, 43, 43);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (5, 44, 101);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (5, 45, 175);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (5, 46, 209);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (5, 47, 1);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (10, 48, 231);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (10, 49, 29);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (10, 50, 449);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (10, 51, 365);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (10, 52, 183);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (10, 53, 335);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (10, 54, 275);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (10, 55, 385);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (10, 56, 3);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (10, 57, 87);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (10, 58, 471);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (10, 59, 425);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (11, 60, 365);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (11, 61, 197);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (11, 62, 135);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (11, 63, 169);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (11, 64, 33);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (11, 65, 107);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (11, 66, 295);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (11, 67, 225);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (11, 68, 71);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (11, 69, 423);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (11, 70, 387);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (11, 71, 291);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (11, 72, 253);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (11, 73, 1);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (11, 74, 331);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 75, 379);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 76, 159);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 77, 223);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 78, 71);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 79, 449);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 80, 217);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 81, 105);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 82, 131);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 83, 29);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 84, 318);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 85, 75);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 86, 456);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 87, 410);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 88, 289);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 89, 185);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 90, 338);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 91, 1);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 92, 376);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 93, 360);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 94, 305);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 95, 365);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 96, 80);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 97, 201);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 98, 424);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 99, 89);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 100, 35);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 101, 95);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 102, 487);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 103, 58);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 104, 176);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 105, 269);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 106, 6);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 37, 143);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 27, 110);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 39, 43);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 29, 51);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (9, 42, 240);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (7, 43, 353);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (7, 76, 121);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (7, 4, 29);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (7, 38, 63);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (7, 107, 139);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (7, 108, 249);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (7, 109, 153);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (7, 52, 405);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (7, 6, 87);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (7, 110, 217);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (7, 35, 283);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (7, 30, 33);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (7, 9, 1);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (7, 111, 453);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (7, 112, 259);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (7, 42, 185);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (8, 113, 357);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (8, 114, 161);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (8, 2, 1);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (8, 115, 263);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (8, 66, 83);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (8, 93, 179);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (8, 7, 21);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (8, 95, 185);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (8, 98, 281);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (8, 46, 399);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (8, 70, 123);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (8, 53, 331);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (8, 22, 29);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (8, 116, 195);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (8, 117, 311);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`, `page_number`) VALUES (8, 33, 53);

COMMIT;


-- -----------------------------------------------------
-- Data for table `collection_has_poem`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (6, 1, 250);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (6, 2, 211);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (6, 3, 249);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (1, 4, 1);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (2, 5, 171);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (2, 6, 269);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (2, 7, 379);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (4, 8, 77);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (4, 9, 187);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (4, 10, 283);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (11, 11, 293);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (11, 12, 69);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (11, 13, 503);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (11, 14, 329);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (9, 15, 200);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (9, 16, 88);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (9, 17, 5);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (9, 18, 337);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (9, 19, 49);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (9, 20, 104);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (9, 21, 184);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (9, 22, 57);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (9, 23, 478);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (9, 24, 42);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (9, 25, 41);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (9, 26, 158);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (9, 27, 409);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (9, 28, 28);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (9, 29, 142);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (9, 30, 268);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (9, 31, 50);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (9, 32, 409);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (9, 33, 27);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (9, 34, 479);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (7, 35, 403);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (7, 36, 213);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (7, 37, 279);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (7, 38, 27);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (7, 39, 469);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (7, 40, 85);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (7, 5, 59);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (7, 41, 119);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (7, 29, 137);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (7, 42, 183);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (7, 43, 257);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (7, 44, 247);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (8, 45, 119);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (8, 46, 177);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (8, 4, 471);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (8, 47, 159);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (8, 48, 397);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (8, 49, 279);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (8, 2, 19);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (8, 26, 329);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (8, 50, 309);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (8, 7, 79);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (8, 14, 117);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`, `page_number`) VALUES (8, 34, 51);

COMMIT;


-- -----------------------------------------------------
-- Data for table `collection_has_miscellanea`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (6, 1, 145);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (6, 2, 67);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (6, 3, 253);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (6, 4, 255);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (6, 5, 151);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (1, 6, 379);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (1, 7, 375);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (1, 8, 409);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (1, 9, 405);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (1, 10, 399);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (1, 11, 403);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (1, 12, 401);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (1, 13, 407);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (2, 14, 85);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (2, 15, 347);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (2, 16, 93);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (2, 17, 255);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (3, 18, 315);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (4, 19, 277);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (4, 20, 287);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (5, 21, 287);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (11, 22, 505);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (11, 23, 499);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (11, 24, 477);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (11, 25, 459);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (11, 26, 495);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (11, 27, 501);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (11, 28, 497);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (9, 29, 483);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (9, 30, 498);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`, `page_number`) VALUES (9, 31, 505);

COMMIT;


-- -----------------------------------------------------
-- Data for table `collection_has_person`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `collection_has_person` (`collection_id`, `person_id`) VALUES (1, 5);
INSERT INTO `collection_has_person` (`collection_id`, `person_id`) VALUES (2, 16);
INSERT INTO `collection_has_person` (`collection_id`, `person_id`) VALUES (3, 5);
INSERT INTO `collection_has_person` (`collection_id`, `person_id`) VALUES (4, 2);
INSERT INTO `collection_has_person` (`collection_id`, `person_id`) VALUES (5, 5);
INSERT INTO `collection_has_person` (`collection_id`, `person_id`) VALUES (6, 13);
INSERT INTO `collection_has_person` (`collection_id`, `person_id`) VALUES (7, 5);
INSERT INTO `collection_has_person` (`collection_id`, `person_id`) VALUES (8, 13);
INSERT INTO `collection_has_person` (`collection_id`, `person_id`) VALUES (9, 16);
INSERT INTO `collection_has_person` (`collection_id`, `person_id`) VALUES (10, 10);
INSERT INTO `collection_has_person` (`collection_id`, `person_id`) VALUES (11, 8);
INSERT INTO `collection_has_person` (`collection_id`, `person_id`) VALUES (7, 13);
INSERT INTO `collection_has_person` (`collection_id`, `person_id`) VALUES (7, 21);
INSERT INTO `collection_has_person` (`collection_id`, `person_id`) VALUES (7, 18);
INSERT INTO `collection_has_person` (`collection_id`, `person_id`) VALUES (7, 10);
INSERT INTO `collection_has_person` (`collection_id`, `person_id`) VALUES (7, 2);
INSERT INTO `collection_has_person` (`collection_id`, `person_id`) VALUES (7, 19);
INSERT INTO `collection_has_person` (`collection_id`, `person_id`) VALUES (7, 16);
INSERT INTO `collection_has_person` (`collection_id`, `person_id`) VALUES (7, 3);
INSERT INTO `collection_has_person` (`collection_id`, `person_id`) VALUES (7, 11);
INSERT INTO `collection_has_person` (`collection_id`, `person_id`) VALUES (8, 20);
INSERT INTO `collection_has_person` (`collection_id`, `person_id`) VALUES (8, 18);
INSERT INTO `collection_has_person` (`collection_id`, `person_id`) VALUES (8, 15);
INSERT INTO `collection_has_person` (`collection_id`, `person_id`) VALUES (8, 5);
INSERT INTO `collection_has_person` (`collection_id`, `person_id`) VALUES (8, 10);
INSERT INTO `collection_has_person` (`collection_id`, `person_id`) VALUES (8, 16);

COMMIT;


-- -----------------------------------------------------
-- Data for table `miscellanea_has_person`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `miscellanea_has_person` (`miscellanea_id`, `person_id`) VALUES (1, 13);
INSERT INTO `miscellanea_has_person` (`miscellanea_id`, `person_id`) VALUES (2, 13);
INSERT INTO `miscellanea_has_person` (`miscellanea_id`, `person_id`) VALUES (3, 13);
INSERT INTO `miscellanea_has_person` (`miscellanea_id`, `person_id`) VALUES (4, 13);
INSERT INTO `miscellanea_has_person` (`miscellanea_id`, `person_id`) VALUES (5, 13);
INSERT INTO `miscellanea_has_person` (`miscellanea_id`, `person_id`) VALUES (6, 5);
INSERT INTO `miscellanea_has_person` (`miscellanea_id`, `person_id`) VALUES (7, 5);
INSERT INTO `miscellanea_has_person` (`miscellanea_id`, `person_id`) VALUES (8, 5);
INSERT INTO `miscellanea_has_person` (`miscellanea_id`, `person_id`) VALUES (9, 5);
INSERT INTO `miscellanea_has_person` (`miscellanea_id`, `person_id`) VALUES (10, 5);
INSERT INTO `miscellanea_has_person` (`miscellanea_id`, `person_id`) VALUES (11, 5);
INSERT INTO `miscellanea_has_person` (`miscellanea_id`, `person_id`) VALUES (12, 5);
INSERT INTO `miscellanea_has_person` (`miscellanea_id`, `person_id`) VALUES (13, 5);
INSERT INTO `miscellanea_has_person` (`miscellanea_id`, `person_id`) VALUES (14, 16);
INSERT INTO `miscellanea_has_person` (`miscellanea_id`, `person_id`) VALUES (15, 16);
INSERT INTO `miscellanea_has_person` (`miscellanea_id`, `person_id`) VALUES (16, 16);
INSERT INTO `miscellanea_has_person` (`miscellanea_id`, `person_id`) VALUES (17, 16);
INSERT INTO `miscellanea_has_person` (`miscellanea_id`, `person_id`) VALUES (18, 5);
INSERT INTO `miscellanea_has_person` (`miscellanea_id`, `person_id`) VALUES (19, 2);
INSERT INTO `miscellanea_has_person` (`miscellanea_id`, `person_id`) VALUES (20, 2);
INSERT INTO `miscellanea_has_person` (`miscellanea_id`, `person_id`) VALUES (21, 5);
INSERT INTO `miscellanea_has_person` (`miscellanea_id`, `person_id`) VALUES (22, 8);
INSERT INTO `miscellanea_has_person` (`miscellanea_id`, `person_id`) VALUES (24, 6);
INSERT INTO `miscellanea_has_person` (`miscellanea_id`, `person_id`) VALUES (31, 11);

COMMIT;


-- -----------------------------------------------------
-- Data for table `story_has_person`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (1, 13);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (2, 13);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (3, 13);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (4, 13);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (5, 13);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (6, 13);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (7, 13);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (8, 13);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (9, 13);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (10, 13);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (11, 13);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (12, 5);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (13, 5);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (14, 5);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (15, 5);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (16, 5);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (17, 5);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (18, 5);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (19, 5);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (20, 5);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (21, 5);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (22, 5);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (23, 5);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (24, 5);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (25, 16);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (26, 16);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (27, 16);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (28, 16);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (29, 16);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (30, 16);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (31, 16);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (32, 16);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (33, 16);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (34, 5);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (35, 5);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (36, 5);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (37, 2);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (38, 2);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (6, 2);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (39, 2);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (40, 2);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (41, 2);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (42, 2);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (43, 5);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (44, 5);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (45, 5);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (46, 5);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (47, 10);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (48, 10);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (49, 10);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (51, 12);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (52, 10);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (53, 10);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (54, 10);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (55, 12);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (56, 10);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (57, 10);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (57, 23);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (58, 10);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (58, 23);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (59, 12);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (60, 8);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (61, 6);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (63, 6);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (70, 24);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (73, 21);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (74, 8);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (103, 1);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (107, 18);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (109, 21);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (110, 19);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (111, 3);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (112, 11);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (113, 20);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (114, 18);
INSERT INTO `story_has_person` (`story_id`, `person_id`) VALUES (115, 15);

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
INSERT INTO `poem_has_person` (`poem_id`, `person_id`) VALUES (1, 13);
INSERT INTO `poem_has_person` (`poem_id`, `person_id`) VALUES (2, 13);
INSERT INTO `poem_has_person` (`poem_id`, `person_id`) VALUES (3, 13);
INSERT INTO `poem_has_person` (`poem_id`, `person_id`) VALUES (4, 5);
INSERT INTO `poem_has_person` (`poem_id`, `person_id`) VALUES (5, 16);
INSERT INTO `poem_has_person` (`poem_id`, `person_id`) VALUES (6, 16);
INSERT INTO `poem_has_person` (`poem_id`, `person_id`) VALUES (7, 16);
INSERT INTO `poem_has_person` (`poem_id`, `person_id`) VALUES (8, 2);
INSERT INTO `poem_has_person` (`poem_id`, `person_id`) VALUES (9, 2);
INSERT INTO `poem_has_person` (`poem_id`, `person_id`) VALUES (10, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_has_chat_room`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `user_has_chat_room` (`user_id`, `chat_room_id`, `joined_at`, `last_activity`, `notification_preferences`, `unread_message_count`, `user_status`, `role`) VALUES (1, 1, '2023-03-03T12:35:22', '2023-03-03T12:35:22', NULL, NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `collection_image`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `collection_image` (`id`, `image_url`) VALUES (1, 'https://howardtreasury.s3.amazonaws.com/assets/collections/images/the-coming-of-conan-the-cimmerian.png');
INSERT INTO `collection_image` (`id`, `image_url`) VALUES (2, 'https://howardtreasury.s3.amazonaws.com/assets/collections/images/the-bloody-crown-of-conan.png');
INSERT INTO `collection_image` (`id`, `image_url`) VALUES (3, 'https://howardtreasury.s3.amazonaws.com/assets/collections/images/the-conquering-sword-of-conan.png');
INSERT INTO `collection_image` (`id`, `image_url`) VALUES (4, 'https://howardtreasury.s3.amazonaws.com/assets/collections/images/bran-mak-morn-the-last-king.png');
INSERT INTO `collection_image` (`id`, `image_url`) VALUES (5, 'https://howardtreasury.s3.amazonaws.com/assets/collections/images/the-savage-tales-of-solomon-kane.png');
INSERT INTO `collection_image` (`id`, `image_url`) VALUES (6, 'https://howardtreasury.s3.amazonaws.com/assets/collections/images/kull-exile-of-atlantis.png');
INSERT INTO `collection_image` (`id`, `image_url`) VALUES (7, 'https://howardtreasury.s3.amazonaws.com/assets/collections/images/the-best-of-robert-e-howard-volume-1-crimson-shadows.png');
INSERT INTO `collection_image` (`id`, `image_url`) VALUES (8, 'https://howardtreasury.s3.amazonaws.com/assets/collections/images/the-best-of-robert-e-howard-volume-2-grim-lands.png');
INSERT INTO `collection_image` (`id`, `image_url`) VALUES (9, 'https://howardtreasury.s3.amazonaws.com/assets/collections/images/the-horror-stories-of-robert-e-howard.png');
INSERT INTO `collection_image` (`id`, `image_url`) VALUES (10, 'https://howardtreasury.s3.amazonaws.com/assets/collections/images/el-borak-and-other-desert-adventures.png');
INSERT INTO `collection_image` (`id`, `image_url`) VALUES (11, 'https://howardtreasury.s3.amazonaws.com/assets/collections/images/sword-woman-and-other-historical-adventures.png');

COMMIT;


-- -----------------------------------------------------
-- Data for table `collection_has_collection_image`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `collection_has_collection_image` (`collection_id`, `collection_image_id`) VALUES (1, 1);
INSERT INTO `collection_has_collection_image` (`collection_id`, `collection_image_id`) VALUES (2, 5);
INSERT INTO `collection_has_collection_image` (`collection_id`, `collection_image_id`) VALUES (3, 2);
INSERT INTO `collection_has_collection_image` (`collection_id`, `collection_image_id`) VALUES (4, 4);
INSERT INTO `collection_has_collection_image` (`collection_id`, `collection_image_id`) VALUES (5, 3);
INSERT INTO `collection_has_collection_image` (`collection_id`, `collection_image_id`) VALUES (6, 6);
INSERT INTO `collection_has_collection_image` (`collection_id`, `collection_image_id`) VALUES (7, 7);
INSERT INTO `collection_has_collection_image` (`collection_id`, `collection_image_id`) VALUES (8, 8);
INSERT INTO `collection_has_collection_image` (`collection_id`, `collection_image_id`) VALUES (9, 9);
INSERT INTO `collection_has_collection_image` (`collection_id`, `collection_image_id`) VALUES (10, 10);
INSERT INTO `collection_has_collection_image` (`collection_id`, `collection_image_id`) VALUES (11, 11);

COMMIT;


-- -----------------------------------------------------
-- Data for table `illustrator`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `illustrator` (`id`, `name`) VALUES (1, 'Mark Schultz');
INSERT INTO `illustrator` (`id`, `name`) VALUES (2, 'Gary Gianni');
INSERT INTO `illustrator` (`id`, `name`) VALUES (3, 'Justin Sweet');
INSERT INTO `illustrator` (`id`, `name`) VALUES (4, 'Jim Keegan');
INSERT INTO `illustrator` (`id`, `name`) VALUES (5, 'Ruth Keegan');
INSERT INTO `illustrator` (`id`, `name`) VALUES (6, 'Gregory Manchess');
INSERT INTO `illustrator` (`id`, `name`) VALUES (7, 'Greg Staples');
INSERT INTO `illustrator` (`id`, `name`) VALUES (8, 'Tim Bradstreet');
INSERT INTO `illustrator` (`id`, `name`) VALUES (9, 'John Watkiss');

COMMIT;


-- -----------------------------------------------------
-- Data for table `collection_has_illustrator`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `collection_has_illustrator` (`collection_id`, `illustrator_id`) VALUES (1, 1);
INSERT INTO `collection_has_illustrator` (`collection_id`, `illustrator_id`) VALUES (2, 2);
INSERT INTO `collection_has_illustrator` (`collection_id`, `illustrator_id`) VALUES (3, 2);
INSERT INTO `collection_has_illustrator` (`collection_id`, `illustrator_id`) VALUES (4, 2);
INSERT INTO `collection_has_illustrator` (`collection_id`, `illustrator_id`) VALUES (5, 6);
INSERT INTO `collection_has_illustrator` (`collection_id`, `illustrator_id`) VALUES (6, 3);
INSERT INTO `collection_has_illustrator` (`collection_id`, `illustrator_id`) VALUES (7, 4);
INSERT INTO `collection_has_illustrator` (`collection_id`, `illustrator_id`) VALUES (7, 5);
INSERT INTO `collection_has_illustrator` (`collection_id`, `illustrator_id`) VALUES (8, 4);
INSERT INTO `collection_has_illustrator` (`collection_id`, `illustrator_id`) VALUES (8, 5);
INSERT INTO `collection_has_illustrator` (`collection_id`, `illustrator_id`) VALUES (9, 7);
INSERT INTO `collection_has_illustrator` (`collection_id`, `illustrator_id`) VALUES (10, 4);
INSERT INTO `collection_has_illustrator` (`collection_id`, `illustrator_id`) VALUES (10, 5);
INSERT INTO `collection_has_illustrator` (`collection_id`, `illustrator_id`) VALUES (10, 8);
INSERT INTO `collection_has_illustrator` (`collection_id`, `illustrator_id`) VALUES (11, 9);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_list_has_story`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `user_list_has_story` (`user_list_id`, `story_id`) VALUES (2, 1);
INSERT INTO `user_list_has_story` (`user_list_id`, `story_id`) VALUES (2, 2);
INSERT INTO `user_list_has_story` (`user_list_id`, `story_id`) VALUES (2, 3);
INSERT INTO `user_list_has_story` (`user_list_id`, `story_id`) VALUES (2, 4);
INSERT INTO `user_list_has_story` (`user_list_id`, `story_id`) VALUES (2, 5);
INSERT INTO `user_list_has_story` (`user_list_id`, `story_id`) VALUES (2, 6);
INSERT INTO `user_list_has_story` (`user_list_id`, `story_id`) VALUES (2, 7);
INSERT INTO `user_list_has_story` (`user_list_id`, `story_id`) VALUES (2, 8);
INSERT INTO `user_list_has_story` (`user_list_id`, `story_id`) VALUES (2, 9);
INSERT INTO `user_list_has_story` (`user_list_id`, `story_id`) VALUES (2, 10);
INSERT INTO `user_list_has_story` (`user_list_id`, `story_id`) VALUES (2, 11);
INSERT INTO `user_list_has_story` (`user_list_id`, `story_id`) VALUES (4, 9);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_list_has_poem`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `user_list_has_poem` (`user_list_id`, `poem_id`) VALUES (1, 1);
INSERT INTO `user_list_has_poem` (`user_list_id`, `poem_id`) VALUES (1, 2);
INSERT INTO `user_list_has_poem` (`user_list_id`, `poem_id`) VALUES (1, 3);
INSERT INTO `user_list_has_poem` (`user_list_id`, `poem_id`) VALUES (4, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_list_has_miscellanea`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `user_list_has_miscellanea` (`user_list_id`, `miscellanea_id`) VALUES (3, 1);
INSERT INTO `user_list_has_miscellanea` (`user_list_id`, `miscellanea_id`) VALUES (3, 2);
INSERT INTO `user_list_has_miscellanea` (`user_list_id`, `miscellanea_id`) VALUES (3, 3);
INSERT INTO `user_list_has_miscellanea` (`user_list_id`, `miscellanea_id`) VALUES (3, 4);
INSERT INTO `user_list_has_miscellanea` (`user_list_id`, `miscellanea_id`) VALUES (3, 5);
INSERT INTO `user_list_has_miscellanea` (`user_list_id`, `miscellanea_id`) VALUES (4, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `story_image`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `story_image` (`id`, `image_url`) VALUES (1, 'https://1.bp.blogspot.com/-b03S65YxaG4/VxO3pBIMd9I/AAAAAAAAL-A/c91YmuJajpUMS9SCPHMqqxqs-JqcpzrJQCKgB/s1600/01.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (2, 'https://3.bp.blogspot.com/-cUKgTV-hrSA/VxO3pL10ZLI/AAAAAAAAMAk/yJY_viYYXfkysFZA2hK22Us-SMiMMF7rQCKgB/s1600/02.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (3, 'https://1.bp.blogspot.com/-X6uaChD1JZM/VxO3pz9w6aI/AAAAAAAAL-I/m2OAgaydZ78lpyN86z8m04naTApv7mtGQCKgB/s1600/03.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (4, 'https://2.bp.blogspot.com/-yfbUfDXa3ro/VxO3qHdKVDI/AAAAAAAAL-M/8R2z7chG5tsd0Oiy7c0oz5vhDu-w6qsHQCKgB/s1600/04.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (5, 'https://4.bp.blogspot.com/-OngFiFzKSnk/VxO3qN7VABI/AAAAAAAAMAk/cczEVCCcsQ4AphvMlvX1K2ZgsK1bbhQBACKgB/s1600/05.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (6, 'https://2.bp.blogspot.com/-DE9gvDd9EGs/VxO3qh8wLzI/AAAAAAAAMAk/y8GYYjO3kEY3EMd_pv91pyvz0x42k3JdgCKgB/s1600/06.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (7, 'https://2.bp.blogspot.com/-r8SUg-U5srA/VxO3qh4u4oI/AAAAAAAAL-Y/UqbVEC31Qz4kawNyQKS6nTM_QaKoJCPcgCKgB/s1600/07.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (8, 'https://1.bp.blogspot.com/-vvU_QVQcbTo/VxO3q4GPsHI/AAAAAAAAL-g/keJggYYhLPkFRSt33_9tZH5GJoVvLq2RwCKgB/s1600/08.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (9, 'https://4.bp.blogspot.com/-P8rHwCXka04/VxO3rqxiURI/AAAAAAAAMAk/pM608_iG6pMPHHe33gL0Wxx0ZtMQTcDbwCKgB/s1600/09.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (10, 'https://1.bp.blogspot.com/-eHhqG9qV_TM/VxO3rCaNOpI/AAAAAAAAMAk/Si9kK2P-VbUWxkwTXYni6Dv4IHvQdsNhwCKgB/s1600/10.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (11, 'https://4.bp.blogspot.com/-Da9RxQN8opA/VxO3zRWuXzI/AAAAAAAAMAk/q-QwZTyTvYYvn5lhtjor5IFzsC6sf9BKgCKgB/s1600/11.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (12, 'https://4.bp.blogspot.com/-Q-3ejzsGfCY/VxO3ztEVQyI/AAAAAAAAMAk/5-cnqUaTgzMhhkEwq_ooiNKxjSFgQgrPgCKgB/s1600/12.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (13, 'https://2.bp.blogspot.com/-1XyQxW9y3kA/VxO3zYezzlI/AAAAAAAAMAk/SO3obexrh-YQD8oL1BBhyWt1wKCBvObaACKgB/s1600/13.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (14, 'https://1.bp.blogspot.com/-tv9g49Qrb74/VxO3zxgg0HI/AAAAAAAAMAk/qN0FAECHiH4mBxAwQLQubNGU5advlPePgCKgB/s1600/14.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (15, 'https://1.bp.blogspot.com/-QA2ENpOLfzM/VxO30LVXIgI/AAAAAAAAMAk/mOowMB_EAkkXk5ikFJa1-wsfYgOdGbAowCKgB/s1600/15.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (16, 'https://3.bp.blogspot.com/-TCUgghdMm-g/VxO32OEBZqI/AAAAAAAAL_Q/I4s7upfnUXUbPSk_qIkBGF-sVWUMe-KlACKgB/s1600/16.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (17, 'https://4.bp.blogspot.com/-SnZ5A6CPVAU/VxO306ufL0I/AAAAAAAAL_E/RwsK3HPboPMzYDzak7zuUJhYrl56s33dwCKgB/s1600/17.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (18, 'https://4.bp.blogspot.com/-jz5oxZYXAAA/VxO30k4DITI/AAAAAAAAL_A/pO3B1sD_jYM7sgGN1xt0iqEc8puBl6kmgCKgB/s1600/18.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (19, 'https://1.bp.blogspot.com/-O9UwMAE7YYc/VxO31FRC_iI/AAAAAAAAL_M/PgSUrroFMJEV4tiwHCsbWp1zBc-OyqOrwCKgB/s1600/19.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (20, 'https://1.bp.blogspot.com/-GK8OsCOuhco/VxO31GeQvpI/AAAAAAAAL_I/SHoBlMHAoO4a_TMp_5N0CWpCNY_rZnUqACKgB/s1600/20.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (21, 'https://2.bp.blogspot.com/-3Ea2-OtXQjA/VxO4jvAtCHI/AAAAAAAAMAI/5t-X4fJecnMbmr7icna7gXmVC09uKjgngCKgB/s1600/21.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (22, 'https://1.bp.blogspot.com/-kh-tKzIzUDE/VxO4jbUvIsI/AAAAAAAAMAA/-mXmVM-RLk8c929JMDuFDL3hu0VU0ls5wCKgB/s1600/22.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (23, 'https://4.bp.blogspot.com/-8wVH2ODmTGE/VxO4jqcboDI/AAAAAAAAMAE/eyah1BMM19Yq0HjC0QmGoomj7_8PxBe7gCKgB/s1600/23.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (24, 'https://2.bp.blogspot.com/-Op2PR-4pofQ/VxO4kEBXblI/AAAAAAAAMC0/Pfhy7I1ophU2NaXhVDGILOb3HWpnhLZOwCKgB/s1600/24.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (25, 'https://2.bp.blogspot.com/-hiqLEDvkLUE/VxO4kP27g6I/AAAAAAAAMC0/NTEWw2kMcBUfhcaH_YE2fjs1QwJ9BpnZQCKgB/s1600/25.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (26, 'https://1.bp.blogspot.com/-YlKu3AlKwd0/VxO4kDJWCHI/AAAAAAAAMAQ/q6gV25B5hxIxI5XiBjo3LL-ue7-vYYUoACKgB/s1600/26.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (27, 'https://1.bp.blogspot.com/-x9-FaLWUoD8/VxO4kpvdOyI/AAAAAAAAMAc/0uEK2r_6p9kjMwViwdBrnRlJ-uOhDqRAwCKgB/s1600/27.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (28, 'https://1.bp.blogspot.com/-hLbkQLmunZU/VxO4kp6tweI/AAAAAAAAMAY/K3FP2f_J8yc-a4mwlAKvhF4EhKjK6cIoQCKgB/s1600/28.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (29, 'https://1.bp.blogspot.com/-tyomfxodCm4/VxO4k5T0EmI/AAAAAAAAMC0/bSCeRuJFFXcLqTFWVmjsiiOq_NsVuVJOgCKgB/s1600/29.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (30, 'https://4.bp.blogspot.com/-vH3bX-SiqdY/VxO3-RaDbXI/AAAAAAAAMAk/v_twbzmk9poEy-RT3EhkUmVpPcPTbRQ8QCKgB/s1600/30.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (31, 'https://4.bp.blogspot.com/-bmRnBZU5ddQ/VxO4AD_nqoI/AAAAAAAAL_s/m4CEi7EIJNkqEN0b_h1QR9dKTuPAjcMnQCKgB/s1600/31.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (32, 'https://4.bp.blogspot.com/-prA-pVHh6-A/VxO3-RgO2eI/AAAAAAAAMC0/komsA3-W6VE5yJwaaNju4sOqnbmruSGcACKgB/s1600/32.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (33, 'https://4.bp.blogspot.com/-q0_OL0Ua_ik/VxO3--r9zRI/AAAAAAAAL_c/OtGTxIeK-fcIzBchxk6koQQSqORwr0RkACKgB/s1600/33.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (34, 'https://2.bp.blogspot.com/-Oj16RWiKO0I/VxO3_CE6xyI/AAAAAAAAMAk/3Wwo2jlweq861r__cXGTcPNtFVS7HflFACKgB/s1600/34.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (35, 'https://4.bp.blogspot.com/-_olzXx4JNOw/VxO3_1gc6wI/AAAAAAAAL_k/0mhhg89Ft0sAvHzbJai_7sIl8tI-yXlgQCKgB/s1600/35.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (36, 'https://4.bp.blogspot.com/-A4laeZQsKHg/VxO3_-ST9fI/AAAAAAAAMAk/Tizz0lS1yfEnKW4_Ii6794-ifPyiVsksQCKgB/s1600/36.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (37, 'https://2.bp.blogspot.com/-OUcPuZb-mu8/VxO4AokYtXI/AAAAAAAAL_w/ucGKv8AlDREAo0HjoGn1FPMWBGYYs8i4gCKgB/s1600/37.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (38, 'https://2.bp.blogspot.com/-_UkogPYLkuA/VxO4AuDHWSI/AAAAAAAAMAk/G3flRUoUblAi2IR5U5ikMh9rQP_dgiiZACKgB/s1600/38.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (39, 'https://2.bp.blogspot.com/-AVPfWT6RkSo/VxO4AtpXNjI/AAAAAAAAMAk/XXGZS4oahf4vatW6LjaGrMRRk5FUCyACgCKgB/s1600/39.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (40, 'https://1.bp.blogspot.com/-6TOWR-cAT3c/VxO4BdMevuI/AAAAAAAAL_8/LOQmljJYZmc60DTKa3tbF40fBihOWJUnwCKgB/s1600/40.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (41, 'https://4.bp.blogspot.com/-CvYam_GycN0/VxO5EqXycJI/AAAAAAAAMAw/uejmJH7cjJUrGnrZvnZx5bF2V4dr7PYBACKgB/s1600/41.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (42, 'https://2.bp.blogspot.com/-fNQYGyCWBsk/VxO5Eeo0-kI/AAAAAAAAMAs/IJhrtE2NAx8lcU7ZsPsr0609fv-MGy5vACKgB/s1600/42.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (43, 'https://2.bp.blogspot.com/-oXLx1WGmYyY/VxO5EUJCaaI/AAAAAAAAMC0/O2FlYTFnnrcy7-bJbZ0H4fp15LSsr3nuQCKgB/s1600/43.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (44, 'https://4.bp.blogspot.com/-R-BDOcUYdas/VxO5EnUnBfI/AAAAAAAAMC0/6Pmx_PI-wJ0_6wIT9lV28J_GyI6EUkmJACKgB/s1600/44.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (45, 'https://3.bp.blogspot.com/-mqW9l2WZqzg/VxO5E8DO3JI/AAAAAAAAMA4/uaax-mOQ7tAos-3CoS3n_TKUq5TmG1jUQCKgB/s1600/45.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (46, 'https://1.bp.blogspot.com/-0wiYDW9SjWY/VxO5E8ZjGOI/AAAAAAAAMC0/UrwL5bCRaOceNHF20O0wvQ3IBKieBwYhACKgB/s1600/46.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (47, 'https://1.bp.blogspot.com/-sDg9i2gV7FI/VxO5FLfScZI/AAAAAAAAMBA/PLJxCoMiR44vh6X4FS3lR57JNfNEmxQXACKgB/s1600/47.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (48, 'https://1.bp.blogspot.com/-9v4h8UizzCA/VxO5GOeTqkI/AAAAAAAAMBM/S42FXsa389AzRqZFEFAEerCyc53D9OTuwCKgB/s1600/48.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (49, 'https://1.bp.blogspot.com/-FyTBrVRkNzw/VxO5Fsw_1LI/AAAAAAAAMBE/nie3V1LR3j4eaTmSA7Ci0j12FihPxxu7ACKgB/s1600/49.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (50, 'https://2.bp.blogspot.com/-91hLx-fUh0o/VxO5GD0VKgI/AAAAAAAAMBI/4gRaWEatSgoO-_yZjc0OhXgcPOsv6MqwACKgB/s1600/50.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (51, 'https://2.bp.blogspot.com/-er7HIbWebbs/VxO5OjgGwBI/AAAAAAAAMBU/knoqq4IQf4csdOrXBMK5pkuRf21UXQVWgCKgB/s1600/51.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (52, 'https://4.bp.blogspot.com/-9lH6bu0Ev1E/VxO5OsdD6MI/AAAAAAAAMC0/UySyfhSzN3w6JhLGHCjB1LHMWRNFm1S8gCKgB/s1600/52.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (53, 'https://4.bp.blogspot.com/-X3Mc-Ab2Z9k/VxO5OktU0uI/AAAAAAAAMBY/9TIV4U11tec3BgEAEBzBDkOYXrzawXlDgCKgB/s1600/53.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (54, 'https://2.bp.blogspot.com/-Fi6WbWLsI8Q/VxO5O0Bi8NI/AAAAAAAAMC0/8BPv9thtovQ8JLPag7f-1WKC4YW-k8EegCKgB/s1600/54.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (55, 'https://4.bp.blogspot.com/--2DF7yNFh-w/VxO5PBteNjI/AAAAAAAAMBg/xSX26Cji0tsleMSJshgyaGx_3IJNgtOyACKgB/s1600/55.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (56, 'https://2.bp.blogspot.com/-N9su524f4yk/VxO5Pk36BxI/AAAAAAAAMBo/-Amq8XDzkwEsL1W2geDb-hRJeTNlZ9CKACKgB/s1600/56.JPG');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (57, 'https://2.bp.blogspot.com/-58j_WtwA2qs/VxO5PYGzJpI/AAAAAAAAMC0/VAIWceYC-iwac_XUVP25itvSCm8jg1EgwCKgB/s1600/57.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (58, 'https://4.bp.blogspot.com/-BXpuqq3-GaQ/VxO5Pmpu8QI/AAAAAAAAMC0/C4XvoqRSW20Pqkq0My0BDrSTK_GkiIkhACKgB/s1600/58.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (59, 'https://3.bp.blogspot.com/-R1cG7j6Rq5Y/VxO5PxfELGI/AAAAAAAAMC0/JCp61XFSync7mQXCBb_nsAIHzXV3YGEMQCKgB/s1600/59.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (60, 'https://3.bp.blogspot.com/-RtThFmxL6aQ/VxO5QNJBdgI/AAAAAAAAMB0/wxX32Lyb85YYh5foDtxLzJfdh7utqJOMgCKgB/s1600/60.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (61, 'https://4.bp.blogspot.com/-GCA6ERWFLBE/VxO5aIpcLFI/AAAAAAAAMC0/1AdmUA9ddrEfV6mojvH5MzvoAT80iOviwCKgB/s1600/61.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (62, 'https://3.bp.blogspot.com/-YnGswkQIhdc/VxO5YOeY6_I/AAAAAAAAMB4/9uXE1LZTUXIkL2d4odVI5SkojqvW4F2PQCKgB/s1600/62.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (63, 'https://2.bp.blogspot.com/-TdaVmGFFIWE/VxO5YXV3M-I/AAAAAAAAMB8/USJpsI52vX8r-7j6EdDcVN9uFnFbr-DhQCKgB/s1600/63.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (64, 'https://3.bp.blogspot.com/-2QJrKxfsLJo/VxO5YxnpKPI/AAAAAAAAMCA/MQ5g2KZo5mojteCSHseIgQLdO1PgOVmHACKgB/s1600/64.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (65, 'https://4.bp.blogspot.com/-LL4yM_wt5mE/VxO5Ywte6EI/AAAAAAAAMCE/KQYCKbe044YWy1QDLeoQTS2w9QHBDVdEwCKgB/s1600/65.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (66, 'https://3.bp.blogspot.com/-SUCzpMhSLuY/VxO5Z9ujFdI/AAAAAAAAMCM/LJYOHWxUmMUAKtGz_TN3PkssMNBQ1WzVwCKgB/s1600/66.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (67, 'https://4.bp.blogspot.com/-DT5Eqysh35Y/VxO5ZwKyIsI/AAAAAAAAMCI/MoS6dBaLZMIWNDhHoWdF4R1XHIgYglbYwCKgB/s1600/67.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (68, 'https://3.bp.blogspot.com/-_oyUVQZa54s/VxO5aOaNYfI/AAAAAAAAMCU/pnu9Sr8k8DcMcEddvSNf8fU4S4xf_fcEgCKgB/s1600/68.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (69, 'https://4.bp.blogspot.com/-DKIFJ3Ylkfw/VxO5aUe-3lI/AAAAAAAAMC0/ALejhpHP4-8TE_pEd56OfLBXIFm0KFVWgCKgB/s1600/69.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (70, 'https://3.bp.blogspot.com/-F3PwIPGuDss/VxO5adF6zFI/AAAAAAAAMC0/zS9qdC5kHCQ_1o0whYJPou5IzstpquOmwCKgB/s1600/70.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (71, 'https://1.bp.blogspot.com/-2PlMjuLkFAs/VxO5ajSVUBI/AAAAAAAAMC0/6Gy-vN4TsSQq1VW0cAhlL1e0P8FKh7wawCKgB/s1600/71.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (72, 'https://2.bp.blogspot.com/-bvXLRnPDak0/VxO5a6boOOI/AAAAAAAAMCk/B_bzB30sx2MQedVAvnXk7QqM2XfsXdEXgCKgB/s1600/72.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (73, 'https://1.bp.blogspot.com/-tqpcLhz0qXM/VxO5a3mBZqI/AAAAAAAAMCo/2Z0mcYLYsiMp5Fa6Tm3VP9SVao01HXxDACKgB/s1600/73.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (74, 'https://4.bp.blogspot.com/-VwyGwGnvs7M/VxO5bczVSYI/AAAAAAAAMCw/roQWqrcDtS0V1bz6NMucBgpMHQWTUSlwACKgB/s1600/74.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (75, 'https://2.bp.blogspot.com/-Zs_u412uVGE/VxO5bXITu-I/AAAAAAAAMC0/vpTeMWhq1p0HrdAd3-A0VtlGySMGdwHeQCKgB/s1600/75.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (76, 'https://4.bp.blogspot.com/-NuT6qkZ-QgQ/VyJOwy6OOgI/AAAAAAAAMJU/e5U6575KVkQIgP7sjgdw0L78Ac_diTaLgCKgB/s1600/01.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (77, 'https://1.bp.blogspot.com/-GclwYrZlB7o/VyJOw8-I2DI/AAAAAAAAMJU/PT13Pqk1jsw5rOqKe6eLqgYDg49ylN8gACKgB/s1600/02.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (78, 'https://1.bp.blogspot.com/-mFaSBfHuTg4/VyJOxYFc1aI/AAAAAAAAMJU/W3LFyUz-FbEHShES7KsPGfLoazGuokt4gCKgB/s1600/03.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (79, 'https://1.bp.blogspot.com/-_wNleBh0Dyg/VyJOxWKdj2I/AAAAAAAAMJU/_zAuhG2gIxUoh_xrYYcbQLKxVF8YLDSbwCKgB/s1600/04.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (80, 'https://1.bp.blogspot.com/-E-PHHduKuIA/VyJOxz3ldII/AAAAAAAAMJU/rrzCiox94QsAB6X-XCvtdcpwBbYINmb_gCKgB/s1600/05.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (81, 'https://4.bp.blogspot.com/-qm-uBShp3jY/VyJOxyIObZI/AAAAAAAAMJU/69ECH-_xYLQH0Yhmn4kf6QF7yLH0xQ04wCKgB/s1600/06.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (82, 'https://3.bp.blogspot.com/-EgryBvvWd8I/VyJOx37nviI/AAAAAAAAMJU/elRYzHqYVH0RsIT8Xjz0jBJ7lxBiDVbbQCKgB/s1600/07.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (83, 'https://2.bp.blogspot.com/-gdtsdvAvBAU/VyJOyUTDGrI/AAAAAAAAMJU/giuPQKQulawriS4utVmwoBd_VgqcrGiggCKgB/s1600/08.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (84, 'https://1.bp.blogspot.com/-Xn-CFwY9fkI/VyJOybn6BiI/AAAAAAAAMJU/lO5GgDdBpYIjnpGU81DX9qjxip2jeaaNACKgB/s1600/09.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (85, 'https://2.bp.blogspot.com/-8vb49HPbmNI/VyJOy_UGZFI/AAAAAAAAMJU/ItO2Z4SIlnAF3Bs5ZbdsJGBM5njCbTCHgCKgB/s1600/10.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (86, 'https://4.bp.blogspot.com/-lNr_3MPAJdY/VyJOzBX5BFI/AAAAAAAAMEc/czB8LRg2i-AsJ-0QgSq2E6aEFIjL7p5xwCKgB/s1600/11.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (87, 'https://4.bp.blogspot.com/-NITYOYw5YOA/VyJOzaIeiUI/AAAAAAAAMJU/-MxY-s0o-oISaP66XHws7G50PdrZ5EaPgCKgB/s1600/12.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (88, 'https://2.bp.blogspot.com/-EM_w3zfgovo/VyJOzj-6DHI/AAAAAAAAMJU/J2M2gIj_7nMJ28J8OfTskNDHHKxfZIF8gCKgB/s1600/13.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (89, 'https://3.bp.blogspot.com/-zmBRu0k_DDg/VyJOziLOZ9I/AAAAAAAAMJU/Do5gbSP672ERVM4hSPoPboxb1Ny4P3zUQCKgB/s1600/14.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (90, 'https://2.bp.blogspot.com/-oCSlnC-z0GY/VyJOz9JUr6I/AAAAAAAAMJU/PQb_TkC_fVY4Ygsh21b7t8oMTO0odE1jACKgB/s1600/15.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (91, 'https://1.bp.blogspot.com/-ft8m55-h83Q/VyJOzzNut9I/AAAAAAAAMJU/2YrmXrqtoxAfFZqyorN9LtjhCeQzNmTAwCKgB/s1600/16.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (92, 'https://1.bp.blogspot.com/-ZEsWgIFvgyQ/VyJO0NKIcNI/AAAAAAAAMJU/bixrstmHvFUszQ6tgVtHAN7fmRhXm0a4wCKgB/s1600/17.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (93, 'https://1.bp.blogspot.com/-ue0Ny-dtwNk/VyJO0AzZw3I/AAAAAAAAMJU/5jlj1d53mZkmycEyenX8ZAidCVc8kT4RgCKgB/s1600/18.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (94, 'https://3.bp.blogspot.com/-v3jDm3Y6tyU/VyJO0QO1lhI/AAAAAAAAMJU/cTPsKBE2czIUprqMDQSfBy50FgFIbeHnQCKgB/s1600/19.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (95, 'https://1.bp.blogspot.com/-Uwb1kPrQ530/VyJO0wQFhxI/AAAAAAAAMJU/AsUcoMbySOY-lGCuLgcjeG8IWKqbXwhIgCKgB/s1600/20.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (96, 'https://2.bp.blogspot.com/-ZI9xPXACHuE/VyJO1JtHE4I/AAAAAAAAMJU/O2BDOJgfEMksRo0crrEetg3nveCBcyplACKgB/s1600/21.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (97, 'https://2.bp.blogspot.com/-YiRIZWYe-6g/VyJO1AFOvpI/AAAAAAAAMJI/I5NrE3rbZQ8xVYsFaOo7_qqPULgwZJM5wCKgB/s1600/22.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (98, 'https://2.bp.blogspot.com/-AnPzchN28fo/VyJO1ejzDxI/AAAAAAAAMJI/_T_1wtAfl4kskaYHOk2SmzigSV5PXhdPQCKgB/s1600/23.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (99, 'https://1.bp.blogspot.com/-C-P1YHmVKEM/VyJO1VxM3rI/AAAAAAAAMJI/GO3txe-68NUaYc3TPSWuSNEzi-ei8gJZQCKgB/s1600/24.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (100, 'https://2.bp.blogspot.com/-ajuIR9DtBoc/VyJO1konz9I/AAAAAAAAMJI/QPgW6khKNKYxN4iAF_MnNsNKPECw3r1gQCKgB/s1600/25.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (101, 'https://1.bp.blogspot.com/-1IrTaoxR3Fs/VyJO1ynPqFI/AAAAAAAAMJI/RqRcoH14BAUEx8d0DiCyYry_fT2dt4WnwCKgB/s1600/26.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (102, 'https://3.bp.blogspot.com/-6Oh525fHZfQ/VyJO2HqICdI/AAAAAAAAMFg/4LMXxu3MTaIfS7nFqRqaOZGEXPQtWpnyACKgB/s1600/27.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (103, 'https://4.bp.blogspot.com/-za_vzkbcfyU/VyJO2KOHqbI/AAAAAAAAMJI/dKNxPK2TzjcqcXq79J-Tnb2BO0lz8g6vgCKgB/s1600/28.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (104, 'https://1.bp.blogspot.com/-pP7N28-virI/VyJO2dHV1kI/AAAAAAAAMJI/wLJ2Lz3rYN81kaLHe3hU6lGzUAeTtiWgwCKgB/s1600/29.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (105, 'https://4.bp.blogspot.com/-wTSJPlb6GzY/VyJO2pQrfmI/AAAAAAAAMJI/Nfa73yns0eUVGmH3jyzd1W8fjnU0erdZgCKgB/s1600/30.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (106, 'https://2.bp.blogspot.com/-mN89m_9aCU4/VyJO2kigh2I/AAAAAAAAMJI/IEI1RsLPOVYKkhg1iwWt946_x_ZiZab0ACKgB/s1600/31.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (107, 'https://2.bp.blogspot.com/--L-jBuJKE2w/VyJO2gnU3uI/AAAAAAAAMJI/XTz430ylWfkZiIYhQMNiD3n-LJI1jhXMACKgB/s1600/32.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (108, 'https://3.bp.blogspot.com/-WtbAgq7N74w/VyJO33Em2CI/AAAAAAAAMGA/UOc7zqK01lg0GyrJ4by-v3ScAHV-XbOhACKgB/s1600/33.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (109, 'https://4.bp.blogspot.com/-jZDOpa7tue4/VyJO3YDJTJI/AAAAAAAAMJI/JsUNa-Xob1EW5Tbk7WncXTz3apeb1bChQCKgB/s1600/34.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (110, 'https://1.bp.blogspot.com/-doRe6R5-R0I/VyJO3VPl7II/AAAAAAAAMJI/f5cOWlYUHyQiuyCeOcJtP2s0ay-NlzXVQCKgB/s1600/35.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (111, 'https://2.bp.blogspot.com/-gVs6E7glF0w/VyJO4E4rWeI/AAAAAAAAMJI/aSFGixOzpAAOYLFDWmjr2mTI5K85Z_y4wCKgB/s1600/36.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (112, 'https://2.bp.blogspot.com/-Y0Vgl0wyMOU/VyJO4RdZnMI/AAAAAAAAMJI/bI4Ys4PwJOsp4bO-_321j9xT8B0PsZs8ACKgB/s1600/37.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (113, 'https://4.bp.blogspot.com/-EHl2ykVUjY8/VyJO4wQVMqI/AAAAAAAAMJI/Q70qIQQ7q_k6s2m1S0p4bX3rgs7WIX9AwCKgB/s1600/38.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (114, 'https://4.bp.blogspot.com/-5Igy0CXp-fQ/VyJO46-hWrI/AAAAAAAAMJI/MFHfP9xZWIshQj3nFKh27eUdY_DYkW6kgCKgB/s1600/39.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (115, 'https://3.bp.blogspot.com/-Dgrr56jZfQQ/VyJO5WW4cWI/AAAAAAAAMJI/DwEux5ufxPgS1BpE3Wu99gqzh_6WWBDmwCKgB/s1600/40.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (116, 'https://2.bp.blogspot.com/-gsj2eK4jnVE/VyJO5_MozII/AAAAAAAAMJI/7rxIknT18SkaXtf7Ss_9JEBJbxKrPXoZwCKgB/s1600/41.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (117, 'https://4.bp.blogspot.com/-aOdrT0Qizyg/VyJO6Ho8SmI/AAAAAAAAMJI/BeozD7VNqj0PjgpK0Z1FuwNag92zCQpCwCKgB/s1600/42.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (118, 'https://3.bp.blogspot.com/-c7EUX-6oa9s/VyJO6CBRLqI/AAAAAAAAMJI/HTqhHkKHNigKyMq-ZQlTUV10lg65GAB6QCKgB/s1600/43.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (119, 'https://1.bp.blogspot.com/-e7WE2L2LxbQ/VyJO6RMRgAI/AAAAAAAAMGk/Ihiooek9-oAawyYBZ6je0zGqXJRP9zMmgCKgB/s1600/44.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (120, 'https://3.bp.blogspot.com/-A269dHprOB8/VyJPIuzMg1I/AAAAAAAAMGs/3D3tTNjxbj8lX_MB1GLtNuVuQJW2ANRIQCKgB/s1600/45.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (121, 'https://4.bp.blogspot.com/-ZrcAdwIrVlo/VyJPIXFx-YI/AAAAAAAAMG8/B9KsWAWbLhk8T1W-lAh6K-gzUW8IYotbACKgB/s1600/46.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (122, 'https://3.bp.blogspot.com/-a5HOL0Q7Bg0/VyJPIv1EOkI/AAAAAAAAMGo/66r7BP_Z06QQBrUFg6MrN2w49xK1uj-dQCKgB/s1600/47.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (123, 'https://4.bp.blogspot.com/-mr592Y9roGs/VyJPIz7PYeI/AAAAAAAAMGw/L8V8EUdDIxccyilI1YqEvIphNKxFWmztgCKgB/s1600/48.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (124, 'https://4.bp.blogspot.com/-Jb8zdGyPS7Q/VyJPJEMN1BI/AAAAAAAAMG0/NStqIR5fZrsp4deOwHnFgfg0tk3Rd_dCgCKgB/s1600/49.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (125, 'https://4.bp.blogspot.com/-1cYXPLZ2rqo/VyJPJLWieAI/AAAAAAAAMG4/txx-TuYd-RYI1ilQGlpeNIyAg06mr7LlgCKgB/s1600/50.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (126, 'https://2.bp.blogspot.com/-xspSp8afO-E/VyJPKdU2hYI/AAAAAAAAMHM/OO-5ZtXFh1EXnv4yNyJoTg7H9-NVe9IfACKgB/s1600/51.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (127, 'https://1.bp.blogspot.com/-dy_tMWXQcPA/VyJPJrfEycI/AAAAAAAAMJY/trVyCWJmK-QxbRCKcxnvaiuVZufpARIGACKgB/s1600/52.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (128, 'https://3.bp.blogspot.com/-_3-groyHI5g/VyJPJynoZbI/AAAAAAAAMJY/UnE_YJKkOyUjyqhHkIOXK1SaPYbDMbm8gCKgB/s1600/53.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (129, 'https://2.bp.blogspot.com/-v2dvoQ-Vqkk/VyJPKJp2n0I/AAAAAAAAMJY/Id2r0dz5ZyUT-DDLblPUIzaWf_RcoRJuACKgB/s1600/54.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (130, 'https://2.bp.blogspot.com/-AO65Ce2Jdx8/VyJPKR5IdGI/AAAAAAAAMHQ/Xl-4IdDiFvQhCzZOUoX7NnrhF8pHUrvhwCKgB/s1600/55.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (131, 'https://1.bp.blogspot.com/-g60TCIKhRs0/VyJPKlTkACI/AAAAAAAAMHU/DvxGFGmeCGgcqAHTH1mXj6fBfmPQ3ee1gCKgB/s1600/56.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (132, 'https://3.bp.blogspot.com/-4DOkknrLdXI/VyJPKyQ0rmI/AAAAAAAAMHY/6g23vhiMO0AYjf2gONF1no-yVbphecx9QCKgB/s1600/57.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (133, 'https://2.bp.blogspot.com/-Po3G4q6Otw0/VyJPK37bcdI/AAAAAAAAMHc/BzdnQk9G02kHF4uJ8i1CDtwGaf2XZ0VfACKgB/s1600/58.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (134, 'https://4.bp.blogspot.com/-P9kVxhGCgqI/VyJPK5Q4A7I/AAAAAAAAMHg/fXbVNmp_5-8rQJd-hYARh0QGQd5fupI3ACKgB/s1600/59.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (135, 'https://1.bp.blogspot.com/-7cftyyzDJRc/VyJPLDSvvzI/AAAAAAAAMHk/71Omosy5-i0K7DMj1JQqdMFKO_CIKDfQwCKgB/s1600/60.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (136, 'https://1.bp.blogspot.com/-vlV5OPQR544/VyJPLBqFJ4I/AAAAAAAAMHo/kf1xrjo9k5s5MPH4LXyq3JURJWAlHKzfwCKgB/s1600/61.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (137, 'https://2.bp.blogspot.com/-cxt_xxZ3rjU/VyJPLWcosMI/AAAAAAAAMHs/LH5dHs-6hIgc7d6VR576UhjZIVVjVGDVACKgB/s1600/62.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (138, 'https://3.bp.blogspot.com/-wL9UiAQXbyo/VyJPMC8UuuI/AAAAAAAAMH8/spdqtvwRYrk5_XiukwosbIhwTduGl8CgwCKgB/s1600/63.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (139, 'https://4.bp.blogspot.com/-tnzfkDMkglU/VyJPL29iSzI/AAAAAAAAMJY/NU9d7JfskisXJEkj8Y8A1oT2HwShFmudwCKgB/s1600/64.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (140, 'https://3.bp.blogspot.com/-qbMPp0PjlBc/VyJPL-m2fBI/AAAAAAAAMJY/NUb13xr8nD4mKSqmv1XamJEmlWv9tdxSQCKgB/s1600/65.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (141, 'https://2.bp.blogspot.com/-OG1v7J370_U/VyJPMl4qHzI/AAAAAAAAMJY/4Blma4oy408iy9I_SQyalMraPvJVFLOKwCKgB/s1600/66.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (142, 'https://3.bp.blogspot.com/-2076tyFjU0c/VyJPMbfB8yI/AAAAAAAAMJY/KDzpekHqiYM2fQ96Kilio4Rr4eaRwnLsACKgB/s1600/67.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (143, 'https://4.bp.blogspot.com/-ZxCPkW1iEh8/VyJPMqyJcyI/AAAAAAAAMJY/6mGansWlKYAhaGfwjTwBIlD_V3CAHIOKACKgB/s1600/68.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (144, 'https://1.bp.blogspot.com/-Tz4A15YaJa0/VyJPMgCRd2I/AAAAAAAAMJY/E57oQ8aiDNwZAhOaFCJkKWyQqQ2eWx-8QCKgB/s1600/69.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (145, 'https://3.bp.blogspot.com/-rHNlNYfdFRs/VyJPM1tQzHI/AAAAAAAAMJY/EXqfBZfEahAYPFc80jiWxWegXpZf6wclgCKgB/s1600/70.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (146, 'https://2.bp.blogspot.com/-hfIHIkbP19I/VyJPM8k1mAI/AAAAAAAAMJY/zCe4VIubuooA8MeUCGIZ2hx9UwCQjouoQCKgB/s1600/71.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (147, 'https://2.bp.blogspot.com/-cVVB4tMTyfA/VyJPNCQhEtI/AAAAAAAAMJY/kQgXRBCQ_y00XcIX4pMQajhkeVdZXphiwCKgB/s1600/72.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (148, 'https://4.bp.blogspot.com/-Fxe5L6WU46E/VyJPNLLzR3I/AAAAAAAAMJY/P8nb1D-Q-NksuiY2apW4iwApguoRBU9hACKgB/s1600/73.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (149, 'https://4.bp.blogspot.com/-Opo0xliplA8/VyJPNYrKgYI/AAAAAAAAMJY/N2BktuvEpG0nseadmLtmv-3FnlKxS3hLACKgB/s1600/74.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (150, 'https://2.bp.blogspot.com/-1neKM4JlbP8/VyJPNfkWyoI/AAAAAAAAMJY/g1iTAHw6hUMXulU3Kyi6lpR1DYuG5hz-gCKgB/s1600/75.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (151, 'https://1.bp.blogspot.com/-gN5GKoq9jA4/VyJPNyZHMpI/AAAAAAAAMJY/yZJ3x-f4_RcwnwwsxXnoaOWXIWjD6jeWQCKgB/s1600/76.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (152, 'https://2.bp.blogspot.com/-OOHCVkXdE44/VyJPNzVGWlI/AAAAAAAAMJg/uTFFdj2Ztm4AhTuChaRpJaSen9AxQQiFACKgB/s1600/77.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (153, 'https://2.bp.blogspot.com/-pm0fE7DhQ98/VyJPOgFIdWI/AAAAAAAAMJg/bJJd_Y3FbGYZF6OhRakqZW5c5dyE8cIPgCKgB/s1600/78.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (154, 'https://3.bp.blogspot.com/-w8iAys1-8iE/VyJPOqCJAqI/AAAAAAAAMJY/jmTol5bK-kEZerKBqD8Z8ZAFnpPneqkpwCKgB/s1600/79.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (155, 'https://3.bp.blogspot.com/-0RNm1Z0QjuQ/VyJPOvzwvHI/AAAAAAAAMJY/SGAI7rBitr0gPmFCGmWmKbpGLBkY5qW5ACKgB/s1600/80.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (156, 'https://4.bp.blogspot.com/-3JeL9w0slPo/VyJPO6p0hzI/AAAAAAAAMJg/Dwi2ZkrSil8F80g-ZyGNEOdI6wr79ASjwCKgB/s1600/81.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (157, 'https://1.bp.blogspot.com/-Iq-kQ_2vyZA/VyJPP_Ft7LI/AAAAAAAAMJY/8jPiHj-7bAkYLrNeQnE_1Pu_jB3gFGwKACKgB/s1600/82.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (158, 'https://1.bp.blogspot.com/-rINoVdm-Ep4/VyJPPDzIrSI/AAAAAAAAMJY/gtztTqkrNyEqhp4Vb_CKZHBLLDUPlUzUwCKgB/s1600/83.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (159, 'https://2.bp.blogspot.com/-yATeaK87-ug/VyJPZ6FALCI/AAAAAAAAMJg/FIYNchKKYz8MM2t17FqWsviWsb-u5RnUgCKgB/s1600/84.jpg');
INSERT INTO `story_image` (`id`, `image_url`) VALUES (160, 'https://1.bp.blogspot.com/-mOl6qXMP4Yw/VyJPcd7l9HI/AAAAAAAAMJg/2ynO-9BR16QeAyYCI9gpALs6loG-xT1NgCKgB/s1600/85.jpg');

COMMIT;


-- -----------------------------------------------------
-- Data for table `story_has_story_image`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (17, 1);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (17, 2);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (17, 3);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (17, 4);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (17, 5);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (17, 6);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (17, 7);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (14, 8);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (14, 9);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (14, 10);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (15, 11);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (15, 12);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (15, 13);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (22, 14);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (22, 15);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (22, 16);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (22, 17);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (22, 18);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (21, 19);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (21, 20);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (21, 21);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (21, 22);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (21, 23);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (21, 24);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (21, 25);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (19, 26);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (19, 27);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (19, 28);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (19, 29);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (19, 30);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (19, 31);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (19, 32);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (19, 33);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (12, 34);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (12, 35);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (12, 36);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (12, 37);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (12, 38);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (12, 39);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (16, 40);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (16, 41);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (16, 42);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (16, 43);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (16, 44);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (16, 45);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (16, 46);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (24, 47);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (24, 48);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (24, 49);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (24, 50);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (24, 51);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (24, 52);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (18, 53);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (18, 54);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (18, 55);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (18, 56);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (18, 57);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (20, 58);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (20, 59);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (20, 60);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (20, 61);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (20, 62);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (23, 63);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (23, 64);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (23, 65);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (23, 66);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (23, 67);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (13, 68);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (13, 69);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (13, 70);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (13, 71);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (13, 72);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (13, 73);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (13, 74);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (13, 75);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (35, 76);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (35, 77);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (35, 78);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (35, 79);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (35, 80);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (35, 81);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (35, 82);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (35, 83);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (35, 84);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (35, 85);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (35, 86);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (35, 87);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (35, 88);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (35, 89);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (35, 90);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (35, 91);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (35, 92);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (35, 93);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (35, 94);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (35, 95);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (35, 96);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (35, 97);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (35, 98);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (36, 99);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (36, 100);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (36, 101);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (36, 102);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (36, 103);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (36, 104);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (36, 105);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (36, 106);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (36, 107);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (36, 108);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (36, 109);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (36, 110);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (36, 111);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (36, 112);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (36, 113);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (36, 114);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 115);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 116);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 117);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 118);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 119);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 120);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 121);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 122);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 123);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 124);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 125);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 126);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 127);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 128);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 129);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 130);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 131);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 132);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 133);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 134);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 135);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 136);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 137);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 138);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 139);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 140);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 141);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 142);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 143);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 144);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 145);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 146);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 147);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 148);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 149);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 150);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 151);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 152);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 153);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 154);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 155);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 156);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 157);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 158);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 159);
INSERT INTO `story_has_story_image` (`story_id`, `story_image_id`) VALUES (34, 160);

COMMIT;


-- -----------------------------------------------------
-- Data for table `story_image_has_illustrator`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (1, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (2, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (3, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (4, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (5, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (6, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (7, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (8, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (9, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (10, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (11, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (12, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (13, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (14, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (15, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (16, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (17, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (18, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (19, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (20, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (21, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (22, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (23, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (24, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (25, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (26, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (27, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (28, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (29, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (30, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (31, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (32, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (33, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (34, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (35, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (36, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (37, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (38, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (39, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (40, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (41, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (42, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (43, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (44, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (45, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (46, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (47, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (48, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (49, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (50, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (51, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (52, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (53, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (54, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (55, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (56, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (57, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (58, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (59, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (60, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (61, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (62, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (63, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (64, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (65, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (66, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (67, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (68, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (69, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (70, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (71, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (72, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (73, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (74, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (75, 1);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (76, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (77, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (78, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (79, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (80, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (81, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (82, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (83, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (84, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (85, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (86, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (87, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (88, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (89, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (90, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (91, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (92, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (93, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (94, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (95, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (96, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (97, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (98, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (99, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (100, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (101, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (102, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (103, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (104, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (105, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (106, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (107, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (108, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (109, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (110, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (111, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (112, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (113, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (114, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (115, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (116, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (117, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (118, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (119, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (120, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (121, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (122, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (123, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (124, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (125, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (126, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (127, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (128, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (129, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (130, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (131, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (132, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (133, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (134, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (135, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (136, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (137, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (138, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (139, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (140, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (141, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (142, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (143, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (144, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (145, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (146, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (147, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (148, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (149, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (150, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (151, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (152, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (153, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (154, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (155, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (156, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (157, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (158, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (159, 2);
INSERT INTO `story_image_has_illustrator` (`story_image_id`, `illustrator_id`) VALUES (160, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `blog_post`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `blog_post` (`id`, `title`, `content`, `created_at`, `user_id`, `hidden`, `image_url`) VALUES (1, 'The Origins of Atlantis and its Place in Sword and Sorcery', '<div class=\"col-md-12 col-xs-12 col-sm-12 col-lg-12\">\n<h1 class=\"\">Exploring the Origins of Atlantis and its Place in Sword and Sorcery</h1>\n<p class=\"\">In our last couple of articles, we’ve taken a closer look at some of the different myths and legends that have fed into sword and sorcery mythology, and this post will be no different. The truth is that sword and sorcery is such a huge, diverse genre that it’s influenced by a little bit of everything.</p>\n<p>Today, we’re going to be climbing into our diving gear and heading under the water to pay a visit to the sunken island of Atlantis, starting out by taking a look at its origins and moving on to take a look at how sword and sorcery has felt its impact.</p>\n<p class=\"\">Like many myths and legends, the tale of Atlantis dates back at least a couple thousand years, and while it does go hand-in-hand with sword and sorcery, it’s been used in pretty much every genre there is. So what is it about Atlantis that makes it so enduring? And who are some of the authors – both classic and contemporary – who’ve used its story to good effect?</p>\n<p>Let’s jump into the water and find out.</p>\n<h2 class=\"\">The origins of Atlantis</h2>\n<p>The lost island of Atlantis has its origins in philosophy, and in fact it’s the brainchild of Greek philosopher Plato. Taught by Socrates, Plato taught Aristotle, who then taught Alexander the Great, arguably the closest thing our real world has to a sword and sorcery hero.</p>\n<p>Much of what Plato talked about was based on real events, but the legend of Atlantis has essentially been proved to be false, though there are still one or two people who’ll swear there’s evidence that it once existed.</p>\n<p class=\"\">Plato first told his followers the story of Atlantis in around 360 BC, nearly two and a half millennia ago. According to Plato, the Atlantians were half god and half human and they lived in a perfect society that can best be described as a heavenly Venice. He said that Atlantis existed around 9,000 years earlier and that its stories had been passed down orally from generation to generation, but his own testimony is the earliest known reference to the sunken island.</p>\n<p class=\"\">No one really knows exactly where Atlantis was supposed to be, and historians and mythologists alike have made suggestions that literally span the globe. In fact, its exact location doesn’t really matter when we’re talking about its influence on sword and sorcery, because it’s usually being ported into some unusual fantasy world anyway.</p>\n<p>The only thing that really matters for our purposes is how the legend ends, which is always the same. The island disappeared beneath the sea and was never heard from again. At least, not until it started popping up in our literature.</p>\n<h2>Atlantis and Robert E. Howard</h2>\n<p>You can’t talk about Atlantis in sword and sorcery without talking about Robert E. Howard. He’s the creator of many of sword and sorcery’s most well-known characters, most notably Conan the Barbarian, but he also used Atlantis and Atlantian mythology to create Kull the Conqueror. You might have heard of him under his other name, Kull of Atlantis.</p>\n<p>Kull came first, and he’s arguably a less refined version of Conan who’s set amongst a different backdrop. Born in around 100,000 BC, Kull lives in an Atlantis that’s populated by barbarian tribes and which lies on the west of the continent of Thuria. Kull’s own tribe is from the Tiger Valley, an area of Atlantis which was destroying by flooding, foreshadowing the eventual fate of the whole island.</p>\n<p class=\"\">Kull is interesting because there are similarities between Kull and the character of Mowgli in Rudyard Kipling’s Jungle Book. In fact, he’s arguably the Atlantian Mowgli, because he survived alone in the wild from a young age before being adopted by the Sea-Mountain tribe. Kull is eventually exiled from Atlantis and spends a short period as a pirate, further continuing that watery theme.</p>\n<p>There’s more to Kull’s story of course, but we don’t want to spoil it for you and his later years don’t tie back as heavily to the theme of his early years in Atlantis. Kull himself only featured in a dozen stories, and only three of those were published before Howard’s death in 1936. Howard later reused many of the elements of his Kull mythos to create the character of Conan, but he ultimately left the Atlantis elements behind to establish Conan instead as a Cimmerian. &nbsp;</p>\n<h2>Atlantis in Sword and Sorcery</h2>\n<p>But that’s not where Atlantis’ influence on sword and sorcery comes to an end. In some cases, as with Kull of Atlantis, the connection is more direct and more obvious. In other cases, it’s used subtly, with story elements or little nods to the original myth.</p>\n<p>Robert E. Howard wasn’t the only one of his contemporaries to write about Atlantis. For example, Edgar Rice Burroughs wrote about a colony of Atlantis, called Opar, in his Tarzan series. More recently, Kara Dalkey wrote her Water Trilogy, which mixes up both Arthurian and Atlantian legends. There’s really nothing quite like it.</p>\n<p>Even earlier than Howard, Sherlock Holmes creator Sir Arthur Conan Doyle wrote a novel called The Maracot Deep in which a deep-sea diving team finds the lost city beneath the waves. Conan Doyle didn’t live long enough to witness the rise of sword and sorcery, but he did use elements of it in his historical fiction novels about the swashbuckling Brigadier Gerard and the adventures of The White Company.</p>\n<p>In her The Fall of Atlantis series, Marion Zimmer Bradley channels the spirit of sword and sorcery and mixes it up with the Atlantis legend to tell the story of Britain’s ancient druids. For Zimmer Bradley, the druids were the direct descendants of the survivors of Atlantis. Even the Godzilla series looked to get on board with a novel called Godzilla and the Lost Continent that was eventually shelved by Random House before it could be published.</p>\n<p>And when it comes to more hardcore, traditional sword and sorcery, you’ll want to check out Sherrilyn Kenyon and her Dark-Hunter series. Following a hero called Alak, the series also has elements of the paranormal, its own impressive mythology system and a bunch of reinterpretations of Greek myths. The leader of the Dark-Hunters is a former Atlantian god.</p>\n<h2 class=\"\">A new take on Atlantis</h2>\n<p>As with anything that becomes a cliché, the legend of Atlantis then started to spawn a range of new interpretations which played with the legend or which looked at it from a different light. One of my favourite examples of this is Sir Terry Pratchett, who used a spin on the Atlantis tale in his Discworld novel, Jingo.</p>\n<p>Here, instead of Atlantis sinking beneath the sea, it suddenly rises, catching two rival fishermen unawares. Each stakes a claim to it on behalf of their respective nations, and before we know it, two of the Disc’s most powerful armies are at each other’s throats, preparing to go to war. Of course, it would be more like traditional sword and sorcery if his epic barbarian character Cohen the Barbarian made an appearance, but it’s still a cracking take on the Atlantis myth.</p>\n<p class=\"\">Atlantis even appeared in K. A. Applegate’s Animorphs series, which has helped to introduce the legend to a new generation of readers. But let’s not forget the older takes on Atlantis, those that predate the sword and sorcery genre. We haven’t even talked about Jules Verne and 20,000 Leagues Under the Sea, in which the crew of the Nautilus walks along the sea bottom before discovering the sunken ruins of the island. Nor have we talked about John Wyndham and his The Kraken Wakes, which features a terrifying deep sea monster.</p>\n<p>The lost island even gets a namecheck in Eoin Colfer’s crazy popular Artemis Fowl series, as well as a little reference in Neil Gaiman’s Neverwhere. The fact is, it’s virtually impossible to write about the water without feeling the spectre of the Atlantis myth hovering on the horizon. There are even those who’ll swear that the cataclysmic flood in the Bible is what drove Atlantis beneath the waves in the first place. If nothing else, the Kraken Wakes, the Bible and the Atlantis myth all tap into our sense of wonder about the water.</p>\n<p>The earth’s surface is 70% water, and even with today’s advanced technologies, there’s a lot we don’t know about the ocean. In fact, <a href=\"https://earthhow.com/ocean-exploration/\">as much as 80% of the ocean is unexplored</a>, and so who’s to say? Perhaps the lost continent of Atlantis is out there somewhere after all.</p>\n<h2>Conclusion</h2>\n<p>We’ve covered a lot today, but there’s no way that we could cover absolutely everything. That’s why we want to hear from you! If you’ve come across other examples of sword and sorcery tapping into the legend of Atlantis, be sure to let us know in the comments.</p>\n<p>Ultimately, the main conclusion to be found here is that the Atlantis tale is super adaptable and that it sneaks its way into every genre, and not just sword and sorcery. Sure, there are a few natural ways in which the two can work together symbiotically, but with so many authors out there – and so many genres – we shouldn’t be surprised to see it cropping up everywhere.</p>\n<p class=\"\">As for me, all this talk about Atlantis and sword and sorcery has got me wanting to revisit some of the classics, and so I think I’m off to revisit some of the books and movies that we’ve talked about in this article. It’s a good job I can swim!</p>\n<p class=\"\">Article Written by Dane Cobain for Epiphany Entertainment</p>\n<p class=\"\">Copyright ©Epiphany Entertainment 2020</p>\n</div>', '2020-07-24T12:35:22', 1, 0, 'https://www.beyondtheblacksea.com/wp-content/uploads/2020/07/AtlantisPic.png');
INSERT INTO `blog_post` (`id`, `title`, `content`, `created_at`, `user_id`, `hidden`, `image_url`) VALUES (2, 'Lost Civilisations and the Fiction Behind the Fact', '<div class=\"container\">\n<p>&nbsp;</p>\n<p class=\"\"><span style=\"color: #230f2b; font-size: 33px;\">Lost Civilisations and the Fiction Behind the Fact</span></p>\n<div class=\"row\">\n<p>&nbsp;</p>\n<p class=\"\">I’ve always had an obsession with sunken islands and lost civilisations, ever since I was a little kid. As I grew older, I learned they were “just stories”, and then as I grew older still, I learned that there was a grain of truth to the stories, which promptly blew my mind.</p>\n<p class=\"\">&nbsp;</p>\n<p class=\"\">Don’t worry, though, because I’m not one of those conspiracy nuts who thinks that Atlantis is in the middle of the Bermuda Triangle or that a race of merpeople is getting ready for an invasion. With that said, I still think that lost civilisations are fascinating, and today we’re going to be taking a little look at a few of the main lost civilisations in both fact and fiction.</p>\n<h1 class=\"\">What is a lost civilisation?</h1>\n<p class=\"\">Lets get exploring!</p>\n<p class=\"\">Before we go any further, we should first take a look at exactly what we mean when we’re talking about a lost civilisation. Broadly speaking, a lost civilisation is any type of human (or otherwise, especially in fantasy) civilisation that’s no longer represented amongst our general population.</p>\n<p class=\"\">Semantically, there’s a slight difference between a lost civilisation and a dead civilisation. The Roman Empire represents a dead civilisation, but it was never lost because their influence lives on today. Likewise, Latin is a dead language, but it’s not a lost language because we still know how it works. It’s just that there are no longer any native Latin speakers, and indeed we don’t know for sure how it actually sounded.</p>\n<p class=\"\">Our real world is full of examples of lost civilisations, and we’re going to take a look at those a little later on in this article. But when we’re talking about lost civilisations in literature, we’re generally talking more specifically about mythical civilisations. Fiction allows us to see these mythical and often downright fictitious civilisations up close and personal, often before whichever cataclysmic event led to their downfall.</p>\n<p class=\"\">Two of the most popular and most interesting lost civilisations are Atlantis and Lemuria, and much of Robert E. Howard’s work can be said to focus on lost civilisations. In fact, his Hyborian Age is essentially a lost epoch in our planet’s history. Let’s take a closer look at some of the most popular civilisations.</p>\n<h2 class=\"\">All about Atlantis</h2>\n<p>Atlantis is arguably the most famous lost civilisation, iconic for sinking beneath the waves. Used as an allegory for hubris, Atlantis is first recorded in some of Plato’s works. Interestingly enough, in Plato’s stories, it represents a rival naval power that attacks his native Athens. When it sank beneath the waves, it was because they’d fallen out of favour with the gods.</p>\n<p>Atlantis is actually not particularly important in Plato’s original stories, but the story has taken on a life of its own and has become an important part of popular culture. In fact, people are so obsessed with the story of Atlantis that many pseudoscientists and conspiracy theorists have tried to locate it. Unfortunately, Plato didn’t exactly leave directions, and so all we really know is that Atlantis was said to have disappeared beneath the waves sometime before 9,000 BC and that it can be found beyond the Pillars of Hercules.</p>\n<p>For the most part, most literary scholars and history buffs agree that Atlantis is fictional, but there’s some debate around where the inspiration for the story comes from. As with most storytellers of his time, Plato borrowed freely from other stories and other traditions, and so it’s likely that there’s an even older tale of a sunken city that Socrates was inspired by.</p>\n<p class=\"\">Some of the historic events that Atlantis has been linked to include the Minoan eruption of 1,600 BC, as well as the so-called Sea Peoples and even the Trojan War, the source of the legend of the wooden horse of Troy. But perhaps it doesn’t matter whether Atlantis was inspired by these events in the same way that it doesn’t really matter if the island of Atlantis is even real. I’d rather investigate the stories that they allow us to tell.</p>\n<h2 class=\"\">Learning about Lemuria</h2>\n<p>Lemuria is essentially another take on Atlantis, a purported lost land that’s said to be somewhere in either the Indian or the Pacific Ocean. It was originally adopted by scientists and other thinkers, but it’s now seen as discredited and a dead theory. That doesn’t make it any less interesting to learn about, though.</p>\n<p>As with Atlantis, even after the initial death of the theory, Lemuria went on to find a place in popular culture. And also like Atlantis, some people have claimed to have discovered its present-day location, with many Tamil writers drawing parallels with Kumari Kandam, another mythical lost continent that’s said to be south of India in the Indian Ocean.</p>\n<p>The original Lemuria theory had it depicted as a former land bridge that’s sunk beneath the waves, although we now know more about plate tectonics and can disprove that theory. Curiously enough, these types of sunken continents exist in our own world, including in both the Pacific and Indian Oceans, but none of them could be Lemuria.</p>\n<p>As it turns out, Madagascar and India were originally part of the same landmass, but there wasn’t a mythical bridge as the Lemurian theorists would have you believe. Instead, they simply slotted together as part of a larger “supercontinent” called Gondwanaland. If you’re a comic fantasy fan and this sounds familiar, it’s probably because Terry Pratchett parodied it in his Discworld series with Howondaland.</p>\n<p>The problem with the Lemuria myth is that Gondwanaland didn’t sink under the ocean. Instead, it broke apart and the pieces slowly floated away from each other.</p>\n<h2>The “real” lost civilisations</h2>\n<p>As you can tell from the real story of Gondwanaland, just because some of the most popular takes on lost civilisations are fictional, it doesn’t mean that they all are. There are countless real lost civilisations, and most of them became lost because they were wiped out by larger tribes and empires. The Romans and the Greeks did a lot for us, but they also created a more homogenous culture and wiped out a lot of history.</p>\n<p>Just a few of the most fascinating lost civilisations in our real history include:</p>\n<ul class=\"\">\n<li><strong>The Khmer Empire:</strong> Located in Southeast Asia over 1,500 years ago, this empire was particularly known for its naval strength. Angkor, their capital city, was the largest city in the world at one time with around a million people.</li>\n<li><strong>The Mayans: </strong>In popular culture, the Mayans are arguably most-known for their calendar, and the popular conspiracy theory that they’d predicted the end of the world in 2012 because of it. Spanning much of South America, the Mayan civilisation itself has long since died out, though there are still millions of people of Mayan descent and a couple of dozen surviving Mayan languages.</li>\n<li><strong>The Aztecs: </strong>This civilisation rose to power in around 1300-1500 AD in modern-day Mexico. Sadly, they were wiped out by Spanish conquistadors led by Hernan Cortes, who overthrew the empire and brought their reign to an end.</li>\n<li><strong>The Babylonians: </strong>You might have heard of the Babylonians because of the Hanging Gardens of Babylon, one of the seven wonders of the ancient world. Their capital city is said to be the first in the world to reach a population of over 200,000, and its remains are in modern-day Iraq, not too far south of Baghdad.</li>\n<li><strong>The Tiwanaku: </strong>This Bolivian empire existed towards the end of the first century AD. When the Incas discovered them, they thought the Tiwanaku were made by the gods due to the grandness of their cities.</li>\n<li><strong>The Incas: </strong>The Inca Empire was the largest empire in America prior to the arrival of Christopher Columbus, effectively coming to an end at the hands of the Spanish in the late 1500s. Its size varied, but at its biggest, it covered parts of Peru, Ecuador, Bolivia, Chile and Columbia.</li>\n</ul>\n<p>You might get the impression from this list that lost civilisations are almost exclusive to Asia and South America, but the truth is that there are lost civilisations all over the world. You just have to look for them, which is somewhat ironic.</p>\n<p class=\"\">For me, I find them to be a fascinating area of research, not only because it exposes me to new cultures but also because we can often borrow from them to create new fictional tales of lost lands and lost peoples.</p>\n<h2>The future</h2>\n<p class=\"\">It’s been said that there’s no such thing as an original idea, and it’s certainly true that most of the stories that we hear today are inspired by other stories that have come before them. In the future, then, we can expect to see more and more stories of lost civilisations, especially because they can do a great job of reflecting our own society.</p>\n<p class=\"\">Part of the reason why stories about lost civilisations are thriving is that they tap into the very real threat of our modern society collapsing. Humanity and society have always been under threat, but we’re arguably more threatened than ever before thanks to COVID-19, global warming and other existential threats.</p>\n<p>Stories of lost civilisations can help us to make sense of our own reality, and they can also help us to prepare for the future by showing us a glimpse of what different scenarios might look like. But more than that, they can help us to expand our minds.</p>\n<p>George R. R. Martin famously said that a reader lives a thousand lives while the non-reader lives only once. What’s interesting to me is that every time we consume a story, we also consume the setting of the story. That means that reading novels can expose us to new cultures, and in the case of lost civilisations, it can expose us to cultures that we might not otherwise have experienced.</p>\n<p>So even though the world feels like it’s getting smaller and smaller as technology continues to evolve, there’s still a place for stories about lost civilisations. Sure, we might not discover any new real examples, but that’s where fiction comes in. And I for one can’t wait to see what tomorrow will bring for today’s generation of writers.</p>\n</div>\n</div>', '2020-09-12T12:35:22', 1, 0, 'https://www.beyondtheblacksea.com/wp-content/uploads/2020/09/LostCivilistion22.png');
INSERT INTO `blog_post` (`id`, `title`, `content`, `created_at`, `user_id`, `hidden`, `image_url`) VALUES (3, 'The Science Behind the Younger Dryas', '<div class=\"col-md-12 col-xs-12 col-sm-12 col-lg-12\">\n<h1 class=\"\"><strong>The Science Behind the Younger Dryas</strong></h1>\n<p class=\"\">Building on from my last few posts where I’ve investigated lost civilisations and the legends of Atlantis and Lemuria, today I want to take a look at something else that happened a long time ago (though not in a galaxy far, far away).</p>\n<p class=\"\">I think that by looking back to the past, we can uncover insights about the future. We also get a better understanding of who we are and where we’re from, and we can become more empathetic if we start to realise that our cultures aren’t necessarily so different after all.</p>\n<p class=\"\">Today, we’re going to talk about the Younger Dryas, a subject that most people haven’t even heard of. I hadn’t heard of it myself until a couple of years ago, but then I started to carry out some research and I quickly got sucked in and hooked on the topic.</p>\n<p class=\"\">So what exactly is the Younger Dryas? Read on to find out…</p>\n<h2>The History of the Younger Dryas</h2>\n<p>Perhaps a more accurate question would be “what exactly was the Younger Dryas?”. It’s essentially a period in our planet’s history that occurred around 12,900 to 11,700 years BP.</p>\n<p class=\"\">In case you’re wondering, that stands for “Before Present” and refers to the period in our history that occurred before the development of carbon dating techniques. The “present” is considered to be January 1<sup>st</sup> 1950, meaning that the Younger Dryas period was around 10,750 – 9,750 BC.</p>\n<p class=\"\">During this time, the earth witnessed a sharp decline in temperatures over a remarkably short period of time (decades as opposed to millennia). Given that this had a major impact on many different ecosystems, you can imagine the kind of effect that this sudden change had.</p>\n<p class=\"\">So what exactly happened? Well, we don’t necessarily know, although there are a bunch of different theories out there, some of them more plausible than others.</p>\n<h2>The Younger Dryas Hypothesis</h2>\n<p class=\"\">One of the more interesting theories about what happened to the Younger Dryas is that a large asteroid or comet disintegrated into large fragments, which then showered down over North and South America, Europa and Asia.</p>\n<p class=\"\">There’s a certain amount of evidence to support this, too. For example, we’ve found large concentrations of platinum and nano-diamonds across over fifty different global sites. It’s posited that these are as a result of the impact, and that’s certainly one explanation for something that we otherwise can’t really understand.</p>\n<p class=\"\">Some scientists have argued that the collision of such a comet could also have led to widescale destruction, burning biomasses and essentially triggering a mini ice age. There’s a lot of evidence that this mini ice age happened, and so it’s really the causes which are up for debate. Although it’s not just the causes that people like to talk about.</p>\n<p class=\"\">For example, many followers of the Younger Dryas Hypothesis suggest that these comet fragments also wiped out a previous civilisation. Given my last blog post on lost civilisations and the prevalence of real lost civilisations from all over the planet, this doesn’t seem particularly implausible, although it can be hard to find definitive evidence either way because of how many years ago it took place.</p>\n<h2 class=\"\">Previous civilisations and extinction</h2>\n<p>In the same way that it’s believed that a meteor strike brought about the extinction of the dinosaurs, it’s believed by many that the Younger Dryas meteor caused the widespread demise of animal and plant life. Of course, if this was the case, we’d expect to see some sort of evidence, and there are certainly clues out there for those who are looking.</p>\n<p class=\"\">The problem is that they’re just that – clues. Clues can be interpreted differently, and that’s why the Younger Dryas is such a hotly debated topic. Supporters of the comet hypothesis will tell you that it led to the extinction of a whole bunch of North American animals, ranging from camels and mammoths to the giant short-faced bear.</p>\n<p class=\"\">In recent years, the Younger Dryas has undergone renewed scrutiny, in part because of the popularity of a book called Fingerprints of the Gods by Charles Hapgood. In it, Hapgood suggests that a lost civilisation in Antarctica had been forced to relocate to the South Pole and that they’d been buried beneath the polar ice cap. He cited the work of Rand Flem-Ath, who’s researched this area before and suggested that the civilisation beneath the ice could be Atlantis.</p>\n<h2 class=\"\">What the evidence says</h2>\n<p>A wide range of different evidence has been cited to point towards the Younger Dryas hypothesis, including a strata of organic-rich soil that’s been discovered at numerous locations in North America. These locations are also said to house an abundance of nanodiamonds, magnetic spherules (whatever they are) and iridium, platinum and more.</p>\n<p>This is actually a reasonably convincing argument, because it’s difficult to explain these phenomena away as a byproduct of any other natural process. But there’s evidence against it too, such as the fact that a study found that there was no sign of a population decline around the Younger Dryas, as we might expect to see. In fact, there’s even evidence to suggest overall growth in the global population towards the end of the Younger Dryas.</p>\n<p>There’s also evidence to show that the widespread extinctions occurred at different times, which implies that perhaps a meteor impact isn’t really what’s to blame here. For example, it seems as though the extinctions in North America happened 400 years before the extinctions in South America.</p>\n<p>There’s also been a lot of research into why certain species went extinct while others didn’t. For example, more larger animals seem to have disappeared than smaller ones. It’s also strange how some large mammals disappeared while others remained behind. This is seen as an argument against the comet impact hypothesis because it should have wiped out all of them.</p>\n<p>Perhaps the most damning argument against the comet theory is that, so far at least, nobody has been able to show evidence of extra-terrestrial metals, which would presumably be brought in by such an impact. In fact, it’s really a case that there’s no concrete evidence either way, mostly because of the astronomical periods of time that we’re talking about.</p>\n<h2 class=\"\">What I think</h2>\n<p>That’s one of the reasons why it’s such a popular topic for discussion. If you spend a little time digging, you’ll find no shortage of scientific papers arguing for and against the comet hypothesis, with many papers responding to previous papers by people on the other side of the debate. It’s a scientific back and forth, and that’s one of the reasons why I find it so fascinating to research and to write about.</p>\n<p class=\"\">As for me, I still haven’t quite decided what I think, although I do think that there’s a lot to be said about both sides of the argument. There’s an argument that a crater in Greenland is the site of one of the meteor-strikes, but scientists are still divided on what caused it.</p>\n<p class=\"\">One thing that people do point out is that the odds of such an impact are almost miniscule, and so the fact that it’s said to have happened so recently would make it statistically improbable, though not impossible. Strangers things have certainly happened, especially when we look at the context of the entire universe.</p>\n<p class=\"\">Ultimately, it’s one of those mysterious conundrums that we might never get a definite answer to. Even if we do, it might not come in our lifetimes. Still, that doesn’t make it any less interesting to speculate over, which is why I’ve shared this brief introduction to get you started on your journey.</p>\n<h2 class=\"\">Conclusion</h2>\n<p>Now that you know a little more about the Younger Dryas, it’s time for you to do some further research of your own. It’s a truly fascinating topic and one that’s had an impact on many of the books that we read, as you’ll already be familiar with if you’ve read some of my previous posts.</p>\n<p>If nothing else, I think that the story of the Younger Dryas is a warning to us about the dangers of climate change and the impact it can have. Anthropogenic climate change aside it had a huge impact in the past and can happen again. &nbsp;We could end up undergoing a period of change that’s just as cataclysmic.</p>\n<p>Now it’s time for you to take over and to share your thoughts on the Younger Dryas by leaving a comment. What do you think happened during this fascinating point in history? Do you agree with the comet hypothesis? And do you think it could have wiped out earlier civilisations? Be sure to let me know what you think with a comment so that we can keep the discussion going!</p>\n</div>', '2020-09-17T12:35:22', 1, 0, 'https://www.beyondtheblacksea.com/wp-content/uploads/2020/09/YoungerDryas.png');
INSERT INTO `blog_post` (`id`, `title`, `content`, `created_at`, `user_id`, `hidden`, `image_url`) VALUES (4, 'Serpent People: The Myths, the Fiction and the History', '<div class=\"col-md-12 col-xs-12 col-sm-12 col-lg-12\">\n<h1><strong>Serpent People: The Myths, the Fiction and the History</strong></h1>\n<p class=\"\">As soon as I start talking about serpent people, I find that people look at me as though they think I’ve gone crazy. That’s probably David Icke’s fault, but we’ll get to that.</p>\n<p>What can I say? I just think that serpent people are cool, and some of my favourite stories of all time have featured serpent people in some form or other. Some of the very best are those that just use the classic myths as a background and then build on them.</p>\n<p class=\"\">Today, I’m going to be telling you everything you need to know about serpent people, from their origins in classical mythology to the science behind them and the place they’ve earned for themselves in popular culture. Let’s slither on in.</p>\n<h2 class=\"\">The Mythology</h2>\n<p class=\"\">\nSerpent people have been around for years, and we can see signs of them in the tale of Medusa, the woman with snakes for hair who turned people to stone with her gaze, although she’s technically a (wo)man serpent. Snakes have long been associated with evil, presumably because of the very real fear of death due to a snakebite. It makes sense that they’d show up as a personification of evil.</p>\n<p>In most tales, serpent men are depicted as human-like figures with scaly skin and the heads of snakes or other reptiles. They’re typically descended from a lineage that goes way back, often essentially evolving in parallel in the same way that homo sapiens descended from apes.</p>\n<p>Another common theme with serpent men is that they usually have the ability to disguise themselves as human beings. This is where the idea of “lizards in people suits” comes from, although the older legends usually say that they’re able to do this because they have magical powers or other abilities.</p>\n<p>Note that serpent men are different to “man serpents”, which are typically depicted the other way round, having the bodies of giant snakes but the heads of human beings. Medusa is a classic example of this, and indeed many other man serpents have the hypnotic stare and superhuman strength that the snake queen is known for.</p>\n<h2>Nagas and Lamias</h2>\n<p>Another mythic type of serpent people are the nagas and lamias, although they’re pretty similar to Medusas and as such are more like man serpents. Usually depicted with a human’s head, arms and torso and a snake’s lower body, they’re basically the reptilian equivalent of centaurs. Female nagas and lamias are usually supernaturally beautiful.</p>\n<p>The origins of these creatures can, of course, be traced back to folklore. In the traditional tales, Lamia was a Libyan queen who ate children, but it’s thought that the popular image of her was subverted by John Keats, who might have combined Lamia with Lilith, Adam’s first wife, who’s associated with the snake in the Garden of Eden.</p>\n<p>Nagas, meanwhile, come from India. If you’ve read the Harry Potter series then you’ll remember Nagini, Voldemort’s snake. She takes her name from the term for a female naga, with male nagas usually being called nagin. Nagas show their Hindu roots because they’re often depicted with more than one pair of arms. Sometimes, they even have multiple heads.</p>\n<h2>Robert E. Howard</h2>\n<p>The first appearance of true “serpent people” was in Robert E. Howard’s King Kull stories. Howard, as you might remember, is the creator of the Conan series and an icon in sword and sorcery communities. He’s arguably the reason why sword and sorcery is popular in the first place.</p>\n<p class=\"\">Howard called his creation “serpent men”, and they first appeared in a story called The Shadow Kingdom, which itself was published in the iconic Weird Tales magazine at the end of the 1920s. Interestingly, they were given a second life in the 1970s when Marvel released its Kull the Conqueror adaptations, effectively introducing serpent men into the Marvel cinematic universe.</p>\n<h2 class=\"\">H. P. Lovecraft</h2>\n<p>Another important thing to note is that in Howard’s work, the serpent men were one of the few examples of creatures from long, long ago, their dominion being measured in terms of the cosmos as opposed to the lifespan of man. This in some ways makes it a precursor to the unique brand of cosmic horror that H. P. Lovecraft helped to pioneer, a subject that I’ve written about at length before.</p>\n<p>The interesting thing about Howard’s serpent men is that they were then adopted as a part of Lovecraft’s Cthulhu Mythos, although most of the legwork was done by Lin Carter and Clark Ashton Smith. Some of Lovcecraft’s own short stories, including The Nameless City and The Haunter of the Dark, mention pre-human races of lizard people.</p>\n<p>In fact, this also means that serpent people are directly connected to Lovecraft’s Cthulhu mythos, and the two of them officially live in the same universe. That’s pretty cool because they also pop up in Spider-Man, making them also part of the Marvel EU. I love the way that they all relate back to each other, even though some of the links are a little obscure. There’s even a cross between a demon and a serpent man that fought against the Avengers.</p>\n<p class=\"\">According to the mythos, the serpent people lived at roughly the same time as the dinosaurs, although they weren’t wiped out by the fateful meteorite. Instead, they dispersed all over the world, warring with mankind and eventually going underground.</p>\n<p>Other names for serpent people include “snake men”, “serpent men”, “serpent folk” and “valusians”. And perhaps unsurprisingly, most named serpent people have names that evoke their flickering tongues and serpent-like features. Just a few of the most well-known serpent people include Ssathasaa, Sss’haa, Ssrhythssaa and Zloigm. Try saying those after you’ve had a few drinks.</p>\n<h2>Reptoids</h2>\n<p>In popular culture, when we talk about serpent people, most people’s minds automatically go to reptoids. Also known as reptilians, lizard people, saurians, draconians and reptiloids, reptoids are theoretical reptilian humanoids, and the concept was popularised by conspiracy theorist David Icke.</p>\n<p>Icke believes that shape-shifting reptoids control the human race by assuming human forms and taking on important positions in global governments and at the top of society. It’s a bit like the Illuminati, except that the Illuminati isn’t made up of serpent people in lizard suits.</p>\n<p>I don’t want to spend too much time dwelling on Icke’s ideas because you can look them up for yourself if you’re interested. I’m not too interested in them myself, but I do think it’s fascinating that they’re almost certainly inspired by (if not based on) the serpent people of Robert E. Howard.</p>\n<p>In fact, most historians agree that Icke’s theories draw upon earlier myths and legends, and it’s pretty easy to see the parallels. Loosely speaking, Icke says that the world is being run by blood-drinking, shape-shifting serpent people who are adopting positions of power (including in the British Royal family and the Bush family).</p>\n<p>They come from the Alpha Draconis star system and are living in underground bases while plotting to overthrow the human race. And whether you believe Icke or not, it’s hard to ignore the fact that at least some people do. According to one 2013 poll, as many as 4% of registered US voters believe in Icke’s ideas.</p>\n<p>As for me, I’d rather read Howard or Lovecraft.</p>\n<h2>Conclusion</h2>\n<p>Now that you know a little more about serpent people, it’s over to you so that you can start carrying out a little more research of your own. If you’re a novelist, perhaps you can start to use serpent people as a plot device, while if you’re a keen movie buff then you could check out some of the movies that use serpent people as a plot device.</p>\n<p>Of course, if you’re into conspiracy theories then you could also look into David Icke and what he thinks, although I’d caution you to take that with a pinch of salt. Far more interesting to me is the history behind snake people and where the legends come from. Snakes themselves have a lot of symbolic power, and you see them being represented everywhere from stories about Medusa to the parceltongue in J. K. Rowling’s Harry Potter series.</p>\n<p>So now you’ve heard a few of my thoughts, I want to hear from you. Be sure to let me know your thoughts on serpent people and the legends that they feature in by leaving a comment, or by reaching out to me on your favourite social networking site. Until next time!</p>\n</div>', '2020-09-21T12:35:22', 1, 0, 'https://www.beyondtheblacksea.com/wp-content/uploads/2020/09/SerpentFolk1.png');
INSERT INTO `blog_post` (`id`, `title`, `content`, `created_at`, `user_id`, `hidden`, `image_url`) VALUES (5, 'Journey To Carcosa', '<div class=\"col-md-12 col-xs-12 col-sm-12 col-lg-12\">\n<h1>Journey To Carcosa</h1>\n<p class=\"\">Carcosa is a fascinating place, a mythical land that was first written about by iconic author Ambrose Bierce and which was later adopted by a range of other writers before becoming a part of popular consciousness.</p>\n<p class=\"\">There’s a lot for us to talk about here and a lot of different sources to draw upon, so let’s cut to the chase and start travelling. Here’s everything you need to know about Carcosa.</p>\n<h2 class=\"\">Out Version of Carcosa</h2>\n<p class=\"\">We draw inspiration from the more ephemeral representations of Carcosa. In Beyond The Black Sea, Carcosa is a world locked in an orbit with a black hole. Its a sword and sorcery setting mostly of bronze age or more primitive technology. We have several mini sagas set in Carcosa starting with <a href=\"https://www.drivethrurpg.com/product/353413/Adventure-Area-4-The-Skull?manufacturers_id=13069\" target=\"_blank\" rel=\"noopener\">The Skull</a>. We also have our <a href=\"https://www.drivethrurpg.com/product/347712/Aldebaran\" target=\"_blank\" rel=\"noopener\">Aldebaran source book</a> which details much of Carcosa, however this is a whole world and our intention is to create enough content for your gaming group to add what you need for the stories you want to tell.&nbsp;</p>\n<p class=\"\"><img decoding=\"async\" class=\"alignnone size-large wp-image-159\" src=\"https://www.beyondtheblacksea.com/wp-content/uploads/2021/05/morgan_docks-1024x711.jpg\" alt=\"The Docks\" width=\"1024\" height=\"711\" srcset=\"https://www.beyondtheblacksea.com/wp-content/uploads/2021/05/morgan_docks-1024x711.jpg 1024w, https://www.beyondtheblacksea.com/wp-content/uploads/2021/05/morgan_docks-300x208.jpg 300w, https://www.beyondtheblacksea.com/wp-content/uploads/2021/05/morgan_docks-768x533.jpg 768w, https://www.beyondtheblacksea.com/wp-content/uploads/2021/05/morgan_docks-1536x1066.jpg 1536w, https://www.beyondtheblacksea.com/wp-content/uploads/2021/05/morgan_docks-2048x1422.jpg 2048w, https://www.beyondtheblacksea.com/wp-content/uploads/2021/05/morgan_docks-250x174.jpg 250w, https://www.beyondtheblacksea.com/wp-content/uploads/2021/05/morgan_docks-550x382.jpg 550w, https://www.beyondtheblacksea.com/wp-content/uploads/2021/05/morgan_docks-800x555.jpg 800w, https://www.beyondtheblacksea.com/wp-content/uploads/2021/05/morgan_docks-259x180.jpg 259w, https://www.beyondtheblacksea.com/wp-content/uploads/2021/05/morgan_docks-432x300.jpg 432w, https://www.beyondtheblacksea.com/wp-content/uploads/2021/05/morgan_docks-720x500.jpg 720w\" sizes=\"(max-width: 1024px) 100vw, 1024px\"></p>\n<h2 class=\"\">Ambrose Bierce and Carcosa</h2>\n<p>The story of Carcosa begins with writer Ambrose Bierce and his 1886 short story An Inhabitant of Carcosa. In it, “the spirit Hoseib Alar Robardin” tells his tale, culminating with the iconic ending:</p>\n<p class=\"\"><em>A level shaft of light illuminated the whole side of the tree as I sprang to my feet in terror. The sun was rising in the rosy east, I stood between the tree and his broad red disk – no shadow darkened the trunk!</em></p>\n<p class=\"\"><em>A chorus of howling wolves saluted the dawn. I saw them sitting on their haunches, singly and in groups, on the summits of irregular mounds and tumuli filling a half of my desert prospect and extending to the horizon. And then I knew that these were the ruins of the ancient and famous city of Carcosa.</em></p>\n<p>What’s interesting about this is that the city itself barely features in the story. It’s mentioned more in passing than anything, with very little description and the lens of time shrouding the truth about the city. By the time that the reader encounters it, the city has already been destroyed, and we hear about it from a character who used to live there.</p>\n<p class=\"\">So where does the name come from? Interestingly, it seems as though it’s just one of those names that captures people’s imagination, because it’s since been reused by more authors than you can shake a pen at. The leading theory for where Bierce got the name is that he’d heard of the French city of Carcassonne and that he simply modified the Latin name of “Carcosa”, but who knows?</p>\n<p><iframe title=\"&quot;An Inhabitant of Carcosa&quot; by Ambrose Bierce |  Classic Horror Readings by Otis Jiry\" width=\"500\" height=\"281\" src=\"https://www.youtube.com/embed/ebT-4Rea4jQ?feature=oembed\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen=\"\"></iframe></p>\n<p class=\"\">&nbsp;</p>\n<h2 class=\"\">Robert W. Chambers and &nbsp;Carcosa</h2>\n<p class=\"\">\nOther writers to have used the Carcosa name and concept include Robert W. Chambers, <a href=\"https://www.goodreads.com/author/quotes/57739.Robert_W_Chambers\">who wrote</a>, “I cannot forget Carcosa where black stars hang in the heavens; where the shadows of men’s thoughts lengthen in the afternoon; where the twin suns sink into the lake of Hali; and my mind will bear for ever the memory of the Pallid Mask. I pray God will curse the writer, as the writer has cursed the world with its beautiful stupendous creation, terrible in its simplicity, irresistible in its truth – a world which now trembles before the King In Yellow.”</p>\n<p class=\"\">So not somewhere you’d want to go on holiday, then.</p>\n<p class=\"\">Chambers’ use of &nbsp;Carcosa was as a part of his 1895 work The King in Yellow, where the author used the &nbsp;Carcosa concept along with a couple of Bierce’s other names including Hali (the lake with the twin suns) and Alar, a city that sits beside the lake. If you’re wondering about those twin suns, by the way, Carcosa isn’t a neighbouring planet to Tattooine. It’s said to be in the star cluster Hyades, <a href=\"https://science.nasa.gov/hyades-star-cluster\">the closest cluster of stars to our sun.</a></p>\n<p>Other locations mentioned by Chambers include Demhe (with its “cloudy depths”), Hastur, Yhtill and Aldebaran. Not to be confused with Alderaan (what is it with these Star Wars similarities?), Aldebaran is a giant star about 65 light years from our sun. <a href=\"https://www.space.com/22026-aldebaran.html\">It’s the brightest star in the Taurus constellation</a> and is nicknamed “The Eye of Taurus”, as well as the 14<sup>th</sup> brightest star in our night sky.</p>\n<p>The King in Yellow also includes a short piece of poetry (technically it’s lyrics but without any music) called Cassilda’s Song, which you can listen to in the player below.</p>\n<p><iframe loading=\"lazy\" title=\"The King in Yellow  Cassilda´s Song/ Der König in Gelb  Cassildas Lied\" width=\"500\" height=\"375\" src=\"https://www.youtube.com/embed/gEVF7944gx4?feature=oembed\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen=\"\"></iframe></p>\n<h2 class=\"\">H. P. Lovecraft and Carcosa</h2>\n<p class=\"\">\nCarcosa was later picked up by the legendary cosmic horror writer H. P. Lovecraft, who adopted it as part of his Cthulu mythos. This was an important boost for the Carcosa story because Lovecraft himself had a huge legion of admirers, including many writers who themselves expanded on the theme in their own work. On top of Lovecraft, these authors include Karl Edward Wagner, Lin Carter, James Blish and Charles Stross.</p>\n<p class=\"\">We should note, though, that Lovecraft never directly mentioned Carcosa in any of his short stories, or at least in the ones that were published. With that said, he did mention it in in an essay he wrote called Supernatural Horror in Literature. Sharing his experience with reading Chambers’ The Yellow Sign, he wrote, “After stumbling queerly upon the hellish and forbidden book of horrors the two learn, among other hideous things which no sane mortal should know, that this talisman is indeed the nameless Yellow Sign handed down from the accursed cult of Hastur – from primordial Carcosa.”</p>\n<p>Lovecraft is also published alongside Chambers and other great writers like Arthur Machen and Edgar Allen Poe in a book called Shadows of Carcosa: Tales of Cosmic Horror. There’s also Lovecraft’s novella The Whisperer in Darkness, which mentions some key bits of lore including Hali and Hastur:</p>\n<p class=\"\"><em>I found myself faced by names and terms that I’d heard elsewhere in the most hideous of [connections] – Yuggoth, Great Cthulhu, Tsathoggua, Yog-Sothoth, R’lyeh, Nyarlathotep, Azathoth, Hastur, Yian, Leng, the Lake of Hali, Bethmoora, the Yellow Sign, L’mur-Kathulos, Bran, and the Magnum Innominandum—and was drawn back through nameless aeons and inconceivable dimensions to worlds of elder, outer entity at which the crazed author of the Necronomicon had only guessed in the vaguest way. I was told of the pits of primal life, and of the streams that had trickled down therefrom; and finally, of the tiny rivulet from one of those streams which had become entangled with the destinies of our own earth.”</em></p>\n<h2>What Carcosa is Like</h2>\n<p class=\"\">We’ve shared a few different excerpts throughout this article which should give you a good idea of what Carcosa is like, but there are a few more clues that we can take a look at. In The Repairer of Reputations, a short story in Chambers’ The King in Yellow, we get a few clues such as that there are black stars in the sky and twin suns that sink into Hali. It’s also said that “the shadows of men’s thoughts lengthen in the afternoon”.</p>\n<p class=\"\">In a short story called Litany to Hastur, author Lin Carter said that Carcosa has black domes and huge towers. More recently, Neal Wilgus wrote a piece for a 21<sup>st</sup> century King in Yellow anthology which reimagines the legend and has Carcosa as a mysterious small town in the backwaters of America. What’s cool about this is that they bring it into a modern era by having Hastur’s Hardware store and the Yellow Sign Hotel.</p>\n<p>There’s even a direct line of inspiration and retelling linking Carcosa to Stephen King, whose Dark Tower series is loosely inspired by Robert Browning’s poem Childe Roland to the Dark Tower Came. In the same King in Yellow anthology, editor DT Tyrer wrote a piece also based on Browning’s poem and the fairy tales that it inspired in which the Dark Tower itself may just be one of the many towers in Carcosa.</p>\n<h2>Carcosa in Our World</h2>\n<p>By this point, you might be thinking that Carcosa doesn’t exist in our own world, and that’s true to a certain extent. That mythical place described by Bierce and Chambers might not exist, but there <em>is</em> a real world place called Carcosa that’s worth mentioning.</p>\n<p class=\"\">Back at the end of the nineteenth century, a building called the Carcosa Mansion was built as the official governmental residence of the Resident-General of the Federal Malay States. The first holder of the office was a guy called Sir Frank Swettenham, who’d read The King in Yellow and who’d liked the name. As recently as 2015, the building was being used as a hotel called the Carcossa Seri Negara, although don’t start booking your flights just yet as it’s now abandoned.</p>\n<p class=\"\">Carcosa has also been used as the name of two different publishing houses. The first was a specialist sci-fi publisher that was formed in 1947 by Frederick B. Shrover, Russel Hodgkins and Paul Skeeters. The second was founded in 1973 by David Drake, Karl Wagner and Jim Groce and published four collections of pulp horror.</p>\n<h2 class=\"\">Carcosa in Pop Culture</h2>\n<p class=\"\">Because of its popularity in literature and fiction, Carcosa has also taken on an important place in popular culture. That means that it’s been reused and remixed in so many different places that it’s often hard to keep track. Just a few of my favourites include:</p>\n<ul class=\"\">\n<li><strong>True Detective: </strong>Here, Carcosa is a temple used by religious leaders and leading politicians in Louisiana, essentially depicting Carcosa as the heart of a cult which worships “The Yellow King”.</li>\n<li><strong>The Chilling Adventures of Sabrina: </strong>There’s a character and a carnival named Carcosa, and it’s slowly revealed that all of the carnival workers are mythological beings and deities.</li>\n<li><strong>DigiTech:</strong> This technology company has released a guitar effects pedal called Carcosa with two modes called Hali and Demhe.</li>\n<li><strong>Mass Effect</strong>: In the third Mass Effect game, there’s a planet called Carcosa.</li>\n<li><strong>A Song of Ice and Fire</strong>: In the fantasy series that inspired Game of Thrones, there’s a city of Carcosa that’s ruled by a sorcerer and which sits right at the far eastern edge of the known world on the shores of a huge lake.</li>\n<li><strong>Joseph S. Pulver: </strong>This successful author has written dozens of stories based on the work of Robert W. Chambers, including Carcosa. He’s even acted as the editor for several Carcosa-themed anthologies.</li>\n</ul>\n<p class=\"\">And believe it or not, this is only the tip of the iceberg. Over the past hundred years or so, there have been so many additions to the Carcosa canon that we’ve only been able to note a few of the most popular and most interesting examples! There’s even <a href=\"https://www.board-game.co.uk/product/carcosa/\">a Carcosa-themed board game</a>!&nbsp;</p>\n<h2 class=\"\">Conclusion</h2>\n<p class=\"\">\nNow that you know just a little bit about Carcosa and its real world and fictional heritage, it’s over to you to keep the discussion going. Carcosa has become a little bit like Atlantis in that it’s entered the popular consciousness and been used all over the place as a result of it.</p>\n<p>The location has been mentioned so often and in so many different works that it would be impossible for us to cover them all here, and so instead we took a look at just a few of the most noteworthy examples.</p>\n<p>And so now it’s over to you so you can share your thoughts on Carcosa. Be sure to leave a comment so we can keep on chatting. I look forward to hearing what you think!t</p>\n</div>', '2021-05-01T12:35:22', 1, 0, 'https://www.beyondtheblacksea.com/wp-content/uploads/2021/05/CarcosaBlog.png');

COMMIT;


-- -----------------------------------------------------
-- Data for table `blog_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `blog_comment` (`id`, `content`, `created_at`, `blog_post_id`, `parent_comment_id`, `user_id`, `hidden`) VALUES (1, 'Great first post!', '2023-03-05T12:35:22', 1, NULL, 2, 0);
INSERT INTO `blog_comment` (`id`, `content`, `created_at`, `blog_post_id`, `parent_comment_id`, `user_id`, `hidden`) VALUES (2, 'Great first comment!', '2023-03-06T12:35:22', 1, 1, 1, 0);

COMMIT;


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
INSERT INTO `collection` (`id`, `title`, `series_id`, `published_at`, `page_count`, `description`) VALUES (1, 'The Coming of Conan the Cimmerian', 1, '2003-12-02T12:00:00', 463, 'Conan is one of the greatest fictional heroes ever created– a swordsman who cuts a swath across the lands of the Hyborian Age, facing powerful sorcerers, deadly creatures, and ruthless armies of thieves and reavers.\n\n“Between the years when the oceans drank Atlantis and the gleaming cities . . . there was an Age undreamed of, when shining kingdoms lay spread across the world like blue mantles beneath the stars. . . . Hither came Conan, the Cimmerian, black-haired, sullen-eyed, sword in hand . . . to tread\nthe jeweled thrones of the Earth under his sandalled feet.”\n\nIn a meteoric career that spanned a mere twelve years before his tragic suicide, Robert E. Howard single-handedly invented the genre that came to be called sword and sorcery. Collected in this volume, profusely illustrated by artist Mark Schultz, are Howard’s first thirteen Conan stories, appearing in their original versions–in some cases for the first time in more than seventy years–and in the order Howard wrote them. Along with classics of dark fantasy like “The Tower of the Elephant” and swashbuckling adventure like “Queen of the Black Coast,” The Coming of Conan the Cimmerian contains a wealth of material never before published in the United States, including the first submitted draft of Conan’s debut, “Phoenix on the Sword,” Howard’s synopses for “The Scarlet Citadel” and “Black Colossus,” and a map of Conan’s world drawn by the author himself.\n\nHere are timeless tales featuring Conan the raw and dangerous youth, Conan the daring thief, Conan the swashbuckling pirate, and Conan the commander of armies. Here, too, is an unparalleled glimpse into the mind of a genius whose bold storytelling style has been imitated by many, yet equaled by none.');
INSERT INTO `collection` (`id`, `title`, `series_id`, `published_at`, `page_count`, `description`) VALUES (2, 'The Savage Tales of Solomon Kane', 2, '2004-06-29T12:00:00', 432, 'With Conan the Cimmerian, Robert E. Howard created more than the greatest action hero of the twentieth century—he also launched a genre that came to be known as sword and sorcery. But Conan wasn’t the first archetypal adventurer to spring from Howard’s fertile imagination.\n\n“He was . . . a strange blending of Puritan and Cavalier, with a touch of the ancient philosopher, and more than a touch of the pagan. . . . A hunger in his soul drove him on and on, an urge to right all wrongs, protect all weaker things. . . . Wayward and restless as the wind, he was consistent in only one respect—he was true to his ideals of justice and right. Such was Solomon Kane.”\n\nCollected in this volume, lavishly illustrated by award-winning artist Gary Gianni, are all of the stories and poems that make up the thrilling saga of the dour and deadly Puritan, Solomon Kane. Together they constitute a sprawling epic of weird fantasy adventure that stretches from sixteenth-century England to remote African jungles where no white man has set foot. Here are shudder-inducing tales of vengeful ghosts and bloodthirsty demons, of dark sorceries wielded by evil men and women, all opposed by a grim avenger armed with a fanatic’s faith and a warrior’s savage heart.');
INSERT INTO `collection` (`id`, `title`, `series_id`, `published_at`, `page_count`, `description`) VALUES (3, 'The Bloody Crown of Conan', 1, '2004-11-23T12:00:00', 384, 'In his hugely influential and tempestuous career, Robert E. Howard created the genre that came to be known as sword and sorcery—and brought to life one of fantasy’s boldest and most enduring figures: Conan the Cimmerian—reaver, slayer, barbarian, king.\n\nThis lavishly illustrated volume gathers together three of Howard’s longest and most famous Conan stories–two of them printed for the first time directly from Howard’ s typescript–along with a collection of the author’s previously unpublished and rarely seen outlines, notes, and drafts. Longtime fans and new readers alike will agree that The Bloody Crown of Conan merits a place of honor on every fantasy lover’s bookshelf.\n\nTHE PEOPLE OF THE BLACK CIRCLE\nAmid the towering crags of Vendhya, in the shadowy citadel of the Black Circle, Yasmina of the golden throne seeks vengeance against the Black Seers. Her only ally is also her most formidable enemy–Conan, the outlaw chief.\n\nTHE HOUR OF THE DRAGON\nToppled from the throne of Aquilonia by the evil machinations of an undead wizard, Conan must find the fabled jewel known as the Heart of Ahriman to reclaim his crown . . . and save his life.\n\nA WITCH SHALL BE BORN\nA malevolent witch of evil beauty. An enslaved queen. A kingdom in the iron grip of ruthless mercenaries. And Conan, who plots deadly vengeance against the human wolf who left him in the desert to die.');
INSERT INTO `collection` (`id`, `title`, `series_id`, `published_at`, `page_count`, `description`) VALUES (4, 'Bran Mak Morn: The Last King', 2, '2005-05-31T12:00:00', 400, 'From Robert E. Howard’s fertile imagination sprang some of fiction’s greatest heroes, including Conan the Cimmerian, King Kull, and Solomon Kane. But of all Howard’s characters, none embodied his creator’s brooding temperament more than Bran Mak Morn, the last king of a doomed race.\n\nIn ages past, the Picts ruled all of Europe. But the descendants of those proud conquerors have sunk into barbarism . . . all save one, Bran Mak Morn, whose bloodline remains unbroken. Threatened by the Celts and the Romans, the Pictish tribes rally under his banner to fight for their very survival, while Bran fights to restore the glory of his race.\n\nLavishly illustrated by award-winning artist Gary Gianni, this collection gathers together all of Howard’s published stories and poems featuring Bran Mak Morn–including the eerie masterpiece “Worms of the Earth” and “Kings of the Night,” in which sorcery summons Kull the conqueror from out of the depths of time to stand with Bran against the Roman invaders.\n\nAlso included are previously unpublished stories and fragments, reproductions of manuscripts bearing Howard’s handwritten revisions, and much, much more.\n\nSpecial Bonus: a newly discovered adventure by Howard, presented here for the very first time.');
INSERT INTO `collection` (`id`, `title`, `series_id`, `published_at`, `page_count`, `description`) VALUES (5, 'The Conquering Sword of Conan', 1, '2005-11-29T12:00:00', 416, 'In a meteoric career that covered only a dozen years, Robert E. Howard defined the sword-and-sorcery genre. In doing so, he brought to life the archetypal adventurer known to millions around the world as Conan the barbarian.\n\nWitness, then, Howard at his finest, and Conan at his most savage, in the latest volume featuring the collected works of Robert E. Howard, lavishly illustrated by award-winning artist Greg Manchess. Prepared directly from the earliest known versions—often Howard’s own manuscripts—are such sword-and-sorcery classics as “The Servants of Bit-Yakin” (formerly published as “Jewels of Gwahlur”), “Beyond the Black River,” “The Black Stranger,” “Man-Eaters of Zamboula” (formerly published as “Shadows in Zamboula”), and, perhaps his most famous adventure of all, “Red Nails.”\n\nThe Conquering Sword of Conan includes never-before-published outlines, notes, and story drafts, plus a new introduction, personal correspondence, and the revealing essay “Hyborian Genesis”—which chronicles the history of the creation of the Conan series. Truly, this is heroic fantasy at its finest.');
INSERT INTO `collection` (`id`, `title`, `series_id`, `published_at`, `page_count`, `description`) VALUES (6, 'Kull: Exile of Atlantis', 2, '2006-10-31T12:00:00', 352, 'In a meteoric career that spanned a mere twelve years, Robert E. Howard single-handedly invented the genre that came to be called sword and sorcery. From his fertile imagination sprang some of fiction’s most enduring heroes. Yet while Conan is indisputably Howard’s greatest creation, it was in his earlier sequence of tales featuring Kull, a fearless warrior with the brooding intellect of a philosopher, that Howard began to develop the distinctive themes, and the richly evocative blend of history and mythology, that would distinguish his later tales of the Hyborian Age.\n\nMuch more than simply the prototype for Conan, Kull is a fascinating character in his own right: an exile from fabled Atlantis who wins the crown of Valusia, only to find it as much a burden as a prize.\n\nThis groundbreaking collection, lavishly illustrated by award-winning artist Justin Sweet, gathers together all Howard’s stories featuring Kull, from Kull’ s first published appearance, in “The Shadow Kingdom,” to “Kings of the Night,” Howard’ s last tale featuring the cerebral swordsman. The stories are presented just as Howard wrote them, with all subsequent editorial emendations removed. Also included are previously unpublished stories, drafts, and fragments, plus extensive notes on the texts, an introduction by Howard authority Steve Tompkins, and an essay by noted editor Patrice Louinet.');
INSERT INTO `collection` (`id`, `title`, `series_id`, `published_at`, `page_count`, `description`) VALUES (7, 'The Best of Robert E. Howard Volume 1: Crimson Shadows', 3, '2007-08-14T12:00:00', 528, 'Robert E. Howard is one of the most famous and influential pulp authors of the twentieth century. Though largely known as the man who invented the sword-and-sorcery genre–and for his iconic hero Conan the Cimmerian–Howard also wrote horror tales, desert adventures, detective yarns, epic poetry, and more. This spectacular volume, gorgeously illustrated by Jim and Ruth Keegan, includes some of his best and most popular works.\n\nInside, readers will discover (or rediscover) such gems as “The Shadow Kingdom,” featuring Kull of Atlantis and considered by many to be the first sword-and-sorcery story; “The Fightin’est Pair,” part of one of Howard’s most successful series, chronicling the travails of Steve Costigan, a merchant seaman with fists of steel and a head of wood; “The Grey God Passes,” a haunting tale about the passing of an age, told against the backdrop of Irish history and legend; “Worms of the Earth,” a brooding narrative featuring Bran Mak Morn, about which H. P. Lovecraft said, “Few readers will ever forget the hideous and compelling power of [this] macabre masterpiece”; a historical poem relating a momentous battle between Cimbri and the legions of Rome; and “Sharp’s Gun Serenade,” one of the last and funniest of the Breckinridge Elkins tales.\n\nThese thrilling, eerie, compelling, swashbuckling stories and poems have been restored to their original form, presented just as the author intended. There is little doubt that after more than seven decades the voice of Robert E. Howard continues to resonate with readers around the world.');
INSERT INTO `collection` (`id`, `title`, `series_id`, `published_at`, `page_count`, `description`) VALUES (8, 'The Best of Robert E. Howard Volume 2: Grim Lands', 3, '2007-11-27T12:00:00', 544, 'The classic pulp magazines of the early twentieth century are long gone, but their action-packed tales live on through the work of legendary storyteller Robert E. Howard. From his fecund imagination sprang an army of larger-than-life heroes–including the iconic Conan the Cimmerian, King Kull of Atlantis, Solomon Kane, and Bran Mak Morn–as well as adventures that would define a genre for generations. Now comes the second volume of this author’s breathtaking short fiction, which runs the gamut from sword and sorcery, historical epic, and seafaring pirate adventure to two-fisted crime and intrigue, ghoulish horror, and rip-roaring western.\n\nKull reigns supreme in “By This Axe I Rule!” and “The Mirrors of Tuzan Thune”; Conan conquers in one of his most popular exploits, “The Tower of the Elephant”; Solomon Kane battles demons deep in Africa in “Wings in the Night”; and itinerant boxer Steve Costigan puts up his dukes of steel inside and outside the ring in “The Bulldog Breed.” In between, warrior kings, daring knights, sinister masterminds, grizzled frontiersmen–even Howard’s stunning heroine, Red Sonya–tear up the pages in stories built to thrill by their masterly creator.\n\nAnd in such epic poems as “Echoes from an Anvil,” “Black Harps in the Hills,” and “The Grim Land,” the author blends his classic characters and visceral imagery with a lyricism as haunting as traditional folk balladry. Lavishly illustrated by Jim and Ruth Keegan, here is a Robert E. Howard collection as indispensable as it is unforgettable.');
INSERT INTO `collection` (`id`, `title`, `series_id`, `published_at`, `page_count`, `description`) VALUES (9, 'The Horror Stories of Robert E. Howard', 3, '2008-10-28T12:00:00', 560, 'Here are Robert E. Howard’s greatest horror tales, all in their original, definitive versions.\n\nSome of Howard’s best-known characters—Solomon Kane, Bran Mak Morn, and sailor Steve Costigan among them—roam the forbidding locales of the author’s fevered imagination, from the swamps and bayous of the Deep South to the fiend-haunted woods outside Paris to remote jungles in Africa.\n\nThe collection includes Howard’s masterpiece “Pigeons from Hell,”which Stephen King calls “one of the finest horror stories of [the twentieth] century,” a tale of two travelers who stumble upon the ruins of a Southern plantation–and into the maw of its fatal secret. In “Black Canaan” even the best warrior has little chance of taking down the evil voodoo man with unholy powers–and none at all against his wily mistress, the diabolical High Priestess of Damballah. In these and other lavishly illustrated classics, such as the revenge nightmare “Worms of the Earth” and“The Cairn on the Headland,”Howard spins tales of unrelenting terror, the legacy of one of the world’s great masters of the macabre.');
INSERT INTO `collection` (`id`, `title`, `series_id`, `published_at`, `page_count`, `description`) VALUES (10, 'El Borak and Other Desert Adventures', 2, '2010-02-09T12:00:00', 592, 'Robert E. Howard is famous for creating such immortal heroes as Conan the Cimmerian, Solomon Kane, and Bran Mak Morn. Less well-known but equally extraordinary are his non-fantasy adventure stories set in the Middle East and featuring such two-fisted heroes as Francis Xavier Gordon—known as “El Borak”—Kirby O’Donnell, and Steve Clarney. This trio of hard-fighting Americans, civilized men with more than a touch of the primordial in their veins, marked a new direction for Howard’s writing, and new territory for his genius to conquer.\n\nThe wily Texan El Borak, a hardened fighter who stalks the sandscapes of Afghanistan like a vengeful wolf, is rivaled among Howard’s creations only by Conan himself. In such classic tales as “The Daughter of Erlik Khan,” “Three-Bladed Doom,” and “Sons of the Hawk,” Howard proves himself once again a master of action, and with plenty of eerie atmosphere his plotting becomes tighter and twistier than ever, resulting in stories worthy of comparison to Jack London and Rudyard Kipling. Every fan of Robert E. Howard and aficionados of great adventure writing will want to own this collection of the best of Howard’s desert tales, lavishly illustrated by award-winning artists Tim Bradstreet and Jim & Ruth Keegan.');
INSERT INTO `collection` (`id`, `title`, `series_id`, `published_at`, `page_count`, `description`) VALUES (11, 'Sword Woman and Other Historical Adventures', 2, '2011-01-25T12:00:00', 576, 'The immortal legacy of Robert E. Howard, creator of Conan the Cimmerian, continues with this latest compendium of Howard’s fiction and poetry. These adventures, set in medieval-era Europe and the Near East, are among the most gripping Howard ever wrote, full of pageantry, romance, and battle scenes worthy of Tolstoy himself. Most of all, they feature some of Howard’s most unusual and memorable characters, including Cormac FitzGeoffrey, a half-Irish, half-Norman man of war who follows Richard the Lion-hearted to twelfth-century Palestine—or, as it was known to the Crusaders, Outremer; Diego de Guzman, a Spaniard who visits Cairo in the guise of a Muslim on a mission of revenge; and the legendary sword woman Dark Agnès, who, faced with an arranged marriage to a brutal husband in sixteenth-century France, cuts the ceremony short with a dagger thrust and flees to forge a new identity on the battlefield.\n\nLavishly illustrated by award-winning artist John Watkiss and featuring miscellanea, informative essays, and a fascinating introduction by acclaimed historical author Scott Oden, Sword Woman and Other Historical Adventures is a must-have for every fan of Robert E. Howard, who, in a career spanning just twelve years, won a place in the pantheon of great American writers.');

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
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (38, 'The Dark Man', NULL, NULL, NULL, NULL, NULL, 'A biting wind drifted the snow as it feel. The surf snarled along the rugged shore and farther out the long leaden combers moaned ceaselessly. Through the gray dawn that was stealing over the coast of Connacht a fisherman came trudging, a man rugged as the land that bore him. His feet were wrapped in rough cured leather; a single garment of deerskin scantily sheltered his body. He wore no other clothing. As he strode stolidly along the shore, as heedless of the bitter cold as if he were the shaggy beast he appeared at first glance, he halted. Another man loomed up out of the veil of falling snow and drifting sea-mist. Turlogh Dubh stood before him', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (39, 'The Little People', NULL, NULL, NULL, NULL, NULL, 'My sister threw down the book she was reading. To be exact, she threw it at me. \"Foolishness!\" said she. \"Fairy tales! Hand me that copy of Michael Arlen.\" I do so mechanically, glancing at the volum which had incurred her youthful displeasure. The story was \"The Shining Pyramid\" by Arthur Machen. \"My dear girl,\" said I, \"this is a masterpiece of outre literature.\" \"Yes, but the idea!\" she answered. \"I outgrew fairy tales when I was ten.\" \"This tale is not intended as an exponent of common-day realism,\" I explained patiently. \"Too far-fetched,\" she said with the finality of seventeen. \"I like to read about things that could happen — who were \'The Little People\' he speaks of, the same old elf and troll business?\" \"All legends have a base of fact,\" I said. \"There is a reason —\" \"You mean to tell me such things actually existed?\" she exclaimed. \"Rot!\"', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (40, 'The Lost Race', NULL, NULL, NULL, NULL, NULL, 'Cororuc glanced about him and hastened his pace. He was no coward, but he did not like the place. Tall trees rose all about, their sullen branches shutting out the sunlight. The dim trail led in and out among them, sometimes skirting the edge of a ravine, where Cororuc could gaze down at the tree-tops beneath. Occasionally, through a rift in the forest, he could see away to the forbidding hills that hinted of the ranges much farther to the west, that were the mountains of Cornwall. In those mountains the bandit chief, Buruc the Cruel, was supposed to lurk, to descend upon such victims as might pass that way. Cororuc shifted his grip on his spear and quickened his step.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (41, 'Men of the Shadows', NULL, NULL, NULL, NULL, NULL, 'From the dim red dawn of Creation. From the fogs of timeless Time. Came we, the first great nation, First on the upward climb. Savage, untaught, unknowing, Groping through primitive night, Yet faintly catching the glowing, The hint of the coming Light.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (42, 'Worms of the Earth', 'http://gutenberg.net.au/ebooks06/0607861h.html', '1932-11-01T00:00:00', NULL, 0, NULL, 'STRIKE in the nails, soldiers, and let our guest see the reality of our good Roman justice!\"  The speaker wrapped his purple cloak closer about his powerful frame and settled back into his official chair, much as he might have settled back in his seat at the Circus Maximus to enjoy the clash of gladiatorial swords. Realization of power colored his every move. Whetted pride was necessary to Roman satisfaction, and Titus Sulla was justly proud; for he was military governor of Eboracum and answerable only to the emperor of Rome. He was a strongly built man of medium height, with the hawk-like features of the pure-bred Roman. Now a mocking smile curved his full lips, increasing the arrogance of his haughty aspect. Distinctly military in appearance, he wore the golden-scaled corselet and chased breastplate of his rank, with the short stabbing sword at his belt, and he held on his knee the silvered helmet with its plumed crest. Behind him stood a clump of impassive soldiers with shield and spear—blond titans from the Rhineland.  Before him was taking place the scene which apparently gave him so much real gratification—a scene common enough wherever stretched the far-flung boundaries of Rome. A rude cross lay flat upon the barren earth and on it was bound a man—half-naked, wild of aspect with his corded limbs, glaring eyes and shock of tangled hair. His executioners were Roman soldiers, and with heavy hammers they prepared to pin the victim\'s hands and feet to the wood with iron spikes.', '‘Worms of the Earth’ is a short story by American fantasy fiction writer Robert E. Howard. It was originally published in the magazine Weird Tales in November 1932, then again in this collection of Howard’s short stories. The story features one of Howard’s recurring protagonists, Bran Mak Morn, a legendary king of the Picts. ');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (43, 'Beyond the Black River', 'http://gutenberg.net.au/ebooks06/0600741h.html', NULL, NULL, NULL, NULL, 'The stillness of the forest trail was so primeval that the tread of a soft-booted foot was a startling disturbance. At least it seemed so to the ears of the wayfarer, though he was moving along the path with the caution that must be practised by any man who ventured beyond Thunder River. He was a young man of medium height, with an open countenance and a mop of tousled tawny hair unconfined by cap or helmet. His garb was common enough for that country — a coarse tunic, belted at the waist, short leather breeches beneath, and soft buckskin boots that came short of the knee. A knife hilt jutted from on boot-top. The broad leather belt supported a short heavy sword, and a buckskin pouch. There was no perturbation in the wide eyes that scanned the green walls which fringed the trail. Though not tall, he was well built, and the arms that the short wide sleeves of the tunic left bare were thick with corded muscle. He tramped imperturbably along although the last settler\'s cabin lay miles behind him, and each step was carrying him nearer the grim peril that hung like a brooding shadow over the ancient forest.', 'A thrilling novelette of the Picts and the wizard Zogar Sag — a startling weird saga of terrific adventures and dark magic.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (44, 'The Black Stranger', 'http://gutenberg.net.au/ebooks15/1501121h.html', NULL, NULL, NULL, NULL, 'One moment the glade lay empty; the next, a man stood poised warily at the edge of the bushes. There had been no sound to warn the grey squirrels of his coming. But the gay-hued birds that flitted about in the sunshine of the open space took fright at his sudden appearance and rose in a clamoring cloud. The man scowled and glanced quickly back the way he had come, as if fearing their flight had betrayed his position to some one unseen. The he stalked across the glade placing his feet with care. For all his massive, muscular build he moved with the supple certitude of a panther. He was naked except for a rag twisted about his loins, and his limbs were criss-crossed with scratches from briars, and caked with dried mud. A brown-crusted bandage was knotted about his thickly-muscled left arm. Under his matted black mane his face was drawn and gaunt, and his eyes burned like the eyes of a wounded panther. He limped slightly as he followed the dim path that led across the open space.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (45, 'The Man-Eaters of Zamboula', 'http://gutenberg.net.au/ebooks06/0600791h.html', NULL, NULL, NULL, NULL, 'Peril hides in the house of Aram Baksh!\" The speaker\'s voice quivered with earnestness and his lean, black-nailed fingers clawed at Conan\'s mightily-muscled arm as he croaked his warning. He was a wiry, sun-burnt man with a straggling black beard, and his ragged garments proclaimed him a nomad. He looked smaller and meaner than ever in contrast to the giant Cimmeriant with his black brows, broad breast, and powerful limbs. They stood in a corner of the Sword-Makers\' Bazaar, and on either side of them flowed past the many-tongued, man-colored stream of the Zamboula streets, which is exotic, hybrid, flamboyant and clamorous.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (46, 'Red Nails', 'http://gutenberg.net.au/ebooks06/0600771h.html', NULL, NULL, NULL, NULL, 'THE woman on the horse reined in her weary steed. It stood with its legs wide-braced, its head drooping, as if it found even the weight of the gold-tassled, red-leather bridle too heavy. The woman drew a booted foot out of the silver stirrup and swung down from the gilt-worked saddle. She made the reins fast to the fork of a sapling, and turned about, hands on her hips, to survey her surroundings. They were not inviting. Giant trees hemmed in the small pool where her horse had just drunk. Clumps of undergrowth limited the vision that quested under the somber twilight of the lofty arches formed by intertwining branches. The woman shivered with a twitch of her magnificent shoulders, and then cursed.', 'One of the strangest stories ever written — the tale of a barbarian adventurer, a woman pirate, and a weird roofed city inhabited by the most peculiar race of men ever spawned.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (47, 'The Servants of Bit-Yakin', 'http://gutenberg.net.au/ebooks06/0600761h.html', NULL, 'Jewels of Gwahlur', NULL, NULL, 'The cliffs rose sheer from the jungle, towering ramparts of stone that glinted jade blue and dull crimson in the rising sun, and curved away and away to east and west above the waving emerald ocean of fronds and leaves. It looked insurmountable, that giant palisade with its sheer curtains of solid rock in which bits of quartz winked dazzlingly in the sunlight. But the man who was working his tedious way upward was already half way to the top. He came of a race of hillmen, accustomed to scaling forbidding crags, and he was a man of unusual strength and agility. His only garment was a pair of short red silk breeks, and his sandals were slung to his back, out of his way, as were his sword and dagger.', 'The tale of a weird, jungle-hidden palace and a strange weird people — and the marvelous sacred jewels that were known as the Teeth of Gwahlur.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (48, 'Blood of the Gods', 'http://gutenberg.net.au/ebooks06/0601041h.html', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (49, 'The Daughter of Erlik Khan', 'http://gutenberg.net.au/ebooks06/0600991h.html', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (50, 'The Fire of Asshurbanipal (original version)', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (51, 'Gold from Tatary', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (52, 'Hawk of the Hills', 'http://gutenberg.net.au/ebooks06/0601001h.html', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (53, 'Son of the White Wolf', 'http://gutenberg.net.au/ebooks06/0601081h.html', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (54, 'Sons of the Hawk', 'http://gutenberg.net.au/ebooks06/0601091h.html', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (55, 'Swords of Shahrazar', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (56, 'Swords of the Hills', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (57, 'Three-Bladed Doom (long version)', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (58, 'Three-Bladed Doom (short version)', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (59, 'The Trail of the Blood-Stained God', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (60, 'Blades for France', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (61, 'The Blood of Belshazzar', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (62, 'Gates of Empire', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (63, 'Hawks of Outremer', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (64, 'Hawks Over Egypt', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (65, 'The Lion of Tiberias', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (66, 'Lord of Samarcand', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (67, 'Red Blades of Black Cathay', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (68, 'The Road of Azrael', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (69, 'The Road of the Eagles', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (70, 'The Shadow of the Vulture', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (71, 'The Skull in the Clouds', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (72, 'The Sowers of the Thunder', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (73, 'Spears of Clontarf', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (74, 'Sword Woman', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (75, 'Black Canaan', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (76, 'The Black Stone', 'http://gutenberg.net.au/ebooks06/0601711h.html', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (77, 'The Cairn on the Headland', 'http://gutenberg.net.au/ebooks06/0601721h.html', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (78, 'Casonetto\'s Last Song', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (79, 'The Dead Remember', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (80, 'Delenda Est', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (81, 'Dermod\'s Bane', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (82, 'Dig Me No Grave', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (83, 'The Dream Snake', 'http://gutenberg.net.au/ebooks06/0607971h.html', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (84, 'The Dwellers Under the Tomb', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (85, 'The Fearsome Touch of Death', 'http://gutenberg.net.au/ebooks06/0607981h.html', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (86, 'The Fire of Asshurbanipal (Weird Tales version)', 'http://gutenberg.net.au/ebooks06/0601741h.html', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (87, 'The Haunter of the Ring', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (88, 'The Hoofed Thing', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (89, 'The Horror From the Mound', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (90, 'The House of Arabu', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (91, 'In the Forest of Villefére', 'http://gutenberg.net.au/ebooks06/0607931h.html', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (92, 'Kelly the Conjure-Man', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (93, 'The Man on the Ground', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (94, 'The Noseless Horror', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (95, 'Old Garfield\'s Heart', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (96, 'Out of the Deep', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (97, 'People of the Dark', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (98, 'Pigeons From Hell', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (99, 'Restless Waters', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (100, 'Sea Curse', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (101, 'The Shadow of the Beast', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (102, 'Spectres in the Dark', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (103, 'The Spirit of Tom Molyneaux (version 2)', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (104, 'The Thing on the Roof', 'http://gutenberg.net.au/ebooks06/0608011h.html', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (105, 'The Valley of the Lost', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (106, 'Wolfshead', 'http://gutenberg.net.au/ebooks06/0601801h.html', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (107, 'The Fightin\'est Pair', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (108, '\"For the Love of Barbara Allen\"', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (109, 'The Grey God Passes', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (110, 'Lord of the Dead', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (111, 'Sharp\'s Gun Serenade', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (112, 'The Valley of the Worm', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (113, 'Black Vulmea\'s Vengeance', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (114, 'The Bull Dog Breed', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (115, 'Gents on the Lynch', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (116, 'Vultures of Wahpeton', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (117, 'Wild Water', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `poem`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (1, 'Am-ra the Ta-an', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (2, 'The King and the Oak', 'http://gutenberg.net.au/ebooks13/1303801h.html', 'Before the shadows slew the sun the kites were soaring free,\nAnd Kull rode down the forest road, his red sword at his knee;\nAnd winds were whispering round the world: \"King Kull rides to the sea.\"\n\nThe sun died crimson in the sea, the long gray shadows fell;\nThe moon rose like a silver skull that wrought a demon\'s spell,\nFor in its light great trees stood up like spectres out of hell.');
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (3, 'Summer Morn', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (4, 'Cimmeria', 'http://gutenberg.net.au/ebooks13/1303771h.html', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (5, 'The One Black Stain', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (6, 'The Return of Sir Richard Grenville', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (7, 'Solomon Kane\'s Homecoming', 'http://gutenberg.net.au/ebooks13/1303871h.html', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (8, 'A Song of the Race', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (9, 'The Drums of Pictdom', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (10, 'Untitled poem (There\'s a bell that hangs...)', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (11, 'A Thousand Years Ago', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (12, 'The Outgoing of Sigurd the Jerusalem-Farer', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (13, 'The Sign of the Sickle', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (14, 'Timur-lang', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (15, 'A Dull Sound as of Knocking', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (16, 'A Legend of Faring Town', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (17, 'A Song of the Werewolf Folk', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (18, 'An Open Window', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (19, 'Dead Man\'s Hate', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (20, 'The Dead Slaver\'s Tale', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (21, 'The Dweller in Dark Valley', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (22, 'The Fear that Follows', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (23, 'Fragment', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (24, 'Moon Mockery', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (25, 'The Moor Ghost', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (26, 'Musings', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (27, 'One Who Comes at Eventide', NULL, NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`, `excerpt`) VALUES (28, 'Remembrance', NULL, NULL);
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
INSERT INTO `person` (`id`, `name`, `image_url`, `description`) VALUES (1, 'Ace Jessel', NULL, NULL);
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


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
  PRIMARY KEY (`id`),
  UNIQUE INDEX `title_UNIQUE` (`title` ASC))
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
INSERT INTO `story` (`id`, `title`) VALUES (12, 'Black Colossus');
INSERT INTO `story` (`id`, `title`) VALUES (13, 'The Devil in Iron');
INSERT INTO `story` (`id`, `title`) VALUES (14, 'The Frost-Giant\'s Daughter');
INSERT INTO `story` (`id`, `title`) VALUES (15, 'The God in the Bowl');
INSERT INTO `story` (`id`, `title`) VALUES (16, 'Iron Shadows in the Moon');
INSERT INTO `story` (`id`, `title`) VALUES (17, 'The Phoenix on the Sword');
INSERT INTO `story` (`id`, `title`) VALUES (18, 'The Pool of the Black One');
INSERT INTO `story` (`id`, `title`) VALUES (19, 'Queen of the Black Coast');
INSERT INTO `story` (`id`, `title`) VALUES (20, 'Rogues in the House');
INSERT INTO `story` (`id`, `title`) VALUES (21, 'The Scarlet Citadel');
INSERT INTO `story` (`id`, `title`) VALUES (22, 'The Tower of the Elephant');
INSERT INTO `story` (`id`, `title`) VALUES (23, 'The Vale of the Lost Women');
INSERT INTO `story` (`id`, `title`) VALUES (24, 'Xuthal of the Dusk');
INSERT INTO `story` (`id`, `title`) VALUES (25, 'The Blue Flame of Vengeance');
INSERT INTO `story` (`id`, `title`) VALUES (26, 'The Footfalls Within');
INSERT INTO `story` (`id`, `title`) VALUES (27, 'The Hills of the Dead');
INSERT INTO `story` (`id`, `title`) VALUES (28, 'The Moon of Skulls');
INSERT INTO `story` (`id`, `title`) VALUES (29, 'Rattle of Bones');
INSERT INTO `story` (`id`, `title`) VALUES (30, 'Red Shadows');
INSERT INTO `story` (`id`, `title`) VALUES (31, 'The Right Hand of Doom');
INSERT INTO `story` (`id`, `title`) VALUES (32, 'Skulls in the Stars');
INSERT INTO `story` (`id`, `title`) VALUES (33, 'Wings in the Night');
INSERT INTO `story` (`id`, `title`) VALUES (34, 'The Hour of the Dragon');
INSERT INTO `story` (`id`, `title`) VALUES (35, 'The People of the Black Circle');
INSERT INTO `story` (`id`, `title`) VALUES (36, 'A Witch Shall Be Born');
INSERT INTO `story` (`id`, `title`) VALUES (37, 'The Children of the Night');
INSERT INTO `story` (`id`, `title`) VALUES (38, 'The Dark Man');
INSERT INTO `story` (`id`, `title`) VALUES (39, 'The Little People');
INSERT INTO `story` (`id`, `title`) VALUES (40, 'The Lost Race');
INSERT INTO `story` (`id`, `title`) VALUES (41, 'Men of the Shadows');
INSERT INTO `story` (`id`, `title`) VALUES (42, 'Worms of the Earth');
INSERT INTO `story` (`id`, `title`) VALUES (43, 'Beyond the Black River');
INSERT INTO `story` (`id`, `title`) VALUES (44, 'The Black Stranger');
INSERT INTO `story` (`id`, `title`) VALUES (45, 'The Man-Eaters of Zamboula');
INSERT INTO `story` (`id`, `title`) VALUES (46, 'Red Nails');
INSERT INTO `story` (`id`, `title`) VALUES (47, 'The Servants of Bit-Yakin');
INSERT INTO `story` (`id`, `title`) VALUES (48, 'Blood of the Gods');
INSERT INTO `story` (`id`, `title`) VALUES (49, 'The Daughter of Erlik Khan');
INSERT INTO `story` (`id`, `title`) VALUES (50, 'The Fire of Asshurbanipal (original version)');
INSERT INTO `story` (`id`, `title`) VALUES (51, 'Gold from Tatary');
INSERT INTO `story` (`id`, `title`) VALUES (52, 'Hawk of the Hills');
INSERT INTO `story` (`id`, `title`) VALUES (53, 'Son of the White Wolf');
INSERT INTO `story` (`id`, `title`) VALUES (54, 'Sons of the Hawk');
INSERT INTO `story` (`id`, `title`) VALUES (55, 'Swords of Shahrazar');
INSERT INTO `story` (`id`, `title`) VALUES (56, 'Swords of the Hills');
INSERT INTO `story` (`id`, `title`) VALUES (57, 'Three-Bladed Doom (long version)');
INSERT INTO `story` (`id`, `title`) VALUES (58, 'Three-Bladed Doom (short version)');
INSERT INTO `story` (`id`, `title`) VALUES (59, 'The Trail of the Blood-Stained God');
INSERT INTO `story` (`id`, `title`) VALUES (60, 'Blades for France');
INSERT INTO `story` (`id`, `title`) VALUES (61, 'The Blood of Belshazzar');
INSERT INTO `story` (`id`, `title`) VALUES (62, 'Gates of Empire');
INSERT INTO `story` (`id`, `title`) VALUES (63, 'Hawks of Outremer');
INSERT INTO `story` (`id`, `title`) VALUES (64, 'Hawks Over Egypt');
INSERT INTO `story` (`id`, `title`) VALUES (65, 'The Lion of Tiberias');
INSERT INTO `story` (`id`, `title`) VALUES (66, 'Lord of Samarcand');
INSERT INTO `story` (`id`, `title`) VALUES (67, 'Red Blades of Black Cathay');
INSERT INTO `story` (`id`, `title`) VALUES (68, 'The Road of Azrael');
INSERT INTO `story` (`id`, `title`) VALUES (69, 'The Road of the Eagles');
INSERT INTO `story` (`id`, `title`) VALUES (70, 'The Shadow of the Vulture');
INSERT INTO `story` (`id`, `title`) VALUES (71, 'The Skull in the Clouds');
INSERT INTO `story` (`id`, `title`) VALUES (72, 'The Sowers of the Thunder');
INSERT INTO `story` (`id`, `title`) VALUES (73, 'Spears of Clontarf');
INSERT INTO `story` (`id`, `title`) VALUES (74, 'Sword Woman');
INSERT INTO `story` (`id`, `title`) VALUES (75, 'Black Canaan');
INSERT INTO `story` (`id`, `title`) VALUES (76, 'The Black Stone');
INSERT INTO `story` (`id`, `title`) VALUES (77, 'The Cairn on the Headland');
INSERT INTO `story` (`id`, `title`) VALUES (78, 'Casonetto\'s Last Song');
INSERT INTO `story` (`id`, `title`) VALUES (79, 'The Dead Remember');
INSERT INTO `story` (`id`, `title`) VALUES (80, 'Delenda Est');
INSERT INTO `story` (`id`, `title`) VALUES (81, 'Dermod\'s Bane');
INSERT INTO `story` (`id`, `title`) VALUES (82, 'Dig Me No Grave');
INSERT INTO `story` (`id`, `title`) VALUES (83, 'The Dream Snake');
INSERT INTO `story` (`id`, `title`) VALUES (84, 'The Dwellers Under the Tomb');
INSERT INTO `story` (`id`, `title`) VALUES (85, 'The Fearsome Touch of Death');
INSERT INTO `story` (`id`, `title`) VALUES (86, 'The Fire of Asshurbanipal (Weird Tales version)');
INSERT INTO `story` (`id`, `title`) VALUES (87, 'The Haunter of the Ring');
INSERT INTO `story` (`id`, `title`) VALUES (88, 'The Hoofed Thing');
INSERT INTO `story` (`id`, `title`) VALUES (89, 'The Horror From the Mound');
INSERT INTO `story` (`id`, `title`) VALUES (90, 'The House of Arabu');
INSERT INTO `story` (`id`, `title`) VALUES (91, 'In the Forest of Villefére');
INSERT INTO `story` (`id`, `title`) VALUES (92, 'Kelly the Conjure-Man');
INSERT INTO `story` (`id`, `title`) VALUES (93, 'The Man on the Ground');
INSERT INTO `story` (`id`, `title`) VALUES (94, 'The Noseless Horror');
INSERT INTO `story` (`id`, `title`) VALUES (95, 'Old Garfield\'s Heart');
INSERT INTO `story` (`id`, `title`) VALUES (96, 'Out of the Deep');
INSERT INTO `story` (`id`, `title`) VALUES (97, 'People of the Dark');
INSERT INTO `story` (`id`, `title`) VALUES (98, 'Pigeons From Hell');
INSERT INTO `story` (`id`, `title`) VALUES (99, 'Restless Waters');
INSERT INTO `story` (`id`, `title`) VALUES (100, 'Sea Curse');
INSERT INTO `story` (`id`, `title`) VALUES (101, 'The Shadow of the Beast');
INSERT INTO `story` (`id`, `title`) VALUES (102, 'Spectres in the Dark');
INSERT INTO `story` (`id`, `title`) VALUES (103, 'The Spirit of Tom Molyneaux (version 2)');
INSERT INTO `story` (`id`, `title`) VALUES (104, 'The Thing on the Roof');
INSERT INTO `story` (`id`, `title`) VALUES (105, 'The Valley of the Lost');
INSERT INTO `story` (`id`, `title`) VALUES (106, 'Wolfshead');
INSERT INTO `story` (`id`, `title`) VALUES (107, 'The Fightin\'est Pair');
INSERT INTO `story` (`id`, `title`) VALUES (108, '\"For the Love of Barbara Allen\"');
INSERT INTO `story` (`id`, `title`) VALUES (109, 'The Grey God Passes');
INSERT INTO `story` (`id`, `title`) VALUES (110, 'Lord of the Dead');
INSERT INTO `story` (`id`, `title`) VALUES (111, 'Sharp\'s Gun Serenade');
INSERT INTO `story` (`id`, `title`) VALUES (112, 'The Valley of the Worm');
INSERT INTO `story` (`id`, `title`) VALUES (113, 'Black Vulmea\'s Vengeance');
INSERT INTO `story` (`id`, `title`) VALUES (114, 'The Bull Dog Breed');
INSERT INTO `story` (`id`, `title`) VALUES (115, 'Gents on the Lynch');
INSERT INTO `story` (`id`, `title`) VALUES (116, 'Vultures of Wahpeton');
INSERT INTO `story` (`id`, `title`) VALUES (117, 'Wild Water');

COMMIT;


-- -----------------------------------------------------
-- Data for table `poem`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `poem` (`id`, `title`) VALUES (1, 'Am-ra the Ta-an');
INSERT INTO `poem` (`id`, `title`) VALUES (2, 'The King and the Oak');
INSERT INTO `poem` (`id`, `title`) VALUES (3, 'Summer Morn');
INSERT INTO `poem` (`id`, `title`) VALUES (4, 'Cimmeria');
INSERT INTO `poem` (`id`, `title`) VALUES (5, 'The One Black Stain');
INSERT INTO `poem` (`id`, `title`) VALUES (6, 'The Return of Sir Richard Grenville');
INSERT INTO `poem` (`id`, `title`) VALUES (7, 'Solomon Kane\'s Homecoming');
INSERT INTO `poem` (`id`, `title`) VALUES (8, 'A Song of the Race');
INSERT INTO `poem` (`id`, `title`) VALUES (9, 'The Drums of Pictdom');
INSERT INTO `poem` (`id`, `title`) VALUES (10, 'Untitled poem (There\'s a bell that hangs...)');
INSERT INTO `poem` (`id`, `title`) VALUES (11, 'A Thousand Years Ago');
INSERT INTO `poem` (`id`, `title`) VALUES (12, 'The Outgoing of Sigurd the Jerusalem-Farer');
INSERT INTO `poem` (`id`, `title`) VALUES (13, 'The Sign of the Sickle');
INSERT INTO `poem` (`id`, `title`) VALUES (14, 'Timur-lang');
INSERT INTO `poem` (`id`, `title`) VALUES (15, 'A Dull Sound as of Knocking');
INSERT INTO `poem` (`id`, `title`) VALUES (16, 'A Legend of Faring Town');
INSERT INTO `poem` (`id`, `title`) VALUES (17, 'A Song of the Werewolf Folk');
INSERT INTO `poem` (`id`, `title`) VALUES (18, 'An Open Window');
INSERT INTO `poem` (`id`, `title`) VALUES (19, 'Dead Man\'s Hate');
INSERT INTO `poem` (`id`, `title`) VALUES (20, 'The Dead Slaver\'s Tale');
INSERT INTO `poem` (`id`, `title`) VALUES (21, 'The Dweller in Dark Valley');
INSERT INTO `poem` (`id`, `title`) VALUES (22, 'The Fear that Follows');
INSERT INTO `poem` (`id`, `title`) VALUES (23, 'Fragment');
INSERT INTO `poem` (`id`, `title`) VALUES (24, 'Moon Mockery');
INSERT INTO `poem` (`id`, `title`) VALUES (25, 'The Moor Ghost');
INSERT INTO `poem` (`id`, `title`) VALUES (26, 'Musings');
INSERT INTO `poem` (`id`, `title`) VALUES (27, 'One Who Comes at Eventide');
INSERT INTO `poem` (`id`, `title`) VALUES (28, 'Remembrance');
INSERT INTO `poem` (`id`, `title`) VALUES (29, 'The Song of a Mad Minstrel');
INSERT INTO `poem` (`id`, `title`) VALUES (30, 'The Symbol');
INSERT INTO `poem` (`id`, `title`) VALUES (31, 'The Tavern');
INSERT INTO `poem` (`id`, `title`) VALUES (32, 'To a Woman');
INSERT INTO `poem` (`id`, `title`) VALUES (33, 'Up, John Kane!');
INSERT INTO `poem` (`id`, `title`) VALUES (34, 'Which Will Scarcely Be Understood');
INSERT INTO `poem` (`id`, `title`) VALUES (35, 'A Word From the Outer Dark');
INSERT INTO `poem` (`id`, `title`) VALUES (36, 'An Echo From the Iron Harp');
INSERT INTO `poem` (`id`, `title`) VALUES (37, 'The Dust Dance (version 1)');
INSERT INTO `poem` (`id`, `title`) VALUES (38, 'The Ghost Kings');
INSERT INTO `poem` (`id`, `title`) VALUES (39, 'Lines Written in the Realization That I Must Die');
INSERT INTO `poem` (`id`, `title`) VALUES (40, 'The Marching Song of Connacht');
INSERT INTO `poem` (`id`, `title`) VALUES (41, 'Recompense');
INSERT INTO `poem` (`id`, `title`) VALUES (42, 'The Song of the Last Briton');
INSERT INTO `poem` (`id`, `title`) VALUES (43, 'The Tide');
INSERT INTO `poem` (`id`, `title`) VALUES (44, 'Untitled (\"You have built a world of paper and wood...\")');
INSERT INTO `poem` (`id`, `title`) VALUES (45, 'A Song of the Naked Lands');
INSERT INTO `poem` (`id`, `title`) VALUES (46, 'Black Harps in the Hills');
INSERT INTO `poem` (`id`, `title`) VALUES (47, 'Echoes From an Anvil');
INSERT INTO `poem` (`id`, `title`) VALUES (48, 'Flint\'s Passing');
INSERT INTO `poem` (`id`, `title`) VALUES (49, 'The Grim Land');
INSERT INTO `poem` (`id`, `title`) VALUES (50, 'Never Beyond the Beast');

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
INSERT INTO `miscellanea` (`id`, `title`) VALUES (6, 'The Hyborian Age (essay)');
INSERT INTO `miscellanea` (`id`, `title`) VALUES (7, 'Notes on Various Peoples of the Hyborian Age (essay)');
INSERT INTO `miscellanea` (`id`, `title`) VALUES (8, 'Untitled draft (\"Amboola awakened slowly...\")');
INSERT INTO `miscellanea` (`id`, `title`) VALUES (9, 'Untitled fragment (\"The battlefield stretched silent...\")');
INSERT INTO `miscellanea` (`id`, `title`) VALUES (10, 'Untitled synopsis (\"A squad of Zamoran soldiers...\")');
INSERT INTO `miscellanea` (`id`, `title`) VALUES (11, 'Untitled synopsis (Black Colossus)');
INSERT INTO `miscellanea` (`id`, `title`) VALUES (12, 'Untitled synopsis (The Scarlet Citadel)');
INSERT INTO `miscellanea` (`id`, `title`) VALUES (13, 'Untitled synopsis (\"The setting: The city of Shumballa...\")');
INSERT INTO `miscellanea` (`id`, `title`) VALUES (14, 'The Castle of the Devil (fragment)');
INSERT INTO `miscellanea` (`id`, `title`) VALUES (15, 'The Children of Asshur (fragment)');
INSERT INTO `miscellanea` (`id`, `title`) VALUES (16, 'Death\'s Black Riders (unfinished)');
INSERT INTO `miscellanea` (`id`, `title`) VALUES (17, 'Hawk of Basti (unfinished)');
INSERT INTO `miscellanea` (`id`, `title`) VALUES (18, 'Untitled draft (\"Three men squatted beside the water hole...\")');
INSERT INTO `miscellanea` (`id`, `title`) VALUES (19, 'Untitled fragment (\"A grey sky arched...\")');
INSERT INTO `miscellanea` (`id`, `title`) VALUES (20, 'Untitled fragment (\"Men have had vision ere now...\")');
INSERT INTO `miscellanea` (`id`, `title`) VALUES (21, 'Wolves Beyond the Border (unfinished)');
INSERT INTO `miscellanea` (`id`, `title`) VALUES (22, 'Mistress of Death (uncompleted draft)');
INSERT INTO `miscellanea` (`id`, `title`) VALUES (23, 'Recap of Harold Lamb\'s \"The Wolf Chaser\"');
INSERT INTO `miscellanea` (`id`, `title`) VALUES (24, 'The Slave-Princess (fragment)');
INSERT INTO `miscellanea` (`id`, `title`) VALUES (25, 'The Track of Bohemund (unfinished draft)');
INSERT INTO `miscellanea` (`id`, `title`) VALUES (26, 'Untitled fragment (\"He knew de Bracy...\")');
INSERT INTO `miscellanea` (`id`, `title`) VALUES (27, 'Untitled fragment (\"The Persians had all fled...\")');
INSERT INTO `miscellanea` (`id`, `title`) VALUES (28, 'Untitled fragment (\"The wind from the Mediterranean...\")');
INSERT INTO `miscellanea` (`id`, `title`) VALUES (29, 'Golnar the Ape (unfinished)');
INSERT INTO `miscellanea` (`id`, `title`) VALUES (30, 'The House (fragment)');
INSERT INTO `miscellanea` (`id`, `title`) VALUES (31, 'Untitled fragment (\"Beneath the glare of the sun...\")');

COMMIT;


-- -----------------------------------------------------
-- Data for table `person`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `person` (`id`, `name`) VALUES (1, 'Ace Jessel');
INSERT INTO `person` (`id`, `name`) VALUES (2, 'Bran Mak Morn');
INSERT INTO `person` (`id`, `name`) VALUES (3, 'Breckinridge Elkins');
INSERT INTO `person` (`id`, `name`) VALUES (4, 'Buckner J. Grimes');
INSERT INTO `person` (`id`, `name`) VALUES (5, 'Conan');
INSERT INTO `person` (`id`, `name`) VALUES (6, 'Cormac Fitzgeoffrey');
INSERT INTO `person` (`id`, `name`) VALUES (7, 'Cormac Mac Art');
INSERT INTO `person` (`id`, `name`) VALUES (8, 'Dark Agnes');
INSERT INTO `person` (`id`, `name`) VALUES (9, 'Dennis Dorgan');
INSERT INTO `person` (`id`, `name`) VALUES (10, 'El Borak');
INSERT INTO `person` (`id`, `name`) VALUES (11, 'James Allison');
INSERT INTO `person` (`id`, `name`) VALUES (12, 'Kirby O\'Donnell');
INSERT INTO `person` (`id`, `name`) VALUES (13, 'Kull');
INSERT INTO `person` (`id`, `name`) VALUES (14, 'Lal Singh');
INSERT INTO `person` (`id`, `name`) VALUES (15, 'Pike Bearfield');
INSERT INTO `person` (`id`, `name`) VALUES (16, 'Solomon Kane');
INSERT INTO `person` (`id`, `name`) VALUES (17, 'The Sonora Kid');
INSERT INTO `person` (`id`, `name`) VALUES (18, 'Steve Costigan');
INSERT INTO `person` (`id`, `name`) VALUES (19, 'Steve Harrison');
INSERT INTO `person` (`id`, `name`) VALUES (20, 'Terence Vulmea');
INSERT INTO `person` (`id`, `name`) VALUES (21, 'Turlogh O\'Brien');
INSERT INTO `person` (`id`, `name`) VALUES (22, 'Wild Bill Clanton');
INSERT INTO `person` (`id`, `name`) VALUES (23, 'Yar Ali Khan');
INSERT INTO `person` (`id`, `name`) VALUES (24, 'Red Sonya');

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
INSERT INTO `person_has_list_content` (`person_id`, `list_content_id`) VALUES (13, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `collection_has_story`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (6, 1);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (6, 2);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (6, 3);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (6, 4);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (6, 5);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (6, 6);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (6, 7);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (6, 8);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (6, 9);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (6, 10);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (6, 11);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (1, 12);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (1, 13);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (1, 14);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (1, 15);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (1, 16);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (1, 17);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (1, 18);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (1, 19);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (1, 20);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (1, 21);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (1, 22);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (1, 23);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (1, 24);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (2, 25);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (2, 26);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (2, 27);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (2, 28);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (2, 29);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (2, 30);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (2, 31);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (2, 32);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (2, 33);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (3, 34);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (3, 35);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (3, 36);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (4, 37);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (4, 6);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (4, 38);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (4, 39);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (4, 40);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (4, 41);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (4, 42);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (5, 43);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (5, 44);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (5, 45);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (5, 46);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (5, 47);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (10, 48);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (10, 49);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (10, 50);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (10, 51);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (10, 52);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (10, 53);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (10, 54);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (10, 55);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (10, 56);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (10, 57);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (10, 58);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (10, 59);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (11, 60);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (11, 61);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (11, 62);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (11, 63);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (11, 64);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (11, 65);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (11, 66);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (11, 67);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (11, 68);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (11, 69);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (11, 70);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (11, 71);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (11, 72);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (11, 73);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (11, 74);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 75);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 76);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 77);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 78);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 79);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 80);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 81);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 82);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 83);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 84);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 85);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 86);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 87);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 88);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 89);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 90);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 91);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 92);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 93);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 94);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 95);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 96);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 97);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 98);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 99);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 100);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 101);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 102);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 103);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 104);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 105);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 106);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 37);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 27);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 39);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 29);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (9, 42);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (7, 43);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (7, 76);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (7, 4);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (7, 38);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (7, 107);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (7, 108);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (7, 109);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (7, 52);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (7, 6);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (7, 110);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (7, 35);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (7, 30);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (7, 9);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (7, 111);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (7, 112);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (7, 42);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (8, 113);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (8, 114);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (8, 2);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (8, 115);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (8, 66);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (8, 93);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (8, 7);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (8, 95);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (8, 98);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (8, 46);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (8, 70);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (8, 53);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (8, 22);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (8, 116);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (8, 117);
INSERT INTO `collection_has_story` (`collection_id`, `story_id`) VALUES (8, 33);

COMMIT;


-- -----------------------------------------------------
-- Data for table `collection_has_poem`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (6, 1);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (6, 2);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (6, 3);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (1, 4);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (2, 5);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (2, 6);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (2, 7);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (4, 8);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (4, 9);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (4, 10);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (11, 11);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (11, 12);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (11, 13);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (11, 14);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (9, 15);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (9, 16);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (9, 17);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (9, 18);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (9, 19);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (9, 20);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (9, 21);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (9, 22);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (9, 23);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (9, 24);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (9, 25);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (9, 26);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (9, 27);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (9, 28);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (9, 29);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (9, 30);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (9, 31);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (9, 32);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (9, 33);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (9, 34);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (7, 35);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (7, 36);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (7, 37);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (7, 38);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (7, 39);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (7, 40);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (7, 5);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (7, 41);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (7, 29);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (7, 42);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (7, 43);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (7, 44);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (8, 45);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (8, 46);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (8, 4);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (8, 47);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (8, 48);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (8, 49);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (8, 2);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (8, 26);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (8, 50);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (8, 7);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (8, 14);
INSERT INTO `collection_has_poem` (`collection_id`, `poem_id`) VALUES (8, 34);

COMMIT;


-- -----------------------------------------------------
-- Data for table `collection_has_miscellanea`
-- -----------------------------------------------------
START TRANSACTION;
USE `howardtreasurydb`;
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (6, 1);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (6, 2);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (6, 3);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (6, 4);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (6, 5);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (1, 6);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (1, 7);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (1, 8);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (1, 9);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (1, 10);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (1, 11);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (1, 12);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (1, 13);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (2, 14);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (2, 15);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (2, 16);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (2, 17);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (3, 18);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (4, 19);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (4, 20);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (5, 21);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (11, 22);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (11, 23);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (11, 24);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (11, 25);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (11, 26);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (11, 27);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (11, 28);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (9, 29);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (9, 30);
INSERT INTO `collection_has_miscellanea` (`collection_id`, `miscellanea_id`) VALUES (9, 31);

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


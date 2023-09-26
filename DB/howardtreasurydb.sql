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
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (12, 'Black Colossus', 'http://gutenberg.net.au/ebooks06/0600931h.html', '1934-01-01T00:00:00', NULL, 0, NULL, 'Only the age-old silence brooded over the mysterious ruins of Kuthchemes, but Fear was there; Fear quivered in the mind of Shevatas, the thief, driving his breath quick and sharp against his clenched teeth. He stood, the one atom of life amidst the colossal monuments of desolation and decay. Not even a vulture hung like a black dot in the vast blue vault of the sky that the sun glazed with its heat. On every hand rose the grim relics of another, forgotten age: huge broken pillars, thrusting up their jagged pinnacles into the sky; long wavering lines of crumbling walls; fallen cyclopean blocks of stone; shattered images, whose horrific features the corroding winds and dust-storms had half erased. From horizon to horizon no sign of life: only the sheer breathtaking sweep of the naked desert, bisected by the wandering line of a long-dry river course; in the midst of that vastness the glimmering fangs of the ruins, the columns standing up like broken masts of sunken ships—all dominated by the towering ivory dome before which Shevatas stood trembling.', '\"Black Colossus\" is one of the original short stories starring the fictional sword and sorcery hero Conan the Cimmerian, written by American author Robert E. Howard and first published in Weird Tales magazine, June 1933. It is set in the pseudo-historical Hyborian Age and concerns Conan leading the demoralized army of Khoraja against an evil sorcerer named Natohk, \"the Veiled One.\" This story formed part of the basis for the later Conan novel, The Hour of the Dragon.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (13, 'The Devil in Iron', 'http://gutenberg.net.au/ebooks06/0600801h.html', '1934-01-01T00:00:00', NULL, 0, NULL, 'The fisherman loosened his knife in its scabbard. The gesture was instinctive, for what he feared was nothing a knife could slay, not even the saw-edged crescent blade of the Yuetshi that could disembowel a man with an upward stroke. Neither man nor beast threatened him in the solitude which brooded over the castellated isle of Xapur. He had climbed the cliffs, passed through the jungle that bordered them, and now stood surrounded by evidences of a vanished state. Broken columns glimmered among the trees, the straggling lines of crumbling walls meandered off into the shadows, and under his feet were broad paves, cracked and bowed by roots growing beneath.', 'A mythical demon and its ancient fortress are resurrected after the theft of a sacred dagger, and Conan is tricked into landing on the island, with many unexpected consequences in store.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (14, 'The Frost-Giant\'s Daughter', 'http://gutenberg.net.au/ebooks06/0600751h.html', '1934-03-01T00:00:00', 'Gods of the North', 0, NULL, 'The clangor of the swords had died away, the shouting of the slaughter was hushed; silence lay on the red-stained snow. The pale bleak sun that glittered so blindingly from the ice-fields and the snow-covered plains struck sheens of silver from rent corselet and broken blade, where the dead lay in heaps. The nerveless hand yet gripped the broken hilt; helmeted heads, back-drawn in the death throes, tilted red beards and golden beards grimly upward, as if in last invocation to Ymir the frost-giant. Across the red drifts and mail-clad forms, two figures approached one another. In that utter desolation only they moved. The frosty sky was over them, the white illimitable plain around them, the dead men at their feet. Slowly through the corpses they came, as ghosts might come to a tryst through the shambles of a world.', 'The clangor of the swords had died away, the shouting of the slaughter was hushed; silence lay on the red-stained snow. The bleak pale sun that glittered so blindingly from the ice-fields and the snow-covered plains struck sheens of silver from rent corselet and broken blade, where the dead lay as they had fallen. The nerveless hand yet gripped the broken hilt; helmeted heads back-drawn in the death-throes, tilted red beards and golden beards grimly upward, as if in last invocation to Ymir the frost-giant, god of a warrior-race.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (15, 'The God in the Bowl', 'http://gutenberg.net.au/ebooks15/1501131h.html', '1952-01-01T00:00:00', NULL, 1, '2052-01-01T00:00:00', 'Arus the watchman grasped his crossbow with shaky hands, and he felt beads of clammy perspiration on his skin as he stared at the unlovely corpse sprawling on the polished floor before him. It is not pleasant to come upon Death in a lonely place at midnight. Arus stood in a vast corridor, lighted by huge candles in niches along the walls. These walls were hung with black velvet tapestries, and between the tapestries hung shields and crossed weapons of fantastic make. Here and there, too, stood figures of curious gods—images carved of stone or rare wood, or cast of bronze, iron or silver—mirrored in the gleaming black mahogany floor. Arus shuddered; he had never become used to the place, although he had worked there as watchman for some months. It was a fantastic establishment, the great museum and antique house which men called Kallian Publico\'s Temple, with its rarities from all over the world—and now, in the lonesomeness of midnight, Arus stood in the great silent hall and stared at the sprawling corpse that had been the rich and powerful owner of the Temple.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (16, 'Iron Shadows in the Moon', 'http://gutenberg.net.au/ebooks06/0600971h.html', '1934-04-01T00:00:00', 'Shadows in the Moonlight', 0, NULL, 'A swift crashing of horses through the tall reeds; a heavy fall, a despairing cry. From the dying steed there staggered up its rider, a slender girl in sandals and girdled tunic. Her dark hair fell over her white shoulders, her eyes were those of a trapped animal. She did not look at the jungle of reeds that hemmed in the little clearing, nor at the blue waters that lapped the low shore behind her. Her wide-eyed gaze was fixed in agonized intensity on the horseman who pushed through the reedy screen and dismounted before her. He was a tall man, slender, but hard as steel. From head to heel he was clad in light silvered mesh-mail that fitted his supple form like a glove. From under the dome-shaped, gold-chased helmet his brown eyes regarded her mockingly. \"Stand back!\" her voice shrilled with terror. \"Touch me not, Shah Amurath, or I will throw myself into the water and drown!\" He laughed, and his laughter was like the purr of a sword sliding from a silken sheath.', '\"Shadows in the Moonlight\" is one of the original short stories starring the fictional sword and sorcery hero Conan the Cimmerian, written by American author Robert E. Howard and first published in Weird Tales magazine in April 1934. Howard originally named his story \"Iron Shadows in the Moon\". It is set in the pseudo-historical Hyborian Age and concerns Conan escaping to a remote island in the Vilayet Sea where he encounters the Red Brotherhood, a skulking creature, and mysterious iron statues.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (17, 'The Phoenix on the Sword', 'http://gutenberg.net.au/ebooks06/0600811h.html', '1932-04-01T00:00:00', NULL, 0, NULL, 'Over shadowy spires and gleaming towers lay the ghostly darkness and silence that runs before dawn. Into a dim alley, one of a veritable labyrinth of mysterious winding ways, four masked figures came hurriedly from a door which a dusky hand furtively opened. They spoke not but went swiftly into the gloom, cloaks wrapped closely about them; as silently as the ghosts of murdered men they disappeared in the darkness. Behind them a sardonic countenance was framed in the partly opened door; a pair of evil eyes glittered malevolently in the gloom. \"Go into the night, creatures of the night,\" a voice mocked. \"Oh, fools, your doom hounds your heels like a blind dog, and you know it not.\"', '\"The Phoenix on the Sword\" begins with a middle-aged Conan of Cimmeria attempting to govern the turbulent kingdom of Aquilonia. Conan has recently seized the bloody crown of Aquilonia from King Numedides whom he strangled upon his throne; however, things have not gone well, as Conan is more suited to swinging a broadsword than to signing official documents with a stylus. The people of Aquilonia, who originally welcomed Conan as their liberator from Numedides\' tyranny, have gradually turned against him due to his foreign Cimmerian blood. They have built a statue to Numedides\' memory in the temple of Mitra, and people burn incense before it, hailing it as the holy effigy of a saintly monarch who was done to death by a red-handed barbarian.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (18, 'The Pool of the Black One', 'http://gutenberg.net.au/ebooks06/0600951h.html', '1934-04-01T00:00:00', NULL, 0, NULL, 'Sancha, once of Kordava, yawned daintily, stretched her supple limbs luxuriously, and composed herself more comfortably on the ermine-fringed silk spread on the carack\'s poop-deck. That the crew watched her with burning interest from waist and forecastle she was lazily aware, just as she was also aware that her short silk kirtle veiled little of her voluptuous contours from their eager eyes. Wherefore she smiled insolently and prepared to snatch a few more winks before the sun, which was just thrusting his golden disk above the ocean, should dazzle her eyes. But at that instant a sound reached her ears unlike the creaking of timbers, thrum of cordage and lap of waves. She sat up, her gaze fixed on the rail, over which, to her amazement, a dripping figure clambered. Her dark eyes opened wide, her red lips parted in an O of surprize. The intruder was a stranger to her. Water ran in rivulets from his great shoulders and down his heavy arms. His single garment—a pair of bright crimson silk breeks—was soaking wet, as was his broad gold-buckled girdle and the sheathed sword it supported. As he stood at the rail, the rising sun etched him like a great bronze statue. He ran his fingers through his streaming black mane, and his blue eyes lit as they rested on the girl.', '\"The Pool of the Black One\" is one of the original short stories starring the sword and sorcery hero Conan the Cimmerian, written by American author Robert E. Howard. It is set in the pseudo-historical Hyborian Age and concerns Conan becoming the captain of a pirate vessel and encountering a remote island with a mysterious pool that has powers of transmutation.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (19, 'Queen of the Black Coast', 'http://gutenberg.net.au/ebooks06/0600961h.html', '1934-05-01T00:00:00', NULL, 0, NULL, 'Hoofs drummed down the street that sloped to the wharfs. The folk that yelled and scattered had only a fleeting glimpse of a mailed figure on a black stallion, a wide scarlet cloak flowing out on the wind. Far up the street came the shout and clatter of pursuit, but the horseman did not look back. He swept out onto the wharfs and jerked the plunging stallion back on its haunches at the very lip of the pier. Seamen gaped up at him, as they stood to the sweep and striped sail of a high-prowed, broad-waisted galley. The master, sturdy and black-bearded, stood in the bows, easing her away from the piles with a boat-hook. He yelled angrily as the horseman sprang from the saddle and with a long leap landed squarely on the mid-deck. \"Who invited you aboard?\" \"Get under way!” roared the intruder with a fierce gesture that spattered red drops from his broadsword. \"But we’re bound for the coasts of Cush!” expostulated the master. \"Then I’m for Cush! Push off, I tell you!” The other cast a quick glance up the street, along which a squad of horse-men were galloping; far behind them toiled a group of archers, crossbows on their shoulders. \"Can you pay for your passage?” demanded the master. \"I pay my way with steel!” roared the man in armor, brandishing the great sword that glittered bluely in the sun. \"By Crom, man, if you don’t get under way. I’ll drench this galley in the blood of its crew!”', '\"Queen of the Black Coast\" is one of the original short stories about Conan the Cimmerian, written by American author Robert E. Howard and first published in Weird Tales magazine circa May 1934. It is set in the pseudo-historical Hyborian Age and concerns Conan becoming a notorious pirate and plundering the coastal villages of Kush alongside Bêlit, a head-strong femme fatale. Due to its epic scope and atypical romance, the story is considered an undisputed classic of Conan lore and is often cited by Howard scholars as one of his most famous tales.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (20, 'Rogues in the House', 'http://gutenberg.net.au/ebooks06/0600781h.html', '1935-01-01T00:00:00', NULL, 0, NULL, 'At a court festival, Nabonidus, the Red Priest, who was the real ruler of the city, touched Murilo, the young aristocrat, courteously on the arm. Murilo turned to meet the priest\'s enigmatic gaze, and to wonder at the hidden meaning therein. No words passed between them, but Nabonidus bowed and handed Murilo a small gold cask. The young nobleman, knowing that Nabonidus did nothing without reason, excused himself at the first opportunity and returned hastily to his chamber. There he opened the cask and found within a human ear, which he recognized by a peculiar scar upon it. He broke into a profuse sweat and was no longer in doubt about the meaning in the Red Priest\'s glance. But Murilo, for all his scented black curls and foppish apparel was no weakling to bend his neck to the knife without a struggle. He did not know whether Nabonidus was merely playing with him or giving him a chance to go into voluntary exile, but the fact that he was still alive and at liberty proved that he was to be given at least a few hours, probably for meditation. However, he needed no meditation for decision; what he needed was a tool. And Fate furnished that tool, working among the dives and brothels of the squalid quarters even while the young nobleman shivered and pondered in the part of the city occupied by the purple-towered marble and ivory palaces of the aristocracy.', '\"Rogues in the House\" is one of the original short stories starring the fictional sword and sorcery hero Conan the Cimmerian, written by American author Robert E. Howard and first published in Weird Tales magazine circa January 1934. It is set in the pseudo-historical Hyborian Age and concerns Conan inadvertently becoming involved in the power play between two powerful men fighting for control of a city. It was the seventh Conan story Howard had published.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (21, 'The Scarlet Citadel', 'http://gutenberg.net.au/ebooks06/0600821h.html', '1933-01-01T00:00:00', NULL, 0, NULL, 'The roar of battle had died away; the shout of victory mingled with the cries of the dying. Like gay-hued leaves after an autumn storm, the fallen littered the plain; the sinking sun shimmered on burnished helmets, gilt-worked mail, silver breastplates, broken swords and the heavy regal folds of silken standards, overthrown in pools of curdling crimson. In silent heaps lay war-horses and their steel-clad riders, flowing manes and blowing plumes stained alike in the red tide. About them and among them, like the drift of a storm, were strewn slashed and trampled bodies in steel caps and leather jerkins—archers and pikemen. The oliphants sounded a fanfare of triumph all over the plain, and the hoofs of the victors crunched in the breasts of the vanquished as all the straggling, shining lines converged inward like the spokes of a glittering wheel, to the spot where the last survivor still waged unequal strife. That day Conan, king of Aquilonia, had seen the pick of his chivalry cut to pieces, smashed and hammered to bits, and swept into eternity.', '\"The Scarlet Citadel\" is one of the original short stories starring the fictional sword and sorcery hero Conan the Cimmerian, written by American author Robert E. Howard and first published in the January, 1933 issue of Weird Tales magazine. It is set in the pseudo-historical Hyborian Age and concerns a middle-aged Conan battling rival kingdoms, being captured through treachery and escaping from an eldritch dungeon via unexpected aid. The story includes Tsotha-lanti who is an evil wizard whose sorcerous arts help ensnare King Conan.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (22, 'The Tower of the Elephant', 'http://gutenberg.net.au/ebooks06/0600831h.html', '1933-01-01T00:00:00', NULL, 0, NULL, 'Torches flared murkily on the revels in the Maul, where the thieves of the east held carnival by night. In the Maul they could carouse and roar as they liked, for honest people shunned the quarters, and watchmen, well paid with stained coins, did not interfere with their sport. Along the crooked, unpaved streets with their heaps of refuse and sloppy puddles, drunken roisterers staggered, roaring. Steel glinted in the shadows where wolf preyed on wolf, and from the darkness rose the shrill laughter of women, and the sounds of scufflings and strugglings. Torchlight licked luridly from broken windows and wide-thrown doors, and out of those doors, stale smells of wine and rank sweaty bodies, clamor of drinking-jacks and fists hammered on rough tables, snatches of obscene songs, rushed like a blow in the face. In one of these dens merriment thundered to the low smoke-stained roof, where rascals gathered in every stage of rags and tatters—furtive cut-purses, leering kidnappers, quick-fingered thieves, swaggering bravoes with their wenches, strident-voiced women clad in tawdry finery. Native rogues were the dominant element—dark-skinned, dark-eyed Zamorians, with daggers at their girdles and guile in their hearts. But there were wolves of half a dozen outland nations there as well. There was a giant Hyperborean renegade, taciturn, dangerous, with a broadsword strapped to his great gaunt frame—for men wore steel openly in the Maul. There was a Shemitish counterfeiter, with his hook nose and curled blue­black beard. There was a bold-eyed Brythunian wench, sitting on the knee of a tawny-haired Gunderman—a wandering mercenary soldier, a deserter from some defeated army. And the fat gross rogue whose bawdy jests were causing all the shouts of mirth was a professional kidnapper come up from distant Koth to teach woman-stealing to Zamorians who were born with more knowledge of the art than he could ever attain.', '\"The Tower of the Elephant\" is one of the original short stories starring the fictional sword and sorcery hero Conan the Cimmerian, written by American author Robert E. Howard. It is set in the pseudo-historical Hyborian Age and concerns Conan infiltrating a perilous tower in order to steal a fabled gem from an evil sorcerer named Yara. Due to its unique insights into the Hyborian world and atypical science fiction elements, the story is considered a classic of Conan lore and is often cited by Howard scholars as one of his best tales.');
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (23, 'The Vale of the Lost Women', NULL, '1967-01-01T00:00:00', NULL, 1, '2063-01-01T00:00:00', 'The thunder of the drums and the great elephant-tusk horns was deafening, but in Livia’s\nears the clamor seemed but a confusing muttering, dull and far away. As she lay on the\nangareb in the great hut, her state bordering between delirium and semi-unconsciousness.\nOutward sounds and movements scarcely impinged upon her senses. Her whole mental\nvision, though dazed and chaotic, was yet centered with hideous certitude on the naked,\nwrithing figure of her brother, blood streaming down his quivering thighs. Against a dim\nnightmare background of dusky interweaving shapes and shadows, that white form was\nlimned in merciless and awful clarity. The air seemed still to pulsate with an agonized\nscreaming, mingled and interwoven obscenely with a rustle of fiendish laughter. She was not conscious of sensation as an individual, separate and distinct from the rest of\nthe cosmos. She was drowned in a great gulf of pain—was herself but pain crystallized\nand manifested in flesh. So she lay without conscious thought or motion, while outside\nthe drums bellowed, the horns clamored, and barbaric voices lifted hideous chants,\nkeeping time to naked feet slapping the hard earth and open palms smiting one another\nsoftly.', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (24, 'Xuthal of the Dusk', 'http://gutenberg.net.au/ebooks06/0601051h.html', '1934-01-01T00:00:00', 'The Slithering Shadow', 0, NULL, 'The desert shimmered in the heat waves. Conan the Cimmerian stared out over the aching desolation and involuntarily drew the back of his powerful hand over his blackened lips. He stood like a bronze image in the sand, apparently impervious to the murderous sun, though his only garment was a silk loin-cloth, girdled by a wide gold-buckled belt from which hung a saber and a broad-bladed poniard. On his clean-cut limbs were evidences of scarcely healed wounds. At his feet rested a girl, one white arm clasping his knee, against which her blond head drooped. Her white skin contrasted with his hard bronzed limbs; her short silken tunic, lownecked and sleeveless, girdled at the waist, emphasized rather than concealed her lithe figure. Conan shook his head, blinking. The sun\'s glare half blinded him. He lifted a small canteen from his belt and shook it, scowling at the faint splashing within.', 'Conan receives more attention than he needs in this wild adventure that nearly costs him his life. Who will win his love, and at what cost?');
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
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (35, 'The People of the Black Circle', 'http://gutenberg.net.au/ebooks06/0600941h.html', '1935-09-01T00:00:00', NULL, 0, NULL, 'The king of Vendhya was dying. Through the hot, stifling night the temple gongs boomed and the conchs roared. Their clamor was a faint echo in the gold-domed chamber where Bunda Chand struggled on the velvet-cushioned dais. Beads of sweat glistened on his dark skin; his fingers twisted the gold-worked fabric beneath him. He was young; no spear had touched him, no poison lurked in his wine. But his veins stood out like blue cords on his temples, and his eyes dilated with the nearness of death. Trembling slave-girls knelt at the foot of the dais, and leaning down to him, watching him with passionate intensity, was his sister, the Devi Yasmina. With her was the wazam, a noble grown old in the royal court. She threw up her head in a gusty gesture of wrath and despair as the thunder of the distant drums reached her ears. \"The priests and their clamor!\" she exclaimed. \"They are no wiser than the leeches who are helpless! Nay, he dies and none can say why. He is dying now—and I stand here helpless, who would burn the whole city and spill the blood of thousands to save him.\" \"Not a man of Ayodhya but would die in his place, if it might be, Devi,\" answered the wazam. \"This poison——\" \"I tell you it is not poison!\" she cried. \"Since his birth he has been guarded so closely that the cleverest poisoners of the East could not reach him. Five skulls bleaching on the Tower of the Kites can testify to attempts which were made—and which failed. As you well know, there are ten men and ten women whose sole duty is to taste his food and wine, and fifty armed warriors guard his chamber as they guard it now. No, it is not poison; it is sorcery—black, ghastly magic——\"', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (36, 'A Witch Shall Be Born', 'http://gutenberg.net.au/ebooks06/0600921h.html', '1934-12-01T00:00:00', NULL, 0, NULL, 'Taramis, Queen of Khauran, awakened from a dream-haunted slumber to a silence that seemed more like the stillness of nighted catacombs than the normal quiet of a sleeping palace. She lay staring into the darkness, wondering why the candles in their golden candelabra had gone out. A flecking of stars marked a gold-barred casement that lent no illumination to the interior of the chamber. But as Taramis lay there, she became aware of a spot of radiance glowing in the darkness before her. She watched, puzzled. It grew and its intensity deepened as it expanded, a widening disk of lurid light hovering against the dark velvet hangings of the opposite wall. Taramis caught her breath, starting up to a sitting position. A dark object was visible in that circle of light—a human head. In a sudden panic the queen opened her lips to cry out for her maids; then she checked herself. The glow was more lurid, the head more vividly limned. It was a woman\'s head, small, delicately molded, superbly poised, with a high-piled mass of lustrous black hair. The face grew distinct as she stared—and it was the sight of this face which froze the cry in Taramis\' throat. The features were her own! She might have been looking into a mirror which subtly altered her reflection, lending it a tigerish gleam of eye, a vindictive curl of lip. \"Ishtar!\" gasped Taramis. \"I am bewitched!\" Appallingly, the apparition spoke, and its voice was like honeyed venom. \"Bewitched? No, sweet sister! Here is no sorcery.\"', NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (37, 'The Children of the Night', 'http://gutenberg.net.au/ebooks06/0607961h.html', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (38, 'The Dark Man', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (39, 'The Little People', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (40, 'The Lost Race', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (41, 'Men of the Shadows', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (42, 'Worms of the Earth', 'http://gutenberg.net.au/ebooks06/0607861h.html', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (43, 'Beyond the Black River', 'http://gutenberg.net.au/ebooks06/0600741h.html', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (44, 'The Black Stranger', 'http://gutenberg.net.au/ebooks15/1501121h.html', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (45, 'The Man-Eaters of Zamboula', 'http://gutenberg.net.au/ebooks06/0600791h.html', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (46, 'Red Nails', 'http://gutenberg.net.au/ebooks06/0600771h.html', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `story` (`id`, `title`, `text_url`, `first_published`, `alternate_title`, `is_copyrighted`, `copyright_expires_at`, `excerpt`, `description`) VALUES (47, 'The Servants of Bit-Yakin', 'http://gutenberg.net.au/ebooks06/0600761h.html', NULL, NULL, NULL, NULL, NULL, NULL);
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
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (1, 'Am-ra the Ta-an', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (2, 'The King and the Oak', 'http://gutenberg.net.au/ebooks13/1303801h.html');
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (3, 'Summer Morn', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (4, 'Cimmeria', 'http://gutenberg.net.au/ebooks13/1303771h.html');
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (5, 'The One Black Stain', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (6, 'The Return of Sir Richard Grenville', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (7, 'Solomon Kane\'s Homecoming', 'http://gutenberg.net.au/ebooks13/1303871h.html');
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (8, 'A Song of the Race', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (9, 'The Drums of Pictdom', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (10, 'Untitled poem (There\'s a bell that hangs...)', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (11, 'A Thousand Years Ago', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (12, 'The Outgoing of Sigurd the Jerusalem-Farer', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (13, 'The Sign of the Sickle', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (14, 'Timur-lang', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (15, 'A Dull Sound as of Knocking', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (16, 'A Legend of Faring Town', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (17, 'A Song of the Werewolf Folk', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (18, 'An Open Window', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (19, 'Dead Man\'s Hate', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (20, 'The Dead Slaver\'s Tale', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (21, 'The Dweller in Dark Valley', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (22, 'The Fear that Follows', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (23, 'Fragment', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (24, 'Moon Mockery', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (25, 'The Moor Ghost', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (26, 'Musings', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (27, 'One Who Comes at Eventide', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (28, 'Remembrance', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (29, 'The Song of a Mad Minstrel', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (30, 'The Symbol', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (31, 'The Tavern', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (32, 'To a Woman', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (33, 'Up, John Kane!', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (34, 'Which Will Scarcely Be Understood', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (35, 'A Word From the Outer Dark', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (36, 'An Echo From the Iron Harp', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (37, 'The Dust Dance (version 1)', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (38, 'The Ghost Kings', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (39, 'Lines Written in the Realization That I Must Die', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (40, 'The Marching Song of Connacht', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (41, 'Recompense', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (42, 'The Song of the Last Briton', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (43, 'The Tide', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (44, 'Untitled (\"You have built a world of paper and wood...\")', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (45, 'A Song of the Naked Lands', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (46, 'Black Harps in the Hills', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (47, 'Echoes From an Anvil', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (48, 'Flint\'s Passing', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (49, 'The Grim Land', NULL);
INSERT INTO `poem` (`id`, `title`, `text_url`) VALUES (50, 'Never Beyond the Beast', NULL);

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


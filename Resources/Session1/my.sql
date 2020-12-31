CREATE TABLE IF NOT EXISTS `user_01`.`client` (
  `Id` INT NOT NULL,
  `Firstname` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  `Lastname` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  `Patronymic` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NULL DEFAULT NULL,
  `BirthDate` DATE NOT NULL,
  `PhoneNumber` VARCHAR(30) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NULL DEFAULT NULL,
  `Email` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NULL DEFAULT NULL,
  `AddedDate` DATE NULL DEFAULT NULL,
  `Photo` LONGBLOB NULL DEFAULT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `user_01`.`tag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user_01`.`tag` (
  `Id` INT NOT NULL,
  `Name` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  `Color` VARCHAR(7) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `user_01`.`clienttag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user_01`.`clienttag` (
  `Id` INT NOT NULL,
  `TagId` INT NOT NULL,
  `ClientId` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `FK_ClientTag_Tag` (`TagId` ASC) VISIBLE,
  INDEX `FK_ClientTag_Client` (`ClientId` ASC) VISIBLE,
  CONSTRAINT `FK_ClientTag_Client`
    FOREIGN KEY (`ClientId`)
    REFERENCES `user_01`.`client` (`Id`),
  CONSTRAINT `FK_ClientTag_Tag`
    FOREIGN KEY (`TagId`)
    REFERENCES `user_01`.`tag` (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `user_01`.`sysdiagrams`
-- -----------------------------------------------------


-- -----------------------------------------------------
-- Table `user_01`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user_01`.`user` (
  `Id` INT NOT NULL,
  `Login` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  `Password` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `user_01`.`visit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user_01`.`visit` (
  `Id` INT NOT NULL,
  `ClientId` INT NOT NULL,
  `Date` DATE NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `FK_Visit_Client` (`ClientId` ASC) VISIBLE,
  CONSTRAINT `FK_Visit_Client`
    FOREIGN KEY (`ClientId`)
    REFERENCES `user_01`.`client` (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


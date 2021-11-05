CREATE DATABASE IF NOT EXISTS Foody;

CREATE TABLE IF NOT EXISTS Categorie (
    CodeCateg INT NOT NULL AUTO_INCREMENT,
    NomCateg VARCHAR(15) NOT NULL,
    Descriptionn VARCHAR(255),
     CONSTRAINT `PK_Categories` PRIMARY KEY (CodeCateg)
   )ENGINE=InnoDB;

CREATE INDEX NomCateg ON `Categorie` (`NomCateg`);

CREATE TABLE IF NOT EXISTS `Client` (
    CodeCli VARCHAR(10) NOT NULL,
    Societe VARCHAR(45) NOT NULL,
    Contact VARCHAR(45) NOT NULL,
    Fonction VARCHAR(45) NOT NULL,
    Adresse VARCHAR(45),
    Ville VARCHAR(25) ,
    Region VARCHAR(25),
    Codepostal VARCHAR(10),
    Pays VARCHAR(25) ,
    Tel VARCHAR(25) ,
    Fax VARCHAR(25),
	CONSTRAINT `PK_Client` PRIMARY KEY (Codecli)
)ENGINE=InnoDB;

CREATE INDEX `Ville` ON `Client` (`Ville`);

CREATE INDEX `Societe` ON `Client` (`Societe`);

CREATE INDEX `Codepostal` ON `Client` (`Codepostal`);

CREATE INDEX `Region` ON `Client` (`Region`);

CREATE TABLE IF NOT EXISTS `Employe` (
    NoEmp INT NOT NULL AUTO_INCREMENT,
    Nom VARCHAR(50) NOT NULL,
    Prenom VARCHAR(50) NOT NULL,
    Fonction VARCHAR(50) ,
    TitreCourtoisie VARCHAR(50),
    DateNaissance DATETIME,
    DateEmbauche DATETIME ,
    Adresse VARCHAR(60),
    Ville VARCHAR(50),
    Region VARCHAR(50),
    Codepostal VARCHAR(50) ,
    Pays VARCHAR(50) ,
    TelDom VARCHAR(20) ,
    Extension VARCHAR(50),
    RendCompteA INT REFERENCES Employe(NoEmp),
    CONSTRAINT `PK_Employe` PRIMARY KEY (NoEmp)
)ENGINE=InnoDB;

CREATE INDEX `Nom` ON `Employe` (`Nom`);

CREATE INDEX `Codepostal` ON `Employe` (`Codepostal`);

CREATE TABLE IF NOT EXISTS DetailsCommande (
    NoCom INT NOT NULL,
    RefProd INT NOT NULL,
    PrixUnit DECIMAL(10,4) NOT NULL DEFAULT 0,
    Qte INT NOT NULL DEFAULT 1,
    Remise Double NOT NULL DEFAULT 0,
    CONSTRAINT `PK_DetailsCommande` PRIMARY KEY (NoCom , RefProd)
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Commande (
    NoCom INT NOT NULL AUTO_INCREMENT,
    CodeCli VARCHAR(10) ,
    NoEmp INT,
    DateCom DATETIME ,
    ALivAvant DATETIME,
    DateEnv DATETIME,
    NoMess INT ,
    Portt DECIMAL(10,4) DEFAULT 0,
    Destinataire VARCHAR(50) ,
    AdrLiv VARCHAR(50) ,
    VilleLiv VARCHAR(50) ,
    RegionLiv VARCHAR(50),
    CodePostalLiv VARCHAR(20),
    PaysLiv VARCHAR(25) ,
    PRIMARY KEY (NoCom)
)ENGINE=InnoDB;
CREATE INDEX `DateCom` ON `Commande` (`DateCom`);

CREATE INDEX `DateEnv` ON `Commande` (`DateEnv`);

CREATE INDEX `CodePostalLiv` ON `Commande` (`CodePostalLiv`);

CREATE TABLE IF NOT EXISTS Produit (
    RefProd INT NOT NULL AUTO_INCREMENT,
    NomProd VARCHAR(50) NOT NULL,
    NoFour INT ,
    CodeCateg INT,
    QteParUnit VARCHAR(20) ,
    PrixUnit DECIMAL(10,4) default 0,
    UnitesStock SMALLINT DEFAULT 0,
    UnitesCom SMALLINT DEFAULT 0,
    NiveauReap SMALLINT DEFAULT 0,
    Indisponible BIT NOT NULL default 0,
    CONSTRAINT `PK_Produit` PRIMARY KEY (RefProd)
)ENGINE=InnoDB;

CREATE INDEX `NomProd` ON `Produit` (`NomProd`);

CREATE TABLE IF NOT EXISTS Messager (
    NoMess INT NOT NULL AUTO_INCREMENT,
    NomMess VARCHAR(50) NOT NULL,
    Tel VARCHAR(20),
    CONSTRAINT `PK_Shippers` PRIMARY KEY (NoMess)
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Fournisseur (
    NoFour INT NOT NULL AUTO_INCREMENT,
    Societe VARCHAR(45) NOT NULL,
    Contact VARCHAR(45) ,
    Fonction VARCHAR(45) ,
    Adresse VARCHAR(255) ,
    Ville VARCHAR(45),
    Region VARCHAR(45),
    CodePostal VARCHAR(10) ,
    Pays VARCHAR(45) ,
    Tel VARCHAR(20) ,
    Fax VARCHAR(20),
    PageAccueil MEDIUMTEXT,
    CONSTRAINT `PK_Fournisseur` PRIMARY KEY (NoFour)
)ENGINE=InnoDB;

CREATE INDEX `Societe` ON `Fournisseur` (`Societe`);

CREATE INDEX `CodePostal` ON `Fournisseur` (`CodePostal`);

ALTER TABLE `Commande` ADD CONSTRAINT `Commande_fk0`
 FOREIGN KEY (`CodeCli`) REFERENCES `Client`(`Codecli`);
 
ALTER TABLE `Commande` ADD CONSTRAINT `Commande_fk1`
 FOREIGN KEY (`NoMess`) REFERENCES `Messager`(`NoMess`);
 
ALTER TABLE `Commande` ADD CONSTRAINT `Commande_fk2`
 FOREIGN KEY (`NoEmp`) REFERENCES `Employe`(`NoEmp`);
 
ALTER TABLE `DetailsCommande` ADD CONSTRAINT `DetailsCommande_fk0`
 FOREIGN KEY (`NoCom`) REFERENCES `Commande`(`NoCom`);
 
ALTER TABLE `DetailsCommande` ADD CONSTRAINT `DetailsCommande_fk1`
 FOREIGN KEY (`RefProd`) REFERENCES `Produit`(`RefProd`);
 
ALTER TABLE `Produit` ADD CONSTRAINT `Produit_fk0`
 FOREIGN KEY (`NoFour`) REFERENCES `Fournisseur`(`NoFour`);
 
ALTER TABLE `Produit` ADD CONSTRAINT `Produit_fk1`
 FOREIGN KEY (`CodeCateg`) REFERENCES `Categorie`(`CodeCateg`);
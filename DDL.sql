CREATE TABLE `Amenities` (
    `idAmenity` INT(11) NOT NULL AUTO_INCREMENT,
    `idProperty` INT(11) NOT NULL,
    `AmenityName` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`idAmenity` , `idProperty` , `AmenityName`),
    KEY `FK_Property_Amenity_idx` (`idProperty`),
    CONSTRAINT `FK_Property_Amenity` FOREIGN KEY (`idProperty`)
        REFERENCES `Property` (`idProperty`)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `AvailableBookingSlot` (
    `idProperty` INT(11) NOT NULL,
    `StartDate` DATE NOT NULL,
    `EndDate` DATE NOT NULL,
    PRIMARY KEY (`idProperty` , `StartDate` , `EndDate`),
    CONSTRAINT `FK_PropertyAvailability` FOREIGN KEY (`idProperty`)
        REFERENCES `Property` (`idProperty`)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `BankDetails` (
    `idBankDetails` INT(11) NOT NULL AUTO_INCREMENT,
    `IBAN` VARCHAR(24) DEFAULT NULL,
    `BIC` VARCHAR(11) DEFAULT NULL,
    `BankName` VARCHAR(100) NOT NULL,
    `createdDate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP (),
    `FK_idHost` INT(11) DEFAULT NULL,
    PRIMARY KEY (`idBankDetails`),
    KEY `FK_Host_idx` (`FK_idHost`),
    CONSTRAINT `FK_Host` FOREIGN KEY (`FK_idHost`)
        REFERENCES `Host` (`idHost`)
        ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE `Bedrooms` (
    `idProperty` INT(11) NOT NULL,
    `BedroomsAvailable` DECIMAL(2 , 1 ) NOT NULL,
    `BedType` VARCHAR(10) NOT NULL,
    `Beds` INT(11) NOT NULL,
    PRIMARY KEY (`idProperty` , `BedroomsAvailable` , `BedType` , `Beds`),
    CONSTRAINT `FK_Property_Beds` FOREIGN KEY (`idProperty`)
        REFERENCES `Property` (`idProperty`)
        ON DELETE CASCADE ON UPDATE NO ACTION
);

CREATE TABLE `Booking` (
    `idBooking` INT(11) NOT NULL AUTO_INCREMENT,
    `CheckInDate` DATE NOT NULL,
    `CheckOutDate` DATE NOT NULL,
    `AmountPaid` DECIMAL(6 , 2 ) DEFAULT NULL,
    `BookingDate` DATE NOT NULL,
    `ModifiedDate` DATE DEFAULT NULL,
    `SeniorGuests` INT(11) DEFAULT 0,
    `Adults` INT(11) DEFAULT 0,
    `Children` INT(11) DEFAULT 0,
    `IsCancelled` TINYINT(1) DEFAULT NULL,
    `RefundPaid` TINYINT(1) DEFAULT NULL,
    `CancelDate` DATE DEFAULT NULL,
    `PromoCode` VARCHAR(10) DEFAULT NULL,
    `idGuest` INT(11) DEFAULT NULL,
    `idProperty` INT(11) DEFAULT NULL,
    `TotalPrice` DECIMAL(6 , 2 ) DEFAULT NULL,
    `Tax` DECIMAL(4 , 2 ) DEFAULT NULL,
    `TotalPriceWithTax` DECIMAL(6 , 2 ) DEFAULT NULL,
    `AmountDue` DECIMAL(4 , 2 ) DEFAULT NULL,
    `RefundAmt` DECIMAL(4 , 2 ) DEFAULT NULL,
    `MinimumStay` INT(11) NOT NULL DEFAULT 1,
    PRIMARY KEY (`idBooking`),
    KEY `FK_GuestBooking_idx` (`idGuest`),
    KEY `FK_PropertyBooking_idx` (`idProperty`),
    KEY `FK_PromoBooking_idx` (`PromoCode`),
    CONSTRAINT `FK_GuestBooking` FOREIGN KEY (`idGuest`)
        REFERENCES `Guest` (`idGuest`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_PromoBooking` FOREIGN KEY (`PromoCode`)
        REFERENCES `Promo` (`Code`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_PropertyBooking` FOREIGN KEY (`idProperty`)
        REFERENCES `Property` (`idProperty`)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Category` (
    `idProperty` INT(11) NOT NULL,
    `CategoryName` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`idProperty` , `CategoryName`),
    CONSTRAINT `FK_Property` FOREIGN KEY (`idProperty`)
        REFERENCES `Property` (`idProperty`)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `CreditCard` (
    `idCreditCard` INT(11) NOT NULL AUTO_INCREMENT,
    `CreditCardType` VARCHAR(24) NOT NULL,
    `CardNumber` VARCHAR(25) DEFAULT NULL,
    `ExpMonth` SMALLINT(6) NOT NULL,
    `ExpYear` SMALLINT(6) NOT NULL,
    `LastModifiedDate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP (),
    `FK_Guest` INT(11) DEFAULT NULL,
    PRIMARY KEY (`idCreditCard`),
    KEY `FK_idGuest_idx` (`FK_Guest`),
    CONSTRAINT `FK_Guest` FOREIGN KEY (`FK_Guest`)
        REFERENCES `Guest` (`idGuest`)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `EmergencyContact` (
    `idEmergencyContact` INT(11) NOT NULL AUTO_INCREMENT,
    `EmergencyContactName` VARCHAR(20) DEFAULT NULL,
    `EmergencyContactRelationship` VARCHAR(20) DEFAULT NULL,
    `EmergencyContactPreferredLanguage` VARCHAR(15) DEFAULT NULL,
    `EmergencyContactEmail` VARCHAR(20) NOT NULL,
    `EmergencyContactCountryCode` VARCHAR(3) NOT NULL,
    `EmergencyContactPhone` VARCHAR(15) NOT NULL,
    PRIMARY KEY (`idEmergencyContact`)
);

CREATE TABLE `Guest` (
    `idGuest` INT(11) NOT NULL AUTO_INCREMENT,
    `AverageRating` DECIMAL(2 , 1 ) DEFAULT NULL,
    `NumberOfRatings` INT(11) DEFAULT 0,
    `idCreditCard` INT(11) NOT NULL,
    `GovernmentID` BLOB DEFAULT NULL,
    `YearsOnPlatform` INT(11) DEFAULT NULL,
    `VerifiedIdentity` TINYINT(4) NOT NULL,
    `CurrentResidence` VARCHAR(255) DEFAULT NULL,
    `SpokenLanguages` VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (`idGuest`),
    UNIQUE KEY `idCreditCard` (`idCreditCard`)
);

CREATE TABLE `Host` (
    `idHost` INT(11) NOT NULL AUTO_INCREMENT,
    `IsSuperHost` TINYINT(1) DEFAULT NULL,
    `Rating` DECIMAL(2 , 1 ) DEFAULT NULL,
    `NumberOfRatings` INT(11) DEFAULT NULL,
    `idBankDetails` INT(11) NOT NULL,
    `createdDate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP (),
    `YearsHosting` INT(11) DEFAULT NULL,
    `SpokenLanguages` VARCHAR(300) DEFAULT NULL,
    PRIMARY KEY (`idHost`),
    UNIQUE KEY `idBankDetails` (`idBankDetails`)
);

CREATE TABLE `HouseRule` (
    `idRule` INT(11) DEFAULT NULL,
    `idProperty` INT(11) NOT NULL,
    `RuleName` VARCHAR(50) NOT NULL,
    `RuleDetails` VARCHAR(1000) DEFAULT NULL,
    PRIMARY KEY (`idProperty` , `RuleName`),
    CONSTRAINT `FK_Property_rule` FOREIGN KEY (`idProperty`)
        REFERENCES `Property` (`idProperty`)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Message` (
    `idMessage` INT(11) DEFAULT NULL,
    `idHost` INT(11) NOT NULL,
    `idGuest` INT(11) NOT NULL,
    `Created` DATE NOT NULL,
    `Message_To` INT(11) NOT NULL,
    `Message_From` INT(11) NOT NULL,
    `Message` VARCHAR(1000) DEFAULT NULL,
    PRIMARY KEY (`idHost` , `idGuest`),
    KEY `FK_Message_Guest` (`idGuest`),
    KEY `FK_Message_Host_idx` (`idHost`),
    CONSTRAINT `FK_Message_Guest` FOREIGN KEY (`idGuest`)
        REFERENCES `Guest` (`idGuest`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_Message_Host` FOREIGN KEY (`idHost`)
        REFERENCES `Host` (`idHost`)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Promo` (
    `idPromo` INT(11) DEFAULT NULL,
    `Code` VARCHAR(10) NOT NULL,
    `Discount_Amt` DECIMAL(19 , 2 ) NOT NULL,
    PRIMARY KEY (`Code`)
);

CREATE TABLE `Property` (
    `idProperty` INT(11) NOT NULL AUTO_INCREMENT,
    `PropertyName` VARCHAR(100) DEFAULT NULL,
    `PropertyDescription` VARCHAR(500) DEFAULT NULL,
    `PostCode` INT(11) NOT NULL,
    `Bathrooms` INT(11) DEFAULT NULL,
    `Bedrooms` INT(11) DEFAULT 0,
    `MaxGuestsAllowed` INT(11) DEFAULT NULL,
    `PricePerNight` DECIMAL(6 , 2 ) DEFAULT NULL,
    `CleaningFee` DECIMAL(4 , 2 ) DEFAULT NULL,
    `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP (),
    `CheckInTime` TIMESTAMP NULL DEFAULT NULL,
    `CheckOutTime` TIMESTAMP NULL DEFAULT NULL,
    `IsRefundable` TINYINT(1) DEFAULT NULL,
    `CancellationPeriod` INT(11) DEFAULT NULL,
    `CancellationType` VARCHAR(10) DEFAULT NULL,
    `RefundRate` DECIMAL(2 , 1 ) DEFAULT NULL,
    `NumOfRatings` INT(11) DEFAULT 0,
    `AverageRatings` DECIMAL(2 , 1 ) DEFAULT 0.0,
    `idHost` INT(11) NOT NULL,
    `Street` VARCHAR(20) DEFAULT NULL,
    `StreetNo` VARCHAR(5) DEFAULT NULL,
    `City` VARCHAR(50) DEFAULT NULL,
    `Country` VARCHAR(20) DEFAULT NULL,
    `TaxRate` DECIMAL(2 , 1 ) DEFAULT NULL,
    PRIMARY KEY (`idProperty`),
    KEY `FK_PropertyHost_idx` (`idHost`),
    CONSTRAINT `FK_PropertyHost` FOREIGN KEY (`idHost`)
        REFERENCES `Host` (`idHost`)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `PropertyOnWishlist` (
    `idProperty` INT(11) NOT NULL,
    `idGuest` INT(11) NOT NULL,
    `WishlistName` VARCHAR(50) NOT NULL,
    `CheckInDate` DATE DEFAULT NULL,
    `CheckOutDate` DATE DEFAULT NULL,
    PRIMARY KEY (`idProperty` , `idGuest` , `WishlistName`),
    KEY `FK_WishName_idx` (`WishlistName`),
    KEY `FK_UserWishProperty_idx` (`idGuest`),
    CONSTRAINT `FK_PropertyWhishlist` FOREIGN KEY (`idProperty`)
        REFERENCES `Property` (`idProperty`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_UserWishProperty` FOREIGN KEY (`idGuest`)
        REFERENCES `Guest` (`idGuest`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_WishName` FOREIGN KEY (`WishlistName`)
        REFERENCES `Wishlist` (`WishlistName`)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `PropertyPhoto` (
    `idPhoto` INT(11) NOT NULL AUTO_INCREMENT,
    `idProperty` INT(11) NOT NULL,
    `PropertyName` VARCHAR(100) NOT NULL,
    `ImageFile` BLOB NOT NULL,
    PRIMARY KEY (`idPhoto` , `idProperty` , `PropertyName`),
    KEY `FK_PropertyPhotos_idx` (`idProperty`),
    CONSTRAINT `FK_PropertyPhotos` FOREIGN KEY (`idProperty`)
        REFERENCES `Property` (`idProperty`)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `PropertyReview` (
    `idPropertyReview` INT(11) NOT NULL AUTO_INCREMENT,
    `idProperty` INT(11) NOT NULL,
    `idGuest` INT(11) NOT NULL,
    `Created_Time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP (),
    `Modified_Time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP () ON UPDATE CURRENT_TIMESTAMP (),
    `CommentInReview` VARCHAR(1000) DEFAULT NULL,
    `Cleanliness_Rating` DECIMAL(2 , 1 ) DEFAULT NULL,
    `Communication_Rating` DECIMAL(2 , 1 ) DEFAULT NULL,
    `CheckIn_Rating` DECIMAL(2 , 1 ) DEFAULT NULL,
    `Accuracy_Rating` DECIMAL(2 , 1 ) DEFAULT NULL,
    `Location_Rating` DECIMAL(2 , 1 ) DEFAULT NULL,
    `Value_Rating` DECIMAL(2 , 1 ) DEFAULT NULL,
    `Overall_Rating` DECIMAL(2 , 1 ) DEFAULT NULL,
    PRIMARY KEY (`idPropertyReview` , `idGuest` , `idProperty`),
    KEY `FK_GuestReviewing` (`idGuest`),
    KEY `FK_PropertyReviewed` (`idProperty`),
    CONSTRAINT `FK_GuestReviewing` FOREIGN KEY (`idGuest`)
        REFERENCES `Guest` (`idGuest`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `FK_PropertyReviewed` FOREIGN KEY (`idProperty`)
        REFERENCES `Property` (`idProperty`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `PropertyReviewPhoto` (
    `idGuest` INT(11) NOT NULL,
    `idProperty` INT(11) NOT NULL,
    `PhotoTitle` VARCHAR(50) NOT NULL,
    `ImageFile` BLOB NOT NULL,
    PRIMARY KEY (`idGuest` , `idProperty` , `PhotoTitle`),
    KEY `FK_PropertyReviewPhoto_idx` (`idProperty`),
    CONSTRAINT `FK_GuestPropertyPhoto` FOREIGN KEY (`idGuest`)
        REFERENCES `Guest` (`idGuest`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_PropertyReviewPhoto` FOREIGN KEY (`idProperty`)
        REFERENCES `Property` (`idProperty`)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `User` (
    `idUser` INT(11) NOT NULL AUTO_INCREMENT,
    `DateOfBirth` DATE DEFAULT NULL,
    `Email` VARCHAR(20) NOT NULL,
    `UserPassword` VARCHAR(20) NOT NULL,
    `Gender` CHAR(1) DEFAULT NULL,
    `About` VARCHAR(255) DEFAULT NULL,
    `Phone` VARCHAR(15) NOT NULL,
    `ProfilePhotoName` VARCHAR(20) DEFAULT NULL,
    `ProfilePhoto` BLOB DEFAULT NULL,
    `Address` VARCHAR(100) DEFAULT NULL,
    `FirstName` VARCHAR(20) NOT NULL,
    `LastName` VARCHAR(20) DEFAULT NULL,
    `CreatedDate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP (),
    `LastLogin` TIMESTAMP NULL DEFAULT NULL,
    `idEmergencyContact` INT(11) DEFAULT NULL,
    `idGuest` INT(11) DEFAULT NULL,
    `idHost` INT(11) DEFAULT NULL,
    PRIMARY KEY (`idUser`),
    KEY `Guest_idx` (`idGuest`),
    KEY `Host_idx` (`idHost`),
    KEY `EmergencyContact_idx` (`idEmergencyContact`),
    CONSTRAINT `FK_EmergencyContact` FOREIGN KEY (`idEmergencyContact`)
        REFERENCES `EmergencyContact` (`idEmergencyContact`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_TypeGuest` FOREIGN KEY (`idGuest`)
        REFERENCES `Guest` (`idGuest`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_TypeHost` FOREIGN KEY (`idHost`)
        REFERENCES `Host` (`idHost`)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `UserReview` (
    `idUserReview` INT(11) DEFAULT NULL,
    `idHost` INT(11) NOT NULL,
    `idGuest` INT(11) NOT NULL,
    `GuestRating` DECIMAL(2 , 1 ) DEFAULT NULL,
    `HostRating` DECIMAL(2 , 1 ) DEFAULT NULL,
    `CommentForHost` VARCHAR(1000) DEFAULT NULL,
    `CommentForGuest` VARCHAR(1000) DEFAULT NULL,
    `HostReviewCreated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP (),
    `GuestReviewCreated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP (),
    `HostReviewModified` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP () ON UPDATE CURRENT_TIMESTAMP (),
    `GuestReviewModified` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP () ON UPDATE CURRENT_TIMESTAMP (),
    PRIMARY KEY (`idHost` , `idGuest`),
    KEY `FK_GuestReview_idx` (`idGuest`),
    CONSTRAINT `FK_GuestReview` FOREIGN KEY (`idGuest`)
        REFERENCES `Guest` (`idGuest`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_HostReview` FOREIGN KEY (`idHost`)
        REFERENCES `Host` (`idHost`)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Wishlist` (
    `idWishlist` INT(11) NOT NULL AUTO_INCREMENT,
    `idGuest` INT(11) NOT NULL,
    `WishlistName` VARCHAR(50) NOT NULL,
    `Privacy` TINYINT(1) DEFAULT NULL,
    PRIMARY KEY (`idWishlist` , `idGuest` , `WishlistName`),
    UNIQUE KEY `WishlistName` (`WishlistName`),
    KEY `FK_UserWishlist_idx` (`idGuest`),
    CONSTRAINT `FK_UserWishlist` FOREIGN KEY (`idGuest`)
        REFERENCES `Guest` (`idGuest`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

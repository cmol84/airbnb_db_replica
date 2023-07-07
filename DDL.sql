CREATE TABLE `Amenities` (
  `idAmenity` int(11) NOT NULL AUTO_INCREMENT,
  `idProperty` int(11) NOT NULL,
  `AmenityName` varchar(255) NOT NULL,
  PRIMARY KEY (`idAmenity`,`idProperty`,`AmenityName`),
  KEY `FK_Property_Amenity_idx` (`idProperty`),
  CONSTRAINT `FK_Property_Amenity` FOREIGN KEY (`idProperty`) REFERENCES `Property` (`idProperty`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `AvailableBookingSlot` (
  `idProperty` int(11) NOT NULL,
  `StartDate` date NOT NULL,
  `EndDate` date NOT NULL,
  PRIMARY KEY (`idProperty`,`StartDate`,`EndDate`),
  CONSTRAINT `FK_PropertyAvailability` FOREIGN KEY (`idProperty`) REFERENCES `Property` (`idProperty`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `BankDetails` (
  `idBankDetails` int(11) NOT NULL AUTO_INCREMENT,
  `IBAN` varchar(24) DEFAULT NULL,
  `BIC` varchar(11) DEFAULT NULL,
  `BankName` varchar(100) NOT NULL,
  `createdDate` timestamp NULL DEFAULT current_timestamp(),
  `FK_idHost` int(11) DEFAULT NULL,
  PRIMARY KEY (`idBankDetails`),
  KEY `FK_Host_idx` (`FK_idHost`),
  CONSTRAINT `FK_Host` FOREIGN KEY (`FK_idHost`) REFERENCES `Host` (`idHost`) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE `Bedrooms` (
  `idProperty` int(11) NOT NULL,
  `BedroomsAvailable` decimal(2,1) NOT NULL,
  `BedType` varchar(10) NOT NULL,
  `Beds` int(11) NOT NULL,
  PRIMARY KEY (`idProperty`,`BedroomsAvailable`,`BedType`,`Beds`),
  CONSTRAINT `FK_Property_Beds` FOREIGN KEY (`idProperty`) REFERENCES `Property` (`idProperty`) ON DELETE CASCADE ON UPDATE NO ACTION
);

CREATE TABLE `Booking` (
  `idBooking` int(11) NOT NULL AUTO_INCREMENT,
  `CheckInDate` date NOT NULL,
  `CheckOutDate` date NOT NULL,
  `AmountPaid` decimal(6,2) DEFAULT NULL,
  `BookingDate` date NOT NULL,
  `ModifiedDate` date DEFAULT NULL,
  `SeniorGuests` int(11) DEFAULT 0,
  `Adults` int(11) DEFAULT 0,
  `Children` int(11) DEFAULT 0,
  `IsCancelled` tinyint(1) DEFAULT NULL,
  `RefundPaid` tinyint(1) DEFAULT NULL,
  `CancelDate` date DEFAULT NULL,
  `PromoCode` varchar(10) DEFAULT NULL,
  `idGuest` int(11) DEFAULT NULL,
  `idProperty` int(11) DEFAULT NULL,
  `TotalPrice` decimal(6,2) DEFAULT NULL,
  `Tax` decimal(4,2) DEFAULT NULL,
  `TotalPriceWithTax` decimal(6,2) DEFAULT NULL,
  `AmountDue` decimal(4,2) DEFAULT NULL,
  `RefundAmt` decimal(4,2) DEFAULT NULL,
  `MinimumStay` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idBooking`),
  KEY `FK_GuestBooking_idx` (`idGuest`),
  KEY `FK_PropertyBooking_idx` (`idProperty`),
  KEY `FK_PromoBooking_idx` (`PromoCode`),
  CONSTRAINT `FK_GuestBooking` FOREIGN KEY (`idGuest`) REFERENCES `Guest` (`idGuest`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_PromoBooking` FOREIGN KEY (`PromoCode`) REFERENCES `Promo` (`Code`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_PropertyBooking` FOREIGN KEY (`idProperty`) REFERENCES `Property` (`idProperty`) ON DELETE CASCADE ON UPDATE CASCADE
) ;

CREATE TABLE `Category` (
  `idProperty` int(11) NOT NULL,
  `CategoryName` varchar(100) NOT NULL,
  PRIMARY KEY (`idProperty`,`CategoryName`),
  CONSTRAINT `FK_Property` FOREIGN KEY (`idProperty`) REFERENCES `Property` (`idProperty`) ON DELETE CASCADE ON UPDATE CASCADE
) ;

CREATE TABLE `CreditCard` (
  `idCreditCard` int(11) NOT NULL AUTO_INCREMENT,
  `CreditCardType` varchar(24) NOT NULL,
  `CardNumber` varchar(25) DEFAULT NULL,
  `ExpMonth` smallint(6) NOT NULL,
  `ExpYear` smallint(6) NOT NULL,
  `LastModifiedDate` timestamp NULL DEFAULT current_timestamp(),
  `FK_Guest` int(11) DEFAULT NULL,
  PRIMARY KEY (`idCreditCard`),
  KEY `FK_idGuest_idx` (`FK_Guest`),
  CONSTRAINT `FK_Guest` FOREIGN KEY (`FK_Guest`) REFERENCES `Guest` (`idGuest`) ON DELETE CASCADE ON UPDATE CASCADE
) ;

CREATE TABLE `EmergencyContact` (
  `idEmergencyContact` int(11) NOT NULL AUTO_INCREMENT,
  `EmergencyContactName` varchar(20) DEFAULT NULL,
  `EmergencyContactRelationship` varchar(20) DEFAULT NULL,
  `EmergencyContactPreferredLanguage` varchar(15) DEFAULT NULL,
  `EmergencyContactEmail` varchar(20) NOT NULL,
  `EmergencyContactCountryCode` varchar(3) NOT NULL,
  `EmergencyContactPhone` varchar(15) NOT NULL,
  PRIMARY KEY (`idEmergencyContact`)
) ;

CREATE TABLE `Guest` (
  `idGuest` int(11) NOT NULL AUTO_INCREMENT,
  `AverageRating` decimal(2,1) DEFAULT NULL,
  `NumberOfRatings` int(11) DEFAULT 0,
  `idCreditCard` int(11) NOT NULL,
  `GovernmentID` blob DEFAULT NULL,
  `YearsOnPlatform` int(11) DEFAULT NULL,
  `VerifiedIdentity` tinyint(4) NOT NULL,
  `CurrentResidence` varchar(255) DEFAULT NULL,
  `SpokenLanguages` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idGuest`),
  UNIQUE KEY `idCreditCard` (`idCreditCard`)
) ;

CREATE TABLE `Host` (
  `idHost` int(11) NOT NULL AUTO_INCREMENT,
  `IsSuperHost` tinyint(1) DEFAULT NULL,
  `Rating` decimal(2,1) DEFAULT NULL,
  `NumberOfRatings` int(11) DEFAULT NULL,
  `idBankDetails` int(11) NOT NULL,
  `createdDate` timestamp NULL DEFAULT current_timestamp(),
  `YearsHosting` int(11) DEFAULT NULL,
  `SpokenLanguages` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`idHost`),
  UNIQUE KEY `idBankDetails` (`idBankDetails`)
) ;

CREATE TABLE `HouseRule` (
  `idRule` int(11) DEFAULT NULL,
  `idProperty` int(11) NOT NULL,
  `RuleName` varchar(50) NOT NULL,
  `RuleDetails` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`idProperty`,`RuleName`),
  CONSTRAINT `FK_Property_rule` FOREIGN KEY (`idProperty`) REFERENCES `Property` (`idProperty`) ON DELETE CASCADE ON UPDATE CASCADE
) ;

CREATE TABLE `Message` (
  `idMessage` int(11) DEFAULT NULL,
  `idHost` int(11) NOT NULL,
  `idGuest` int(11) NOT NULL,
  `Created` date NOT NULL,
  `Message_To` int(11) NOT NULL,
  `Message_From` int(11) NOT NULL,
  `Message` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`idHost`,`idGuest`),
  KEY `FK_Message_Guest` (`idGuest`),
  KEY `FK_Message_Host_idx` (`idHost`),
  CONSTRAINT `FK_Message_Guest` FOREIGN KEY (`idGuest`) REFERENCES `Guest` (`idGuest`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Message_Host` FOREIGN KEY (`idHost`) REFERENCES `Host` (`idHost`) ON DELETE CASCADE ON UPDATE CASCADE
) ;

CREATE TABLE `Promo` (
  `idPromo` int(11) DEFAULT NULL,
  `Code` varchar(10) NOT NULL,
  `Discount_Amt` decimal(19,2) NOT NULL,
  PRIMARY KEY (`Code`)
) ;

CREATE TABLE `Property` (
  `idProperty` int(11) NOT NULL AUTO_INCREMENT,
  `PropertyName` varchar(100) DEFAULT NULL,
  `PropertyDescription` varchar(500) DEFAULT NULL,
  `PostCode` int(11) NOT NULL,
  `Bathrooms` int(11) DEFAULT NULL,
  `Bedrooms` int(11) DEFAULT 0,
  `MaxGuestsAllowed` int(11) DEFAULT NULL,
  `PricePerNight` decimal(6,2) DEFAULT NULL,
  `CleaningFee` decimal(4,2) DEFAULT NULL,
  `Created` datetime NOT NULL DEFAULT current_timestamp(),
  `CheckInTime` timestamp NULL DEFAULT NULL,
  `CheckOutTime` timestamp NULL DEFAULT NULL,
  `IsRefundable` tinyint(1) DEFAULT NULL,
  `CancellationPeriod` int(11) DEFAULT NULL,
  `CancellationType` varchar(10) DEFAULT NULL,
  `RefundRate` decimal(2,1) DEFAULT NULL,
  `NumOfRatings` int(11) DEFAULT 0,
  `AverageRatings` decimal(2,1) DEFAULT 0.0,
  `idHost` int(11) NOT NULL,
  `Street` varchar(20) DEFAULT NULL,
  `StreetNo` varchar(5) DEFAULT NULL,
  `City` varchar(50) DEFAULT NULL,
  `Country` varchar(20) DEFAULT NULL,
  `TaxRate` decimal(2,1) DEFAULT NULL,
  PRIMARY KEY (`idProperty`),
  KEY `FK_PropertyHost_idx` (`idHost`),
  CONSTRAINT `FK_PropertyHost` FOREIGN KEY (`idHost`) REFERENCES `Host` (`idHost`) ON DELETE CASCADE ON UPDATE CASCADE
) ;

CREATE TABLE `PropertyOnWishlist` (
  `idProperty` int(11) NOT NULL,
  `idGuest` int(11) NOT NULL,
  `WishlistName` varchar(50) NOT NULL,
  `CheckInDate` date DEFAULT NULL,
  `CheckOutDate` date DEFAULT NULL,
  PRIMARY KEY (`idProperty`,`idGuest`,`WishlistName`),
  KEY `FK_WishName_idx` (`WishlistName`),
  KEY `FK_UserWishProperty_idx` (`idGuest`),
  CONSTRAINT `FK_PropertyWhishlist` FOREIGN KEY (`idProperty`) REFERENCES `Property` (`idProperty`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_UserWishProperty` FOREIGN KEY (`idGuest`) REFERENCES `Guest` (`idGuest`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_WishName` FOREIGN KEY (`WishlistName`) REFERENCES `Wishlist` (`WishlistName`) ON DELETE CASCADE ON UPDATE CASCADE
) ;

CREATE TABLE `PropertyPhoto` (
  `idPhoto` int(11) NOT NULL AUTO_INCREMENT,
  `idProperty` int(11) NOT NULL,
  `PropertyName` varchar(100) NOT NULL,
  `ImageFile` blob NOT NULL,
  PRIMARY KEY (`idPhoto`,`idProperty`,`PropertyName`),
  KEY `FK_PropertyPhotos_idx` (`idProperty`),
  CONSTRAINT `FK_PropertyPhotos` FOREIGN KEY (`idProperty`) REFERENCES `Property` (`idProperty`) ON DELETE CASCADE ON UPDATE CASCADE
) ;

CREATE TABLE `PropertyReview` (
  `idPropertyReview` int(11) NOT NULL AUTO_INCREMENT,
  `idProperty` int(11) NOT NULL,
  `idGuest` int(11) NOT NULL,
  `Created_Time` timestamp NOT NULL DEFAULT current_timestamp(),
  `Modified_Time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `CommentInReview` varchar(1000) DEFAULT NULL,
  `Cleanliness_Rating` decimal(2,1) DEFAULT NULL,
  `Communication_Rating` decimal(2,1) DEFAULT NULL,
  `CheckIn_Rating` decimal(2,1) DEFAULT NULL,
  `Accuracy_Rating` decimal(2,1) DEFAULT NULL,
  `Location_Rating` decimal(2,1) DEFAULT NULL,
  `Value_Rating` decimal(2,1) DEFAULT NULL,
  `Overall_Rating` decimal(2,1) DEFAULT NULL,
  PRIMARY KEY (`idPropertyReview`,`idGuest`,`idProperty`),
  KEY `FK_GuestReviewing` (`idGuest`),
  KEY `FK_PropertyReviewed` (`idProperty`),
  CONSTRAINT `FK_GuestReviewing` FOREIGN KEY (`idGuest`) REFERENCES `Guest` (`idGuest`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_PropertyReviewed` FOREIGN KEY (`idProperty`) REFERENCES `Property` (`idProperty`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ;

CREATE TABLE `PropertyReviewPhoto` (
  `idGuest` int(11) NOT NULL,
  `idProperty` int(11) NOT NULL,
  `PhotoTitle` varchar(50) NOT NULL,
  `ImageFile` blob NOT NULL,
  PRIMARY KEY (`idGuest`,`idProperty`,`PhotoTitle`),
  KEY `FK_PropertyReviewPhoto_idx` (`idProperty`),
  CONSTRAINT `FK_GuestPropertyPhoto` FOREIGN KEY (`idGuest`) REFERENCES `Guest` (`idGuest`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_PropertyReviewPhoto` FOREIGN KEY (`idProperty`) REFERENCES `Property` (`idProperty`) ON DELETE CASCADE ON UPDATE CASCADE
) ;

CREATE TABLE `User` (
  `idUser` int(11) NOT NULL AUTO_INCREMENT,
  `DateOfBirth` date DEFAULT NULL,
  `Email` varchar(20) NOT NULL,
  `UserPassword` varchar(20) NOT NULL,
  `Gender` char(1) DEFAULT NULL,
  `About` varchar(255) DEFAULT NULL,
  `Phone` varchar(15) NOT NULL,
  `ProfilePhotoName` varchar(20) DEFAULT NULL,
  `ProfilePhoto` blob DEFAULT NULL,
  `Address` varchar(100) DEFAULT NULL,
  `FirstName` varchar(20) NOT NULL,
  `LastName` varchar(20) DEFAULT NULL,
  `CreatedDate` timestamp NULL DEFAULT current_timestamp(),
  `LastLogin` timestamp NULL DEFAULT NULL,
  `idEmergencyContact` int(11) DEFAULT NULL,
  `idGuest` int(11) DEFAULT NULL,
  `idHost` int(11) DEFAULT NULL,
  PRIMARY KEY (`idUser`),
  KEY `Guest_idx` (`idGuest`),
  KEY `Host_idx` (`idHost`),
  KEY `EmergencyContact_idx` (`idEmergencyContact`),
  CONSTRAINT `FK_EmergencyContact` FOREIGN KEY (`idEmergencyContact`) REFERENCES `EmergencyContact` (`idEmergencyContact`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TypeGuest` FOREIGN KEY (`idGuest`) REFERENCES `Guest` (`idGuest`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TypeHost` FOREIGN KEY (`idHost`) REFERENCES `Host` (`idHost`) ON DELETE CASCADE ON UPDATE CASCADE
) ;

CREATE TABLE `UserReview` (
  `idUserReview` int(11) DEFAULT NULL,
  `idHost` int(11) NOT NULL,
  `idGuest` int(11) NOT NULL,
  `GuestRating` decimal(2,1) DEFAULT NULL,
  `HostRating` decimal(2,1) DEFAULT NULL,
  `CommentForHost` varchar(1000) DEFAULT NULL,
  `CommentForGuest` varchar(1000) DEFAULT NULL,
  `HostReviewCreated` timestamp NOT NULL DEFAULT current_timestamp(),
  `GuestReviewCreated` timestamp NOT NULL DEFAULT current_timestamp(),
  `HostReviewModified` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `GuestReviewModified` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`idHost`,`idGuest`),
  KEY `FK_GuestReview_idx` (`idGuest`),
  CONSTRAINT `FK_GuestReview` FOREIGN KEY (`idGuest`) REFERENCES `Guest` (`idGuest`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_HostReview` FOREIGN KEY (`idHost`) REFERENCES `Host` (`idHost`) ON DELETE CASCADE ON UPDATE CASCADE
) ;

CREATE TABLE `Wishlist` (
  `idWishlist` int(11) NOT NULL AUTO_INCREMENT,
  `idGuest` int(11) NOT NULL,
  `WishlistName` varchar(50) NOT NULL,
  `Privacy` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idWishlist`,`idGuest`,`WishlistName`),
  UNIQUE KEY `WishlistName` (`WishlistName`),
  KEY `FK_UserWishlist_idx` (`idGuest`),
  CONSTRAINT `FK_UserWishlist` FOREIGN KEY (`idGuest`) REFERENCES `Guest` (`idGuest`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ;

CREATE TABLE `Amenities` (
  `idAmenity` int(11) NOT NULL AUTO_INCREMENT,
  `idProperty` int(11) NOT NULL,
  `AmenityName` varchar(255) NOT NULL,
  PRIMARY KEY (`idAmenity`,`idProperty`,`AmenityName`),
  KEY `FK_Property_Amenity_idx` (`idProperty`),
  CONSTRAINT `FK_Property_Amenity` FOREIGN KEY (`idProperty`) REFERENCES `Property` (`idProperty`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `AvailableBookingSlot` (
  `idProperty` int(11) NOT NULL,
  `StartDate` date NOT NULL,
  `EndDate` date NOT NULL,
  PRIMARY KEY (`idProperty`,`StartDate`,`EndDate`),
  CONSTRAINT `FK_PropertyAvailability` FOREIGN KEY (`idProperty`) REFERENCES `Property` (`idProperty`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `BankDetails` (
  `idBankDetails` int(11) NOT NULL AUTO_INCREMENT,
  `IBAN` varchar(24) DEFAULT NULL,
  `BIC` varchar(11) DEFAULT NULL,
  `BankName` varchar(100) NOT NULL,
  `createdDate` timestamp NULL DEFAULT current_timestamp(),
  `FK_idHost` int(11) DEFAULT NULL,
  PRIMARY KEY (`idBankDetails`),
  KEY `FK_Host_idx` (`FK_idHost`),
  CONSTRAINT `FK_idHost` FOREIGN KEY (`FK_idHost`) REFERENCES `Host` (`idHost`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `Bedrooms` (
  `idProperty` int(11) NOT NULL,
  `BedroomsAvailable` decimal(6,1) NOT NULL,
  `BedType` varchar(100) NOT NULL,
  `Beds` int(11) NOT NULL,
  PRIMARY KEY (`idProperty`,`BedroomsAvailable`,`BedType`,`Beds`),
  CONSTRAINT `FK_Property_Beds` FOREIGN KEY (`idProperty`) REFERENCES `Property` (`idProperty`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

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
  `idPromo` int(11) DEFAULT NULL,
  `idGuest` int(11) DEFAULT NULL,
  `idProperty` int(11) DEFAULT NULL,
  `TotalPrice` decimal(6,2) DEFAULT NULL,
  `Tax` decimal(4,2) DEFAULT NULL,
  `TotalPriceWithTax` decimal(6,2) DEFAULT NULL,
  `AmountDue` decimal(6,2) DEFAULT NULL,
  `RefundAmt` decimal(6,2) DEFAULT NULL,
  `MinimumStay` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idBooking`),
  KEY `FK_GuestBooking_idx` (`idGuest`),
  KEY `FK_PromoBooking_idx` (`idPromo`),
  KEY `FK_PropertyBooking_idx` (`idProperty`),
  CONSTRAINT `FK_GuestBooking` FOREIGN KEY (`idGuest`) REFERENCES `Guest` (`idGuest`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_PromoBooking` FOREIGN KEY (`idPromo`) REFERENCES `Promo` (`idPromo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_PropertyBooking` FOREIGN KEY (`idProperty`) REFERENCES `Property` (`idProperty`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `Category` (
  `idCategory` int(11) NOT NULL AUTO_INCREMENT,
  `CategoryName` varchar(100) NOT NULL,
  PRIMARY KEY (`idCategory`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `CreditCard` (
  `idCreditCard` int(11) NOT NULL AUTO_INCREMENT,
  `CreditCardType` varchar(100) NOT NULL,
  `CardNumber` varchar(25) NOT NULL,
  `CardHolderName` varchar(55) NOT NULL,
  `ExpiryDate` varchar(5) NOT NULL,
  `SecCode` varchar(5) NOT NULL,
  `LastModifiedDate` timestamp NULL DEFAULT current_timestamp(),
  `FK_Guest` int(11) DEFAULT NULL,
  PRIMARY KEY (`idCreditCard`),
  KEY `FK_cc_guest_idx` (`FK_Guest`),
  CONSTRAINT `FK_cc_guest` FOREIGN KEY (`FK_Guest`) REFERENCES `Guest` (`idGuest`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `EmergencyContact` (
  `idEmergencyContact` int(11) NOT NULL AUTO_INCREMENT,
  `EmergencyContactName` varchar(50) DEFAULT NULL,
  `EmergencyContactRelationship` varchar(20) DEFAULT NULL,
  `EmergencyContactPreferredLanguage` varchar(100) DEFAULT NULL,
  `EmergencyContactEmail` varchar(200) NOT NULL,
  `EmergencyContactCountry` varchar(100) NOT NULL,
  `EmergencyContactPhone` varchar(25) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  PRIMARY KEY (`idEmergencyContact`),
  KEY `FK_user_idx` (`id_user`),
  CONSTRAINT `FK_user` FOREIGN KEY (`id_user`) REFERENCES `User` (`idUser`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `Guest` (
  `idGuest` int(11) NOT NULL AUTO_INCREMENT,
  `idUser` int(11) NOT NULL,
  `AverageRating` decimal(2,1) DEFAULT NULL,
  `NumberOfRatings` int(11) DEFAULT 0,
  `idCreditCard` int(11) NOT NULL,
  `GovernmentID` blob DEFAULT NULL,
  `YearsOnPlatform` int(11) DEFAULT NULL,
  `VerifiedIdentity` tinyint(4) NOT NULL,
  `CurrentResidence` varchar(255) DEFAULT NULL,
  `SpokenLanguages` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idGuest`),
  UNIQUE KEY `idCreditCard` (`idCreditCard`),
  KEY `FK_guest_user_idx` (`idUser`),
  CONSTRAINT `FK_guest_user` FOREIGN KEY (`idUser`) REFERENCES `User` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `Host` (
  `idHost` int(11) NOT NULL AUTO_INCREMENT,
  `idUser` int(11) NOT NULL,
  `IsSuperHost` tinyint(1) DEFAULT NULL,
  `Rating` decimal(2,1) DEFAULT NULL,
  `NumberOfRatings` int(11) DEFAULT NULL,
  `idBankDetails` int(11) NOT NULL,
  `createdDate` timestamp NULL DEFAULT current_timestamp(),
  `YearsHosting` int(11) DEFAULT NULL,
  `SpokenLanguages` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`idHost`),
  UNIQUE KEY `idBankDetails` (`idBankDetails`),
  KEY `FK_User_idx` (`idUser`),
  KEY `FK_host_user_idx` (`idUser`),
  CONSTRAINT `FK_host_user` FOREIGN KEY (`idUser`) REFERENCES `User` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `HouseRule` (
  `idRule` int(11) DEFAULT NULL,
  `idProperty` int(11) NOT NULL,
  `RuleName` varchar(50) NOT NULL,
  `RuleDetails` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`idProperty`,`RuleName`),
  CONSTRAINT `FK_prop_hausRule` FOREIGN KEY (`idProperty`) REFERENCES `Property` (`idProperty`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `Message` (
  `idMessage` int(11) NOT NULL,
  `Created` date NOT NULL DEFAULT current_timestamp(),
  `Message_To` int(11) NOT NULL,
  `Message_From` int(11) NOT NULL,
  `Message` text DEFAULT NULL,
  `id_guest` int(11) DEFAULT NULL,
  `id_host` int(11) DEFAULT NULL,
  PRIMARY KEY (`idMessage`),
  KEY `FK_Message_Guest_idx` (`id_guest`),
  KEY `FK_Message_Host_idx` (`id_host`),
  CONSTRAINT `FK_Message_Guest` FOREIGN KEY (`id_guest`) REFERENCES `Guest` (`idGuest`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Message_Host` FOREIGN KEY (`id_host`) REFERENCES `Host` (`idHost`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `Promo` (
  `idPromo` int(11) NOT NULL,
  `Code` varchar(50) NOT NULL,
  `Discount_Amt` decimal(19,2) NOT NULL,
  PRIMARY KEY (`idPromo`),
  UNIQUE KEY `idPromo_UNIQUE` (`idPromo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

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
  `RefundRate` decimal(4,1) DEFAULT NULL,
  `NumOfRatings` int(11) DEFAULT 0,
  `AverageRatings` decimal(2,1) DEFAULT 0.0,
  `idHost` int(11) NOT NULL,
  `Street` varchar(255) DEFAULT NULL,
  `StreetNo` varchar(12) DEFAULT NULL,
  `City` varchar(100) DEFAULT NULL,
  `Country` varchar(200) DEFAULT NULL,
  `TaxRate` float DEFAULT NULL,
  PRIMARY KEY (`idProperty`),
  KEY `FK_PropertyHost_idx` (`idHost`),
  CONSTRAINT `FK_PropertyHost` FOREIGN KEY (`idHost`) REFERENCES `Host` (`idHost`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `PropertyAmenities` (
  `idPropertyAmenity` int(11) NOT NULL AUTO_INCREMENT,
  `idProperty` int(11) NOT NULL,
  `idAmenity` int(11) NOT NULL,
  PRIMARY KEY (`idPropertyAmenity`),
  UNIQUE KEY `UQ_property_amenities_connection` (`idProperty`,`idAmenity`),
  KEY `FK_prop_amenity_idx` (`idProperty`),
  KEY `FK_amenities_idx` (`idAmenity`),
  CONSTRAINT `FK_amenities` FOREIGN KEY (`idAmenity`) REFERENCES `Amenities` (`idAmenity`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_prop_amenity` FOREIGN KEY (`idProperty`) REFERENCES `Property` (`idProperty`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3121 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `PropertyCategories` (
  `idPropertyCategory` int(11) NOT NULL AUTO_INCREMENT,
  `idProperty` int(11) NOT NULL,
  `idCategory` int(11) NOT NULL,
  PRIMARY KEY (`idPropertyCategory`),
  UNIQUE KEY `UQ_property_category_connection` (`idProperty`,`idCategory`),
  KEY `FK_prop_cat_idx` (`idProperty`),
  KEY `FK_categories_idx` (`idCategory`),
  CONSTRAINT `FK_categories` FOREIGN KEY (`idCategory`) REFERENCES `Category` (`idCategory`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_prop_cat` FOREIGN KEY (`idProperty`) REFERENCES `Property` (`idProperty`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=992 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `PropertyOnWishlist` (
  `idProperty` int(11) NOT NULL,
  `idGuest` int(11) NOT NULL,
  `idWishlist` int(11) NOT NULL,
  `CheckInDate` date DEFAULT NULL,
  `CheckOutDate` date DEFAULT NULL,
  PRIMARY KEY (`idProperty`,`idGuest`,`idWishlist`),
  KEY `FK_UserWishProperty` (`idGuest`),
  KEY `FK_id_Wish` (`idWishlist`),
  CONSTRAINT `FK_PropertyWhishlist` FOREIGN KEY (`idProperty`) REFERENCES `Property` (`idProperty`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_UserWishProperty` FOREIGN KEY (`idGuest`) REFERENCES `Guest` (`idGuest`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_id_Wish` FOREIGN KEY (`idWishlist`) REFERENCES `Wishlist` (`idWishlist`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `PropertyPhoto` (
  `idPhoto` int(11) NOT NULL AUTO_INCREMENT,
  `idProperty` int(11) NOT NULL,
  `PropertyName` varchar(100) NOT NULL,
  `ImageFile` blob NOT NULL,
  PRIMARY KEY (`idPhoto`,`idProperty`,`PropertyName`),
  KEY `FK_PropertyPhotos_idx` (`idProperty`),
  CONSTRAINT `FK_PropertyPhotos` FOREIGN KEY (`idProperty`) REFERENCES `Property` (`idProperty`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

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
  KEY `FK_GuestReviewing_idx` (`idGuest`),
  KEY `FK_PropertyReviewed_idx` (`idProperty`),
  CONSTRAINT `FK_GuestReviewing` FOREIGN KEY (`idGuest`) REFERENCES `Guest` (`idGuest`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_PropertyReviewed` FOREIGN KEY (`idProperty`) REFERENCES `Property` (`idProperty`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `PropertyReviewPhoto` (
  `idGuest` int(11) NOT NULL,
  `idProperty` int(11) NOT NULL,
  `PhotoTitle` varchar(50) NOT NULL,
  `ImageFile` blob NOT NULL,
  PRIMARY KEY (`idGuest`,`idProperty`,`PhotoTitle`),
  KEY `FK_PropertyReviewPhoto_idx` (`idProperty`),
  CONSTRAINT `FK_GuestPropertyPhoto` FOREIGN KEY (`idGuest`) REFERENCES `Guest` (`idGuest`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_PropertyReviewPhoto` FOREIGN KEY (`idProperty`) REFERENCES `Property` (`idProperty`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `User` (
  `idUser` int(11) NOT NULL AUTO_INCREMENT,
  `DateOfBirth` date DEFAULT NULL,
  `Email` varchar(100) NOT NULL,
  `UserPassword` varchar(20) NOT NULL,
  `About` varchar(255) DEFAULT NULL,
  `Phone` varchar(50) NOT NULL,
  `ProfilePhotoName` varchar(50) DEFAULT NULL,
  `ProfilePhoto` blob DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `CreatedDate` timestamp NULL DEFAULT current_timestamp(),
  `LastLogin` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`idUser`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

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
  CONSTRAINT `FK_GuestReview` FOREIGN KEY (`idGuest`) REFERENCES `Guest` (`idGuest`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_HostReview` FOREIGN KEY (`idHost`) REFERENCES `Host` (`idHost`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `Wishlist` (
  `idWishlist` int(11) NOT NULL AUTO_INCREMENT,
  `idGuest` int(11) NOT NULL,
  `WishlistName` varchar(50) NOT NULL,
  `Privacy` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idWishlist`,`idGuest`,`WishlistName`),
  UNIQUE KEY `WishlistName` (`WishlistName`),
  KEY `FK_UserWishlist_idx` (`idGuest`),
  CONSTRAINT `FK_UserWishlist` FOREIGN KEY (`idGuest`) REFERENCES `Guest` (`idGuest`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

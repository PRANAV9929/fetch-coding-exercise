create table users(
user_id varchar(50) primary key not null,
active boolean,
createdDate date,
lastLogin date,
role varchar(50),
signUpSource varchar(50),
state varchar(50)
);

create table brands(
brands_id varchar(50) primary key not null,
barcode bigint,
category varchar(50),
categoryCode varchar(50),
cpg_Id varchar(50),
cpg_Ref varchar(50),
name text,
topBrand tinyint,
brandCode text
);

create table receipts(
receipts_id varchar(50) primary key not null,
bonusPointsEarned int,
bonusPointsEarnedReason varchar(50),
createDate date,
dateScanned date,
finishedDate date,
modifyDate date,
pointsAwardedDate date,
pointsEarned double,
purchaseDate date,
purchasedItemCount int,
rewardsReceiptStatus varchar(50),
totalSpent double,
user_id varchar(50),
FOREIGN KEY (user_id) REFERENCES users(user_id)
);

create table receipts_list(
brands_id varchar(50),
barcode bigint,
receipts_id varchar(50),
description text,   
finalPrice double,   
itemPrice double,    
partnerItemId int,    
quantityPurchased int,    
rewardsProductPartnerId varchar(50),
FOREIGN KEY (brands_id) REFERENCES brands(brands_id),
FOREIGN KEY (receipts_id) REFERENCES receipts(receipts_id)
);
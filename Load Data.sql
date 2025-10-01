-- ===============================
-- Load Data from CSV Files
-- ===============================

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'E:/Sql Practice/Library/authors.csv'
INTO TABLE library_db.authors
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'E:/Sql Practice/Library/branches.csv'
INTO TABLE library_db.branches
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'E:/Sql Practice/Library/members.csv'
INTO TABLE library_db.members
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'E:/Sql Practice/Library/books.csv'
INTO TABLE library_db.books
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'E:/Sql Practice/Library/borrowings.csv'
INTO TABLE library_db.borrowings
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
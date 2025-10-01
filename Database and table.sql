-- Create DB
CREATE DATABASE IF NOT EXISTS library_db;
USE library_db;

CREATE TABLE authors (
  author_id INT PRIMARY KEY,
  author_name VARCHAR(200),
  author_country VARCHAR(100)
);

CREATE TABLE branches (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(200),
  city VARCHAR(100),
  state VARCHAR(100),
  opened_date DATE
);

CREATE TABLE members (
  member_id INT PRIMARY KEY,
  member_name VARCHAR(200),
  gender VARCHAR(20),
  age INT,
  city VARCHAR(100),
  membership_type VARCHAR(50),
  membership_start_date DATE,
  occupation VARCHAR(100),
  phone VARCHAR(20),
  email VARCHAR(200)
);

CREATE TABLE books (
  book_id INT PRIMARY KEY,
  title VARCHAR(500),
  author_id INT,
  genre VARCHAR(100),
  publish_year INT,
  isbn BIGINT,
  pages INT,
  language VARCHAR(50),
  FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

CREATE TABLE borrowings (
  transaction_id BIGINT PRIMARY KEY,
  book_id INT,
  member_id INT,
  branch_id INT,
  borrow_date DATETIME,
  due_date DATETIME,
  return_date DATETIME NULL,
  fine_amount DECIMAL(10,2),
  status VARCHAR(50),
  renewals INT,
  device_used VARCHAR(50),
  rating INT,
  FOREIGN KEY (book_id) REFERENCES books(book_id),
  FOREIGN KEY (member_id) REFERENCES members(member_id),
  FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);
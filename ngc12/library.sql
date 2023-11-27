CREATE DATABASE library;

CREATE TABLE authors (
    author_id INT AUTO_INCREMENT,
    author_name VARCHAR(200) NOT NULL,
    country VARCHAR(100) NOT NULL,
    PRIMARY KEY(author_id)
);

CREATE TABLE books (
    book_id INT AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    author_id INT,
    publication_year YEAR NOT NULL,
    available_quantity INT,
    PRIMARY KEY(book_id),
    FOREIGN KEY(author_id) REFERENCES authors(author_id)
);

CREATE TABLE book_loans (
    loan_id INT AUTO_INCREMENT,
    book_id INT,
    borrower_name VARCHAR(200) NOT NULL,
    loan_date DATE NOT NULL,
    return_date DATE NOT NULL,
    PRIMARY KEY(loan_id),
    FOREIGN KEY(book_id) REFERENCES books(book_id)
);

-- add constraints
ALTER TABLE authors
ADD UNIQUE (author_name);

ALTER TABLE books
ADD UNIQUE (title);

-- create index for faster retrieval of books by author_id and finding overdue book loans
CREATE INDEX book_by_author_id
ON books (author_id);

CREATE INDEX overdue_loans
ON book_loans(return_date) WHERE return_date < GETDATE();
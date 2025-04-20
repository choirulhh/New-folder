-- Table: Library
CREATE TABLE library (
    library_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL
);

-- Table: Book
CREATE TABLE book (
    book_id SERIAL PRIMARY KEY,
    library_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    quantity INT NOT NULL CHECK (quantity >= 0),
    FOREIGN KEY (library_id) REFERENCES Library(library_id)
);

-- Table: Category
CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE NOT NULL
);

-- Table: Book_Category (Many-to-Many Relation)
CREATE TABLE book_category (
    book_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (book_id, category_id),
    FOREIGN KEY (book_id) REFERENCES Book(book_id),
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

-- Table: User
CREATE TABLE "user" (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL
);

-- Table: Loan
CREATE TABLE loan (
    loan_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (user_id) REFERENCES "user"(user_id),
    FOREIGN KEY (book_id) REFERENCES Book(book_id)
);

-- Table: Hold
CREATE TABLE hold (
    hold_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    hold_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    queue_position INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES "user"(user_id),
    FOREIGN KEY (book_id) REFERENCES Book(book_id)
);

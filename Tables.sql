-- Table for storing book information
CREATE TABLE Book (
    Book_ID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255),
    Genre VARCHAR(100),
    ISBN VARCHAR(13) UNIQUE,  -- ISBN is always unique
    Available_Copies  INT DEFAULT 1 CHECK (Available_Copies >= 0),
    Rating FLOAT CHECK (Rating BETWEEN 0 AND 5) -- Rated between 0 and 5 stars
);

-- Table for storing user info
CREATE TABLE User (
    User_ID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(255) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,  -- Passwords stored securely (hashed)
    Email VARCHAR(255) UNIQUE NOT NULL,
    Role ENUM('Librarian', 'Regular User') NOT NULL  -- Defining user roles
);

-- Table for borrowing records
CREATE TABLE Borrowing (
    Borrowing_ID INT AUTO_INCREMENT PRIMARY KEY,
    User_ID INT,
    Book_ID INT,
    Borrow_Date DATE NOT NULL,
    Return_Date DATE,
    Status ENUM('Borrowed', 'Returned') DEFAULT 'Borrowed',
    FOREIGN KEY (User_ID) REFERENCES User(User_ID) ON DELETE CASCADE,
    FOREIGN KEY (Book_ID) REFERENCES Book(Book_ID) ON DELETE CASCADE
);

-- Table for reservation records
CREATE TABLE Reservation (
    Reservation_ID INT AUTO_INCREMENT PRIMARY KEY,
    User_ID INT,
    Book_ID INT,
    Reservation_Date DATE NOT NULL,
    Status ENUM('Active', 'Completed') DEFAULT 'Active',
    FOREIGN KEY (User_ID) REFERENCES User(User_ID) ON DELETE CASCADE,
    FOREIGN KEY (Book_ID) REFERENCES Book(Book_ID) ON DELETE CASCADE,
    UNIQUE (User_ID, Book_ID)  -- Preventing duplicate reservations
);

-- Table for storing reviews and ratings by users
CREATE TABLE Review (
    Review_ID INT AUTO_INCREMENT PRIMARY KEY,
    User_ID INT,
    Book_ID INT,
    Review_Text TEXT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Review_Date DATE NOT NULL,
    FOREIGN KEY (User_ID) REFERENCES User(User_ID) ON DELETE CASCADE,
    FOREIGN KEY (Book_ID) REFERENCES Book(Book_ID) ON DELETE CASCADE,
    UNIQUE (User_ID, Book_ID)  
);

-- Table for tracking user accounts and managing profile edits
CREATE TABLE Account_Management (
    Account_ID INT AUTO_INCREMENT PRIMARY KEY,
    User_ID INT,
    Profile_Edit_Date DATE,
    FOREIGN KEY (User_ID) REFERENCES User(User_ID) ON DELETE CASCADE
);
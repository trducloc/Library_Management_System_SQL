-- Tạo cơ sở dữ liệu
CREATE DATABASE IF NOT EXISTS QuanLyThuVien;

-- Sử dụng cơ sở dữ liệu vừa tạo
USE QuanLyThuVien;

-- Tạo bảng Sách
CREATE TABLE IF NOT EXISTS Books (
    BookId INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255),
    Genre VARCHAR(255),
    PublicationYear INT,
    QuantityInStock INT DEFAULT 0
);

-- Tạo bảng Thể loại sách
CREATE TABLE IF NOT EXISTS BookGenres (
    GenreId INT PRIMARY KEY AUTO_INCREMENT,
    GenreName VARCHAR(50) NOT NULL
);

-- Tạo bảng nhà xuất bản
CREATE TABLE IF NOT EXISTS Publishers (
    PublisherId INT PRIMARY KEY AUTO_INCREMENT,
    PublisherName VARCHAR(100) NOT NULL
);

-- Tạo bảng Tác Giả
CREATE TABLE IF NOT EXISTS Authors (
    AuthorId INT PRIMARY KEY AUTO_INCREMENT,
    AuthorName VARCHAR(100) NOT NULL,
    DateOfBirth DATE,
    Nationality VARCHAR(50)
);

-- Tạo bảng Độc Giả
CREATE TABLE IF NOT EXISTS Readers (
    ReaderId INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(255) NOT NULL,
    Address VARCHAR(255),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    RegistrationDate DATE
);

-- Tạo bảng Phiếu Mượn
CREATE TABLE IF NOT EXISTS BorrowingReceipts (
    ReceiptId INT PRIMARY KEY AUTO_INCREMENT,
    BorrowDate DATE,
    DueDate DATE,
    Status ENUM('Borrowing', 'Returned') DEFAULT 'Borrowing',
    ReaderId INT,
    FOREIGN KEY (ReaderId) REFERENCES Readers(ReaderId)
);

-- Tạo bảng Chi Tiết Mượn
CREATE TABLE IF NOT EXISTS BorrowingDetails (
    DetailId INT PRIMARY KEY AUTO_INCREMENT,
    ReceiptId INT,
    BookId INT,
    QuantityBorrowed INT,
    FOREIGN KEY (ReceiptId) REFERENCES BorrowingReceipts(ReceiptId),
    FOREIGN KEY (BookId) REFERENCES Books(BookId)
);

-- Tạo bảng nhân viên thư viện
CREATE TABLE IF NOT EXISTS LibraryStaff (
    StaffId INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(255) NOT NULL,
    Email VARCHAR(100),
    Position VARCHAR(50)
);

-- Tạo bảng nhập sách
CREATE TABLE IF NOT EXISTS BookEntry (
    EntryId INT PRIMARY KEY AUTO_INCREMENT,
    EntryDate DATE,
    StaffId INT,
    FOREIGN KEY (StaffId) REFERENCES LibraryStaff(StaffId)
);

-- Tạo bảng chi tiết nhập sách
CREATE TABLE IF NOT EXISTS EntryDetails (
    EntryDetailId INT PRIMARY KEY AUTO_INCREMENT,
    EntryId INT,
    BookId INT,
    QuantityEntered INT,
    FOREIGN KEY (EntryId) REFERENCES BookEntry(EntryId),
    FOREIGN KEY (BookId) REFERENCES Books(BookId)
);

-- Tạo bảng bình luận sách
CREATE TABLE IF NOT EXISTS BookComments (
    CommentId INT PRIMARY KEY AUTO_INCREMENT,
    ReaderId INT,
    BookId INT,
    Content TEXT NOT NULL,
    TimePosted DATETIME,
    FOREIGN KEY (ReaderId) REFERENCES Readers(ReaderId),
    FOREIGN KEY (BookId) REFERENCES Books(BookId)
);

-- Tạo bảng đánh giá sách
CREATE TABLE IF NOT EXISTS BookRatings (
    RatingId INT PRIMARY KEY AUTO_INCREMENT,
    ReaderId INT,
    BookId INT,
    RatingScore INT,
    TimePosted DATETIME,
    FOREIGN KEY (ReaderId) REFERENCES Readers(ReaderId),
    FOREIGN KEY (BookId) REFERENCES Books(BookId)
);


-- Thêm dữ liệu cho bảng Sách
INSERT INTO Books (Title, Author, Genre, PublicationYear, QuantityInStock) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 1925, 10),
('To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960, 8),
('1984', 'George Orwell', 'Science Fiction', 1949, 15),
('Pride and Prejudice', 'Jane Austen', 'Romance', 1813, 12),
('The Catcher in the Rye', 'J.D. Salinger', 'Fiction', 1951, 7),
('Harry Potter and the Sorcerer''s Stone', 'J.K. Rowling', 'Fantasy', 1997, 20),
('The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 1937, 18),
('The Da Vinci Code', 'Dan Brown', 'Mystery', 2003, 14),
('The Girl on the Train', 'Paula Hawkins', 'Thriller', 2015, 9),
('The Alchemist', 'Paulo Coelho', 'Fiction', 1988, 11);

-- Thêm dữ liệu cho bảng Thể loại sách
INSERT INTO BookGenres (GenreName) VALUES
('Fiction'),
('Non-Fiction'),
('Mystery'),
('Science Fiction'),
('Biography'),
('History'),
('Romance'),
('Fantasy'),
('Thriller'),
('Self-Help');

-- Thêm dữ liệu cho bảng Nhà xuất bản
INSERT INTO Publishers (PublisherName) VALUES
('Penguin Books'),
('Random House'),
('HarperCollins'),
('Simon & Schuster'),
('Macmillan Publishers'),
('Hachette Livre'),
('Wiley'),
('Pearson'),
('Oxford University Press'),
('Cambridge University Press');

-- Thêm dữ liệu cho bảng Tác Giả
INSERT INTO Authors (AuthorName, DateOfBirth, Nationality) VALUES
('Jane Austen', '1775-12-16', 'British'),
('Mark Twain', '1835-11-30', 'American'),
('J.K. Rowling', '1965-07-31', 'British'),
('George Orwell', '1903-06-25', 'British'),
('Agatha Christie', '1890-09-15', 'British'),
('Stephen King', '1947-09-21', 'American'),
('Haruki Murakami', '1949-01-12', 'Japanese'),
('Toni Morrison', '1931-02-18', 'American'),
('Gabriel Garcia Marquez', '1927-03-06', 'Colombian'),
('Leo Tolstoy', '1828-09-09', 'Russian');

-- Thêm dữ liệu cho bảng Người Mượn
INSERT INTO Readers (FullName, Address, Email, Phone, RegistrationDate) VALUES
('John Doe', '123 Main St', 'john.doe@example.com', '123-456-7890', '2023-01-01'),
('Jane Smith', '456 Oak St', 'jane.smith@example.com', '987-654-3210', '2023-01-02'),
('Michael Johnson', '789 Pine St', 'michael.johnson@example.com', '456-789-0123', '2023-01-03'),
('Emily Davis', '101 Elm St', 'emily.davis@example.com', '789-012-3456', '2023-01-04'),
('Christopher Wilson', '202 Maple St', 'christopher.wilson@example.com', '012-345-6789', '2023-01-05'),
('Jessica Brown', '303 Birch St', 'jessica.brown@example.com', '234-567-8901', '2023-01-06'),
('Andrew Lee', '404 Cedar St', 'andrew.lee@example.com', '567-890-1234', '2023-01-07'),
('Olivia Harris', '505 Walnut St', 'olivia.harris@example.com', '890-123-4567', '2023-01-08'),
('Daniel White', '606 Pineapple St', 'daniel.white@example.com', '123-456-7890', '2023-01-09'),
('Ava Martinez', '707 Banana St', 'ava.martinez@example.com', '987-654-3210', '2023-01-10');

-- Thêm dữ liệu cho bảng Phiếu Mượn
INSERT INTO BorrowingReceipts (BorrowDate, DueDate, Status, ReaderId) VALUES
('2023-02-01', '2023-02-15', 'Borrowing', 1),
('2023-02-02', '2023-02-16', 'Returned', 2),
('2023-02-03', '2023-02-17', 'Borrowing', 3),
('2023-02-04', '2023-02-18', 'Borrowing', 4),
('2023-02-05', '2023-02-19', 'Borrowing', 5),
('2023-02-06', '2023-02-20', 'Returned', 6),
('2023-02-07', '2023-02-21', 'Borrowing', 7),
('2023-02-08', '2023-02-22', 'Returned', 8),
('2023-02-09', '2023-02-23', 'Borrowing', 9),
('2023-02-10', '2023-02-24', 'Borrowing', 10);

-- Thêm dữ liệu cho bảng Chi Tiết Mượn
INSERT INTO BorrowingDetails (ReceiptId, BookId, QuantityBorrowed) VALUES
(1, 1, 2),
(1, 3, 1),
(2, 2, 3),
(3, 4, 2),
(4, 5, 1),
(5, 6, 4),
(6, 7, 2),
(7, 8, 3),
(8, 9, 1),
(9, 10, 2);

-- Thêm dữ liệu cho bảng Nhân viên thư viện
INSERT INTO LibraryStaff (FullName, Email, Position) VALUES
('Alex Turner', 'alex.turner@example.com', 'Librarian'),
('Emma Thompson', 'emma.thompson@example.com', 'Assistant Librarian'),
('Christopher Martin', 'christopher.martin@example.com', 'Library Clerk'),
('Olivia Davis', 'olivia.davis@example.com', 'Library Technician'),
('James Smith', 'james.smith@example.com', 'Library Assistant'),
('Sophia Johnson', 'sophia.johnson@example.com', 'Library Assistant'),
('William Brown', 'william.brown@example.com', 'Library Assistant'),
('Oliver Wilson', 'oliver.wilson@example.com', 'Library Assistant'),
('Amelia Lee', 'amelia.lee@example.com', 'Library Assistant'),
('Lucas Harris', 'lucas.harris@example.com', 'Library Assistant');

-- Thêm dữ liệu cho bảng Nhập sách
INSERT INTO BookEntry (EntryDate, StaffId) VALUES
('2023-02-01', 1),
('2023-02-02', 2),
('2023-02-03', 3),
('2023-02-04', 4),
('2023-02-05', 5),
('2023-02-06', 6),
('2023-02-07', 7),
('2023-02-08', 8),
('2023-02-09', 9),
('2023-02-10', 10);

-- Thêm dữ liệu cho bảng Chi Tiết Nhập sách
INSERT INTO EntryDetails (EntryId, BookId, QuantityEntered) VALUES
(1, 1, 10),
(1, 2, 8),
(2, 3, 15),
(2, 4, 12),
(3, 5, 7),
(3, 6, 20),
(4, 7, 18),
(4, 8, 14),
(5, 9, 11),
(5, 10, 9);

-- Thêm dữ liệu cho bảng Bình luận sách
INSERT INTO BookComments (ReaderId, BookId, Content, TimePosted) VALUES
(1, 1, 'Great book! Loved the storyline.', '2023-02-02 10:30:00'),
(2, 2, 'Classic masterpiece. A must-read!', '2023-02-03 12:45:00'),
(3, 3, 'Couldn''t put it down. So captivating.', '2023-02-04 14:20:00'),
(4, 4, 'Beautifully written. Jane Austen''s best!', '2023-02-05 16:10:00'),
(5, 5, 'Holden Caulfield''s journey is unforgettable.', '2023-02-06 18:00:00'),
(6, 6, 'Magical world. Rowling is a genius!', '2023-02-07 20:15:00'),
(7, 7, 'An epic adventure. Tolkien''s imagination is limitless.', '2023-02-08 22:30:00'),
(8, 8, 'Thrilling plot. Couldn''t guess the ending!', '2023-02-09 08:45:00'),
(9, 9, 'Page-turner. Couldn''t stop reading!', '2023-02-10 11:00:00'),
(10, 10, 'The journey of Santiago is inspiring.', '2023-02-11 13:20:00');

-- Thêm dữ liệu cho bảng Đánh giá sách
INSERT INTO BookRatings (ReaderId, BookId, RatingScore, TimePosted) VALUES
(1, 1, 5, '2023-02-03 09:30:00'),
(2, 2, 4, '2023-02-04 11:45:00'),
(3, 3, 5, '2023-02-05 13:20:00'),
(4, 4, 4, '2023-02-06 15:10:00'),
(5, 5, 5, '2023-02-07 17:00:00'),
(6, 6, 4, '2023-02-08 19:15:00'),
(7, 7, 5, '2023-02-09 21:30:00'),
(8, 8, 4, '2023-02-10 08:45:00'),
(9, 9, 5, '2023-02-11 11:00:00'),
(10, 10, 4, '2023-02-12 13:20:00');

-- Lấy thông tin tất cả các cuốn sách
SELECT * FROM Books;

-- Lấy tên và quốc tịch của tất cả tác giả
SELECT AuthorName, Nationality FROM Authors;

-- Lấy tất cả các thể loại sách
SELECT * FROM BookGenres;

-- Lấy tên và địa chỉ của tất cả độc giả
SELECT FullName, Address FROM Readers;

-- Lấy tên và vị trí của tất cả nhân viên trong thư viện
SELECT FullName, Position FROM LibraryStaff;

-- Lấy thông tin về tất cả các phiếu mượn sách
SELECT * FROM BorrowingReceipts;

-- Lấy tên sách và nội dung bình luận của tất cả các bình luận.
SELECT Books.Title, BookComments.Content FROM Books
JOIN BookComments ON Books.BookID = BookComments.BookID;

-- Lấy tên sách và điểm đánh giá của tất cả các đánh giá sách.
SELECT Books.Title, BookRatings.RatingScore FROM Books
JOIN BookRatings ON Books.BookID = BookRatings.BookID;

-- Lấy tên sách, ngày mượn, và ngày trả dự kiến của tất cả các phiếu mượn sách.
SELECT Books.Title, BorrowingReceipts.BorrowDate, BorrowingReceipts.DueDate
FROM Books
JOIN BorrowingDetails ON Books.BookID = BorrowingDetails.BookID
JOIN BorrowingReceipts ON BorrowingDetails.ReceiptID = BorrowingReceipts.ReceiptID;

-- Lấy số lượng sách có sẵn trong kho và tổng số lượng sách trong cơ sở dữ liệu.
SELECT SUM(QuantityInStock) AS TotalStock, COUNT(*) AS TotalBooks 
FROM Books;

-- Lấy tất cả các sách có thể mượn (số lượng trong kho lớn hơn 0).
SELECT * FROM Books WHERE QuantityInStock > 0;

-- Lấy tên sách và ngày đánh giá của tất cả đánh giá sách có điểm đánh giá là 5.
SELECT Books.Title, BookRatings.TimePosted
FROM Books
JOIN BookRatings ON Books.BookID = BookRatings.BookID
WHERE BookRatings.RatingScore = 5;

-- Lấy tên đầy đủ và địa chỉ của tất cả độc giả đã mượn sách.
SELECT Readers.FullName, Readers.Address
FROM Readers
JOIN BorrowingReceipts ON Readers.ReaderID = BorrowingReceipts.ReaderID;

-- Lấy tên sách và ngày đăng bình luận của tất cả bình luận có nội dung chứa từ khóa 'fantastic'.
SELECT Books.Title, BookComments.TimePosted
FROM Books
JOIN BookComments ON Books.BookID = BookComments.BookID
WHERE BookComments.Content LIKE '%fantastic%';

-- Lấy tên sách và ngày nhập của tất cả sách đã được nhập vào cơ sở dữ liệu.
SELECT Books.Title, BookEntry.EntryDate
FROM Books
JOIN EntryDetails ON Books.BookID = EntryDetails.BookID
JOIN BookEntry ON EntryDetails.EntryID = BookEntry.EntryID;

-- Lấy tên sách và số lượng đã mượn của tất cả sách đã được mượn.
SELECT Books.Title, SUM(BorrowingDetails.QuantityBorrowed) AS TotalBorrowed
FROM Books
JOIN BorrowingDetails ON Books.BookID = BorrowingDetails.BookID
GROUP BY Books.Title;

-- Lấy tên đầy đủ và số lượng sách đã mượn của tất cả độc giả.
SELECT Readers.FullName, COUNT(*) AS TotalBorrowed
FROM Readers
JOIN BorrowingReceipts ON Readers.ReaderID = BorrowingReceipts.ReaderID
GROUP BY Readers.FullName;

-- Lấy tên sách và ngày trả của tất cả phiếu mượn đã được trả.
SELECT Books.Title, BorrowingReceipts.DueDate
FROM Books
JOIN BorrowingDetails ON Books.BookID = BorrowingDetails.BookID
JOIN BorrowingReceipts ON BorrowingDetails.ReceiptID = BorrowingReceipts.ReceiptID
WHERE BorrowingReceipts.Status = 'Returned';

-- Lấy tên sách và ngày nhập của tất cả sách có số lượng nhập lớn hơn 10.
SELECT Books.Title, BookEntry.EntryDate
FROM Books
JOIN EntryDetails ON Books.BookID = EntryDetails.BookID
JOIN BookEntry ON EntryDetails.EntryID = BookEntry.EntryID
WHERE EntryDetails.QuantityEntered > 10;

-- Lấy tên đầy đủ và địa chỉ của tất cả độc giả đã mượn sách và đang giữ sách quá hạn. 
SELECT Readers.FullName, Readers.Address
FROM Readers
JOIN BorrowingReceipts ON Readers.ReaderID = BorrowingReceipts.ReaderID
WHERE BorrowingReceipts.DueDate < CURDATE() AND BorrowingReceipts.Status = 'Borrowing';

# Thiết kế Cơ sở dữ liệu cho Hệ thống Quản Lý Thư Viện
## I. Giới thiệu

  Trong xã hội hiện đại, để đáp ứng nhu cầu phát triển các hoạt động giáo dục,khoa học, văn hóa, kinh tế, v.v…, việc đọc sách báo (và các tài liệu khác) với mục đích khai thác, sử dụng thông tin, tri thức, càng ngày càng trở nên cấp thiết. Cùng với đó, số lượt mượn sách hàng ngày trong thư viện đạt đến con số hàng nghìn lượt.Việc quản lý sách được thực hiện thủ công gặp nhiều khó khăn. Vì vậy việc xây dựng chương tình quản lý thông tin liên quan đến việc mượn, trả, tìm kiếm thông tin về sách là một việc cần thiết. Từ đó giúp cho việc quản lý thư viện trở nên thuận tiện và ưu việt hơn.
  
  Đồ án này nhằm mục đích thực hành và hiểu rõ về tạo cơ sở dữ liệu cơ bản. Được viết ra để giải quyết những vấn đề xung quanh việc quản lý thư viện ở một nhà sách, hoặc một trường học.
  
## II. Setup

   **Bước 1:**  Download và cài đặt MySQL theo hướng dẫn tại: https://dev.mysql.com/doc/refman/8.2/en/installing.html
     
   **Bước 2:** Cài đặt docker qua hướng dẫn: https://docs.docker.com/desktop/
     
   **Bước 3:** Cài đặt MySQL bằng docker commdline: `docker run --name learn-mysql -e MYSQL_ROOT_PASSWORD=123 -p 8080:3306 -d mysql:latest`
     
   **Bước 4:** Sau khi cài đặt, Tạo MySQL Connection với user/pass đã tạo khi cài đặt MySQL (root/123)


## III. Biểu đồ Diagram

   ![image](https://github.com/trducloc/Library_Management_System_SQL/blob/main/diagramQLTV.png)

   - Trong biểu đồ này:
     - Bảng Sách (Books):
       + Thuộc tính: BookId (PK), Title, Author, Genre, PublicationYear, QuantityInStock.
     - Bảng Thể loại sách (BookGenres):
       + Thuộc tính: GenreId (PK), GenreName.
       + Mối quan hệ: Có mối quan hệ n-n với bảng Sách (Books) qua bảng trung gian BookGenres.
     - Bảng Nhà xuất bản (Publishers):
       + Thuộc tính: PublisherId (PK), PublisherName.
     - Bảng Tác Giả (Authors):
       + Thuộc tính: AuthorId (PK), AuthorName, DateOfBirth, Nationality.
       + Mối quan hệ: Có mối quan hệ n-n với bảng Sách (Books) qua bảng trung gian Authors.
     - Bảng Độc Giả (Readers):
       + Thuộc tính: ReaderId (PK), FullName, Address, Email, Phone, RegistrationDate.
       + Mối quan hệ: Có mối quan hệ 1-n với các bảng BorrowingReceipts, BookComments, BookRatings.
     - Bảng Phiếu Mượn (BorrowingReceipts):
       + Thuộc tính: ReceiptId (PK), BorrowDate, DueDate, Status, ReaderId.
       + Mối quan hệ: Có mối quan hệ 1-n với bảng BorrowingDetails.
     - Bảng Chi Tiết Mượn (BorrowingDetails):
       + Thuộc tính: DetailId (PK), ReceiptId, BookId, QuantityBorrowed.
       + Mối quan hệ: Có mối quan hệ 1-n với bảng Books và BorrowingReceipts.
     - Bảng Nhân viên thư viện (LibraryStaff):
       + Thuộc tính: StaffId (PK), FullName, Email, Position.
       + Mối quan hệ: Có mối quan hệ 1-n với bảng BookEntry.
     - Bảng Nhập sách (BookEntry):
       + Thuộc tính: EntryId (PK), EntryDate, StaffId.
       + Mối quan hệ: Có mối quan hệ 1-n với bảng EntryDetails.
     - Bảng Chi tiết nhập sách (EntryDetails):
       + Thuộc tính: EntryDetailId (PK), EntryId, BookId, QuantityEntered.
       + Mối quan hệ: Có mối quan hệ 1-n với bảng Books và BookEntry.
     - Bảng Bình luận sách (BookComments):
       + Thuộc tính: CommentId (PK), ReaderId, BookId, Content, TimePosted.
       + Mối quan hệ: Có mối quan hệ 1-n với bảng Books và Readers.
     - Bảng Đánh giá sách (BookRatings):
       + Thuộc tính: RatingId (PK), ReaderId, BookId, RatingScore, TimePosted.
       + Mối quan hệ: Có mối quan hệ 1-n với bảng Books và Readers.
  ## IV. Chi tiết DataBase Design
  https://github.com/trducloc/Library_Management_System_SQL/blob/main/Database_Structure.xlsx

  ## V. Kết quả
- Đồ án Quản lý thư viện đã được triển khai thành công và có thể sử dụng để quản lý thông tin về sách và độc giả trong thư viện.
- Sau khi hoàn thành môn DATABASE ở TECHMASTER, mình đã:
  + Hiểu Biết Vững Về Cơ Sở Dữ Liệu: Hiểu rõ về các khái niệm cơ bản như bảng (table), trường (field), dòng (row), khóa chính (primary key), ràng buộc (constraints), và quan hệ giữa các bảng. Khả năng thiết kế cơ sở dữ liệu đơn giản hoặc phức tạp dựa trên yêu cầu cụ thể.
  + Sử dụng thành thạo các câu lệnh SQL để truy vấn, cập nhật, xóa dữ liệu từ cơ sở dữ liệu. Hiểu cách sử dụng các chức năng như GROUP BY, JOIN, HAVING để thực hiện các truy vấn phức tạp.
  + Tối Ưu Hóa Hiệu Suất: Hiểu cách tối ưu hóa truy vấn để cải thiện hiệu suất hệ thống cơ sở dữ liệu. Biết cách sử dụng chỉ mục (indexing) để làm cho các truy vấn nhanh hơn.
  + Phát Triển Kỹ Năng Lập Trình Kết Hợp: Nếu có thể, sử dụng kiến thức về cơ sở dữ liệu để phát triển ứng dụng hoặc dự án có sử dụng cơ sở dữ liệu.






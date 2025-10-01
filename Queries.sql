-- 1. List all Premium members from Chennai.
SELECT member_id, member_name, membership_type, city
FROM members
WHERE city = 'Chennai' AND membership_type = 'Premium';

-- 2. Get the total number of books in the library.
SELECT COUNT(*) AS total_books FROM books;

-- 3. Find all books published after 2015.
SELECT title, publish_year
FROM books
WHERE publish_year > 2015;

-- 4. List all borrowings that are still not returned.
SELECT transaction_id, member_id, book_id, borrow_date
FROM borrowings
WHERE status = 'Borrowed';

-- 5. Show all distinct genres available.
SELECT DISTINCT genre FROM books;

-- 6. Count number of borrowings per branch.
SELECT branch_id, COUNT(*) AS total_borrowings
FROM borrowings
GROUP BY branch_id
ORDER BY total_borrowings DESC;

-- 7. Find top 5 most borrowed books.
SELECT b.title, COUNT(*) AS times_borrowed
FROM borrowings br
JOIN books b ON br.book_id = b.book_id
GROUP BY b.title
ORDER BY times_borrowed DESC
LIMIT 5;

-- 8. Get members with more than 50 borrowings.
SELECT m.member_id, m.member_name, COUNT(*) AS total_borrowings
FROM borrowings br
JOIN members m ON br.member_id = m.member_id
GROUP BY m.member_id, m.member_name
HAVING COUNT(*) > 50;

-- 9. Find overdue percentage branch-wise.
SELECT branch_id,
       ROUND(SUM(CASE WHEN status='Overdue' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS overdue_pct
FROM borrowings
GROUP BY branch_id;

-- 10. Find average fine collected per year.
SELECT YEAR(borrow_date) AS year, AVG(fine_amount) AS avg_fine
FROM borrowings
GROUP BY YEAR(borrow_date)
ORDER BY year;

-- 11. Find the most popular genre overall.
SELECT b.genre, COUNT(*) AS total_borrowed
FROM borrowings br
JOIN books b ON br.book_id = b.book_id
GROUP BY b.genre
ORDER BY total_borrowed DESC
LIMIT 1;

-- 12. Show borrowing trend per year.
SELECT YEAR(borrow_date) AS year, COUNT(*) AS total_borrowings
FROM borrowings
GROUP BY YEAR(borrow_date)
ORDER BY year;

-- 13. Compare average books borrowed by Premium vs Regular members.
SELECT m.membership_type, ROUND(COUNT(*)*1.0/COUNT(DISTINCT m.member_id),2) AS avg_books_borrowed
FROM borrowings br
JOIN members m ON br.member_id = m.member_id
GROUP BY m.membership_type;

-- 14. Find members who borrowed books from more than 3 branches.
SELECT member_id, COUNT(DISTINCT branch_id) AS branches_used
FROM borrowings
GROUP BY member_id
HAVING COUNT(DISTINCT branch_id) > 3;

-- 15. Find members with highest fines.
SELECT m.member_name, SUM(br.fine_amount) AS total_fine
FROM borrowings br
JOIN members m ON br.member_id = m.member_id
GROUP BY m.member_name
ORDER BY total_fine DESC
LIMIT 10;

-- 16. Find top 5 authors by borrow count.
SELECT a.author_name, COUNT(*) AS borrow_count
FROM borrowings br
JOIN books b ON br.book_id = b.book_id
JOIN authors a ON b.author_id = a.author_id
GROUP BY a.author_name
ORDER BY borrow_count DESC
LIMIT 5;

-- 17. Find average return delay in days.
SELECT ROUND(AVG(DATEDIFF(return_date, due_date)),2) AS avg_delay_days
FROM borrowings
WHERE status='Overdue';

-- 18. Find device usage share (Web vs Mobile vs Kiosk).
SELECT device_used, COUNT(*) AS total_usage,
       ROUND(COUNT(*)*100.0/(SELECT COUNT(*) FROM borrowings),2) AS pct_share
FROM borrowings
GROUP BY device_used;

-- 19. Show monthly borrowing trend for last 2 years.
SELECT YEAR(borrow_date) AS year, MONTH(borrow_date) AS month, COUNT(*) AS total_borrowings
FROM borrowings
WHERE borrow_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR)
GROUP BY YEAR(borrow_date), MONTH(borrow_date)
ORDER BY year, month;

-- 20. Find genre popularity by age group.
SELECT CASE 
         WHEN m.age < 18 THEN 'Under 18'
         WHEN m.age BETWEEN 18 AND 30 THEN '18-30'
         WHEN m.age BETWEEN 31 AND 50 THEN '31-50'
         ELSE '50+' END AS age_group,
       b.genre, COUNT(*) AS total_borrowings
FROM borrowings br
JOIN members m ON br.member_id = m.member_id
JOIN books b ON br.book_id = b.book_id
GROUP BY age_group, b.genre
ORDER BY age_group, total_borrowings DESC;

-- 21. Find members who rated more than 10 books.
SELECT member_id, COUNT(rating) AS total_ratings
FROM borrowings
WHERE rating IS NOT NULL
GROUP BY member_id
HAVING COUNT(rating) > 10;

-- 22. Find top 5 cities with maximum borrowings.
SELECT m.city, COUNT(*) AS borrowings
FROM borrowings br
JOIN members m ON br.member_id = m.member_id
GROUP BY m.city
ORDER BY borrowings DESC
LIMIT 5;

-- 23. Find top 3 branches by revenue from fines.
SELECT branch_id, SUM(fine_amount) AS total_fine
FROM borrowings
GROUP BY branch_id
ORDER BY total_fine DESC
LIMIT 3;

-- 24. Show yearly trend of Premium vs Regular borrowings.
SELECT YEAR(br.borrow_date) AS year, m.membership_type, COUNT(*) AS borrowings
FROM borrowings br
JOIN members m ON br.member_id = m.member_id
GROUP BY YEAR(br.borrow_date), m.membership_type
ORDER BY year, m.membership_type;

-- 25. Find top 5 most loyal members (highest borrowings).
SELECT m.member_name, COUNT(*) AS total_borrowings
FROM borrowings br
JOIN members m ON br.member_id = m.member_id
GROUP BY m.member_name
ORDER BY total_borrowings DESC
LIMIT 5;

-- 26. Find books that were never borrowed.
SELECT b.book_id, b.title
FROM books b
LEFT JOIN borrowings br ON b.book_id = br.book_id
WHERE br.book_id IS NULL;

-- 27. Find genre with highest overdue percentage.
SELECT b.genre,
       ROUND(SUM(CASE WHEN br.status='Overdue' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS overdue_pct
FROM borrowings br
JOIN books b ON br.book_id = b.book_id
GROUP BY b.genre
ORDER BY overdue_pct DESC
LIMIT 1;

-- 28. Find average borrowing frequency by member occupation.
SELECT m.occupation, ROUND(COUNT(*)*1.0/COUNT(DISTINCT m.member_id),2) AS avg_books_borrowed
FROM borrowings br
JOIN members m ON br.member_id = m.member_id
GROUP BY m.occupation
ORDER BY avg_books_borrowed DESC;

-- 29. Find most active borrowing month each year.
SELECT year, month, borrowings FROM (
    SELECT YEAR(borrow_date) AS year, MONTH(borrow_date) AS month,
           COUNT(*) AS borrowings,
           ROW_NUMBER() OVER(PARTITION BY YEAR(borrow_date) ORDER BY COUNT(*) DESC) AS rn
    FROM borrowings
    GROUP BY YEAR(borrow_date), MONTH(borrow_date)
) t WHERE rn=1;

-- 30. Find members with maximum renewals.
SELECT m.member_name, SUM(br.renewals) AS total_renewals
FROM borrowings br
JOIN members m ON br.member_id = m.member_id
GROUP BY m.member_name
ORDER BY total_renewals DESC
LIMIT 5;

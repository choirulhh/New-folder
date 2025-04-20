
--1
SELECT		l.name AS library_name,
			SUM(b.quantity) AS total_books
FROM 		library AS l
JOIN 		book b 
ON			l.library_id = b.library_id
GROUP BY 	l.name
ORDER BY 	total_books ASC;


--2
SELECT		u.name, 
			COUNT(l.loan_id) AS total_loans
FROM 		"user" u
JOIN 		loan l 
ON 			u.user_id = l.user_id
GROUP BY 	u.name
ORDER BY 	total_loans DESC;

--3
SELECT 		b.title, 
			COUNT(l.loan_id) AS times_borrowed
FROM 		book b
JOIN 		loan l 
ON 			b.book_id = l.book_id
GROUP BY 	b.title
ORDER BY 	times_borrowed DESC;

--4
SELECT 		u.user_name, 
			h.hold_date, 
			h.expiry_date
FROM		"user" u
JOIN 		hold h 
ON 			u.user_id = h.user_id
WHERE 		CURRENT_DATE > h.expiry_date;

--5
SELECT 		c.category_name, 
			COUNT(bc.book_id) AS total_books
FROM 		category c
JOIN 		book_category bc 
ON 			c.category_id = bc.category_id
GROUP BY 	c.category_name;

!pip install faker

from faker import Faker
import pandas as pd
import random
from datetime import timedelta, datetime

fake = Faker()

# Number of records
n_libraries = 5
n_categories = 10
n_books = 50
n_users = 20
n_loans = 30
n_holds = 20

# 1. Libraries
libraries = []
for i in range(n_libraries):
    libraries.append({
        'name': fake.company(),
        'location': fake.city()
    })

# 2. Categories
categories = [
    {'category_name': cat} for cat in [
        'Self-Improvement', 'Biography', 'Fantasy', 'Romance', 
        'Science Fiction', 'Mystery', 'History', 'Children', 'Horror', 'Adventure'
    ]
]

# 3. Books
books = []
for i in range(n_books):
    books.append({
        'library_id': random.randint(1, n_libraries),
        'title': fake.sentence(nb_words=3),
        'author': fake.name(),
        'quantity': random.randint(1, 10)
    })

# 4. Users
users = []
for i in range(n_users):
    users.append({
        'name': fake.name(),
        'email': fake.unique.email()
    })

# 5. Book_Category (assign random categories to each book)
book_categories = []
for book_id in range(1, n_books+1):
    categories_sample = random.sample(range(1, n_categories+1), random.randint(1, 2))
    for cat_id in categories_sample:
        book_categories.append({
            'book_id': book_id,
            'category_id': cat_id
        })

# 6. Loans
loans = []
for i in range(1, n_loans+1):
    loan_date = fake.date_between(start_date='-30d', end_date='today')
    due_date = loan_date + timedelta(days=14)
    return_date = None
    if random.choice([True, False]):
        return_date = loan_date + timedelta(days=random.randint(1, 14))
    loans.append({
        'user_id': random.randint(1, n_users),
        'book_id': random.randint(1, n_books),
        'loan_date': loan_date,
        'due_date': due_date,
        'return_date': return_date
    })

# 7. Holds
holds = []
for i in range(1, n_holds+1):
    hold_date = fake.date_between(start_date='-20d', end_date='today')
    expiry_date = hold_date + timedelta(days=7)
    holds.append({
        'user_id': random.randint(1, n_users),
        'book_id': random.randint(1, n_books),
        'hold_date': hold_date,
        'expiry_date': expiry_date,
        'is_active': random.choice([True, False]),
        'queue_position': random.randint(1, 5)
    })

# Save to CSV
pd.DataFrame(libraries).to_csv('libraries.csv', index=False)
pd.DataFrame(categories).to_csv('categories.csv', index=False)
pd.DataFrame(books).to_csv('books.csv', index=False)
pd.DataFrame(users).to_csv('users.csv', index=False)
pd.DataFrame(book_categories).to_csv('book_categories.csv', index=False)
pd.DataFrame(loans).to_csv('loans.csv', index=False)
pd.DataFrame(holds).to_csv('holds.csv', index=False)

print("Dummy data generated successfully!")

import pandas as pd

# Read the data from Excel file
excel_data = pd.read_excel('books-database.xlsx')

# Convert the data to a list of dictionaries
books_data = excel_data.to_dict(orient='records')

print(books_data)
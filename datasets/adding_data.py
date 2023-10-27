import pandas as pd
import numpy as np
df = pd.read_excel("books-database.xlsx")
rows = 50
for k,g in df.groupby(np.arange(len(df))//rows):
    g.to_excel("dataset{}.xlsx".format(k+1), index=False)
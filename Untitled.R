fichiers <- read_xlsx("Tweets_coalitionavenir_2018.xlsx")



# Importer le texte (Journal des débats de l'Assemblée nationale 15 septembre 2021)
journal_debats <- readtext("Journal des débats.txt", cache = FALSE) %>% c

class(journal_debats)

journal_debats %>% head()

# premier niveau
journal_debats[1]

# deuxième niveau
journal_debats[[1]]

# corpus_reshape() permet de changer l'unité des textes entre les documents, les paragraphes et les phrases
corpus <- corpus(journal_debats)
ndoc(corpus)
corpus[[1]]

corpus <- corpus_reshape(corpus, to = "sentences")
ndoc(corpus)
corpus[[2]]

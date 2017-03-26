# RMySQL : interface R pour MySQL
2016-07-30  

***(latest update : 2016-07-30 15:53:45)***
<br/>






La librairie `RMySQL` (qui repose sur la librairie `DBI`) permet de se connecter à une base de données MySQL dans R, d'importer un tableau de la base de données dans R ou vice-versa, et d'exécuter des requêtes SQL dans la base de données à partir de R. 


## Connexion à une base de données

Nous créons d'abord une nouvelle base de données dans MySQL. Pour cela, on lance MySQL dans un terminal avec la commande `mysql -u root -p`, puis, après avoir saisi le mot de passe, on crée la base de données `rmysql0` avec l'instruction  

```
CREATE DATABASE rmysql0;
``` 

La première chose à faire pour utiliser `RMySQL` est la connexion à la base de données, qu'on réalise ainsi :


```r
library(RMySQL)
# connect to database (don't forget to disconnect)
DB <- dbConnect(MySQL(), user="root", host="localhost",
                password="hulk", dbname="rmysql0")
```

Il faudra penser à déconnecter en fin d'utilisation. 
Nous avons assigné la connexion à la variable `DB`, qu'il faudra alors utiliser à chaque opération.


## Import/Export d'un tableau 

La base de données que nous venons de créer est vide : 


```r
dbListTables(DB) # list tables
## character(0)
```

Nous allons y ajouter le tableau de données R suivant :


```r
df1 <- data.frame(
  Name = c("Joe", "Joe", "Bill", "Jim", "Kate"),
  Value = c(10.1, 13, 9, 7.7, -3),
  Indic = c(0L, 1L, 1L, 2L, 2L),
  Status = c("A", "A", "A", "B", "B")
)
df1
##   Name Value Indic Status
## 1  Joe  10.1     0      A
## 2  Joe  13.0     1      A
## 3 Bill   9.0     1      A
## 4  Jim   7.7     2      B
## 5 Kate  -3.0     2      B
```

Cela se réalise avec la fonction `dbWriteTable` : 


```r
dbWriteTable(DB, "dat1", df1) # write dataframe to the database
## [1] TRUE
```

Nous avons nommé le tableau `dat1` dans MySQL. Il apparaît maintenant dans la liste des tableaux de la base de données :


```r
dbListTables(DB)
## [1] "dat1"
```

La fonction `dbListFields` retourne les noms de ses colonnes :


```r
dbListFields(DB, "dat1")
## [1] "row_names" "Name"      "Value"     "Indic"     "Status"
```

Une colonne `row_names` a automatiquement été ajoutée par la fonction `dbWriteTable`. Voilà le tableau `dat1` visualisé dans MySQL :

```
mysql> SELECT * FROM dat1;
+-----------+------+-------+-------+--------+
| row_names | Name | Value | Indic | Status |
+-----------+------+-------+-------+--------+
| 1         | Joe  |  10.1 |     0 |      0 |
| 2         | Joe  |    13 |     1 |      0 |
| 3         | Bill |     9 |     1 |      0 |
| 4         | Jim  |   7.7 |     2 |      0 |
| 5         | Kate |    -3 |     2 |      0 |
+-----------+------+-------+-------+--------+
```
Si on ne veut pas la colonne `row_names`, il faut utiliser l'option `row.names=FALSE` lorsqu'on écrit le tableau : `dbWriteTable(DB, "dat1", df1, row.names=FALSE)`.  


Pour importer un tableau de MySQL dans R, on utilise `dbReadTable` :


```r
dbReadTable(DB, "dat1") # get database table as dataframe
##   Name Value Indic Status
## 1  Joe  10.1     0      A
## 2  Joe  13.0     1      A
## 3 Bill   9.0     1      A
## 4  Jim   7.7     2      B
## 5 Kate  -3.0     2      B
```

Notez que la colonne `row_names` ne se retrouve pas dans le tableau importé dans R.

## Exécuter une requête SQL  

La librairie `RMySQL` fournit deux fonctions pour exécuter une requête SQL sur un tableau : `dbSendQuery` et `dbGetQuery`. 

### Fonction `dbGetQuery`

La fonction `dbGetQuery` envoie une requête et retourne le résultat dans R. 
On peut l'utiliser par exemple pour la requête `DESCRIBE` :


```r
dbGetQuery(DB, "DESCRIBE dat1")
##       Field       Type Null Key Default Extra
## 1 row_names       text  YES        <NA>      
## 2      Name       text  YES        <NA>      
## 3     Value     double  YES        <NA>      
## 4     Indic bigint(20)  YES        <NA>      
## 5    Status       text  YES        <NA>
```

Ou pour une reqûete `SELECT` :


```r
dbGetQuery(DB, "SELECT * FROM dat1 WHERE Name='Joe';")
##   row_names Name Value Indic Status
## 1         1  Joe  10.1     0      A
## 2         2  Joe  13.0     1      A
```

Cela n'a pas altéré le tableau :


```r
dbReadTable(DB, "dat1") 
##   Name Value Indic Status
## 1  Joe  10.1     0      A
## 2  Joe  13.0     1      A
## 3 Bill   9.0     1      A
## 4  Jim   7.7     2      B
## 5 Kate  -3.0     2      B
```

La fonction `dbGetQuery` ne retourne rien lorsqu'on l'utilise pour exécuter une  requête qui altère le tableau, telle que `ALTER` ou `UPDATE` :


```r
dbGetQuery(DB, "ALTER TABLE `dat1` DROP COLUMN `Name`")
## data frame with 0 columns and 0 rows
dbGetQuery(DB, "UPDATE `dat1` SET `Value` = `Value`*2")
## data frame with 0 columns and 0 rows
```

Ces requêtes ont bien été exécutées :


```r
dbReadTable(DB, "dat1") 
##   Value Indic Status
## 1  20.2     0      A
## 2  26.0     1      A
## 3  18.0     1      A
## 4  15.4     2      B
## 5  -6.0     2      B
```

Il vaut mieux utiliser la fonction `dbSendQuery` pour exécuter ces requêtes. 

### Fonction `dbSendQuery`

Avant d'illustrer la fonction `dbSendQuery`, nous restaurons le tableau initial. Il faut d'abord l'effacer avec `dbRemoveTable` :


```r
dbRemoveTable(DB, "dat1")
## [1] TRUE
dbWriteTable(DB, "dat1", df1) 
## [1] TRUE
```

Exécutons la requête `ALTER` comme précédemment :


```r
dbSendQuery(DB, "ALTER TABLE `dat1` DROP COLUMN `Name`")
## <MySQLResult:31102696,3,18>
```

La requête a été exécutée. La fonction `dbSendQuery` retourne aussi un objet dans R : un "résultat". Si on le stocke dans une variable, on peut obtenir des informations sur ce résultat :


```r
res <- dbSendQuery(DB, "UPDATE `dat1` SET `Value` = `Value`*2")
dbGetStatement(res)
## [1] "UPDATE `dat1` SET `Value` = `Value`*2"
dbGetRowsAffected(res)
## [1] 5
```

La fonction `dbGetInfo` retourne toute une liste d'informations. 

La fonction `dbGetQuery` vue précédemment est en fait équivalente à `dbSendQuery` suivie de `dbFetch` :


```r
res <- dbSendQuery(DB, "SELECT * FROM dat1 WHERE Value > 20") 
dbColumnInfo(res)
##        name    Sclass      type length
## 1 row_names character BLOB/TEXT  65535
## 2     Value    double    DOUBLE     22
## 3     Indic    double    BIGINT     20
## 4    Status character BLOB/TEXT  65535
dbFetch(res)
##   row_names Value Indic Status
## 1         1  20.2     0      A
## 2         2  26.0     1      A
```

L'instruction `SELECT` n'effectue pas de transformation sur le tableau de données. C'est pourquoi il faut assigner le résultat de `dbSendQuery` dans une variable lorsqu'on effectue une requête `SELECT`. Par exemple le code suivant retourne une erreur, car une opération sur le tableau est en suspens :


```r
dbSendQuery(DB, "SELECT * FROM dat1 WHERE Value > 20") 
## <MySQLResult:85042008,3,21>
dbReadTable(DB, "dat1")
## Error in .local(conn, statement, ...): connection with pending rows, close resultSet before continuing
```



Assigner le résultat dans une variable permet d'effacer le résultat avec la fonction `dbClearResult`, ce qui annule l'opération en suspens : 


```r
res <- dbSendQuery(DB, "SELECT * FROM dat1 WHERE Value > 20") 
dbClearResult(res)
## [1] TRUE
dbReadTable(DB, "dat1")
##   Value Indic Status
## 1  20.2     0      A
## 2  26.0     1      A
## 3  18.0     1      A
## 4  15.4     2      B
## 5  -6.0     2      B
```

La fonction `dbHasCompleted` indique si un résultat est achevé ou non :


```r
res <- dbSendQuery(DB, "UPDATE `dat1` SET `Value` = `Value`*2")
dbHasCompleted(res)
## [1] TRUE
res <- dbSendQuery(DB, "SELECT * FROM dat1 WHERE Value > 20") 
dbHasCompleted(res)
## [1] FALSE
dbClearResult(res)
## [1] TRUE
dbHasCompleted(res)
## Error: Expired MySQLResult
```



## Annuler une requête 

Si on utilise la fonction `dbBegin` avant d'exécuter une requête, on peut annuler cette requête avec la fonction `dbRollback`. Par exemple :


```r
# SendQuery and Rollback
dbBegin(DB)
## [1] TRUE
res <- dbSendQuery(DB, "DELETE FROM dat1 WHERE Indic = 0") 
dbReadTable(DB, "dat1") # query is executed
##   Value Indic Status
## 2  52.0     1      A
## 3  36.0     1      A
## 4  30.8     2      B
## 5 -12.0     2      B
dbRollback(DB)
## [1] TRUE
dbReadTable(DB, "dat1") # query is cancelled
##   Value Indic Status
## 1  40.4     0      A
## 2  52.0     1      A
## 3  36.0     1      A
## 4  30.8     2      B
## 5 -12.0     2      B
dbClearResult(res)
## [1] TRUE
```


## Déconnexion 


```r
dbDisconnect(DB)
## [1] TRUE
```

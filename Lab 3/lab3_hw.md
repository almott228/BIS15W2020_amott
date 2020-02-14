---
title: "Lab 3 Homework"
author: "Andrea Mott"
date: "Winter 2020"
output:
  html_document: 
    keep_md: yes
    theme: spacelab
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run.  

## Load the tidyverse

```r
library(tidyverse)
```

## Data
For the homework, we will use data about vertebrate home range sizes. The data are in the class folder, but the reference is below.  

**Database of vertebrate home range sizes.**  
Reference: Tamburello N, Cote IM, Dulvy NK (2015) Energy and the scaling of animal space use. The American Naturalist 186(2):196-211. http://dx.doi.org/10.1086/682070.  
Data: http://datadryad.org/resource/doi:10.5061/dryad.q5j65/1  

1. Load the data into a new object called `homerange`.  

```r
homerange <- readr::read_csv("data/Tamburelloetal_HomeRangeDatabase.csv")
```

```
## Parsed with column specification:
## cols(
##   .default = col_character(),
##   mean.mass.g = col_double(),
##   log10.mass = col_double(),
##   mean.hra.m2 = col_double(),
##   log10.hra = col_double(),
##   preymass = col_double(),
##   log10.preymass = col_double(),
##   PPMR = col_double()
## )
```

```
## See spec(...) for full column specifications.
```

2. Use `spec()` to see the full details of the columns.

```r
spec(homerange)
```

```
## cols(
##   taxon = col_character(),
##   common.name = col_character(),
##   class = col_character(),
##   order = col_character(),
##   family = col_character(),
##   genus = col_character(),
##   species = col_character(),
##   primarymethod = col_character(),
##   N = col_character(),
##   mean.mass.g = col_double(),
##   log10.mass = col_double(),
##   alternative.mass.reference = col_character(),
##   mean.hra.m2 = col_double(),
##   log10.hra = col_double(),
##   hra.reference = col_character(),
##   realm = col_character(),
##   thermoregulation = col_character(),
##   locomotion = col_character(),
##   trophic.guild = col_character(),
##   dimension = col_character(),
##   preymass = col_double(),
##   log10.preymass = col_double(),
##   PPMR = col_double(),
##   prey.size.reference = col_character()
## )
```


3. Explore the data. Show the dimensions, column names, classes for each variable, and a statistical summary. Keep these as separate code chunks. 

```r
dim(homerange)
```

```
## [1] 569  24
```


```r
ncol(homerange)
```

```
## [1] 24
```


```r
class(homerange)
```

```
## [1] "spec_tbl_df" "tbl_df"      "tbl"         "data.frame"
```


```r
summary(homerange)
```

```
##     taxon           common.name           class              order          
##  Length:569         Length:569         Length:569         Length:569        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##     family             genus             species          primarymethod     
##  Length:569         Length:569         Length:569         Length:569        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##       N              mean.mass.g        log10.mass     
##  Length:569         Min.   :      0   Min.   :-0.6576  
##  Class :character   1st Qu.:     50   1st Qu.: 1.6990  
##  Mode  :character   Median :    330   Median : 2.5185  
##                     Mean   :  34602   Mean   : 2.5947  
##                     3rd Qu.:   2150   3rd Qu.: 3.3324  
##                     Max.   :4000000   Max.   : 6.6021  
##                                                        
##  alternative.mass.reference  mean.hra.m2          log10.hra     
##  Length:569                 Min.   :0.000e+00   Min.   :-1.523  
##  Class :character           1st Qu.:4.500e+03   1st Qu.: 3.653  
##  Mode  :character           Median :3.934e+04   Median : 4.595  
##                             Mean   :2.146e+07   Mean   : 4.709  
##                             3rd Qu.:1.038e+06   3rd Qu.: 6.016  
##                             Max.   :3.551e+09   Max.   : 9.550  
##                                                                 
##  hra.reference         realm           thermoregulation    locomotion       
##  Length:569         Length:569         Length:569         Length:569        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##  trophic.guild       dimension            preymass         log10.preymass   
##  Length:569         Length:569         Min.   :     0.67   Min.   :-0.1739  
##  Class :character   Class :character   1st Qu.:    20.02   1st Qu.: 1.3014  
##  Mode  :character   Mode  :character   Median :    53.75   Median : 1.7304  
##                                        Mean   :  3989.88   Mean   : 2.0188  
##                                        3rd Qu.:   363.35   3rd Qu.: 2.5603  
##                                        Max.   :130233.20   Max.   : 5.1147  
##                                        NA's   :502         NA's   :502      
##       PPMR         prey.size.reference
##  Min.   :  0.380   Length:569         
##  1st Qu.:  3.315   Class :character   
##  Median :  7.190   Mode  :character   
##  Mean   : 31.752                      
##  3rd Qu.: 15.966                      
##  Max.   :530.000                      
##  NA's   :502
```

4. Are there NA's in your data? Show the code that you would use to verify this, please.  

```r
anyNA(homerange)
```

```
## [1] TRUE
```
#Yes there are NAs. You could also use is.na(homestead)

5. Change the class of the variables `taxon` and `order` to factors and display their levels.  

```r
as.factor(homerange$taxon)
```

```
##   [1] lake fishes   river fishes  river fishes  river fishes  river fishes 
##   [6] river fishes  marine fishes marine fishes marine fishes marine fishes
##  [11] marine fishes marine fishes marine fishes lake fishes   lake fishes  
##  [16] lake fishes   river fishes  river fishes  lake fishes   lake fishes  
##  [21] marine fishes marine fishes marine fishes marine fishes marine fishes
##  [26] marine fishes marine fishes marine fishes marine fishes marine fishes
##  [31] marine fishes marine fishes marine fishes marine fishes marine fishes
##  [36] marine fishes marine fishes marine fishes marine fishes marine fishes
##  [41] marine fishes marine fishes marine fishes marine fishes marine fishes
##  [46] marine fishes marine fishes marine fishes marine fishes marine fishes
##  [51] marine fishes marine fishes marine fishes marine fishes marine fishes
##  [56] marine fishes marine fishes marine fishes marine fishes lake fishes  
##  [61] marine fishes marine fishes marine fishes marine fishes marine fishes
##  [66] marine fishes marine fishes marine fishes marine fishes marine fishes
##  [71] marine fishes marine fishes marine fishes marine fishes marine fishes
##  [76] marine fishes marine fishes marine fishes marine fishes marine fishes
##  [81] marine fishes marine fishes marine fishes marine fishes marine fishes
##  [86] marine fishes marine fishes marine fishes marine fishes marine fishes
##  [91] marine fishes marine fishes marine fishes marine fishes marine fishes
##  [96] marine fishes river fishes  river fishes  river fishes  river fishes 
## [101] lake fishes   river fishes  river fishes  river fishes  marine fishes
## [106] marine fishes marine fishes marine fishes marine fishes lake fishes  
## [111] marine fishes marine fishes marine fishes birds         birds        
## [116] birds         birds         birds         birds         birds        
## [121] birds         birds         birds         birds         birds        
## [126] birds         birds         birds         birds         birds        
## [131] birds         birds         birds         birds         birds        
## [136] birds         birds         birds         birds         birds        
## [141] birds         birds         birds         birds         birds        
## [146] birds         birds         birds         birds         birds        
## [151] birds         birds         birds         birds         birds        
## [156] birds         birds         birds         birds         birds        
## [161] birds         birds         birds         birds         birds        
## [166] birds         birds         birds         birds         birds        
## [171] birds         birds         birds         birds         birds        
## [176] birds         birds         birds         birds         birds        
## [181] birds         birds         birds         birds         birds        
## [186] birds         birds         birds         birds         birds        
## [191] birds         birds         birds         birds         birds        
## [196] birds         birds         birds         birds         birds        
## [201] birds         birds         birds         birds         birds        
## [206] birds         birds         birds         birds         birds        
## [211] birds         birds         birds         birds         birds        
## [216] birds         birds         birds         birds         birds        
## [221] birds         birds         birds         birds         birds        
## [226] birds         birds         birds         birds         birds        
## [231] birds         birds         birds         birds         birds        
## [236] birds         birds         birds         birds         birds        
## [241] birds         birds         birds         birds         birds        
## [246] birds         birds         birds         birds         birds        
## [251] birds         birds         birds         mammals       mammals      
## [256] mammals       mammals       mammals       mammals       mammals      
## [261] mammals       mammals       mammals       mammals       mammals      
## [266] mammals       mammals       mammals       mammals       mammals      
## [271] mammals       mammals       mammals       mammals       mammals      
## [276] mammals       mammals       mammals       mammals       mammals      
## [281] mammals       mammals       mammals       mammals       mammals      
## [286] mammals       mammals       mammals       mammals       mammals      
## [291] mammals       mammals       mammals       mammals       mammals      
## [296] mammals       mammals       mammals       mammals       mammals      
## [301] mammals       mammals       mammals       mammals       mammals      
## [306] mammals       mammals       mammals       mammals       mammals      
## [311] mammals       mammals       mammals       mammals       mammals      
## [316] mammals       mammals       mammals       mammals       mammals      
## [321] mammals       mammals       mammals       mammals       mammals      
## [326] mammals       mammals       mammals       mammals       mammals      
## [331] mammals       mammals       mammals       mammals       mammals      
## [336] mammals       mammals       mammals       mammals       mammals      
## [341] mammals       mammals       mammals       mammals       mammals      
## [346] mammals       mammals       mammals       mammals       mammals      
## [351] mammals       mammals       mammals       mammals       mammals      
## [356] mammals       mammals       mammals       mammals       mammals      
## [361] mammals       mammals       mammals       mammals       mammals      
## [366] mammals       mammals       mammals       mammals       mammals      
## [371] mammals       mammals       mammals       mammals       mammals      
## [376] mammals       mammals       mammals       mammals       mammals      
## [381] mammals       mammals       mammals       mammals       mammals      
## [386] mammals       mammals       mammals       mammals       mammals      
## [391] mammals       mammals       mammals       mammals       mammals      
## [396] mammals       mammals       mammals       mammals       mammals      
## [401] mammals       mammals       mammals       mammals       mammals      
## [406] mammals       mammals       mammals       mammals       mammals      
## [411] mammals       mammals       mammals       mammals       mammals      
## [416] mammals       mammals       mammals       mammals       mammals      
## [421] mammals       mammals       mammals       mammals       mammals      
## [426] mammals       mammals       mammals       mammals       mammals      
## [431] mammals       mammals       mammals       mammals       mammals      
## [436] mammals       mammals       mammals       mammals       mammals      
## [441] mammals       mammals       mammals       mammals       mammals      
## [446] mammals       mammals       mammals       mammals       mammals      
## [451] mammals       mammals       mammals       mammals       mammals      
## [456] mammals       mammals       mammals       mammals       mammals      
## [461] mammals       mammals       mammals       mammals       mammals      
## [466] mammals       mammals       mammals       mammals       mammals      
## [471] mammals       mammals       mammals       mammals       mammals      
## [476] mammals       mammals       mammals       mammals       mammals      
## [481] mammals       mammals       mammals       mammals       mammals      
## [486] mammals       mammals       mammals       mammals       mammals      
## [491] mammals       lizards       snakes        snakes        snakes       
## [496] snakes        snakes        snakes        snakes        snakes       
## [501] snakes        snakes        snakes        snakes        snakes       
## [506] snakes        snakes        snakes        snakes        snakes       
## [511] snakes        snakes        snakes        snakes        snakes       
## [516] snakes        snakes        lizards       lizards       lizards      
## [521] lizards       lizards       lizards       lizards       lizards      
## [526] lizards       snakes        lizards       snakes        snakes       
## [531] snakes        snakes        snakes        snakes        snakes       
## [536] snakes        snakes        snakes        snakes        snakes       
## [541] snakes        snakes        snakes        turtles       turtles      
## [546] turtles       turtles       turtles       turtles       turtles      
## [551] turtles       turtles       turtles       turtles       turtles      
## [556] turtles       tortoises     tortoises     tortoises     tortoises    
## [561] tortoises     tortoises     tortoises     tortoises     tortoises    
## [566] tortoises     tortoises     tortoises     turtles      
## 9 Levels: birds lake fishes lizards mammals marine fishes ... turtles
```


```r
as.factor(homerange$order)
```

```
##   [1] anguilliformes    cypriniformes     cypriniformes     cypriniformes    
##   [5] cypriniformes     esociformes       gadiformes        gadiformes       
##   [9] perciformes       perciformes       perciformes       perciformes      
##  [13] perciformes       perciformes       perciformes       perciformes      
##  [17] perciformes       perciformes       perciformes       perciformes      
##  [21] perciformes       perciformes       perciformes       perciformes      
##  [25] perciformes       perciformes       perciformes       perciformes      
##  [29] perciformes       perciformes       perciformes       perciformes      
##  [33] perciformes       perciformes       perciformes       perciformes      
##  [37] perciformes       perciformes       perciformes       perciformes      
##  [41] perciformes       perciformes       perciformes       perciformes      
##  [45] perciformes       perciformes       perciformes       perciformes      
##  [49] perciformes       perciformes       perciformes       perciformes      
##  [53] perciformes       perciformes       perciformes       perciformes      
##  [57] perciformes       perciformes       perciformes       perciformes      
##  [61] perciformes       perciformes       perciformes       perciformes      
##  [65] perciformes       perciformes       perciformes       perciformes      
##  [69] perciformes       perciformes       perciformes       perciformes      
##  [73] perciformes       perciformes       perciformes       perciformes      
##  [77] perciformes       perciformes       perciformes       perciformes      
##  [81] perciformes       perciformes       perciformes       perciformes      
##  [85] perciformes       perciformes       perciformes       perciformes      
##  [89] perciformes       perciformes       perciformes       perciformes      
##  [93] perciformes       perciformes       perciformes       perciformes      
##  [97] salmoniformes     salmoniformes     salmoniformes     salmoniformes    
## [101] salmoniformes     scorpaeniformes   scorpaeniformes   scorpaeniformes  
## [105] scorpaeniformes   scorpaeniformes   scorpaeniformes   scorpaeniformes  
## [109] scorpaeniformes   siluriformes      syngnathiformes   syngnathiformes  
## [113] tetraodontiformes accipitriformes   accipitriformes   accipitriformes  
## [117] accipitriformes   accipitriformes   accipitriformes   anseriformes     
## [121] apterygiformes    caprimulgiformes  charadriiformes   columbidormes    
## [125] columbiformes     columbiformes     coraciiformes     coraciiformes    
## [129] cuculiformes      cuculiformes      cuculiformes      cuculiformes     
## [133] falconiformes     falconiformes     falconiformes     falconiformes    
## [137] falconiformes     falconiformes     falconiformes     falconiformes    
## [141] falconiformes     falconiformes     falconiformes     falconiformes    
## [145] falconiformes     falconiformes     falconiformes     falconiformes    
## [149] falconiformes     galliformes       galliformes       galliformes      
## [153] galliformes       galliformes       galliformes       galliformes      
## [157] galliformes       gruiformes        gruiformes        gruiformes       
## [161] passeriformes     passeriformes     passeriformes     passeriformes    
## [165] passeriformes     passeriformes     passeriformes     passeriformes    
## [169] passeriformes     passeriformes     passeriformes     passeriformes    
## [173] passeriformes     passeriformes     passeriformes     passeriformes    
## [177] passeriformes     passeriformes     passeriformes     passeriformes    
## [181] passeriformes     passeriformes     passeriformes     passeriformes    
## [185] passeriformes     passeriformes     passeriformes     passeriformes    
## [189] passeriformes     passeriformes     passeriformes     passeriformes    
## [193] passeriformes     passeriformes     passeriformes     passeriformes    
## [197] passeriformes     passeriformes     passeriformes     passeriformes    
## [201] passeriformes     passeriformes     passeriformes     passeriformes    
## [205] passeriformes     passeriformes     passeriformes     passeriformes    
## [209] passeriformes     passeriformes     passeriformes     passeriformes    
## [213] passeriformes     passeriformes     passeriformes     passeriformes    
## [217] passeriformes     passeriformes     passeriformes     passeriformes    
## [221] passeriformes     passeriformes     passeriformes     passeriformes    
## [225] passeriformes     passeriformes     passeriformes     passeriformes    
## [229] passeriformes     passeriformes     pelecaniformes    pelecaniformes   
## [233] piciformes        piciformes        piciformes        piciformes       
## [237] piciformes        piciformes        piciformes        psittaciformes   
## [241] rheiformes        rheiformes        strigiformes      strigiformes     
## [245] strigiformes      strigiformes      strigiformes      strigiformes     
## [249] strigiformes      strigiformes      strigiformes      struthioniformes 
## [253] tinamiformes      afrosoricida      afrosoricida      artiodactyla     
## [257] artiodactyla      artiodactyla      artiodactyla      artiodactyla     
## [261] artiodactyla      artiodactyla      artiodactyla      artiodactyla     
## [265] artiodactyla      artiodactyla      artiodactyla      artiodactyla     
## [269] artiodactyla      artiodactyla      artiodactyla      artiodactyla     
## [273] artiodactyla      artiodactyla      artiodactyla      artiodactyla     
## [277] artiodactyla      artiodactyla      artiodactyla      artiodactyla     
## [281] artiodactyla      artiodactyla      artiodactyla      artiodactyla     
## [285] artiodactyla      artiodactyla      artiodactyla      artiodactyla     
## [289] artiodactyla      artiodactyla      artiodactyla      artiodactyla     
## [293] artiodactyla      artiodactyla      carnivora         carnivora        
## [297] carnivora         carnivora         carnivora         carnivora        
## [301] carnivora         carnivora         carnivora         carnivora        
## [305] carnivora         carnivora         carnivora         carnivora        
## [309] carnivora         carnivora         carnivora         carnivora        
## [313] carnivora         carnivora         carnivora         carnivora        
## [317] carnivora         carnivora         carnivora         carnivora        
## [321] carnivora         carnivora         carnivora         carnivora        
## [325] carnivora         carnivora         carnivora         carnivora        
## [329] carnivora         carnivora         carnivora         carnivora        
## [333] carnivora         carnivora         carnivora         carnivora        
## [337] carnivora         carnivora         carnivora         carnivora        
## [341] carnivora         carnivora         carnivora         carnivora        
## [345] carnivora         carnivora         carnivora         carnivora        
## [349] carnivora         carnivora         dasyuromorpha     dasyuromorpha    
## [353] dasyuromorpha     dasyuromorpia     didelphimorphia   didelphimorphia  
## [357] diprodontia       diprodontia       diprodontia       diprodontia      
## [361] diprodontia       diprodontia       diprodontia       diprodontia      
## [365] diprodontia       diprodontia       diprodontia       diprodontia      
## [369] diprotodontia     diprotodontia     diprotodontia     diprotodontia    
## [373] diprotodontia     diprotodontia     diprotodontia     erinaceomorpha   
## [377] erinaceomorpha    lagomorpha        lagomorpha        lagomorpha       
## [381] lagomorpha        lagomorpha        lagomorpha        lagomorpha       
## [385] lagomorpha        lagomorpha        lagomorpha        lagomorpha       
## [389] lagomorpha        lagomorpha        lagomorpha        macroscelidea    
## [393] macroscelidea     macroscelidea     monotrematae      peramelemorphia  
## [397] peramelemorphia   perissodactyla    perissodactyla    perissodactyla   
## [401] pilosa            proboscidea       proboscidea       roden            
## [405] rodentia          rodentia          rodentia          rodentia         
## [409] rodentia          rodentia          rodentia          rodentia         
## [413] rodentia          rodentia          rodentia          rodentia         
## [417] rodentia          rodentia          rodentia          rodentia         
## [421] rodentia          rodentia          rodentia          rodentia         
## [425] rodentia          rodentia          rodentia          rodentia         
## [429] rodentia          rodentia          rodentia          rodentia         
## [433] rodentia          rodentia          rodentia          rodentia         
## [437] rodentia          rodentia          rodentia          rodentia         
## [441] rodentia          rodentia          rodentia          rodentia         
## [445] rodentia          rodentia          rodentia          rodentia         
## [449] rodentia          rodentia          rodentia          rodentia         
## [453] rodentia          rodentia          rodentia          rodentia         
## [457] rodentia          rodentia          rodentia          rodentia         
## [461] rodentia          rodentia          rodentia          rodentia         
## [465] rodentia          rodentia          rodentia          rodentia         
## [469] rodentia          rodentia          rodentia          rodentia         
## [473] rodentia          rodentia          rodentia          rodentia         
## [477] rodentia          rodentia          rodentia          rodentia         
## [481] rodentia          soricomorpha      soricomorpha      soricomorpha     
## [485] soricomorpha      soricomorpha      soricomorpha      soricomorpha     
## [489] soricomorpha      soricomorpha      soricomorpha      squamata         
## [493] squamata          squamata          squamata          squamata         
## [497] squamata          squamata          squamata          squamata         
## [501] squamata          squamata          squamata          squamata         
## [505] squamata          squamata          squamata          squamata         
## [509] squamata          squamata          squamata          squamata         
## [513] squamata          squamata          squamata          squamata         
## [517] squamata          squamata          squamata          squamata         
## [521] squamata          squamata          squamata          squamata         
## [525] squamata          squamata          squamata          squamata         
## [529] squamata          squamata          squamata          squamata         
## [533] squamata          squamata          squamata          squamata         
## [537] squamata          squamata          squamata          squamata         
## [541] squamata          squamata          squamata          testudines       
## [545] testudines        testudines        testudines        testudines       
## [549] testudines        testudines        testudines        testudines       
## [553] testudines        testudines        testudines        testudines       
## [557] testudines        testudines        testudines        testudines       
## [561] testudines        testudines        testudines        testudines       
## [565] testudines        testudines        testudines        testudines       
## [569] testudines       
## 51 Levels: accipitriformes afrosoricida anguilliformes ... tinamiformes
```
#9 taxon levels, 51 order levels

6. Make a new dataframe `deer` that is limited to the mean mass, log10 mass, family, genus, and species of deer in the database. The family for deer is cervidae. Arrange the data in descending order by log10 mass. Which is the largest deer?  

```r
deer <- filter(homerange, family=="cervidae")
```


```r
deer %>%
  select(mean.mass.g, log10.mass, family, genus, species) %>% 
  arrange(desc(log10.mass))
```

```
## # A tibble: 12 x 5
##    mean.mass.g log10.mass family   genus      species    
##          <dbl>      <dbl> <chr>    <chr>      <chr>      
##  1     307227.       5.49 cervidae alces      alces      
##  2     234758.       5.37 cervidae cervus     elaphus    
##  3     102059.       5.01 cervidae rangifer   tarandus   
##  4      87884.       4.94 cervidae odocoileus virginianus
##  5      71450.       4.85 cervidae dama       dama       
##  6      62823.       4.80 cervidae axis       axis       
##  7      53864.       4.73 cervidae odocoileus hemionus   
##  8      35000.       4.54 cervidae ozotoceros bezoarticus
##  9      29450.       4.47 cervidae cervus     nippon     
## 10      24050.       4.38 cervidae capreolus  capreolus  
## 11      13500.       4.13 cervidae muntiacus  reevesi    
## 12       7500.       3.88 cervidae pudu       puda
```
#Alces alces is the largest deer (Mooooose)

7. As measured by the data, which snake species has the smallest homerange? Show all of your work, please. Look this species up online and tell me about it!  

```r
homerange %>% 
  filter(taxon=="snakes") %>% 
  select(genus, species, mean.hra.m2) %>% 
  arrange(mean.hra.m2)
```

```
## # A tibble: 41 x 3
##    genus       species      mean.hra.m2
##    <chr>       <chr>              <dbl>
##  1 bitis       schneideri          200 
##  2 carphopis   viridis             253 
##  3 thamnophis  butleri             600 
##  4 carphopis   vermis              700 
##  5 vipera      latastei           2400 
##  6 gloydius    shedaoensis        2614.
##  7 diadophis   punctatus          6476 
##  8 agkistrodon piscivorous       10655 
##  9 oocatochus  rufodorsatus      15400 
## 10 pituophis   catenifer         17400 
## # … with 31 more rows
```
#Bitis schneideri or the Namaqua Dwarf Adder is a small species of viper (possibly the world's smallest viper). It has evolved a higher rate of reproduction than members of the family Viperidae. Scientists believe this is due to its high rate of depredation within the small coastal region between Namibia and South Africa

8. You suspect that homerange and mass are correlated in birds. We need a ratio that facilitates exploration of this prediction. First, build a new dataframe called `hra_ratio` that is limited to genus, species, mean.mass.g, log10.mass, log10.hra. Arrange it in ascending order by mean mass in grams.  

```r
hra_ratio <- filter(homerange, taxon=="birds")
hra_ratio %>% 
  select(genus, species, mean.mass.g, log10.mass, log10.hra) %>% 
  arrange(mean.mass.g)
```

```
## # A tibble: 140 x 5
##    genus        species      mean.mass.g log10.mass log10.hra
##    <chr>        <chr>              <dbl>      <dbl>     <dbl>
##  1 regulus      regulus             5.15      0.712      4.30
##  2 regulus      ignicapillus        5.3       0.724      4.22
##  3 phylloscopus bonelli             7.5       0.875      4.54
##  4 aegithalos   caudatus            8         0.903      4.62
##  5 vireo        atricapillus        8.5       0.929      4.18
##  6 setophaga    magnolia            8.6       0.934      3.86
##  7 certhia      familiaris          8.77      0.943      4.67
##  8 sylvia       undata              8.8       0.944      3.45
##  9 setophaga    ruticilla           9         0.954      3.29
## 10 setophaga    virens              9         0.954      3.81
## # … with 130 more rows
```


9. Replace the existing `hra_ratio` dataframe with a new dataframe that adds a column calculating the ratio of log 10 hra to log 10 mass. Call it `hra.mass.ratio`. Arrange it in descending order by mean mass in grams.  

```r
hra_ratio_new <- 
hra_ratio %>% 
  mutate(hra.mass.ratio = log10.hra/log10.mass) %>% 
  select(genus, species, mean.mass.g, hra.mass.ratio, log10.mass, log10.hra ) %>% 
  arrange(desc(mean.mass.g))
```



10. What is the lowest mass for birds with a `hra.mass.ratio` greater than or equal to 4.0?

```r
hra_ratio_new %>% 
  filter(hra.mass.ratio>=4) %>% 
  arrange(mean.mass.g)
```

```
## # A tibble: 17 x 6
##    genus        species      mean.mass.g hra.mass.ratio log10.mass log10.hra
##    <chr>        <chr>              <dbl>          <dbl>      <dbl>     <dbl>
##  1 regulus      regulus             5.15           6.04      0.712      4.30
##  2 regulus      ignicapillus        5.3            5.82      0.724      4.22
##  3 phylloscopus bonelli             7.5            5.19      0.875      4.54
##  4 aegithalos   caudatus            8              5.12      0.903      4.62
##  5 vireo        atricapillus        8.5            4.49      0.929      4.18
##  6 setophaga    magnolia            8.6            4.13      0.934      3.86
##  7 certhia      familiaris          8.77           4.95      0.943      4.67
##  8 wilsonia     canadensis          9.3            4.14      0.968      4.01
##  9 troglodytes  troglodytes         9.5            4.10      0.978      4.01
## 10 cisticola    juncidis            9.8            4.20      0.991      4.16
## 11 vireo        belli              10              4.07      1          4.07
## 12 parus        carolinensis       10.1            4.16      1.00       4.18
## 13 hippolais    polyglotta         11              4.30      1.04       4.48
## 14 parus        palustris          11              4.18      1.04       4.36
## 15 spizella     passerina          12.2            4.13      1.09       4.49
## 16 contopus     virens             13.8            4.07      1.14       4.64
## 17 motacilla    alba               21.2            4.44      1.33       5.89
```
#5.15g is the lowest mass with an hra mass ratio >= 4.0 (Regulus regulus)

11. Do a search online; what is the common name of the bird from #8 above? Place a link in your markdown file that takes us to a webpage with information on its biology.  
[Canada Warbler] (https://www.allaboutbirds.org/guide/Canada_Warbler/id#)
#I thought the question was refering to #8 on the bird list (which was the canada warbler). I'm going to leave the link there because canada warbler are the best, but here is a link to the Goldcrest. 
[Goldcrest] (https://en.wikipedia.org/wiki/Goldcrest)

12. What is the `hra.mass.ratio` for an ostrich? Show your work, please.

```r
hra_ratio_new %>%
  filter(genus=="struthio" & species=="camelus") %>% 
  select(genus, species, hra.mass.ratio)
```

```
## # A tibble: 1 x 3
##   genus    species hra.mass.ratio
##   <chr>    <chr>            <dbl>
## 1 struthio camelus           1.60
```


## Push your final code to GitHub!
Please be sure that you have check the `keep md` file in the knit preferences.  

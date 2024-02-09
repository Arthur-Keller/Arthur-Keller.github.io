# Expansion de noms de fichiers

## Exercice 1.1 Globbing - exercices de base

#### Q1: Affichez la liste des fichiers dans le répertoire **/bin/**

##### Dont les noms contiennent :
- au moins trois caractères
```bash
echo /bin/???
```

- au moins deux tirets
```bash
echo /bin/*[-]*[-]*
```

- au moins une occurrence de la lettre i après une occurrence de la lettre z ;
```bash
echo /bin/*z*i*
echo /bin/*zi*
```

##### Dont les noms ne commencent ni par une lettre ni par un chiffre;
```bash
echo /bin/[!0-9a-zA-Z]
```
##### Dont les noms commencent par les lettres w, y ou z et ne terminent pas par un chiffre.
```bash
echo /bin/[wyz]*[!0-9]
```

## Exercice 1.2 : Globbing et filtres

#### Q2: A l’aide des commandes *stat* et *grep*, affichez la taille et le nom des dossiers dans la racine *(/)* dont n’avez pas le droit de franchissement. Pour cela, cherchez dans le manuel comment utiliser l’option *-c* de *stat*.
```bash
stat -c "%A%n" /* | grep ".........-"
```

#### Q3: Le dossier */etc/cron.weekly/* contient des scripts qui doivent être exécutés hebdomadairement (nous reviendrons sur ce sujet la semaine prochaine). À l’aide des commandes *cat* et *grep*, affichez toutes les lignes en commentaire dans les scripts se trouvant dans */etc/cron.weekly/*.
```bash
cat /etc/cron.weekly/* | grep -E "#+"
```

#### Q4: Refaites la question précédente en utilisant la commande *find* avec l’option *-exec*.
```bash
find /etc/cron.weekly/* -exec cat {} \; | grep -E "^#+"
```
#### Q5: En utilisant une ligne de commande, affichez le nom et la taille des fichiers *.txt* à l’intérieur de chaque dossier dans *∼*.
```bash
find ~/ -name \*.txt -exec stat -c %s%n {} \;
```

# 2 Expressions régulières 1 2

## Exercice 2.1 : Expressions régulières

#### Q6: En prenant en compte la syntaxe présentée dans le Tableau ci-dessus, trouvez les expressions régulières (les plus simples possibles) qui décrivent les ensembles de chaînes de caractères ci-dessus. Vous pouvez tester vos réponses à l’aide de la commande *cat | grep -x -E -e <expression>* en replaçant *<expression>* par votre réponse à chaque question. L’option *-x* de *grep* sert à sélectionner seulement les correspondances exactes de ligne entière. Pour chaque ligne saisie sur le terminal, la ligne sera réaffichée seulement si elle apparie avec l’expression régulière donnée.

- Zéro ou plus lettres ‘a’ : {∅,a,aa,aaa,aaaa,...}
```bash
cat | grep -x -E -e "a*"
```

- Deux jusqu’à cinq lettres ‘a’ : {aa,aaa,aaaa,aaaaa}
```bash
cat | grep -x -E -e "a{2,5}"
```

- Toutes les chaînes ne contenant pas une suite de deux ou plus occurrences de la lettre a (e.g. l’expression doit apparier avec les chaînes abcdaed, bcdrt et abababa, mais pas avec aabcdet ni bcdaa)
```bash
cat | grep -x -E -e "[^a]*(a[^a]+)*a?"
```

- Les cinq chaînes suivantes : {tata,tete,titi,toto,tutu}
```bash
cat | grep -x -E -e "((ta)|(ti)|(to)|(tu)|(te))((ta)|(ti)|(to)|(tu)|(te))"
```

- Les 25 chaînes suivantes : {tata,tate,...,tatu,teta,tete,...tetu,...,tutu}
```bash
cat | grep -x -E -e "(t[aeiou]){2}"
```

- L’ensemble de mots-clés en bash : {for,while,case,if,else}
```bash
cat | grep -x -E -e "((for)|(while)|(case)|(if)|(else))"
```

#### Q7: Donnez la chaîne de caractères la plus courte qui apparie avec l’expression régulière suivante :
> ((pa)+e?r)+[!f]*f+((aite)|(ait))+
```bash
# Commande utilisé
cat | grep -x -E -e "((pa)+e?r)+[!f]*f+((aite)|(ait))+"

# Plus courte réponse 
parfait
```

#### Q8: Étant donnée le texte ci-dessous 4 , donnez l’expression régulière la plus succincte permettant de retrouver tous les verbes soulignés.

> L’année prochaine, Fathia aura 25 ans, elle **va changer** de vie : elle **va arrêter** de travailler, elle **va partir** de son appartement, elle ira à la campagne. Elle **va vendre** sa voiture, elle fera de nouvelles études, elle **va rentrer** d’autres amis et, ensemble, ils **vont sortir** au cinéma : ils **vont regarder** des films du cinéma asiatique. Moi... je ne serai pas comme elle, je resterai ici !

```bash
cat futur.txt | grep -E -e "va [^ ]+|vont [^ ]+"
```

#### Q11: Dans une seule ligne de commande, remplacez tous les verbes soulignés par leurs correspondants au futur simple à l’aide de la commande *sed*.

## Exercice 2.2 : Globbing, Regex et Scripts
#### Q12) Créez un script nommé *cherche_motif* qui prend en entrée un chemin *R* vers un dossier et une chaîne de caractères *C* et qui renvoie la liste de fichiers/dossiers dans *R* dont le nom contient *C*. Si le répertoire *R* n’existe pas ou s’il n’est pas accessible, la commande ne doit rien afficher sur la sortie standard.
```bash
#!/bin/bash

CHEMIN="$1"
CHAINE="$2"

ls "$CHEMIN" 2>/dev/null | grep "$CHAINE" 2>/dev/null
```

```bash
# Exemple d'utilisation
./cherche_motif 'Repertoire souhaité' 'Lettre voulu'
```


#### Q13: Créez un script nommé *remplace_repetition_motif* qui prend en entrée un chemin *F* vers un fichier de texte et une chaîne *C* de caractères et qui remplace toutes les répétitions de *C* dans *F* (c.-à-d. *CC*, *CCC*, *CCC*, *CCCC*, ...) par un seul *C*. La commande ne doit rien afficher sur la sortie standard.
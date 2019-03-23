# mado-git-flow

## Git flow

`mado-git-flow` é un wrapper del piú noto [git flow](https://github.com/petervanderdoes/gitflow-avh)

## Installazione

### Git

```
git clone https://github.com/studiomado/mado-git-flow.git  ~/.gim
~/.gim/init.sh
```

### Makefile

```make init```

## Utilizzo

#### Inizializzazione di un repository

Sia che si tratti di un repository nuovo o giá esistente:

```
gim init
```

### Creazione di una nuova feature

```
gim feature
```

### Creazione di un hotfix

```
gim hotfix
```
il branch di bugfix viene gestito come quello di feature, serve solo per indicare che è un fix che viene fatto su una feature già mergiata

### Creazione di un bugfix

```
gim hotfix
```

Viene creato un branch denominato con la versione con la patch version automaticamente ricavata dalla versione corrente del repository

### Creazione di una release

```
gim release
```

### Commit

```
gim commit
```

alias di `git commit -A`
Prima della scrittura del messaggio viene richiesto il codice del task ed il tipo di commit (vedere [Conventional commit](https://www.conventionalcommits.org/en/v1.0.0-beta.3/))

### Delete

```
gim delete
```

elimina branch corrente

#### Merge e cancellazione del branch

```
gim finish
```

Effettua merge del branch corrente; le operazioni effettuate dipendono dalla natura del ramo (`feature`, `hotfix`, `release`, `develop`) (vedere `git flow` per maggiori dettagli)

### Push del branch corrente

```
gim publish
```

## Risorse

- [git flow](https://github.com/~/gitflow-avh)
- [conventional commit](https://www.conventionalcommits.org/en/v1.0.0-beta.3/)

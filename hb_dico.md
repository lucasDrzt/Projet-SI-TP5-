# Dictionnaire de Données


**Table : `Employés`**
| Attribut        | Type de Données | Contraintes                         | Description                                  |
|-----------------|-----------------|-------------------------------------|----------------------------------------------|
| id_employé      | INT             | Clé primaire, Auto-incrément        | Identifiant unique de l'employé              |
| nom             | VARCHAR(50)     | Non nul                             | Nom de l'employé                             |
| prénom          | VARCHAR(50)     | Non nul                             | Prénom de l'employé                          |
| âge             | INT             | Non nul, >= 18                      | Âge de l'employé                             |
| date_arrivée    | DATE            | Non nul                             | Date d'arrivée de l'employé dans l'usine     |
| date_départ     | DATE            | Nullable                            | Date de départ de l'employé                  |

**Table : `Fournisseurs`**
| Attribut          | Type de Données | Contraintes                         | Description                                  |
|-------------------|-----------------|-------------------------------------|----------------------------------------------|
| id_fournisseur    | INT             | Clé primaire, Auto-incrément        | Identifiant unique du fournisseur            |
| nom               | VARCHAR(100)    | Non nul                             | Nom du fournisseur                           |

**Table : `Livraisons`**
| Attribut          | Type de Données | Contraintes                         | Description                                  |
|-------------------|-----------------|-------------------------------------|----------------------------------------------|
| id_livraison      | INT             | Clé primaire, Auto-incrément        | Identifiant unique de la livraison           |
| id_fournisseur    | INT             | Clé étrangère vers `Fournisseurs`   | Identifiant du fournisseur                   |
| date_livraison    | DATE            | Non nul                             | Date de livraison                            |
| quantité_pieces   | INT             | Non nul, >= 0                       | Quantité de pièces livrées                   |

**Table : `Robots`**
| Attribut          | Type de Données | Contraintes                         | Description                                  |
|-------------------|-----------------|-------------------------------------|----------------------------------------------|
| id_robot          | INT             | Clé primaire, Auto-incrément        | Identifiant unique du robot                  |
| date_production   | DATE            | Non nul                             | Date de production du robot                  |
| quantité_produite | INT             | Non nul, >= 0                       | Quantité de robots produits ce jour-là       |

## Usine Rachetée

**Table : `Employés_Rachetée`**
| Attribut        | Type de Données | Contraintes                         | Description                                  |
|-----------------|-----------------|-------------------------------------|----------------------------------------------|
| id_employé      | INT             | Clé primaire, Auto-incrément        | Identifiant unique de l'employé              |
| prénom          | VARCHAR(50)     | Non nul                             | Prénom de l'employé                          |
| nom             | VARCHAR(50)     | Non nul                             | Nom de l'employé                             |
| date_démarrage  | DATE            | Non nul                             | Date de démarrage de l'employé dans l'usine  |
| présent         | BOOLEAN         | Non nul                             | Présence dans les effectifs                  |

**Table : `Fournisseurs_Rachetée`**
| Attribut          | Type de Données | Contraintes                         | Description                                  |
|-------------------|-----------------|-------------------------------------|----------------------------------------------|
| id_fournisseur    | INT             | Clé primaire, Auto-incrément        | Identifiant unique du fournisseur            |
| nom               | VARCHAR(100)    | Non nul                             | Nom du fournisseur                           |

**Table : `Livraisons_Rachetée`**
| Attribut          | Type de Données | Contraintes                         | Description                                  |
|-------------------|-----------------|-------------------------------------|----------------------------------------------|
| id_livraison      | INT             | Clé primaire, Auto-incrément        | Identifiant unique de la livraison           |
| id_fournisseur    | INT             | Clé étrangère vers `Fournisseurs_Rachetée` | Identifiant du fournisseur                   |
| date_livraison    | DATE            | Non nul                             | Date de livraison                            |
| quantité_pieces   | INT             | Non nul, >= 0                       | Quantité de pièces livrées                   |
| id_employé_recepteur | INT          | Clé étrangère vers `Employés_Rachetée` | Identifiant de l'employé ayant réceptionné   |

**Table : `Pièces_Utilisées`**
| Attribut          | Type de Données | Contraintes                         | Description                                  |
|-------------------|-----------------|-------------------------------------|----------------------------------------------|
| id_utilisation    | INT             | Clé primaire, Auto-incrément        | Identifiant unique de l'utilisation          |
| date_utilisation  | DATE            | Non nul                             | Date d'utilisation des pièces                |
| quantité_utilisée | INT             | Non nul, >= 0                       | Quantité de pièces utilisées                 |

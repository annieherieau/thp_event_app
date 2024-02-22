# Thp Event app

Site où les utilisateurs peuvent créer des événements, et s'inscrire aux événements.
THP Projet validant du 20/02/2024

## Fonctionnalités

- Page d'accueil : liste des évènements
- Page évènement :  infos de l'événement (description, date, durée, prix, nombre de participants)
- Utilisateurs inscrits : s'inscrire / se connecter, profil (voir / éditer / ajouter une photo / supprimer son compte), créer un événement, s'inscrire à un évènement, payer via CB
- Créateur de l'évènement: éditer, voir la liste des participants, supprimer
- Interface administrateur
- Emailing via Mailjet
- API de paiement Stripe

## Installation

Clone repository

Install dépendencies

```bash
  $ bundle install
```

Install Database : create tables

```bash
  $ rails db:create
  $ rails db:migrate
  $ rails db:seed # for seeding
```

To launch server

```bash
  $ bin/rails server
```

## Todo List:
- event: destroy (+ attendees + mail)
- User: Update, delete, ajouter une photo
- Devise : mailer
- désincription à un event si payant + refund ?
- Interface administrateur

# reSea Express

Backend REST per un e-commerce di prodotti eco-sostenibili a tema marino, con gestione ordini, catalogo prodotti/categorie, notifiche email e un assistente AI integrato.

## Indice

- [Descrizione](#descrizione)
- [Stack Tecnologico](#stack-tecnologico)
- [Prerequisiti](#prerequisiti)
- [Installazione](#installazione)
- [Configurazione ambiente](#configurazione-ambiente)
- [Setup del database](#setup-del-database)
- [Utilizzo](#utilizzo)
- [Struttura del progetto](#struttura-del-progetto)
- [Endpoint principali](#endpoint-principali)
- [Contributi](#contributi)
- [Licenza](#licenza)

## Descrizione

reSea Express espone le API necessarie a un negozio online di prodotti eco-sostenibili: ogni prodotto è associato a una quantità di plastica risparmiata (`plastic_offset_kg`), tracciata a livello di database. Il backend gestisce il catalogo prodotti e categorie, la creazione e consultazione degli ordini con relativo invio di email transazionali (conferma d'ordine per il cliente, notifica per l'amministratore), ed espone inoltre un endpoint `/agent` che inoltra le richieste dell'utente a un assistente AI basato su Claude tramite LangChain.

## Stack Tecnologico

- **Node.js** (ES Modules)
- **Express 5** — framework HTTP e routing
- **MySQL** (`mysql2`) — persistenza dati
- **Nodemailer** + **Handlebars** — invio email transazionali con template
- **LangChain** + **@langchain/anthropic** — assistente AI (Claude)
- **CORS** — gestione delle richieste cross-origin

> Il repository contiene esclusivamente il backend.

## Frontend
Questa API è progettata per servire il client web. Puoi trovare il repository del frontend qui:
[reSea Frontend](https://github.com/francesco-cassese/reSea-Frontend)

## Prerequisiti

- [Node.js](https://nodejs.org/) 18 o superiore
- [pnpm](https://pnpm.io/) come gestore di pacchetti
- Un'istanza MySQL raggiungibile
- Credenziali SMTP (es. account Gmail) per l'invio delle email
- Una API key Anthropic (Claude) per l'endpoint `/agent`

## Installazione

Clona il repository e installa le dipendenze con pnpm:

```bash
git clone <url-del-repository>
cd reSea-Express
pnpm install
```

## Configurazione ambiente

Copia il file `.env.example` in `.env` e valorizza le variabili richieste:

```bash
cp .env.example .env
```

```env
PORT=
HOST=
URL=
DB_HOSTNAME=
DB_PORT=
DB_USERNAME=
DB_PASSWORD=
DB_DATABASE=

SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USERNAME=your_gmail_address
SMTP_PASSWORD=your_gmail_password

# usa l'email che dovrà ricevere l'avviso del nuovo ordine ricevuto
ADMIN_EMAIL=admin@example.com

CLAUDE_API_KEY=
```

| Variabile | Descrizione |
|---|---|
| `PORT`, `HOST`, `URL` | Configurazione dell'indirizzo su cui viene esposto il server |
| `DB_HOSTNAME`, `DB_PORT`, `DB_USERNAME`, `DB_PASSWORD`, `DB_DATABASE` | Credenziali di connessione al database MySQL |
| `SMTP_HOST`, `SMTP_PORT`, `SMTP_USERNAME`, `SMTP_PASSWORD` | Credenziali SMTP per l'invio delle email transazionali |
| `ADMIN_EMAIL` | Indirizzo email che riceve la notifica di ogni nuovo ordine |
| `CLAUDE_API_KEY` | API key Anthropic usata dall'endpoint `/agent` |

## Setup del database

Prima di avviare il server, importa lo schema e i dati in un database MySQL usando uno dei dump presenti in `database/dump/` (si consiglia il più recente, `DB_Dump4.sql`):

```bash
mysql -u <utente> -p <nome_database> < database/dump/DB_Dump4.sql
```

## Utilizzo

Avvio standard del server:

```bash
pnpm start
```

Avvio in modalità sviluppo, con riavvio automatico ad ogni modifica (`node --watch`):

```bash
pnpm watch
```

Non è previsto alcuno step di build: il progetto è un backend Node.js in ES Modules eseguito direttamente, senza bundler.

## Struttura del progetto

```
├── config/       # Configurazione (es. transporter Nodemailer)
├── controllers/  # Logica delle route (agent, categories, orders, products)
├── database/     # Connessione MySQL e dump SQL
├── middleware/   # Validatori delle richieste
├── public/       # Asset statici serviti su /assets
├── routers/      # Definizione delle route Express
├── services/      # Servizi (invio email, integrazione agente AI)
├── templates/    # Template Handlebars per le email
├── utils/        # Funzioni di utilità
└── server.js     # Entry point dell'applicazione
```

## Endpoint principali

| Metodo | Endpoint | Descrizione |
|---|---|---|
| `GET` | `/products` | Elenco prodotti, con filtri per query/categoria |
| `GET` | `/products/best-sellers` | Prodotti più venduti |
| `GET` | `/products/:slug` | Dettaglio prodotto |
| `GET` | `/categories` | Elenco categorie |
| `GET` | `/categories/:slug` | Dettaglio categoria |
| `GET` | `/orders` | Elenco ordini |
| `POST` | `/orders` | Creazione di un nuovo ordine (con invio email di conferma/notifica) |
| `POST` | `/agent` | Richiesta all'assistente AI (Claude via LangChain) |

Gli asset statici sono serviti sotto `/assets`. Le richieste a rotte inesistenti restituiscono una risposta 404 in formato JSON.

## Contributi

Progetto sviluppato dal **Gruppo 2**:

- [Sara Luongo](https://github.com/Sara-Luongo)
- [Abdeslam ElFtouh](https://github.com/AbdeslamElFtouh)
- [Raffaele De Pasca](https://github.com/depasca-raffaele)
- [Antonino Bellia](https://github.com/BelliaNino)
- [Francesco Cassese](https://github.com/francesco-cassese)

## Licenza

Progetto didattico a uso privato, sviluppato nell'ambito di un project work Boolean.

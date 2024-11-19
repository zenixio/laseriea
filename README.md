# ⚽️ **LaSerieA App** 
Un'app moderna e intuitiva per gli appassionati del calcio italiano, con un focus sulla Serie A!  

![LaSerieA Logo](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTZzOvLvPNvyjPNlFMSH9pFu9ebR_7pPT3gQ&s)  
*Un'app che combina notizie, social e funzionalità interattive in un'unica piattaforma elegante.*



## 📋 **Indice**
- [📖 Descrizione del Progetto](#-descrizione-del-progetto)
- [🚀 Funzionalità Principali](#-funzionalità-principali)
- [💡 Scelte Tecnologiche](#-scelte-tecnologiche)
- [🛠️ Librerie Utilizzate](#️-librerie-utilizzate)
- [📂 Struttura delle Cartelle](#-struttura-delle-cartelle)
- [🏁 Avvio del Progetto](#-avvio-del-progetto)
- [👨‍💻 Autore](#-autore)



## 📖 **Descrizione del Progetto**
**LaSerieA** è un'app costruita per portare la passione del calcio italiano direttamente sul tuo dispositivo.  
Pensata per:
- 📰 Tenerti aggiornato con le ultime notizie della Serie A tramite feed RSS da **Gazzetta.it**.
- 📱 Connetterti con il profilo Instagram ufficiale della Serie A.
- 🖼️ Consentirti di caricare e salvare immagini nella memoria locale per consultarle in qualsiasi momento.

Flutter è stato scelto come framework per la sua versatilità, performance, e per la possibilità di creare un'esperienza utente nativa e fluida su **iOS**, **Android**, e **Web**, utilizzando un unico codice base.



## 🚀 **Funzionalità Principali**
1. 📰 **Home Page**: 
   - Raccoglie e visualizza i feed RSS sulle ultime notizie della Serie A dal sito ufficiale **Gazzetta.it**.
2. 📸 **Gestione Immagini**:
   - Carica un'immagine dal dispositivo e salvala nella memoria locale.
   - Visualizza l'immagine salvata ogni volta che desideri.
3. 🔗 **Instagram Integration**:
   - Apri l'app di Instagram direttamente dalla pagina dedicata e visita il profilo ufficiale della Serie A.



## 💡 **Scelte Tecnologiche**
### Perché Flutter?  
- **Cross-platform**: Sviluppo di app native per Android, iOS e Web con un unico codice base.
- **Velocità di sviluppo**: Grazie all'hot reload e un vasto ecosistema di widget.
- **UI personalizzabile**: Design accattivanti con animazioni fluide.

### Perché **BLoC**?  
- **Gestione dello stato reattiva**: Per gestire complesse logiche di stato in modo organizzato e scalabile.
- **Testabilità**: Favorisce il testing isolato e un codice più pulito.



## 🛠️ **Librerie Utilizzate**
| Libreria                        | Versione  |   Descrizione                       |
|---------------------------------|-----------|-------------------------------------|
| **`appcheck`**                  | ^1.5.2    | Per controllare app native.         |
| **`dio`**                       | ^5.7.0    | HTTP client per feed RSS.           |
| **`equatable`**                 | ^2.0.5    | Confronti eleganti di oggetti.      |
| **`file_picker`**               | ^8.1.4    | Selezione immagini da file.         |
| **`flutter_bloc`**              | ^8.1.6    | Gestione stato scalabile.           |
| **`flutter_secure_storage`**    | ^9.2.2    | Memorizzazione sicura di dati.      |
| **`get_it`**                    | ^8.0.2    | Dependency injection semplice.      |
| **`image_picker`**              | ^1.1.2    | Selezione immagini dispositivo.     |
| **`url_launcher`**              | ^6.3.1    | Apertura link esterni.              |
| **`webview_flutter`**           | ^4.8.0    | Visualizzazione contenuti web.      |
| **`xml`**                       | ^6.5.0    | Parsing di feed RSS in XML.         |



## 📂 **Struttura (short) delle Cartelle**
```plaintext
lib/
...
└── features/
    ├── feature/
    │   ├── domain/
    │   │   ├── entities/
    │   │   └── repositories/
    │   ├── presentation/
    │   │   ├── bloc/
    │   │   ├── widgets/
    │   │   └── screens/
    └── ...
```

## 🏁 **Avvio del Progetto**

### Prerequisiti  
- **Flutter SDK** (versione >= 3.10.0)  
- **Dart SDK** (versione >= 3.0.0)  

### Installazione  
1. Clona il repository:  
    ```bash
    git clone https://github.com/tuo-username/LaSerieA.git
    cd LaSerieA
    ```
2. Installa le dipendenze:
    ```bash
    flutter pub get
    ```
3. Avvia l'app:
    ```bash
    flutter run
    ```

## 👨‍💻 Autore

    Made with ❤️ by Drago Picari.

# IOS\_Assessment\_Notes

SwiftUI notes app built with **MVVM**. Two pages: **Add Note** (shows current time from an API and validates non-empty input) and **All Notes** (lists, edits, deletes, and paginates notes 10 at a time). Navigation is via a custom **side drawer**.

> **Notes:** Per reviewer guidance, networking uses **timeapi.io** (instead of worldtimeapi.org). Persistence uses **Core Data**, which has been accepted by the reviewer for this assignment.

---

## Demo

* **Video:** [https://drive.google.com/file/d/1KoSBqhZDoEte6Bgy-fKZ7lRA47PgaE9o/view?usp=sharing](https://drive.google.com/file/d/1KoSBqhZDoEte6Bgy-fKZ7lRA47PgaE9o/view?usp=sharing)

## Screenshots

<p align="center">
<img width="196" height="426" alt="IMG_3618" src="https://github.com/user-attachments/assets/b24973a1-3436-44ec-8d93-194b6e90224a" />
<img width="196" height="426" alt="IMG_3616" src="https://github.com/user-attachments/assets/3e0902f4-90cf-4fdf-98b1-6525e162f8f5" />
<img width="196" height="426" alt="IMG_3615" src="https://github.com/user-attachments/assets/2d35e84a-1839-40e3-8cf0-9c3bd998f1e2" />
</p>
<p align="center">
<img width="196" height="426" alt="IMG_3614" src="https://github.com/user-attachments/assets/2bcc79a0-0bd6-454c-957c-5c2d9c85e89c" />
<img width="196" height="426" alt="IMG_3613" src="https://github.com/user-attachments/assets/fd85ead3-341c-4d03-97f3-df6be70f74f1" />
<img width="196" height="426" alt="IMG_3612" src="https://github.com/user-attachments/assets/53068430-94fc-4cea-a72d-2d5d1c8af8a8" />
</p>
<p align="center">
<img width="196" height="426" alt="IMG_3611" src="https://github.com/user-attachments/assets/1c46a575-56a1-4bd6-9aa0-eceef9841523" />
</p>

---

## Requirements Checklist

### Core & Architecture

* ✅ iOS Swift application
* ✅ SwiftUI UI layer
* ✅ MVVM architecture (`AddNoteViewModel`, `NotesListViewModel`)
* ✅ App drawer for navigation (`DrawerView` + `NavigationMenu` + `ToolbarView`)
* ✅ Standard library networking (`URLSession`)

### Data & UX

* ✅ Persistence accepted as **Core Data**
* ✅ Validate note is not empty in add form
* ✅ Delete confirmation popup

### Bonus

* ✅ Pagination: show **10** notes at a time
* ⛔ Arabic & English localization (not implemented)

### Functionalities

* ✅ Page 1: Add note with validation + show time (from **timeapi.io** per reviewer)
* ✅ Page 2: List notes (with pagination)
* ✅ Edit notes
* ✅ Delete notes (with confirmation)

---

## Project Structure

```
IOS_Assessment_Notes/
└─ IOS_Assessment_Notes/
   ├─ DrawerViews/
   │  ├─ DrawerView.swift
   │  ├─ NavigationDrawerRowType.swift
   │  ├─ NavigationMenu.swift
   │  └─ ToolbarView.swift
   ├─ Home/
   │  ├─ AddNoteViewModel.swift
   │  └─ HomeView.swift
   ├─ List/
   │  ├─ EditNoteView.swift
   │  ├─ NotesListView.swift
   │  └─ NotesListViewModel.swift
   ├─ Model/
   │  ├─ Model.xcdatamodeld
   │  └─ Note.swift
   ├─ Network/
   │  └─ TimeService.swift
   ├─ Persistence/
   │  ├─ NoteEntity.swift
   │  ├─ NotesRepository.swift
   │  └─ PersistenceController.swift
   ├─ Assets.xcassets
   ├─ ContentView.swift
   ├─ IOS_Assessment_NotesApp.swift
   └─ README.md
```

---

## Key Components

* **DrawerView / NavigationMenu / ToolbarView** – Custom side drawer with dim background and a leading toolbar button.
* **HomeView** – Add note UI with `TextEditor`, shows formatted time from the API, and saves via repository.
* **NotesListView** – Lists notes, supports tap-to-edit, swipe actions, infinite scroll, and delete with confirmation popup.
* **EditNoteView** – Edits a note; disables **Save** when empty.
* **AddNoteViewModel / NotesListViewModel** – MVVM state holders; perform validation, pagination (10), and CRUD via repository.
* **TimeService** – `URLSession` networking (uses **timeapi.io** per reviewer’s instruction).

---

## How to Run

* Xcode **15+** recommended; iOS **17+** target.
* Open the project and run on a simulator or device.
* No third-party networking frameworks required.

---

## Repository

GitHub: [https://github.com/AbdullahHafiz30/IOS\_Assessment\_Notes.git](https://github.com/AbdullahHafiz30/IOS_Assessment_Notes.git)

---

## License

**Unlicensed.** No license file is provided; all rights reserved by the author.
For reuse or distribution, please contact the repository owner.


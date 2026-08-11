
# ⚔️ Grand Strife: Civil War

<div align="center">

[![Game Engine](https://img.shields.io/badge/Engine-Godot%20%2F%20Custom-blueviolet?style=for-the-badge&logo=godotengine)](https://godotengine.org)
[![Genre](https://img.shields.io/badge/Genre-RPG%20%7C%20Survival-informational?style=for-the-badge)](https://en.wikipedia.org/wiki/Role-playing_video_game)
[![Status](https://img.shields.io/badge/Status-In%20Development-orange?style=for-the-badge)](https://github.com)
[![License: Non-Commercial](https://img.shields.io/badge/License-Non--Commercial-red.svg?style=for-the-badge)](LICENSE)

*A gritty 2D dark fantasy RPG and survival experience set in a crumbling medieval world consumed by civil war.*

</div>

---

## 📜 Table of Contents
- [About The Project](#-about-the-project)
- [Design Philosophy & Vision](#-design-philosophy--vision)
- [World & Lore](#-world--lore)
- [Core Gameplay Mechanics](#-core-gameplay-mechanics)
- [Technical Approach & Architecture](#-technical-approach--architecture)
- [Roadmap & Development Status](#-roadmap--development-status)
- [Getting Started](#-getting-started)
- [Project Structure](#-project-structure)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🎯 About The Project

**Grand Strife: Civil War** is the inaugural title in the **Indie Grand Strife Series** — a passion-driven initiative focused on mastering independent game development pipelines, understanding market dynamics, and delivering deeply engaging narrative experiences. 

By leveraging a stylized **2D top-down perspective**, the project bypasses complex asset generation bottlenecks, focusing instead on sharp mechanical depth, atmospheric storytelling, and tight survival loops. Drawing from extensive personal fluency in RPG and survival systems, *Grand Strife* merges tactical resource management with unforgiving medieval combat.

---

## 🧠 Design Philosophy & Vision

> *"Constraint breeds creativity."*

* **Smart Scope Management:** Utilizing 2D graphics enables rapid iteration and complete artistic control without requiring professional illustration training.
* **Mechanical Fluency:** Built upon deeply understood pillars of classic RPG progression and modern survival loops.
* **Narrative-First Design:** Every feature, mechanic, and encounter is anchored directly to the lore and tone of the world.

---

## 🌑 World & Lore

The realm is bleeding. Set within an original, hand-crafted **dark medieval fantasy universe**, *Grand Strife* takes place in the aftermath of a shattered kingdom torn apart by dynastic war, brutal fractions, famine, and fanaticism. 

* **Written from the Ground Up:** Every faction, region, and historical event has been meticulously constructed to create a cohesive, oppressive atmosphere.
* **Character-Driven Narrative:** Characters are not mere quest-givers; they are designed first with psychological depth, motivations, and flaws, and then integrated seamlessly into the harsh realities of the world.

---

## 🛠️ Core Gameplay Mechanics

| System | Description |
| :--- | :--- |
| **Survival & Sustenance** | Manage hunger, fatigue, exposure, and injuries while traversing hostile territories. |
| **Tactical 2D Combat** | Positioning, stamina management, and weapon versatility dictate life and death. |
| **Dynamic relations** | Realations with other characters or organizations not only impact on costs but on many other things |
| **Dynamic Faction Standoffs** | Navigate shifting alliances in a war-torn civil landscape where choices alter regional stability. |
| **Medieval economy** | Game try to simulate medieval economy, which react on random events or player impact. |
| **Deep RPG Progression** | Skill trees, gear crafting, and consequential dialogue choices. |

---

## ⚙️ Technical Approach & Architecture

* **Engine:** Godot 4.7.1 for optimized, modularity and clean state management.
* **Asset Pipeline:** Scalable 2D spritesheet architecture with tile-based environment mapping.
* **Code Quality:** Adherence to clean code principles, ensuring maintainability as the project scales.

---

## 🗺️ Roadmap & Development Status

- [x] **Phase 1: Conceptualization & Lore Writing** (World-building, character design, core design document)
- [ ] **Phase 2: Core Engine & Prototype Loop** (Movement, basic inventory, rudimentary survival systems)
- [ ] **Phase 3: Content Expansion** (Quest systems, advanced combat, initial region implementation)
- [ ] **Phase 4: Playtesting & Polish** (Balancing, bug fixing, community feedback integration)

---

## 🚀 Getting Started

Since the project is currently in early development, instructions for building from source will be updated as the repository matures.

```bash
# Clone the repository
git clone https://github.com/MichalMroz06/grand-strife-civil-war.git

# Navigate into the project directory
cd grand-strife-civil-war
```

**Note:**
Window settings could not be applied in default, cause of debbuging tools and embedded settings.

---

## 📁 Project Structure

- `assets` - Folder with 'raw' files, such as graphics, fonts
  - `fonts` - Folder fonts
- `common` - Folder with scripts, resources available in whole project
  - `debug` - Folder with debug tools available globally
  - `ui_themes` - Folder with themes for ui
- `scenes` - Folder with modular game elements
  - `ui` - Folder with UI scenes and their logic
    - `menu_pages` - Folder with menu pages, such as `main_menu` or `settings`

---


## 🤝 Contributing

While *Grand Strife* is primarily a solo learning endeavor, feedback, bug reports, and suggestions are always welcome! Feel free to open an issue or start a discussion.

---

## 📄 License

This project is distributed under a **Custom Non-Commercial License**. See the [LICENSE](LICENSE) file for more information.

<div align="center">
  <p><i>Crafted with passion for indie gaming.</i></p>
</div>

# Projet d'Infrastructure Logicielle pour le Bâtiment Intelligent

Suivi éclairé d'une personne

- Jordan DE GEA
- Jean BOUVATIER
- Moreno LA QUATRA
- Danilo CAZZOLLA
- Raynald DANTIGNY


## Links
`http://fablab.ensimag.fr/index.php?title=PILBI-2016-Team2`

`https://github.com/jordandegea/PILB`


## Installation

Download on https://processing.org/download/?processing
Add library OpenCV in Processing
Add library GSTreamer
Add library HTTPRequests

## Projet

L'objectif est de suivre une personne sur une surface spécifique. 
Pour ce projet, nous décidons d'uiliser une caméra qui sera devant la scène pour identifier les personnes. 


## Increments

- Creation d'une fonction simple de detection de personne
- Creation de la fonction d'étalonnage de la scène grâce à la lumière projeté
- Creation des fonctions de conversion carthésien -> degrée
- Creation des fonctions de transmission caméra -> programme -> projecteurs


- Creation de l'étalonnage des personnes

## Comment l'utiliser

- Se connecter à la WiFi du labo
- Se connecter en ssh à pi@192.168.0.85, password raspberry
- Lancer openhab /home/pi/openhab1.8/runtime/start.sh
- Aller sur la page http://192.168.0.85:8080/openhab.app?sitemap=main

- Mettre la lyre sur channel 30 & p18

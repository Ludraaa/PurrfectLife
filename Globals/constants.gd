extends Node
#How fast the player can move
const playerMovementSpeed = 5000

#How far the build shop should come out of the right side of the screen
const buildShopDistance = -330
#How fast the build shop should come out
const buildShopSpeed = 1200
#The path to all floor resources
const floorResPath = "res://Resources/FloorTiles/floor"
#The path to all wall resources
const wallResPath = "res://Resources/WallTiles/wall"
#Color of Item slots in the shop
const shopSlotColor = Color(0.162, 0.162, 0.162)
#Color of Item slots when they are hovered
const shopSlotHighlightColor = Color(0.289, 0.436, 0.233)
#Color of unselected build shop tabs
const shopTabColor = Color(0.191, 0.191, 0.191)
#Color of selected build shop tabs
const shopTabSelectedColor = Color(0.303, 0.39, 0.576)
#Color of the button to open the shop when hovered
const shopOpenHover = Color(1, 0.2, 0.2, 1)
#Color of the button to close the shop when hovered
const shopCloseHover = Color(0.5, 0.5, 1, 1)
#Base Color to modulate back to original sprite
const baseColor = Color(1, 1, 1, 1)
#Color to highlight something that is being hovered, results in a slightly brighter appearance
const highlightColor = Color(1.3, 1.3, 1.3)

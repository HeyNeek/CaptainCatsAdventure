extends StaticBody2D

#maybe also we make the BasicIsland reusable outside of main islands for figuring out what level to enter?

#signal function that detects when player enters BasicIsland area and calls PirateShip's dock_ship() function
func _on_area_2d_body_entered(body):
	if body.name == "PirateShip":
		print("PirateShip is hitting island!")
		body.dock_ship(self.name)

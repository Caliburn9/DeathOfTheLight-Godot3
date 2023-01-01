extends Node2D

#--------------------------------------------
#Make sure variables that are passed into the 
#equations are floats (add ".0" at the end)
#--------------------------------------------

func value_to_percentage(num, total):
	return (num/total) * 100

func percentage_to_value(num, total):
	return (num/100) * total

extends Control
class_name icon_money

var money = 5
@onready var money_tx: Label = %Money_Tx

func _ready() -> void:
	money_tx.text = str(money)

func changed_money(value: int)->void:
	money = value

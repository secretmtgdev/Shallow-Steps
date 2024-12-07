extends Node

signal light_on
signal light_off
signal take_damage(damageTaken: float)

signal qte_in_progress
signal qte_is_done
signal fail_qte(damageTaken: float)
signal pass_qte
signal dice_rolled(rolledNumber: int)

signal game_over

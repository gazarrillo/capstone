extends Node

const ITERATIONS := 100000
const DECK_A_START := 0
const DECK_A_END := 17

func _ready():
	randomize()
	run_deck_a_test()


func run_deck_a_test():
	print("\n=== STARTING METAL DECK TEST (CARDS 0–17) ===\n")
	
	var draw_counts := {}
	
	# Initialize counters
	for i in range(DECK_A_START, DECK_A_END + 1):
		draw_counts[i] = 0
	
	# Simulate draws
	for i in range(ITERATIONS):
		var card = randi_range(DECK_A_START, DECK_A_END)
		draw_counts[card] += 1
	
	print_report(draw_counts)
	verify_distribution(draw_counts)


func print_report(draw_counts: Dictionary):
	print("\n=== DRAW REPORT ===")
	
	for key in draw_counts.keys():
		print("Card ", key, ": ", draw_counts[key])
	
	print("========================\n")


func verify_distribution(draw_counts: Dictionary):
	var total_cards := DECK_A_END - DECK_A_START + 1
	var expected := float(ITERATIONS) / total_cards
	var tolerance := expected * 0.05
	
	print("Expected per card: ", expected)
	print("Allowed tolerance (5%): ±", tolerance)
	
	var all_within_range := true
	
	for card in draw_counts.keys():
		var count = draw_counts[card]
		
		if abs(count - expected) > tolerance:
			print("⚠ Card ", card, " OUTSIDE 5% range")
			all_within_range = false
	
	if all_within_range:
		print("\n✅ DECK A PASSED — Distribution within 5%")
	else:
		print("\n❌ DECK A FAILED — Distribution outside 5% tolerance")

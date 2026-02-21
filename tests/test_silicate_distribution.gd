extends Node

const ITERATIONS := 100000
const DECK_START := 18
const DECK_END := 35

func _ready():
	randomize()
	run_test()


func run_test():
	print("\n=== STARTING SILICATE DECK TEST (CARDS 18–35) ===\n")
	
	var draw_counts := {}
	
	# Initialize counts
	for i in range(DECK_START, DECK_END + 1):
		draw_counts[i] = 0
	
	# Reset lock state
	ChanceCardMgr.go_for_launch1_available = true
	ChanceCardMgr.go_for_launch2_available = true
	ChanceCardMgr.go_for_launch1_owner = -1
	ChanceCardMgr.go_for_launch2_owner = -1
	
	# Fake required GameState values so resolve_card doesn’t crash
	GameState.current_player_index = 0
	GameState.player_count = 1
	
	for i in range(ITERATIONS):
		var card = simulate_draw()
		
		draw_counts[card] += 1
		
		# Call resolve_card so lock behavior occurs naturally
		ChanceCardMgr.resolve_card(card, 0, 0, 0)
	
	print_report(draw_counts)
	verify_distribution(draw_counts)


func simulate_draw() -> int:
	var current_card = randi_range(DECK_START, DECK_END)
		
	while current_card == 35 and not ChanceCardMgr.go_for_launch2_available:
		current_card = randi_range(DECK_START, DECK_END)
		
	while current_card == 34 and not ChanceCardMgr.go_for_launch1_available:
		current_card = randi_range(DECK_START, DECK_END-1)
	
	return current_card


func print_report(draw_counts: Dictionary):
	print("\n=== DRAW REPORT ===")
	
	for key in draw_counts.keys():
		print("Card ", key, ": ", draw_counts[key])
	
	print("========================\n")


func verify_distribution(draw_counts: Dictionary):
	var active_cards := []
	
	for i in range(DECK_START, DECK_END + 1):
		if i != 34 and i != 35:
			active_cards.append(i)
	
	var expected := float(ITERATIONS) / active_cards.size()
	var tolerance := expected * 0.05
	
	print("Expected per unlocked card: ", expected)
	print("Allowed tolerance (5%): ±", tolerance)
	
	var all_within_range := true
	
	for card in active_cards:
		var count = draw_counts[card]
		
		if abs(count - expected) > tolerance:
			print("⚠ Card ", card, " OUTSIDE 5% range")
			all_within_range = false
	
	if draw_counts[34] > 1:
		print("❌ Card 34 drawn more than once")
		all_within_range = false
		
	if draw_counts[35] > 1:
		print("❌ Card 35 drawn more than once")
		all_within_range = false
	
	if all_within_range:
		print("\n✅ TEST PASSED — Distribution within 5% and locks respected")
	else:
		print("\n❌ TEST FAILED — Distribution outside tolerance or lock broken")

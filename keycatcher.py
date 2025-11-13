import keyboard

def on_key_event(event):
    # event.name gives the key name
    # event.event_type is 'down' or 'up'
    print(f"Key: {event.name}, Event: {event.event_type}")

# Hook into all keyboard events
keyboard.hook(on_key_event)

print("Listening for all key presses... Press ESC to stop.")
# Keep the program running
keyboard.wait('esc')  # Press ESC to exit

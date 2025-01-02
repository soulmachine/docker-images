import quopri

# Read the .doc file as raw content in binary mode
with open("example.doc", "rb") as file:
    raw_content = file.read()

decoded_content = quopri.decodestring(raw_content).decode("utf-8", errors="ignore")

# Save the decoded content to a file for debugging
with open("decoded_debug.txt", "w", encoding="utf-8") as debug_file:
    debug_file.write(decoded_content)

print("Decoded content saved to decoded_debug.txt")

import re

# Read the raw decoded content
with open("decoded_debug.txt", "r", encoding="utf-8") as file:
    content = file.read()

# Debug: Save the raw content for inspection
with open("raw_content_debug.txt", "w", encoding="utf-8") as debug_file:
    debug_file.write(content)

# Split the content by MIME boundary
mime_parts = re.split(r"^------=_Part_\d+.*$", content, flags=re.MULTILINE)

# Find the part containing the HTML
html_part = ""
for part in mime_parts:
    if "<html>" in part and "</html>" in part:
        html_part = part
        break

# Extract the HTML content
if html_part:
    start_index = html_part.find("<html>")
    end_index = html_part.find("</html>") + len("</html>")
    cleaned_html = html_part[start_index:end_index]
    print("HTML content successfully extracted.")
else:
    print("No HTML content found in MIME parts.")
    cleaned_html = ""

# Save the cleaned HTML content
with open("cleaned_output.html", "w", encoding="utf-8") as output_file:
    output_file.write(cleaned_html)

print("Cleaned HTML content saved to cleaned_output.html")

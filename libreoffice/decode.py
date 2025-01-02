import re

# Step 1: Read the file
with open("example.doc", "r", encoding="utf-8", errors="ignore") as file:
    raw_content = file.read()

# Step 2: Remove MIME headers
cleaned_content = re.sub(r"^boundary=.*?$", "", raw_content, flags=re.MULTILINE)
cleaned_content = re.sub(r"^Content-Transfer-Encoding:.*?$", "", cleaned_content, flags=re.MULTILINE)
cleaned_content = re.sub(r"^Content-Location:.*?$", "", cleaned_content, flags=re.MULTILINE)

# Step 3: Decode attributes (replace `3D` with `=`) and fix quoted-printable encodings
cleaned_content = re.sub(r"=3D", "=", cleaned_content)  # Decode `3D` to `=`
cleaned_content = re.sub(r"=20", " ", cleaned_content)  # Replace `=20` with a space
cleaned_content = re.sub(r"=([0-9A-Fa-f]{2})", lambda x: chr(int(x.group(1), 16)), cleaned_content)  # Decode other quoted-printable

# Step 4: Attempt to locate HTML content
html_match = re.search(r"<html.*?>.*?</html>", cleaned_content, flags=re.DOTALL | re.IGNORECASE)

if html_match:
    html_content = html_match.group()

    # Optional: Remove unnecessary spaces and empty lines
    html_content = re.sub(r"\n\s*\n", "\n", html_content)

    # Step 5: Save the cleaned HTML content
    with open("cleaned_output.html", "w", encoding="utf-8") as output_file:
        output_file.write(html_content)

    print("Cleaned HTML content saved to cleaned_output.html")
else:
    print("No valid HTML content found in the file.")

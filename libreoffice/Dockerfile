FROM ubuntu:latest

RUN apt-get update && apt-get install -y --no-install-recommends \
    libreoffice \
    libreoffice-writer \
    default-jre \
    fonts-dejavu-core \
    fonts-liberation \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["libreoffice", "--headless", "--convert-to", "pdf"]

CMD ["--help"]

